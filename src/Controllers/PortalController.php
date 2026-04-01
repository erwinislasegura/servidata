<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\Container;
use App\Core\Controller;

final class PortalController extends Controller
{
    public function searchForm(): void
    {
        $this->view('portal/search', [], 'layouts/guest');
    }

    public function searchResult(): void
    {
        $db = Container::get('db')->pdo();
        $stmt = $db->prepare('SELECT so.order_number, so.entry_date, so.public_notes, so.estimated_total, ss.name status_name, CONCAT(c.first_name, " ", c.last_name) customer, d.device_type, d.brand, d.model FROM service_orders so JOIN customers c ON c.id=so.customer_id JOIN devices d ON d.id=so.device_id JOIN service_statuses ss ON ss.id=so.current_status_id WHERE so.order_number=:order_number AND (so.public_tracking_code=:track OR c.phone=:phone) LIMIT 1');
        $stmt->execute([
            'order_number' => $this->input('order_number'),
            'track' => $this->input('track_or_phone'),
            'phone' => $this->input('track_or_phone'),
        ]);

        $order = $stmt->fetch();
        $history = [];
        if ($order) {
            $hs = $db->prepare('SELECT changed_at, new_status_name, public_comment FROM service_order_status_history WHERE order_number=:order ORDER BY id ASC');
            $hs->execute(['order' => $order['order_number']]);
            $history = $hs->fetchAll();
        }

        $this->view('portal/result', ['order' => $order, 'history' => $history], 'layouts/guest');
    }
}
