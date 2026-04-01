<?php

use Aplicacion\Controladores\Autenticacion\AutenticacionControlador;
use Aplicacion\Controladores\Publico\PublicoControlador;

$enrutador->agregar('GET', '/', [AutenticacionControlador::class, 'mostrarLogin']);
$enrutador->agregar('POST', '/', [AutenticacionControlador::class, 'iniciarSesion']);
$enrutador->agregar('GET', '/recuperar', [AutenticacionControlador::class, 'recuperarContrasena']);
$enrutador->agregar('GET', '/cotizacion/publica/{token}', [PublicoControlador::class, 'verCotizacionPublica']);
$enrutador->agregar('GET', '/cotizacion/publica/{token}/imprimir', [PublicoControlador::class, 'imprimirCotizacionPublica']);
$enrutador->agregar('POST', '/cotizacion/publica/{token}/decision', [PublicoControlador::class, 'registrarDecisionCotizacion']);
