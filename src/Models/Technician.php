<?php

declare(strict_types=1);

namespace App\Models;

final class Technician extends BaseModel
{
    public function allActive(): array
    {
        return $this->db->query('SELECT id, CONCAT(first_name, " ", last_name) AS full_name FROM technicians WHERE status = 1 AND deleted_at IS NULL ORDER BY first_name ASC')->fetchAll();
    }
}
