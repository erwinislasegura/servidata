<?php

declare(strict_types=1);

namespace App\Core;

final class Router
{
    private array $routes = [];

    public function get(string $path, string $action, bool $auth = true): void
    {
        $this->map('GET', $path, $action, $auth);
    }

    public function post(string $path, string $action, bool $auth = true): void
    {
        $this->map('POST', $path, $action, $auth);
    }

    private function map(string $method, string $path, string $action, bool $auth): void
    {
        $this->routes[$method][$path] = ['action' => $action, 'auth' => $auth];
    }

    public function dispatch(string $method, string $uri): void
    {
        $path = parse_url($uri, PHP_URL_PATH) ?: '/';
        $path = $this->normalizePath($path);
        $method = strtoupper($method) === 'HEAD' ? 'GET' : strtoupper($method);

        $route = $this->routes[$method][$path] ?? null;

        if (!$route) {
            http_response_code(404);
            echo '404 - Ruta no encontrada';
            return;
        }

        if ($route['auth'] && !Auth::check()) {
            header('Location: /login');
            return;
        }

        [$controller, $handler] = explode('@', $route['action']);
        $fqcn = 'App\\Controllers\\' . $controller;
        (new $fqcn())->{$handler}();
    }
    private function normalizePath(string $path): string
    {
        if ($path === '/') {
            return '/';
        }

        $normalized = '/' . trim($path, '/');
        return rtrim($normalized, '/') ?: '/';
    }

}
