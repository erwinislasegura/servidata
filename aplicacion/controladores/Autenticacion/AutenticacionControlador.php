<?php

namespace Aplicacion\Controladores\Autenticacion;

use Aplicacion\Nucleo\Controlador;
use Aplicacion\Nucleo\BaseDatos;
use Aplicacion\Modelos\Usuario;
use Aplicacion\Modelos\Empresa;
use Aplicacion\Modelos\Plan;
use Aplicacion\Modelos\Suscripcion;
use Aplicacion\Modelos\LogCorreo;
use Throwable;

class AutenticacionControlador extends Controlador
{
    public function mostrarLogin(): void
    {
        $this->vista('autenticacion/login', [], 'publico');
    }

    public function iniciarSesion(): void
    {
        validar_csrf();
        $correo = filter_var($_POST['correo'] ?? '', FILTER_VALIDATE_EMAIL);
        $password = $_POST['password'] ?? '';

        if (!$correo || $password === '') {
            flash('danger', 'Completa correo y contraseña correctamente.');
            $this->redirigir('/iniciar-sesion');
        }

        $usuario = (new Usuario())->buscarPorCorreo($correo);
        if (!$usuario || !password_verify($password, $usuario['password'])) {
            flash('danger', 'Credenciales inválidas.');
            $this->redirigir('/iniciar-sesion');
        }

        session_regenerate_id(true);
        $_SESSION['usuario'] = [
            'id' => (int) $usuario['id'],
            'empresa_id' => $usuario['empresa_id'] ? (int) $usuario['empresa_id'] : null,
            'nombre' => $usuario['nombre'],
            'correo' => $usuario['correo'],
            'rol_codigo' => $usuario['rol_codigo'],
        ];

        if ($usuario['rol_codigo'] === 'superadministrador') {
            $this->redirigir('/admin/panel');
        }

        $this->redirigir('/app/panel');
    }

    public function cerrarSesion(): void
    {
        $_SESSION = [];
        session_destroy();
        $this->redirigir('/iniciar-sesion');
    }

    public function mostrarRegistro(): void
    {
        $planes = (new Plan())->listar(true);
        $planPreseleccionado = 0;
        if (isset($_GET['plan'])) {
            $pre = (new Plan())->buscar((int) $_GET['plan']);
            $planPreseleccionado = ($pre && ($pre['estado'] ?? '') === 'activo' && (int) ($pre['visible'] ?? 0) === 1) ? (int) $pre['id'] : 0;
        }
        $this->vista('autenticacion/registro', ['planes' => $planes, 'planPreseleccionado' => $planPreseleccionado], 'publico');
    }

    public function registrarEmpresa(): void
    {
        validar_csrf();
        $planId = (int) ($_POST['plan_id'] ?? 0);
        $razonSocial = trim((string) ($_POST['razon_social'] ?? ''));
        $nombreComercial = trim((string) ($_POST['nombre_comercial'] ?? ''));
        $identificadorFiscal = trim((string) ($_POST['identificador_fiscal'] ?? ''));
        $correoEmpresa = filter_var(trim((string) ($_POST['correo_empresa'] ?? '')), FILTER_VALIDATE_EMAIL);
        $telefono = trim((string) ($_POST['telefono'] ?? ''));
        $direccion = trim((string) ($_POST['direccion'] ?? ''));
        $ciudad = trim((string) ($_POST['ciudad'] ?? ''));
        $pais = trim((string) ($_POST['pais'] ?? ''));
        $nombreAdmin = trim((string) ($_POST['nombre_admin'] ?? ''));
        $correoAdmin = filter_var(trim((string) ($_POST['correo_admin'] ?? '')), FILTER_VALIDATE_EMAIL);
        $password = (string) ($_POST['password'] ?? '');

        if ($razonSocial === '' || $nombreComercial === '' || $identificadorFiscal === '' || !$correoEmpresa || $nombreAdmin === '' || !$correoAdmin || strlen($password) < 8 || $planId <= 0) {
            flash('danger', 'Completa los campos obligatorios con información válida para crear la empresa.');
            $this->redirigir('/registro');
        }

        $plan = (new Plan())->buscar($planId);
        if (!$plan || ($plan['estado'] ?? '') !== 'activo' || (int) ($plan['visible'] ?? 0) !== 1) {
            flash('danger', 'Selecciona un plan válido para continuar con el registro.');
            $this->redirigir('/registro');
        }

        $empresaModel = new Empresa();
        $usuarioModel = new Usuario();
        $suscripcionModel = new Suscripcion();

        if ($empresaModel->existePorIdentificadorFiscal($identificadorFiscal)) {
            flash('danger', 'Ya existe una empresa registrada con ese RUT/NIT.');
            $this->redirigir('/registro');
        }

        if ($usuarioModel->buscarPorCorreo($correoAdmin)) {
            flash('danger', 'El correo del administrador ya está en uso. Usa otro correo para continuar.');
            $this->redirigir('/registro');
        }

        $db = BaseDatos::obtener();

        try {
            $db->beginTransaction();

            $empresaId = $empresaModel->crear([
                'razon_social' => $razonSocial,
                'nombre_comercial' => $nombreComercial,
                'identificador_fiscal' => $identificadorFiscal,
                'correo' => $correoEmpresa,
                'telefono' => $telefono !== '' ? $telefono : null,
                'direccion' => $direccion !== '' ? $direccion : null,
                'ciudad' => $ciudad !== '' ? $ciudad : null,
                'pais' => $pais !== '' ? $pais : null,
                'estado' => 'activa',
                'fecha_activacion' => date('Y-m-d'),
                'plan_id' => $planId,
            ]);

            $usuarioModel->crear([
                'empresa_id' => $empresaId,
                'rol_id' => 2,
                'nombre' => $nombreAdmin,
                'correo' => $correoAdmin,
                'password' => password_hash($password, PASSWORD_DEFAULT),
                'telefono' => null,
                'cargo' => null,
                'biografia' => null,
                'estado' => 'activo',
            ]);

            $suscripcionModel->crear([
                'empresa_id' => $empresaId,
                'plan_id' => $planId,
                'estado' => 'activa',
                'fecha_inicio' => date('Y-m-d'),
                'fecha_vencimiento' => date('Y-m-d', strtotime('+30 days')),
                'observaciones' => 'Alta inicial desde registro',
                'renovacion_automatica' => 0,
            ]);

            $db->commit();
        } catch (Throwable $e) {
            if ($db->inTransaction()) {
                $db->rollBack();
            }
            flash('danger', 'No fue posible crear la empresa. Intenta nuevamente en unos minutos.');
            $this->redirigir('/registro');
        }

        flash('success', 'Empresa creada con éxito. Tu cuenta administrativa ya está activa para iniciar sesión.');
        $this->redirigir('/iniciar-sesion');
    }

