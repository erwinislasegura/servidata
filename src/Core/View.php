<?php

namespace App\Core;

class View
{
    public static function render(string $view, array $data = []): void
    {
        extract($data, EXTR_SKIP);
        $viewPath = __DIR__ . '/../Views/' . $view . '.php';

        if (!file_exists($viewPath)) {
            http_response_code(404);
            echo "Vista no encontrada: {$view}";
            return;
        }

        require __DIR__ . '/../Views/layouts/header.php';
        require $viewPath;
        require __DIR__ . '/../Views/layouts/footer.php';
    }
}
