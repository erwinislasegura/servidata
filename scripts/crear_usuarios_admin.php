<?php
/**
 * Creador de usuarios administrativos iniciales.
 *
 * Ejecuta el SQL que garantiza la existencia de:
 * - Superadministrador global
 * - Administrador de cliente (empresa)
 *
 * Uso: php scripts/crear_usuarios_admin.php
 */

declare(strict_types=1);

require_once __DIR__ . '/../aplicacion/nucleo/CargadorEntorno.php';

use Aplicacion\Nucleo\CargadorEntorno;

CargadorEntorno::cargar(__DIR__ . '/../.env');
$config = require __DIR__ . '/../configuracion/base_datos.php';

$dsn = sprintf('mysql:host=%s;port=%s;dbname=%s;charset=%s', $config['host'], $config['puerto'], $config['nombre'], $config['charset']);
$sqlPath = __DIR__ . '/../base_datos/actualizaciones/actualizacion_usuarios_superadmin_admin_cliente.sql';
$logPath = __DIR__ . '/../base_datos/actualizaciones/actualizacion_usuarios_superadmin_admin_cliente.log';
$nombreBaseDatos = (string) $config['nombre'];

if (!file_exists($sqlPath)) {
    fwrite(STDERR, "No se encontró el SQL de usuarios administrativos: {$sqlPath}\n");
    exit(1);
}

try {
    $pdo = new PDO($dsn, $config['usuario'], $config['password'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);

    echo "[INFO] Creando/actualizando usuarios administrativos...\n";

    $sql = file_get_contents($sqlPath);
    if ($sql === false) {
        throw new RuntimeException("No se pudo leer {$sqlPath}");
    }

    $pdo->exec(sprintf('USE `%s`;', str_replace('`', '``', $nombreBaseDatos)));
    $pdo->exec($sql);

    $mensaje = sprintf("[%s] Usuarios administrativos creados/actualizados correctamente.%s", date('Y-m-d H:i:s'), PHP_EOL);
    file_put_contents($logPath, $mensaje, FILE_APPEND);

    echo "[OK] Proceso finalizado.\n";
    echo "[OK] Log: {$logPath}\n";
    echo "[OK] Credenciales demo sugeridas: superadmin@cotizapro.com y admin.cliente@cotizapro.com (Demo1234*).\n";
} catch (Throwable $e) {
    file_put_contents($logPath, sprintf("[%s] ERROR: %s%s", date('Y-m-d H:i:s'), $e->getMessage(), PHP_EOL), FILE_APPEND);
    fwrite(STDERR, "[ERROR] Falló la creación de usuarios administrativos: {$e->getMessage()}\n");
    exit(1);
}
