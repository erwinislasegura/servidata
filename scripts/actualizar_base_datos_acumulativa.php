<?php
/**
 * Actualizador acumulativo de base de datos.
 *
 * Ejecuta todos los archivos SQL en base_datos/actualizaciones en orden alfabético.
 * Uso: php scripts/actualizar_base_datos_acumulativa.php
 */

declare(strict_types=1);

require_once __DIR__ . '/../aplicacion/nucleo/CargadorEntorno.php';

use Aplicacion\Nucleo\CargadorEntorno;

CargadorEntorno::cargar(__DIR__ . '/../.env');
$config = require __DIR__ . '/../configuracion/base_datos.php';

$dsn = sprintf(
    'mysql:host=%s;port=%s;dbname=%s;charset=%s',
    $config['host'],
    $config['puerto'],
    $config['nombre'],
    $config['charset']
);

$directorioActualizaciones = __DIR__ . '/../base_datos/actualizaciones';
$logPath = $directorioActualizaciones . '/actualizacion_acumulativa.log';
$nombreBaseDatos = (string) $config['nombre'];

if (!is_dir($directorioActualizaciones)) {
    fwrite(STDERR, "No se encontró el directorio de actualizaciones: {$directorioActualizaciones}\n");
    exit(1);
}

$archivosSql = glob($directorioActualizaciones . '/*.sql');
if ($archivosSql === false || $archivosSql === []) {
    fwrite(STDERR, "No se encontraron archivos SQL en {$directorioActualizaciones}\n");
    exit(1);
}

natsort($archivosSql);
$archivosSql = array_values($archivosSql);

try {
    $pdo = new PDO($dsn, $config['usuario'], $config['password'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);

    echo "[INFO] Iniciando actualización acumulativa de base de datos...\n";
    echo "[INFO] Recomendación: respalda la base de datos antes de continuar.\n";

    foreach ($archivosSql as $archivoSql) {
        $nombreArchivo = basename($archivoSql);
        echo "[INFO] Aplicando {$nombreArchivo}...\n";

        $sql = file_get_contents($archivoSql);
        if ($sql === false) {
            throw new RuntimeException("No se pudo leer {$archivoSql}");
        }

        // Respeta siempre la BD configurada y evita fallos por USE hardcodeado en los .sql.
        $sql = preg_replace('/^\\s*USE\\s+`?[^`;]+`?\\s*;\\s*$/im', '', $sql) ?? $sql;

        if (trim($sql) !== '') {
            $pdo->exec(sprintf('USE `%s`;', str_replace('`', '``', $nombreBaseDatos)));
            $pdo->exec($sql);
        }

        $mensaje = sprintf(
            "[%s] OK %s%s",
            date('Y-m-d H:i:s'),
            $nombreArchivo,
            PHP_EOL
        );
        file_put_contents($logPath, $mensaje, FILE_APPEND);
    }

    echo "[OK] Actualización acumulativa finalizada.\n";
    echo "[OK] Log: {$logPath}\n";
} catch (Throwable $e) {
    $mensajeError = sprintf("[%s] ERROR: %s%s", date('Y-m-d H:i:s'), $e->getMessage(), PHP_EOL);
    file_put_contents($logPath, $mensajeError, FILE_APPEND);
    fwrite(STDERR, "[ERROR] Falló la actualización acumulativa: {$e->getMessage()}\n");
    exit(1);
}
