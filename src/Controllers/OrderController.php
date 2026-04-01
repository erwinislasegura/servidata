<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\Controller;
use App\Core\Csrf;
use App\Models\Customer;
use App\Models\ServiceOrder;
use App\Models\ServiceStatus;
use App\Models\Technician;

final class OrderController extends Controller
{
    public function index(): void
    {
        $this->view('orders/index', [
            'orders' => (new ServiceOrder())->all(),
            'customers' => (new Customer())->paginate(),
            'statuses' => (new ServiceStatus())->all(),
            'technicians' => (new Technician())->allActive(),
        ]);
    }

    public function create(): void
    {
        if (!Csrf::validate((string) $this->input('csrf_token'))) {
            flash('danger', 'Token CSRF inválido. Intente nuevamente.');
            $this->redirect('/orders');
        }

        $customerId = (int) $this->input('customer_id', 0);
        if ($customerId <= 0) {
            flash('danger', 'Debes seleccionar un cliente registrado o crearlo desde el botón Nuevo.');
            $this->redirect('/orders');
        }

        $ok = (new ServiceOrder())->createFast([
            'customer_id' => $customerId,
            'customer_first_name' => (string) $this->input('customer_first_name', ''),
            'customer_last_name' => (string) $this->input('customer_last_name', ''),
            'customer_document' => (string) $this->input('customer_document', ''),
            'customer_phone' => (string) $this->input('customer_phone', ''),
            'customer_email' => (string) $this->input('customer_email', ''),
            'customer_address' => (string) $this->input('customer_address', ''),
            'customer_city' => (string) $this->input('customer_city', ''),
            'customer_notes' => (string) $this->input('customer_notes', ''),
            'technician_id' => (string) $this->input('technician_id', ''),
            'device_type' => (string) $this->input('device_type', 'otro'),
            'device_brand' => (string) $this->input('device_brand', ''),
            'device_model' => (string) $this->input('device_model', ''),
            'device_serial' => (string) $this->input('device_serial', ''),
            'device_imei' => (string) $this->input('device_imei', ''),
            'device_color' => (string) $this->input('device_color', ''),
            'device_accessories' => (string) $this->input('device_accessories', ''),
            'unlock_code' => (string) $this->input('unlock_code', ''),
            'issue_main' => (string) $this->input('issue_main', ''),
            'issue_detail' => (string) $this->input('issue_detail', ''),
            'physical_state' => (string) $this->input('physical_state', ''),
            'reception_notes' => (string) $this->input('reception_notes', ''),
            'allow_review' => (string) $this->input('allow_review', ''),
            'allow_format' => (string) $this->input('allow_format', ''),
            'allow_backup' => (string) $this->input('allow_backup', ''),
            'estimated_total' => (float) $this->input('estimated_total', 0),
            'estimated_date' => (string) $this->input('estimated_date', ''),
            'status_id' => (int) $this->input('status_id', 1),
            'priority' => (string) $this->input('priority', 'media'),
            'internal_notes' => (string) $this->input('internal_notes', ''),
            'public_notes' => (string) $this->input('public_notes', ''),
        ]);

        flash($ok ? 'success' : 'danger', $ok ? 'Orden registrada correctamente.' : 'No se pudo registrar la orden.');
        $this->redirect('/orders');
    }

    public function createCustomer(): void
    {
        if (!Csrf::validate((string) $this->input('csrf_token'))) {
            $this->jsonResponse(['ok' => false, 'message' => 'Token CSRF inválido.'], 422);
        }

        $firstName = trim((string) $this->input('first_name', ''));
        $lastName = trim((string) $this->input('last_name', ''));

        if ($firstName === '' || $lastName === '') {
            $this->jsonResponse(['ok' => false, 'message' => 'Nombres y apellidos son obligatorios.'], 422);
        }

        $customerId = (new Customer())->create([
            'first_name' => $firstName,
            'last_name' => $lastName,
            'document_number' => (string) $this->input('document_number', ''),
            'phone' => (string) $this->input('phone', ''),
            'email' => (string) $this->input('email', ''),
            'address' => (string) $this->input('address', ''),
            'city' => (string) $this->input('city', ''),
            'notes' => (string) $this->input('notes', ''),
            'status' => 1,
        ]);

        $this->jsonResponse([
            'ok' => true,
            'customer' => [
                'id' => $customerId,
                'first_name' => $firstName,
                'last_name' => $lastName,
                'document_number' => (string) $this->input('document_number', ''),
                'phone' => (string) $this->input('phone', ''),
                'email' => (string) $this->input('email', ''),
                'address' => (string) $this->input('address', ''),
                'city' => (string) $this->input('city', ''),
            ],
        ]);
    }

    private function jsonResponse(array $payload, int $status = 200): void
    {
        http_response_code($status);
        header('Content-Type: application/json; charset=utf-8');
        echo json_encode($payload, JSON_UNESCAPED_UNICODE);
        exit;
    }
}
