<?php

namespace Aplicacion\Controladores\Admin;

use Aplicacion\Modelos\Empresa;
use Aplicacion\Modelos\LogAdministracion;
use Aplicacion\Modelos\Plan;
use Aplicacion\Modelos\Suscripcion;
use Aplicacion\Modelos\Usuario;
use Aplicacion\Nucleo\BaseDatos;
use Aplicacion\Nucleo\Controlador;

class EmpresasControlador extends Controlador
{
    public function index(): void
    {
        $filtros = [
            'busqueda' => trim($_GET['q'] ?? ''),
            'estado' => $_GET['estado'] ?? '',
            'plan_id' => $_GET['plan_id'] ?? '',
        ];

        $empresas = (new Empresa())->listar($filtros);
        $planes = (new Plan())->listar();
        $this->vista('admin/empresas/index', compact('empresas', 'planes', 'filtros'), 'admin');
    }

    public function ver(int $id): void
    {
        $this->cargarVistaEmpresa($id, false);
    }

    public function editar(int $id): void
    {
        $this->cargarVistaEmpresa($id, true);
    }

    private function cargarVistaEmpresa(int $id, bool $modoEdicion): void
    {
        $empresa = (new Empresa())->buscarDetalleAdmin($id);
        if (!$empresa) {
            flash('danger', 'Empresa no encontrada.');
            $this->redirigir('/admin/empresas');
        }

        $admins = (new Usuario())->listarAdministradoresEmpresa(['empresa_id' => $id]);
        $historial = BaseDatos::obtener()->prepare('SELECT hs.*, u.nombre AS admin_nombre FROM historial_suscripciones hs LEFT JOIN suscripciones s ON s.id = hs.suscripcion_id LEFT JOIN usuarios u ON u.id = s.empresa_id WHERE s.empresa_id = :empresa_id ORDER BY hs.id DESC LIMIT 20');
        $historial->execute(['empresa_id' => $id]);
        $historial = $historial->fetchAll();

        $planes = (new Plan())->listarActivos();
        $titulo = $modoEdicion ? 'Editar empresa' : 'Detalle de empresa';
        $this->vista('admin/empresas/ver', compact('empresa', 'admins', 'historial', 'planes', 'titulo', 'modoEdicion'), 'admin');
    }

    public function actualizarEstado(int $id): void
    {
        validar_csrf();
        $estado = $_POST['estado'] ?? 'activa';
        try {
            (new Empresa())->actualizarEstado($id, $estado);
            (new LogAdministracion())->registrar('empresas', 'cambiar_estado', 'Cambio de estado a ' . $estado, $id);
            flash('success', 'Estado de empresa actualizado.');
        } catch (\Throwable $e) {
            flash('danger', 'No se pudo actualizar el estado de la empresa.');
        }
        $this->redirigir('/admin/empresas/editar/' . $id);
    }

    public function actualizarEmpresa(int $id): void
    {
        validar_csrf();

        $correo = filter_var(trim((string) ($_POST['correo'] ?? '')), FILTER_VALIDATE_EMAIL);
        if (!$correo) {
            flash('danger', 'El correo de empresa no es válido.');
            $this->redirigir('/admin/empresas/editar/' . $id);
        }

        $data = [
            'razon_social' => trim((string) ($_POST['razon_social'] ?? '')),
            'nombre_comercial' => trim((string) ($_POST['nombre_comercial'] ?? '')),
            'identificador_fiscal' => trim((string) ($_POST['identificador_fiscal'] ?? '')),
            'correo' => $correo,
            'telefono' => trim((string) ($_POST['telefono'] ?? '')) ?: null,
            'direccion' => trim((string) ($_POST['direccion'] ?? '')) ?: null,
            'ciudad' => trim((string) ($_POST['ciudad'] ?? '')) ?: null,
            'pais' => trim((string) ($_POST['pais'] ?? '')) ?: null,
            'estado' => (string) ($_POST['estado'] ?? 'activa'),
        ];

        if ($data['razon_social'] === '' || $data['nombre_comercial'] === '' || $data['identificador_fiscal'] === '') {
            flash('danger', 'Completa razón social, nombre comercial e identificador fiscal.');
            $this->redirigir('/admin/empresas/editar/' . $id);
        }

        try {
            (new Empresa())->actualizarDatosAdmin($id, $data);
            (new LogAdministracion())->registrar('empresas', 'editar_datos', 'Actualización de datos generales', $id);
            flash('success', 'Datos de la empresa actualizados.');
        } catch (\Throwable $e) {
            flash('danger', 'No se pudieron actualizar los datos de la empresa.');
        }

        $this->redirigir('/admin/empresas/editar/' . $id);
    }

