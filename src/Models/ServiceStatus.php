<?php

declare(strict_types=1);

namespace App\Models;

use PDOException;

final class ServiceStatus extends BaseModel
{
    public function all(): array
    {
        try {
            return $this->db->query('SELECT id,name,color,is_final,sort_order FROM service_statuses ORDER BY sort_order ASC, id ASC')->fetchAll();
        } catch (PDOException) {
            return [];
        }
    }

    public function create(array $data): bool
    {
        try {
            $stmt = $this->db->prepare('INSERT INTO service_statuses (name,color,is_final,sort_order,created_at,updated_at) VALUES (:name,:color,:is_final,:sort_order,NOW(),NOW())');
            return $stmt->execute([
                'name' => $data['name'],
                'color' => $data['color'],
                'is_final' => (int) ($data['is_final'] ?? 0),
                'sort_order' => (int) ($data['sort_order'] ?? 0),
            ]);
        } catch (PDOException) {
            return false;
        }
    }

    public function historyLatest(int $limit = 50): array
    {
        try {
            $stmt = $this->db->prepare('SELECT h.order_number,h.old_status_name,h.new_status_name,h.public_comment,h.changed_at,u.full_name
                FROM service_order_status_history h
                JOIN users u ON u.id = h.changed_by_user_id
                ORDER BY h.id DESC LIMIT :limit');
            $stmt->bindValue(':limit', $limit, \PDO::PARAM_INT);
            $stmt->execute();
            return $stmt->fetchAll();
        } catch (PDOException) {
            return [];
        }
    }

    public function changeOrderStatus(array $data): bool
    {
        try {
            $this->db->beginTransaction();

            $currentStmt = $this->db->prepare('SELECT so.id, so.order_number, ss.name current_status FROM service_orders so JOIN service_statuses ss ON ss.id = so.current_status_id WHERE so.id = :id');
            $currentStmt->execute(['id' => $data['service_order_id']]);
            $order = $currentStmt->fetch();

            if (!$order) {
                $this->db->rollBack();
                return false;
            }

            $newStmt = $this->db->prepare('SELECT name FROM service_statuses WHERE id = :id');
            $newStmt->execute(['id' => $data['new_status_id']]);
            $newStatus = $newStmt->fetchColumn();

            if (!$newStatus) {
                $this->db->rollBack();
                return false;
            }

            $update = $this->db->prepare('UPDATE service_orders SET current_status_id = :status_id, updated_at = NOW() WHERE id = :id');
            $update->execute([
                'status_id' => $data['new_status_id'],
                'id' => $data['service_order_id'],
            ]);

            $history = $this->db->prepare('INSERT INTO service_order_status_history (service_order_id,order_number,old_status_name,new_status_name,changed_by_user_id,internal_comment,public_comment,changed_at,created_at)
                VALUES (:service_order_id,:order_number,:old_status_name,:new_status_name,:changed_by_user_id,:internal_comment,:public_comment,NOW(),NOW())');

            $history->execute([
                'service_order_id' => $data['service_order_id'],
                'order_number' => $order['order_number'],
                'old_status_name' => $order['current_status'],
                'new_status_name' => $newStatus,
                'changed_by_user_id' => $data['changed_by_user_id'],
                'internal_comment' => $data['internal_comment'] ?? null,
                'public_comment' => $data['public_comment'] ?? null,
            ]);

            $this->db->commit();
            return true;
        } catch (PDOException) {
            if ($this->db->inTransaction()) {
                $this->db->rollBack();
            }
            return false;
        }
    }
}
