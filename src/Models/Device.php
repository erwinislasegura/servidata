<?php

declare(strict_types=1);

namespace App\Models;

final class Device extends BaseModel
{
    public function all(): array
    {
        return $this->db->query('SELECT d.*, CONCAT(c.first_name, " ", c.last_name) customer FROM devices d JOIN customers c ON c.id=d.customer_id WHERE d.deleted_at IS NULL ORDER BY d.id DESC LIMIT 100')->fetchAll();
    }

    public function create(array $data): void
    {
        $stmt = $this->db->prepare('INSERT INTO devices (customer_id,device_type,brand,model,serial_number,imei,color,accessories,reported_issue,physical_state,reception_notes,unlock_code,allow_review,allow_format,allow_backup,entry_date,created_at,updated_at) VALUES (:customer_id,:device_type,:brand,:model,:serial_number,:imei,:color,:accessories,:reported_issue,:physical_state,:reception_notes,:unlock_code,:allow_review,:allow_format,:allow_backup,:entry_date,NOW(),NOW())');
        $stmt->execute($data);
    }
}
