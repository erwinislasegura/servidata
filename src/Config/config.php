<?php

declare(strict_types=1);

return [
    'app' => [
        'name' => 'Sistema de Gestión de Servicio Técnico',
        'url' => getenv('APP_URL') ?: 'http://localhost:8080',
        'timezone' => 'America/Santiago',
    ],
    'database' => [
        'host' => getenv('DB_HOST') ?: '127.0.0.1',
        'port' => getenv('DB_PORT') ?: '3306',
        'database' => getenv('DB_DATABASE') ?: 'taller_servicio',
        'username' => getenv('DB_USERNAME') ?: 'root',
        'password' => getenv('DB_PASSWORD') ?: '',
        'charset' => 'utf8mb4',
    ],
];
