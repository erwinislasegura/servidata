<?php

declare(strict_types=1);

namespace App\Core;

final class Auth
{
    public static function check(): bool
    {
        return isset($_SESSION['user']);
    }

    public static function user(): ?array
    {
        return $_SESSION['user'] ?? null;
    }

    public static function login(array $user): void
    {
        $_SESSION['user'] = $user;
        $_SESSION['csrf'] = bin2hex(random_bytes(32));
    }

    public static function logout(): void
    {
        session_destroy();
    }

    public static function can(string $permission): bool
    {
        if (!self::check()) {
            return false;
        }

        return in_array($permission, self::user()['permissions'] ?? [], true);
    }
}
