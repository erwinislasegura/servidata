<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\Controller;
use App\Models\ServiceOrder;

final class DashboardController extends Controller
{
    public function index(): void
    {
        $orderModel = new ServiceOrder();
        $metrics = $orderModel->dashboardMetrics();
        $statusChart = $orderModel->byStatus();
        $latestOrders = $orderModel->latest();

        if ($metrics['orders_today'] === 0 && $metrics['customers_total'] === 0 && $statusChart === []) {
            flash('warning', 'Panel cargado en modo inicial. Verifica que la base de datos esté importada correctamente.');
        }

        $this->view('dashboard/index', [
            'metrics' => $metrics,
            'statusChart' => $statusChart,
            'latestOrders' => $latestOrders,
        ]);
    }
}
