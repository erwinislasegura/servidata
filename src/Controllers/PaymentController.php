<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\Controller;

final class PaymentController extends Controller
{
    public function index(): void
    {
        $this->view('payment/index');
    }
}
