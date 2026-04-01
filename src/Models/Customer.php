<?php

declare(strict_types=1);

namespace App\Models;

final class Customer extends BaseModel
{
    public function paginate(string $term = ''): array
    {
        $sql = 'SELECT * FROM customers WHERE deleted_at IS NULL';
        $params = [];

        if ($term !== '') {
            $sql .= ' AND (first_name LIKE :term OR last_name LIKE :term OR document_number LIKE :term OR phone LIKE :term)';
            $params['term'] = '%' . $term . '%';
        }

        $sql .= ' ORDER BY id DESC LIMIT 100';
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }

    public function create(array $data): int
    {
        $stmt = $this->db->prepare('INSERT INTO customers (first_name,last_name,document_number,phone,email,address,city,notes,status,created_at,updated_at) VALUES (:first_name,:last_name,:document_number,:phone,:email,:address,:city,:notes,:status,NOW(),NOW())');
        $stmt->execute($data);
        return (int) $this->db->lastInsertId();
    }
}
