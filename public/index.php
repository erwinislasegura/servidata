<?php

declare(strict_types=1);

if (!function_exists('str_starts_with')) {
    function str_starts_with(string $haystack, string $needle): bool
    {
        if ($needle === '') {
            return true;
        }

        return strncmp($haystack, $needle, strlen($needle)) === 0;
    }
}

if (!function_exists('str_ends_with')) {
    function str_ends_with(string $haystack, string $needle): bool
    {
        if ($needle === '') {
            return true;
        }

        $longitud = strlen($needle);
        if ($longitud > strlen($haystack)) {
            return false;
        }

        return substr($haystack, -$longitud) === $needle;
    }
}

if (!function_exists('str_contains')) {
    function str_contains(string $haystack, string $needle): bool
    {
        if ($needle === '') {
            return true;
        }

        return strpos($haystack, $needle) !== false;
    }
}

if (!function_exists('renderizar_error_critico')) {
    function renderizar_error_critico(string $mensaje): void
    {
        http_response_code(500);
        echo '<!doctype html><html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">';
        echo '<title>Error interno</title>';
        echo '<style>body{font-family:Arial,sans-serif;background:#f8fafc;color:#1f2937;margin:0;padding:24px}.card{max-width:760px;margin:32px auto;background:#fff;border:1px solid #d1d5db;border-radius:10px;padding:20px}h1{margin:0 0 12px;font-size:22px}.muted{color:#4b5563;font-size:14px}</style>';
        echo '</head><body><div class="card"><h1>No se pudo cargar la aplicación</h1><p>' . htmlspecialchars($mensaje, ENT_QUOTES, 'UTF-8') . '</p>';
        echo '<p class="muted">Revisa el <code>error_log</code> del hosting para más detalle técnico.</p></div></body></html>';
    }
}

register_shutdown_function(function (): void {
    $error = error_get_last();
    if (!$error) {
        return;
    }

    $fatales = [E_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR, E_USER_ERROR];
    if (!in_array((int) $error['type'], $fatales, true)) {
        return;
    }

    error_log('[FerriTalia] Fatal bootstrap error: ' . ($error['message'] ?? 'sin detalle') . ' en ' . ($error['file'] ?? 'desconocido') . ':' . ($error['line'] ?? 0));
    if (!headers_sent()) {
        renderizar_error_critico('Ocurrió un error crítico durante el arranque. Si el problema persiste, contacta soporte técnico.');
    }
});

spl_autoload_register(function (string $clase): void {
    $prefijo = 'Aplicacion\\';
    if (!str_starts_with($clase, $prefijo)) {
        return;
    }

    $segmentos = explode('\\', substr($clase, strlen($prefijo)));
    if ($segmentos !== []) {
        $segmentos[0] = strtolower($segmentos[0]);
    }

    $relativa = implode('/', $segmentos);
    $ruta = __DIR__ . '/../aplicacion/' . $relativa . '.php';
    if (is_file($ruta)) {
        require_once $ruta;
    }
});

require_once __DIR__ . '/../aplicacion/nucleo/App.php';

try {
    \Aplicacion\Nucleo\App::iniciar();
} catch (\Throwable $e) {
    error_log('[FerriTalia] Uncaught exception: ' . $e->getMessage() . ' en ' . $e->getFile() . ':' . $e->getLine());
    renderizar_error_critico('Se produjo un error interno al iniciar la aplicación.');
}
