<?php

namespace App\Controllers;

use App\Core\Controller;
use App\Models\Cliente;

class ClienteController extends Controller
{
    public function index(): void
    {
        $this->ensureAuth();
        $clientes = Cliente::all(100);
        $this->view('clientes/index', compact('clientes'));
    }

    private function ensureAuth(): void
    {
        if (!isset($_SESSION['auth'])) {
            $this->redirect('/login');
        }
    }
}
