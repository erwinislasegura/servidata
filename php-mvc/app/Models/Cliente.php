<?php

namespace App\Models;

use App\Core\Database;

class Cliente
{
    public static function all(int $limit = 50): array
    {
        $stmt = Database::connection()->prepare('SELECT id, nombre, telefono, email, condicion FROM clientes ORDER BY id DESC LIMIT :limit');
        $stmt->bindValue(':limit', $limit, \PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll();
    }
}
