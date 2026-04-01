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
        $this->view('dashboard/index', [
            'metrics' => $orderModel->dashboardMetrics(),
            'statusChart' => $orderModel->byStatus(),
            'latestOrders' => $orderModel->latest(),
        ]);
    }
}
