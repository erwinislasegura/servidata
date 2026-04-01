<?php

namespace App\Models;

use App\Core\Database;

class User
{
    public static function findByUsuario(string $usuario): ?array
    {
        $stmt = Database::connection()->prepare('SELECT * FROM users WHERE usuario = :usuario LIMIT 1');
        $stmt->execute(['usuario' => $usuario]);
        $user = $stmt->fetch();

        return $user ?: null;
    }
}
