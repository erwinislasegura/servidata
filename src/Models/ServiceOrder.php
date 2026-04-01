<?php

declare(strict_types=1);

namespace App\Models;

final class ServiceOrder extends BaseModel
{
    public function dashboardMetrics(): array
    {
        $sql = 'SELECT
            (SELECT COUNT(*) FROM service_orders WHERE DATE(entry_date)=CURDATE()) orders_today,
            (SELECT COUNT(*) FROM customers WHERE deleted_at IS NULL) customers_total,
            (SELECT IFNULL(SUM(amount),0) FROM payments WHERE DATE(paid_at)=CURDATE()) income_today,
            (SELECT IFNULL(SUM(amount),0) FROM payments WHERE DATE_FORMAT(paid_at, "%Y-%m")=DATE_FORMAT(CURDATE(), "%Y-%m")) income_month,
            (SELECT COUNT(*) FROM inventory_items WHERE stock_current <= stock_minimum AND status=1) low_stock';
        return $this->db->query($sql)->fetch() ?: [];
    }

    public function byStatus(): array
    {
        return $this->db->query('SELECT ss.name, COUNT(*) total FROM service_orders so JOIN service_statuses ss ON ss.id=so.current_status_id GROUP BY ss.name ORDER BY total DESC')->fetchAll();
    }

    public function latest(): array
    {
        return $this->db->query('SELECT so.order_number,so.entry_date,ss.name status_name,CONCAT(c.first_name," ",c.last_name) customer FROM service_orders so JOIN customers c ON c.id=so.customer_id JOIN service_statuses ss ON ss.id=so.current_status_id ORDER BY so.id DESC LIMIT 10')->fetchAll();
    }

    public function all(): array
    {
        return $this->db->query('SELECT so.id,so.order_number,so.public_tracking_code,so.priority,so.estimated_total,so.payment_status,ss.name status_name,CONCAT(c.first_name," ",c.last_name) customer FROM service_orders so JOIN customers c ON c.id=so.customer_id JOIN service_statuses ss ON ss.id=so.current_status_id ORDER BY so.id DESC LIMIT 100')->fetchAll();
    }
}
