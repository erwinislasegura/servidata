<?php

declare(strict_types=1);

session_start();

require __DIR__ . '/src/bootstrap.php';

use App\Core\Router;

$router = new Router();
require __DIR__ . '/src/routes.php';
$router->dispatch($_SERVER['REQUEST_METHOD'], $_SERVER['REQUEST_URI']);
