<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\Auth;
use App\Core\Controller;
use App\Core\Csrf;
use App\Models\ServiceOrder;
use App\Models\ServiceStatus;

final class StatusController extends Controller
{
    public function index(): void
    {
        $statusModel = new ServiceStatus();

        $this->view('statuses/index', [
            'statuses' => $statusModel->all(),
            'orders' => (new ServiceOrder())->all(),
            'history' => $statusModel->historyLatest(),
        ]);
    }

    public function create(): void
    {
        if (!Csrf::validate($this->input('csrf_token'))) {
            flash('danger', 'Token CSRF inválido.');
            $this->redirect('/statuses');
        }

        $name = trim((string) $this->input('name'));
        if ($name === '') {
            flash('warning', 'Debe indicar el nombre del estado.');
            $this->redirect('/statuses');
        }

        $ok = (new ServiceStatus())->create([
            'name' => $name,
            'color' => $this->input('color', 'secondary'),
            'is_final' => (int) $this->input('is_final', 0),
            'sort_order' => (int) $this->input('sort_order', 0),
        ]);

        flash($ok ? 'success' : 'danger', $ok ? 'Estado creado correctamente.' : 'No fue posible crear el estado.');
        $this->redirect('/statuses');
    }

    public function change(): void
    {
        if (!Csrf::validate($this->input('csrf_token'))) {
            flash('danger', 'Token CSRF inválido.');
            $this->redirect('/statuses');
        }

        $user = Auth::user();
        $ok = (new ServiceStatus())->changeOrderStatus([
            'service_order_id' => (int) $this->input('service_order_id'),
            'new_status_id' => (int) $this->input('new_status_id'),
            'internal_comment' => trim((string) $this->input('internal_comment')),
            'public_comment' => trim((string) $this->input('public_comment')),
            'changed_by_user_id' => (int) ($user['id'] ?? 0),
        ]);

        flash($ok ? 'success' : 'danger', $ok ? 'Estado de la orden actualizado.' : 'No se pudo actualizar el estado.');
        $this->redirect('/statuses');
    }
}
