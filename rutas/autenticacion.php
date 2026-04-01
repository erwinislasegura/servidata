<?php

use Aplicacion\Controladores\Autenticacion\AutenticacionControlador;

$enrutador->agregar('GET', '/iniciar-sesion', [AutenticacionControlador::class, 'mostrarLogin']);
$enrutador->agregar('POST', '/iniciar-sesion', [AutenticacionControlador::class, 'iniciarSesion']);
$enrutador->agregar('POST', '/cerrar-sesion', [AutenticacionControlador::class, 'cerrarSesion']);
$enrutador->agregar('GET', '/recuperar', [AutenticacionControlador::class, 'recuperarContrasena']);
$enrutador->agregar('GET', '/recuperar-contrasena', [AutenticacionControlador::class, 'recuperarContrasena']);
$enrutador->agregar('POST', '/recuperar-contrasena', [AutenticacionControlador::class, 'solicitarRecuperacionContrasena']);
$enrutador->agregar('GET', '/restablecer-contrasena', [AutenticacionControlador::class, 'restablecerContrasena']);
$enrutador->agregar('POST', '/restablecer-contrasena', [AutenticacionControlador::class, 'actualizarContrasenaRecuperada']);
