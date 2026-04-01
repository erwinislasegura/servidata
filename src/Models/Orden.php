<?php

namespace App\Models;

use App\Core\Database;

class Orden
{
    public static function latest(int $limit = 50): array
    {
        $sql = 'SELECT o.id, c.nombre AS cliente, t.nombre AS tecnico, o.nombreEquipo, o.marca, o.modelo, o.estado, o.totalPagar, o.fechaEntrada
                FROM orden o
                INNER JOIN clientes c ON c.id = o.idcliente
                INNER JOIN tecnicos t ON t.id = o.idtecnico
                ORDER BY o.id DESC
                LIMIT :limit';

        $stmt = Database::connection()->prepare($sql);
        $stmt->bindValue(':limit', $limit, \PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetchAll();
    }

    public static function resumen(): array
    {
        $db = Database::connection();
        $total = (int) $db->query('SELECT COUNT(*) FROM orden')->fetchColumn();
        $entregados = (int) $db->query("SELECT COUNT(*) FROM orden WHERE estado = 'Entregado'")->fetchColumn();
        $reparacion = (int) $db->query("SELECT COUNT(*) FROM orden WHERE estado = 'Reparando'")->fetchColumn();

        return compact('total', 'entregados', 'reparacion');
    }
}
