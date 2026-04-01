<?php

declare(strict_types=1);

require_once __DIR__ . '/../aplicacion/nucleo/CargadorEntorno.php';

use Aplicacion\Nucleo\CargadorEntorno;
CargadorEntorno::cargar(__DIR__ . '/../.env');
$config = require __DIR__ . '/../configuracion/base_datos.php';

$dsn = sprintf('mysql:host=%s;port=%s;charset=%s', $config['host'], $config['puerto'], $config['charset']);
$nombreBaseInstalacion = 'taller_servicio';

$archivos = [
    __DIR__ . '/../base_datos/esquema/esquema.sql',
    __DIR__ . '/../base_datos/esquema/semillas.sql',
    __DIR__ . '/../base_datos/esquema/datos_demo.sql',
];

$actualizaciones = glob(__DIR__ . '/../base_datos/actualizaciones/*.sql') ?: [];
sort($actualizaciones);
$archivos = array_merge($archivos, $actualizaciones);

try {
    $pdo = new PDO($dsn, $config['usuario'], $config['password'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    ]);

    $pdo->exec(sprintf('CREATE DATABASE IF NOT EXISTS `%s` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;', str_replace('`', '``', $nombreBaseInstalacion)));
    $pdo->exec(sprintf('USE `%s`;', str_replace('`', '``', $nombreBaseInstalacion)));

    echo "[INFO] Instalando base de datos completa en {$nombreBaseInstalacion}...\n";

    foreach ($archivos as $archivo) {
        $sql = file_get_contents($archivo);
        if ($sql === false) {
            throw new RuntimeException('No se pudo leer: ' . $archivo);
        }

        $sql = preg_replace('/^\s*USE\s+`?[^`;]+`?\s*;\s*$/im', '', $sql) ?? $sql;
        if (trim($sql) === '') {
            continue;
        }

        $pdo->exec(sprintf('USE `%s`;', str_replace('`', '``', $nombreBaseInstalacion)));
        $pdo->exec($sql);
        echo '[OK] ' . basename($archivo) . "\n";
    }

    $checks = [
        'clientes' => 'SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = "st_clientes"',
        'ordenes' => 'SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = "st_ordenes"',
        'root' => 'SELECT COUNT(*) FROM usuarios WHERE correo = "root@tallerlocal.com" AND estado = "activo"',
        'admin' => 'SELECT COUNT(*) FROM usuarios WHERE correo = "admin@tallerlocal.com" AND estado = "activo"',
    ];

    foreach ($checks as $nombre => $query) {
        $valor = (int) $pdo->query($query)->fetchColumn();
        if ($valor <= 0) {
            throw new RuntimeException("Validación fallida: {$nombre}");
        }
    }

    echo "[OK] Base de datos FULL instalada correctamente con usuarios root.\n";
} catch (Throwable $e) {
    fwrite(STDERR, '[ERROR] ' . $e->getMessage() . "\n");
    exit(1);
}
