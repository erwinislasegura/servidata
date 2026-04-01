<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Orden;

class OrdenController extends Controller
{
    public function index(): void
    {
        $this->ensureAuth();
        $ordenes = Orden::latest(100);
        $this->view('ordenes/index', compact('ordenes'));
    }

    private function ensureAuth(): void
    {
        if (!isset($_SESSION['auth'])) {
            $this->redirect('/login');
        }
    }
}
