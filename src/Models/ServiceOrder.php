<?php

declare(strict_types=1);

namespace App\Models;

use PDOException;

final class ServiceOrder extends BaseModel
{
    public function createFast(array $data): bool
    {
        try {
            $this->db->beginTransaction();

            $customerId = (int) ($data['customer_id'] ?? 0);
            if ($customerId <= 0) {
                $customerStmt = $this->db->prepare('INSERT INTO customers (first_name,last_name,document_number,phone,email,address,city,notes,status,created_at,updated_at) VALUES (:first_name,:last_name,:document_number,:phone,:email,:address,:city,:notes,1,NOW(),NOW())');
                $customerStmt->execute([
                    'first_name' => $data['customer_first_name'] ?: 'Cliente',
                    'last_name' => $data['customer_last_name'] ?: 'Mostrador',
                    'document_number' => $data['customer_document'],
                    'phone' => $data['customer_phone'],
                    'email' => $data['customer_email'],
                    'address' => $data['customer_address'],
                    'city' => $data['customer_city'],
                    'notes' => $data['customer_notes'],
                ]);
                $customerId = (int) $this->db->lastInsertId();
            }

            $deviceStmt = $this->db->prepare('INSERT INTO devices (customer_id,device_type,brand,model,serial_number,imei,color,accessories,reported_issue,physical_state,reception_notes,unlock_code,allow_review,allow_format,allow_backup,entry_date,created_at,updated_at) VALUES (:customer_id,:device_type,:brand,:model,:serial_number,:imei,:color,:accessories,:reported_issue,:physical_state,:reception_notes,:unlock_code,:allow_review,:allow_format,:allow_backup,CURDATE(),NOW(),NOW())');
            $deviceStmt->execute([
                'customer_id' => $customerId,
                'device_type' => $data['device_type'],
                'brand' => $data['device_brand'],
                'model' => $data['device_model'],
                'serial_number' => $data['device_serial'],
                'imei' => $data['device_imei'],
                'color' => $data['device_color'],
                'accessories' => $data['device_accessories'],
                'reported_issue' => $data['issue_main'],
                'physical_state' => $data['physical_state'],
                'reception_notes' => $data['reception_notes'],
                'unlock_code' => $data['unlock_code'],
                'allow_review' => (int) !empty($data['allow_review']),
                'allow_format' => (int) !empty($data['allow_format']),
                'allow_backup' => (int) !empty($data['allow_backup']),
            ]);
            $deviceId = (int) $this->db->lastInsertId();

            $orderStmt = $this->db->prepare('INSERT INTO service_orders (order_number,public_tracking_code,customer_id,device_id,technician_id,current_status_id,priority,service_category,failure_description,entry_date,estimated_date,internal_notes,public_notes,estimated_total,payment_status,service_status,created_at,updated_at) VALUES (:order_number,:public_tracking_code,:customer_id,:device_id,:technician_id,:current_status_id,:priority,:service_category,:failure_description,NOW(),:estimated_date,:internal_notes,:public_notes,:estimated_total,:payment_status,:service_status,NOW(),NOW())');
            $orderStmt->execute([
                'order_number' => $this->nextOrderNumber(),
                'public_tracking_code' => strtoupper(bin2hex(random_bytes(4))),
                'customer_id' => $customerId,
                'device_id' => $deviceId,
                'technician_id' => $data['technician_id'] ?: null,
                'current_status_id' => (int) ($data['status_id'] ?? 1),
                'priority' => $data['priority'] ?: 'media',
                'service_category' => $data['device_type'],
                'failure_description' => trim(($data['issue_main'] ?? '') . "\n" . ($data['issue_detail'] ?? '')),
                'estimated_date' => $data['estimated_date'] ?: null,
                'internal_notes' => $data['internal_notes'],
                'public_notes' => $data['public_notes'],
                'estimated_total' => (float) ($data['estimated_total'] ?? 0),
                'payment_status' => 'pendiente',
                'service_status' => 'abierto',
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

    private function nextOrderNumber(): string
    {
        $last = $this->db->query('SELECT id FROM service_orders ORDER BY id DESC LIMIT 1')->fetchColumn();
        $next = ((int) $last) + 1;
        return 'OS-' . date('Y') . '-' . str_pad((string) $next, 5, '0', STR_PAD_LEFT);
    }

    public function dashboardMetrics(): array
    {
        try {
            $sql = 'SELECT
                (SELECT COUNT(*) FROM service_orders WHERE DATE(entry_date)=CURDATE()) orders_today,
                (SELECT COUNT(*) FROM customers WHERE deleted_at IS NULL) customers_total,
                (SELECT IFNULL(SUM(amount),0) FROM payments WHERE DATE(paid_at)=CURDATE()) income_today,
                (SELECT IFNULL(SUM(amount),0) FROM payments WHERE DATE_FORMAT(paid_at, "%Y-%m")=DATE_FORMAT(CURDATE(), "%Y-%m")) income_month,
                (SELECT COUNT(*) FROM inventory_items WHERE stock_current <= stock_minimum AND status=1) low_stock';
            return $this->db->query($sql)->fetch() ?: [];
        } catch (PDOException) {
            return [
                'orders_today' => 0,
                'customers_total' => 0,
                'income_today' => 0,
                'income_month' => 0,
                'low_stock' => 0,
            ];
        }
    }

    public function byStatus(): array
    {
        try {
            return $this->db->query('SELECT ss.name, COUNT(*) total FROM service_orders so JOIN service_statuses ss ON ss.id=so.current_status_id GROUP BY ss.name ORDER BY total DESC')->fetchAll();
        } catch (PDOException) {
            return [];
        }
    }

    public function latest(): array
    {
        try {
            return $this->db->query('SELECT so.order_number,so.entry_date,ss.name status_name,CONCAT(c.first_name," ",c.last_name) customer FROM service_orders so JOIN customers c ON c.id=so.customer_id JOIN service_statuses ss ON ss.id=so.current_status_id ORDER BY so.id DESC LIMIT 10')->fetchAll();
        } catch (PDOException) {
            return [];
        }
    }

    public function all(): array
    {
        try {
            return $this->db->query('SELECT so.id,so.order_number,so.public_tracking_code,so.priority,so.estimated_total,so.payment_status,ss.name status_name,CONCAT(c.first_name," ",c.last_name) customer,t.first_name tech_name,d.device_type,d.brand,d.model,so.entry_date,so.estimated_date FROM service_orders so JOIN customers c ON c.id=so.customer_id JOIN service_statuses ss ON ss.id=so.current_status_id LEFT JOIN technicians t ON t.id=so.technician_id LEFT JOIN devices d ON d.id=so.device_id ORDER BY so.id DESC LIMIT 100')->fetchAll();
        } catch (PDOException) {
            return [];
        }
    }
}
