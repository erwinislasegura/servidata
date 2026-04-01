<?php

declare(strict_types=1);

use App\Core\Csrf;

function e(string $value): string { return htmlspecialchars($value, ENT_QUOTES, 'UTF-8'); }
function csrf_field(): string { return '<input type="hidden" name="csrf_token" value="' . Csrf::token() . '">'; }
function flash(string $type, string $message): void { $_SESSION['flash'] = compact('type', 'message'); }
function get_flash(): ?array { $f = $_SESSION['flash'] ?? null; unset($_SESSION['flash']); return $f; }

function base_path_url(): string {
    $script = $_SERVER['SCRIPT_NAME'] ?? '';
    $base = rtrim(str_replace('\\', '/', dirname($script)), '/');
    return $base === '/' ? '' : $base;
}
function url(string $path = ''): string {
    $base = base_path_url();
    $path = '/' . ltrim($path, '/');
    return $base . ($path === '/' ? '' : $path);
}
function asset(string $path): string {
    return url('/public/' . ltrim($path, '/'));
}

function clp(mixed $amount): string
{
    return '$' . number_format((float) $amount, 0, ',', '.');
}

function fecha_cl(?string $date): string
{
    if (!$date) {
        return '-';
    }
    $ts = strtotime($date);
    if ($ts === false) {
        return '-';
    }
    return date('d-m-Y H:i', $ts);
}

function is_active(string $path): bool
{
    $uri = $_SERVER['REQUEST_URI'] ?? '/';
    return str_contains($uri, $path);
}
