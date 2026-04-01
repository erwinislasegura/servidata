<div class="d-flex justify-content-between align-items-center mb-3">
  <h2 class="h4 mb-0">Clientes</h2>
</div>

<div class="card shadow-sm mb-3">
  <div class="card-body">
    <form method="POST" action="<?= e(url('/app/servicio-tecnico/clientes')) ?>" class="row g-2">
      <?= csrf_campo() ?>
      <div class="col-md-2"><input required name="nombres" class="form-control form-control-sm" placeholder="Nombres"></div>
      <div class="col-md-2"><input required name="apellidos" class="form-control form-control-sm" placeholder="Apellidos"></div>
      <div class="col-md-2"><input name="rut" class="form-control form-control-sm" placeholder="RUT"></div>
      <div class="col-md-2"><input name="telefono" class="form-control form-control-sm" placeholder="Teléfono"></div>
      <div class="col-md-2"><input name="email" type="email" class="form-control form-control-sm" placeholder="Email"></div>
      <div class="col-md-2 d-grid"><button class="btn btn-primary btn-sm">Guardar cliente</button></div>
    </form>
  </div>
</div>

<div class="card shadow-sm">
  <div class="card-body border-bottom py-2">
    <form method="GET" class="row g-2 align-items-center">
      <div class="col-md-4"><input type="search" name="q" value="<?= e($buscar) ?>" class="form-control form-control-sm" placeholder="Buscar por nombre, RUT, teléfono, email"></div>
      <div class="col-auto"><button class="btn btn-outline-secondary btn-sm">Buscar</button></div>
    </form>
  </div>
  <div class="table-responsive">
    <table class="table table-sm table-hover mb-0">
      <thead class="table-light"><tr><th>Cliente</th><th>RUT</th><th>Teléfono</th><th>Email</th><th>Estado</th><th class="text-end">Acciones</th></tr></thead>
      <tbody>
      <?php foreach ($clientes as $cliente): ?>
        <tr>
          <td><?= e(trim(($cliente['nombres'] ?? '') . ' ' . ($cliente['apellidos'] ?? ''))) ?></td>
          <td><?= e($cliente['rut'] ?? '-') ?></td>
          <td><?= e($cliente['telefono'] ?? '-') ?></td>
          <td><?= e($cliente['email'] ?? '-') ?></td>
          <td><span class="badge text-bg-light"><?= e($cliente['estado']) ?></span></td>
          <td class="text-end">
            <a class="btn btn-outline-primary btn-sm" href="<?= e(url('/app/servicio-tecnico/ordenes?cliente_id=' . $cliente['id'])) ?>">Crear orden</a>
          </td>
        </tr>
      <?php endforeach; ?>
      </tbody>
    </table>
  </div>
</div>
