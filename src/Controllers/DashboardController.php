<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Orden;

class DashboardController extends Controller
{
    public function index(): void
    {
        $this->ensureAuth();

        $resumen = Orden::resumen();
        $ultimasOrdenes = Orden::latest(10);

        $this->view('dashboard/index', compact('resumen', 'ultimasOrdenes'));
    }

    private function ensureAuth(): void
    {
        if (!isset($_SESSION['auth'])) {
            $this->redirect('/login');
        }
    }
}