    public function recuperarContrasena(): void
    {
        $this->vista('autenticacion/recuperar', [], 'publico');
    }

    public function solicitarRecuperacionContrasena(): void
    {
        validar_csrf();
        $correo = filter_var(trim((string) ($_POST['correo'] ?? '')), FILTER_VALIDATE_EMAIL);

        if (!$correo) {
            flash('danger', 'Ingresa un correo válido para recuperar tu contraseña.');
            $this->redirigir('/recuperar-contrasena');
        }

        $usuarioModel = new Usuario();
        $usuario = $usuarioModel->buscarPorCorreo($correo);

        // Mensaje neutro para no exponer existencia de cuentas.
        $mensajeGenerico = 'Si el correo existe y está activo, se generó un enlace de recuperación válido por 60 minutos.';

        if (!$usuario || ($usuario['estado'] ?? '') !== 'activo') {
            flash('success', $mensajeGenerico);
            $this->redirigir('/recuperar-contrasena');
        }

        $token = bin2hex(random_bytes(32));
        $expiracion = date('Y-m-d H:i:s', strtotime('+60 minutes'));
        $enlace = url('/restablecer-contrasena?token=' . $token);

        $usuarioModel->invalidarTokensRestablecimiento((int) $usuario['id']);
        $usuarioModel->crearTokenRestablecimiento((int) $usuario['id'], $token, $expiracion);

        (new LogCorreo())->registrar([
            'destinatario' => $correo,
            'asunto' => 'Recuperación de contraseña',
            'plantilla' => 'recuperacion_contrasena',
            'payload' => json_encode(['enlace' => $enlace, 'expira' => $expiracion], JSON_UNESCAPED_UNICODE),
            'estado' => 'pendiente',
        ]);

        flash('success', $mensajeGenerico . ' Enlace temporal: ' . $enlace);
        $this->redirigir('/recuperar-contrasena');
    }

    public function restablecerContrasena(): void
    {
        $token = trim((string) ($_GET['token'] ?? ''));
        $tokenValido = false;

        if ($token !== '') {
            $tokenValido = (new Usuario())->obtenerTokenRestablecimientoVigente($token) !== null;
        }

        $this->vista('autenticacion/restablecer', [
            'token' => $token,
            'tokenValido' => $tokenValido,
        ], 'publico');
    }

    public function actualizarContrasenaRecuperada(): void
    {
        validar_csrf();

        $token = trim((string) ($_POST['token'] ?? ''));
        $password = (string) ($_POST['password'] ?? '');
        $confirmacion = (string) ($_POST['password_confirmacion'] ?? '');

        if ($token === '') {
            flash('danger', 'El enlace de recuperación no es válido.');
            $this->redirigir('/recuperar-contrasena');
        }

        if (strlen($password) < 8) {
            flash('danger', 'La nueva contraseña debe tener al menos 8 caracteres.');
            $this->redirigir('/restablecer-contrasena?token=' . urlencode($token));
        }

        if ($password !== $confirmacion) {
            flash('danger', 'La confirmación de contraseña no coincide.');
            $this->redirigir('/restablecer-contrasena?token=' . urlencode($token));
        }

        $usuarioModel = new Usuario();
        $registroToken = $usuarioModel->obtenerTokenRestablecimientoVigente($token);
        if (!$registroToken) {
            flash('danger', 'El enlace de recuperación expiró o ya fue utilizado.');
            $this->redirigir('/recuperar-contrasena');
        }

        $usuarioModel->actualizarPasswordPorId((int) $registroToken['usuario_id'], password_hash($password, PASSWORD_DEFAULT));
        $usuarioModel->marcarTokenRestablecimientoUsado((int) $registroToken['id']);
        $usuarioModel->invalidarTokensRestablecimiento((int) $registroToken['usuario_id']);

        flash('success', 'Contraseña actualizada correctamente. Ya puedes iniciar sesión.');
        $this->redirigir('/iniciar-sesion');
    }
}
