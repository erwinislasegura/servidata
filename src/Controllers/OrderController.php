<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\Controller;
use App\Models\ServiceOrder;

final class OrderController extends Controller
{
    public function index(): void
    {
        $this->view('orders/index', ['orders' => (new ServiceOrder())->all()]);
    }
}
