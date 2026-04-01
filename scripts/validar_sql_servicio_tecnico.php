<?php

declare(strict_types=1);

$archivos = glob(__DIR__ . '/../base_datos/actualizaciones/*.sql') ?: [];
$archivos[] = __DIR__ . '/../base_datos/instalacion/base_datos_full_servicio_tecnico.sql';

sort($archivos);

$errores = [];

$patronesPegados = [
    '/\bestadoFROM\b/i',
    '/\bt\.estadoFROM\b/i',
    '/\btmp_planes_base\s+tLEFT\b/i',
    '/\bslugWHERE\b/i',
    '/\)SELECT\b/i',
    '/\)FROM\b/i',
];

$palabrasCriticas = ['SELECT', 'FROM', 'WHERE', 'LEFT JOIN', 'INSERT INTO', 'UPDATE', 'ON DUPLICATE KEY UPDATE'];

foreach ($archivos as $archivo) {
    if (!is_file($archivo)) {
        $errores[] = "No existe archivo SQL: {$archivo}";
        continue;
    }

    $contenido = (string) file_get_contents($archivo);
    if (trim($contenido) === '') {
        $errores[] = basename($archivo) . ' está vacío';
        continue;
    }

    foreach ($patronesPegados as $patron) {
        if (preg_match($patron, $contenido) === 1) {
            $errores[] = basename($archivo) . " contiene patrón riesgoso: {$patron}";
        }
    }


    foreach ($palabrasCriticas as $palabra) {
        if (stripos($contenido, $palabra) === false) {
            continue;
        }
    }
}

$full = __DIR__ . '/../base_datos/instalacion/base_datos_full_servicio_tecnico.sql';
if (is_file($full)) {
    $contenidoFull = (string) file_get_contents($full);
    $checks = [
        "st_clientes" => "CREATE TABLE IF NOT EXISTS st_clientes",
        "st_ordenes" => "CREATE TABLE IF NOT EXISTS st_ordenes",
        "root user" => "root@tallerlocal.com",
        "admin user" => "admin@tallerlocal.com",
    ];

    foreach ($checks as $nombre => $needle) {
        if (stripos($contenidoFull, $needle) === false) {
            $errores[] = "SQL FULL no contiene bloque obligatorio: {$nombre}";
        }
    }
}

if ($errores !== []) {
    fwrite(STDERR, "[ERROR] Validación SQL minuciosa con observaciones:\n");
    foreach ($errores as $error) {
        fwrite(STDERR, " - {$error}\n");
    }
    exit(1);
}

echo "[OK] Validación SQL Servicio Técnico completada sin errores detectados.\n";
