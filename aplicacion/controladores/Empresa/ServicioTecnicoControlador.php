<?php

namespace Aplicacion\Controladores\Empresa;

use Aplicacion\Modelos\ServicioTecnico;
use Aplicacion\Nucleo\Controlador;

class ServicioTecnicoControlador extends Controlador
{
    public function dashboard(): void
    {
        $datos = (new ServicioTecnico())->dashboard((int) empresa_actual_id());
        $this->vista('empresa/servicio_tecnico/dashboard', $datos, 'empresa');
    }

    public function clientes(): void
    {
        $buscar = trim($_GET['q'] ?? '');
        $modelo = new ServicioTecnico();
        $clientes = $modelo->listarClientes((int) empresa_actual_id(), $buscar);
        $this->vista('empresa/servicio_tecnico/clientes', compact('clientes', 'buscar'), 'empresa');
    }

    public function guardarCliente(): void
    {
        validar_csrf();
        (new ServicioTecnico())->crearCliente((int) empresa_actual_id(), [
            'nombres' => trim($_POST['nombres'] ?? ''),
            'apellidos' => trim($_POST['apellidos'] ?? ''),
            'rut' => trim($_POST['rut'] ?? ''),
            'tipo_documento' => trim($_POST['tipo_documento'] ?? 'RUT'),
            'numero_documento' => trim($_POST['numero_documento'] ?? ''),
            'direccion' => trim($_POST['direccion'] ?? ''),
            'comuna' => trim($_POST['comuna'] ?? ''),
            'ciudad' => trim($_POST['ciudad'] ?? ''),
            'telefono' => trim($_POST['telefono'] ?? ''),
            'email' => trim($_POST['email'] ?? ''),
            'observaciones' => trim($_POST['observaciones'] ?? ''),
            'estado' => trim($_POST['estado'] ?? 'activo'),
        ]);

        flash('success', 'Cliente creado correctamente.');
        $this->redirigir('/app/servicio-tecnico/clientes');
    }

    public function equipos(): void
    {
        $buscar = trim($_GET['q'] ?? '');
        $modelo = new ServicioTecnico();
        $equipos = $modelo->listarEquipos((int) empresa_actual_id(), $buscar);
        $clientes = $modelo->listarClientes((int) empresa_actual_id());
        $this->vista('empresa/servicio_tecnico/equipos', compact('equipos', 'clientes', 'buscar'), 'empresa');
    }

    public function guardarEquipo(): void
    {
        validar_csrf();
        (new ServicioTecnico())->crearEquipo((int) empresa_actual_id(), $_POST);
        flash('success', 'Equipo registrado correctamente.');
        $this->redirigir('/app/servicio-tecnico/equipos');
    }

    public function ordenes(): void
    {
        $buscar = trim($_GET['q'] ?? '');
        $estado = trim($_GET['estado'] ?? '');
        $modelo = new ServicioTecnico();
        $ordenes = $modelo->listarOrdenes((int) empresa_actual_id(), $buscar, $estado);
        $clientes = $modelo->listarClientes((int) empresa_actual_id());
        $equipos = $modelo->listarEquipos((int) empresa_actual_id());
        $tecnicos = $modelo->listarTecnicos((int) empresa_actual_id());
        $estados = ['Ingresado', 'Diagnóstico', 'Esperando aprobación', 'Aprobado', 'En reparación', 'Esperando repuesto', 'Pruebas', 'Listo', 'Entregado', 'No reparado', 'Cancelado'];
        $this->vista('empresa/servicio_tecnico/ordenes', compact('ordenes', 'clientes', 'equipos', 'tecnicos', 'estados', 'buscar', 'estado'), 'empresa');
    }

    public function guardarOrden(): void
    {
        validar_csrf();
        $ordenId = (new ServicioTecnico())->crearOrden((int) empresa_actual_id(), $_POST);

        $accion = $_POST['accion_guardado'] ?? 'guardar';
        if ($accion === 'guardar_nueva') {
            flash('success', 'Orden guardada correctamente. Ya puedes registrar una nueva.');
            $this->redirigir('/app/servicio-tecnico/ordenes');
        }

        if ($accion === 'guardar_imprimir') {
            flash('success', 'Orden guardada. Puedes imprimir el comprobante de ingreso de inmediato.');
            $this->redirigir('/app/servicio-tecnico/ordenes?q=' . urlencode((string) $ordenId));
        }

        flash('success', 'Orden guardada correctamente.');
        $this->redirigir('/app/servicio-tecnico/ordenes');
    }

    public function portalPublico(): void
    {
        $this->vista('empresa/servicio_tecnico/portal_publico', [], 'empresa');
    }
}
