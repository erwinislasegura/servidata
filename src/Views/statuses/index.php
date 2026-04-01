<h5 class="mb-3">Estados y Seguimiento</h5>

<div class="row g-3 mb-3">
  <div class="col-lg-5">
    <div class="card h-100">
      <div class="card-body">
        <h6 class="mb-3">Configurar estado</h6>
        <form method="post" action="<?= url('/statuses/create') ?>" class="row g-2">
          <?= csrf_field() ?>
          <div class="col-12">
            <input required name="name" class="form-control" placeholder="Nombre del estado">
          </div>
          <div class="col-md-4">
            <select name="color" class="form-select">
              <option value="secondary">Gris</option>
              <option value="primary">Azul</option>
              <option value="info">Info</option>
              <option value="warning">Amarillo</option>
              <option value="success">Verde</option>
              <option value="danger">Rojo</option>
              <option value="dark">Oscuro</option>
            </select>
          </div>
          <div class="col-md-4">
            <input type="number" name="sort_order" class="form-control" placeholder="Orden" value="0">
          </div>
          <div class="col-md-4 form-check d-flex align-items-center ps-4">
            <input class="form-check-input" type="checkbox" value="1" id="is_final" name="is_final">
            <label class="form-check-label" for="is_final">Final</label>
          </div>
          <div class="col-12">
            <button class="btn btn-dark w-100">Guardar estado</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <div class="col-lg-7">
    <div class="card h-100">
      <div class="card-body">
        <h6 class="mb-3">Cambio rápido de estado</h6>
        <form method="post" action="<?= url('/statuses/change') ?>" class="row g-2">
          <?= csrf_field() ?>
          <div class="col-md-6">
            <select required name="service_order_id" class="form-select">
              <option value="">Seleccionar orden...</option>
              <?php foreach ($orders as $order): ?>
                <option value="<?= e((string) $order['id']) ?>"><?= e($order['order_number']) ?> · <?= e($order['customer']) ?></option>
              <?php endforeach; ?>
            </select>
          </div>
          <div class="col-md-6">
            <select required name="new_status_id" class="form-select">
              <option value="">Nuevo estado...</option>
              <?php foreach ($statuses as $status): ?>
                <option value="<?= e((string) $status['id']) ?>"><?= e($status['name']) ?></option>
              <?php endforeach; ?>
            </select>
          </div>
          <div class="col-md-6">
            <input name="internal_comment" class="form-control" placeholder="Comentario interno">
          </div>
          <div class="col-md-6">
            <input name="public_comment" class="form-control" placeholder="Comentario visible al cliente">
          </div>
          <div class="col-12">
            <button class="btn btn-primary w-100">Actualizar estado</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="card mb-3">
  <div class="card-body">
    <h6 class="mb-2">Listado de estados</h6>
    <div class="table-responsive">
      <table class="table table-sm align-middle">
        <thead><tr><th>#</th><th>Estado</th><th>Color</th><th>Orden</th><th>Final</th></tr></thead>
        <tbody>
        <?php foreach ($statuses as $status): ?>
          <tr>
            <td><?= e((string) $status['id']) ?></td>
            <td><?= e($status['name']) ?></td>
            <td><span class="badge bg-<?= e($status['color']) ?>"><?= e($status['color']) ?></span></td>
            <td><?= e((string) $status['sort_order']) ?></td>
            <td><?= (int) $status['is_final'] === 1 ? 'Sí' : 'No' ?></td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
    </div>
  </div>
</div>

<div class="card">
  <div class="card-body">
    <h6 class="mb-2">Historial reciente</h6>
    <div class="table-responsive">
      <table class="table table-hover table-sm align-middle">
        <thead><tr><th>Fecha</th><th>Orden</th><th>Cambio</th><th>Comentario cliente</th><th>Usuario</th></tr></thead>
        <tbody>
        <?php foreach ($history as $item): ?>
          <tr>
            <td><?= e((string) $item['changed_at']) ?></td>
            <td><?= e($item['order_number']) ?></td>
            <td><?= e(($item['old_status_name'] ?: 'Sin estado') . ' → ' . $item['new_status_name']) ?></td>
            <td><?= e((string) $item['public_comment']) ?></td>
            <td><?= e($item['full_name']) ?></td>
          </tr>
        <?php endforeach; ?>
        </tbody>
      </table>
    </div>
  </div>
</div>
