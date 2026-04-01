<?php

namespace Aplicacion\Nucleo;

class Enrutador
{
    private array $rutas = [];

    /**
     * @param callable|array $accion
     */
    public function agregar(string $metodo, string $patron, $accion, array $middlewares = []): void
    {
        if (!is_callable($accion) && !is_array($accion)) {
            throw new \InvalidArgumentException('La acción de la ruta debe ser callable o array [Controlador::class, método].');
        }

        $this->rutas[] = compact('metodo', 'patron', 'accion', 'middlewares');
    }

    public function despachar(string $metodo, string $uri): void
    {
        foreach ($this->rutas as $ruta) {
            if ($ruta['metodo'] !== $metodo) {
                continue;
            }

            $regex = preg_replace('#\{([a-zA-Z_][a-zA-Z0-9_]*)\}#', '(?P<$1>[^/]+)', $ruta['patron']);
            $regex = '#^' . $regex . '$#';

            if (!preg_match($regex, $uri, $coincidencias)) {
                continue;
            }

            foreach ($ruta['middlewares'] as $middleware) {
                (new $middleware())->manejar();
            }

            $parametros = array_filter($coincidencias, fn($k) => !is_int($k), ARRAY_FILTER_USE_KEY);

            if (is_array($ruta['accion'])) {
                [$controlador, $metodoAccion] = $ruta['accion'];
                $instancia = new $controlador();
                $instancia->$metodoAccion(...array_values($parametros));
                return;
            }

            call_user_func_array($ruta['accion'], array_values($parametros));
            return;
        }

        http_response_code(404);
        require __DIR__ . '/../vistas/errores/404.php';
    }
}
