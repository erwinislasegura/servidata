<?php

declare(strict_types=1);
require __DIR__ . '/Helpers/helpers.php';

spl_autoload_register(function (string $class): void {
    $prefix = 'App\\';
    $baseDir = __DIR__ . '/';

    if (strncmp($prefix, $class, strlen($prefix)) !== 0) {
        return;
    }

    $relativeClass = substr($class, strlen($prefix));
    $file = $baseDir . str_replace('\\', '/', $relativeClass) . '.php';

    if (file_exists($file)) {
        require $file;
    }
});

$config = require __DIR__ . '/Config/config.php';

App\Core\Container::set('config', $config);
App\Core\Container::set('db', static fn (): App\Core\Database => new App\Core\Database($config['database']));
