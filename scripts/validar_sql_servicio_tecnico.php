<?php

declare(strict_types=1);

$archivos = [
    __DIR__ . '/../base_datos/actualizaciones/actualizacion_coherencia_planes_publicos.sql',
    __DIR__ . '/../base_datos/actualizaciones/actualizacion_servicio_tecnico.sql',
    __DIR__ . '/../base_datos/actualizaciones/actualizacion_servicio_tecnico_admin_root.sql',
    __DIR__ . '/../base_datos/instalacion/base_datos_full_servicio_tecnico.sql',
];

$errores = [];

foreach ($archivos as $archivo) {
    if (!is_file($archivo)) {
        $errores[] = "No existe archivo SQL: {$archivo}";
        continue;
    }

    $contenido = (string) file_get_contents($archivo);

    $patronesPegados = [
        '/\bestadoFROM\b/i',
        '/\bt\.estadoFROM\b/i',
        '/\btmp_planes_base\s+tLEFT\b/i',
        '/\bslugWHERE\b/i',
        '/\)SELECT\b/i',
        '/\)FROM\b/i',
    ];

    foreach ($patronesPegados as $patron) {
        if (preg_match($patron, $contenido) === 1) {
            $errores[] = basename($archivo) . " contiene tokens SQL pegados detectados por {$patron}";
        }
    }

    $sentencias = preg_split('/;\s*(\r?\n|$)/', $contenido);
    if ($sentencias === false) {
        $errores[] = basename($archivo) . ' no pudo separarse en sentencias';
        continue;
    }

    $sentenciasNoVacias = 0;
    foreach ($sentencias as $sentencia) {
        if (trim($sentencia) !== '') {
            $sentenciasNoVacias++;
        }
    }

    if ($sentenciasNoVacias < 3) {
        $errores[] = basename($archivo) . ' tiene muy pocas sentencias SQL para ser válido';
    }
}

if ($errores !== []) {
    fwrite(STDERR, "[ERROR] Validación SQL con observaciones:\n");
    foreach ($errores as $error) {
        fwrite(STDERR, " - {$error}\n");
    }
    exit(1);
}

echo "[OK] Validación SQL Servicio Técnico completada sin errores detectados.\n";
