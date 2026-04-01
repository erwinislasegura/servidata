<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\Controller;
use App\Core\Csrf;
use App\Models\Customer;

final class CustomerController extends Controller
{
    public function index(): void
    {
        $this->view('customers/index', ['customers' => (new Customer())->paginate((string) $this->input('q', ''))]);
    }

    public function create(): void
    {
        if (!Csrf::validate($this->input('csrf_token'))) {
            flash('danger', 'Token inválido.');
            $this->redirect('/customers');
        }

        (new Customer())->create([
            'first_name' => $this->input('first_name'),
            'last_name' => $this->input('last_name'),
            'document_number' => $this->input('document_number'),
            'phone' => $this->input('phone'),
            'email' => $this->input('email'),
            'address' => $this->input('address'),
            'city' => $this->input('city'),
            'notes' => $this->input('notes'),
            'status' => (int) $this->input('status', 1),
        ]);

        flash('success', 'Cliente creado correctamente.');
        $this->redirect('/customers');
    }
}
