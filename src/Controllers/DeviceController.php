<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\Controller;
use App\Core\Csrf;
use App\Models\Customer;
use App\Models\Device;

final class DeviceController extends Controller
{
    public function index(): void
    {
        $this->view('devices/index', [
            'devices' => (new Device())->all(),
            'customers' => (new Customer())->paginate(),
        ]);
    }

    public function create(): void
    {
        if (!Csrf::validate($this->input('csrf_token'))) {
            flash('danger', 'Token inválido');
            $this->redirect('/devices');
        }

        (new Device())->create([
            'customer_id' => $this->input('customer_id'),
            'device_type' => $this->input('device_type'),
            'brand' => $this->input('brand'),
            'model' => $this->input('model'),
            'serial_number' => $this->input('serial_number'),
            'imei' => $this->input('imei'),
            'color' => $this->input('color'),
            'accessories' => $this->input('accessories'),
            'reported_issue' => $this->input('reported_issue'),
            'physical_state' => $this->input('physical_state'),
            'reception_notes' => $this->input('reception_notes'),
            'unlock_code' => $this->input('unlock_code'),
            'allow_review' => (int) $this->input('allow_review', 0),
            'allow_format' => (int) $this->input('allow_format', 0),
            'allow_backup' => (int) $this->input('allow_backup', 0),
            'entry_date' => $this->input('entry_date') ?: date('Y-m-d'),
        ]);

        flash('success', 'Equipo registrado correctamente.');
        $this->redirect('/devices');
    }
}