    public function cambiarPlan(int $id): void
    {
        validar_csrf();
        $planId = (int) ($_POST['plan_id'] ?? 0);
        $observaciones = trim($_POST['observaciones_internas'] ?? '');
        $rutaRetorno = '/admin/empresas/editar/' . $id;

        if ($planId <= 0 || !(new Plan())->buscar($planId)) {
            flash('danger', 'Selecciona un plan válido para la empresa.');
            $this->redirigir($rutaRetorno);
        }

        $empresaModel = new Empresa();
        $empresa = $empresaModel->buscar($id);
        if (!$empresa) {
            flash('danger', 'Empresa no encontrada.');
            $this->redirigir('/admin/empresas');
        }

        $db = BaseDatos::obtener();
        try {
            $db->beginTransaction();

            $empresaModel->actualizarPlanYObservacion($id, $planId, $observaciones);

            $suscripcionModelo = new Suscripcion();
            $suscripcion = $suscripcionModelo->obtenerUltimaPorEmpresa($id);
            if ($suscripcion) {
                $nota = trim(($suscripcion['observaciones'] ?? '') . ' | Cambio de plan desde admin a ID ' . $planId);
                $suscripcionModelo->actualizarPlanSuscripcion((int) $suscripcion['id'], $planId, $nota);
            } else {
                $suscripcionModelo->crear([
                    'empresa_id' => $id,
                    'plan_id' => $planId,
                    'estado' => 'activa',
                    'fecha_inicio' => date('Y-m-d'),
                    'fecha_vencimiento' => date('Y-m-d', strtotime('+30 days')),
                    'observaciones' => 'Alta de suscripción automática por cambio de plan desde admin.',
                    'renovacion_automatica' => 0,
                ]);
            }

            $db->commit();
            (new LogAdministracion())->registrar('empresas', 'cambiar_plan', 'Plan asignado ID ' . $planId, $id);
            flash('success', 'Plan de empresa actualizado.');
        } catch (\Throwable $e) {
            if ($db->inTransaction()) {
                $db->rollBack();
            }
            flash('danger', 'No se pudo actualizar el plan de la empresa.');
        }
        $this->redirigir($rutaRetorno);
    }

    public function extenderSuscripcion(int $id): void
    {
        validar_csrf();
        $dias = max(1, (int) ($_POST['dias'] ?? 30));
        $empresa = (new Empresa())->buscar($id);
        if (!$empresa) {
            flash('danger', 'Empresa no encontrada.');
            $this->redirigir('/admin/empresas');
        }

        $suscripcionModelo = new Suscripcion();
        try {
            $actual = $suscripcionModelo->obtenerUltimaPorEmpresa($id);
            if (!$actual) {
                $planId = (int) ($empresa['plan_id'] ?? 0);
                if ($planId <= 0) {
                    flash('danger', 'La empresa no tiene plan asignado para crear una suscripción.');
                    $this->redirigir('/admin/empresas/editar/' . $id);
                }

                $fechaInicio = date('Y-m-d');
                $fechaVencimiento = date('Y-m-d', strtotime('+' . $dias . ' days'));
                $suscripcionModelo->crear([
                    'empresa_id' => $id,
                    'plan_id' => $planId,
                    'estado' => 'activa',
                    'fecha_inicio' => $fechaInicio,
                    'fecha_vencimiento' => $fechaVencimiento,
                    'observaciones' => 'Alta de suscripción automática por extensión manual desde admin.',
                    'renovacion_automatica' => 0,
                ]);
                (new LogAdministracion())->registrar('suscripciones', 'crear_y_extender_vigencia', 'Creación + extensión de ' . $dias . ' días', $id);
                flash('success', 'Suscripción creada y vigente hasta ' . $fechaVencimiento . '.');
                $this->redirigir('/admin/empresas/editar/' . $id);
            }

            $vencimientoActual = (string) ($actual['fecha_vencimiento'] ?? '');
            $base = (strtotime($vencimientoActual) !== false && $vencimientoActual > date('Y-m-d'))
                ? $vencimientoActual
                : date('Y-m-d');
            $nuevaFecha = date('Y-m-d', strtotime($base . ' +' . $dias . ' days'));
            $observaciones = trim(($actual['observaciones'] ?? '') . ' | Extensión admin: +' . $dias . ' días');
            $suscripcionModelo->extenderVigencia((int) $actual['id'], $nuevaFecha, $observaciones);
            (new Empresa())->actualizarEstado($id, 'activa');
            (new LogAdministracion())->registrar('suscripciones', 'extender_vigencia', 'Extensión de ' . $dias . ' días', $id);
            flash('success', 'Vigencia extendida hasta ' . $nuevaFecha . '.');
        } catch (\Throwable $e) {
            flash('danger', 'No se pudo extender la vigencia. Detalle: ' . $e->getMessage());
        }
        $this->redirigir('/admin/empresas/editar/' . $id);
    }
}
