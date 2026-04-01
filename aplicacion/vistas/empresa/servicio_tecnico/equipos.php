<div class="d-flex justify-content-between align-items-center mb-3">
  <h2 class="h4 mb-0">Equipos</h2>
</div>

<div class="card shadow-sm mb-3"><div class="card-body">
  <form method="POST" action="<?= e(url('/app/servicio-tecnico/equipos')) ?>" class="row g-2">
    <?= csrf_campo() ?>
    <div class="col-md-2">
      <select name="cliente_id" class="form-select form-select-sm" required>
        <option value="">Cliente</option>
        <?php foreach ($clientes as $cliente): ?>
          <option value="<?= (int) $cliente['id'] ?>"><?= e(trim(($cliente['nombres'] ?? '') . ' ' . ($cliente['apellidos'] ?? ''))) ?></option>
        <?php endforeach; ?>
      </select>
    </div>
    <div class="col-md-2"><select name="tipo_equipo" class="form-select form-select-sm"><option>PC</option><option>Impresora</option><option>Celular</option></select></div>
    <div class="col-md-2"><input name="nombre_equipo" class="form-control form-control-sm" placeholder="Nombre equipo" required></div>
    <div class="col-md-1"><input name="marca" class="form-control form-control-sm" placeholder="Marca"></div>
    <div class="col-md-1"><input name="modelo" class="form-control form-control-sm" placeholder="Modelo"></div>
    <div class="col-md-2"><input name="serie" class="form-control form-control-sm" placeholder="Serie / IMEI"></div>
    <div class="col-md-2 d-grid"><button class="btn btn-primary btn-sm">Guardar equipo</button></div>
  </form>
</div></div>

<div class="card shadow-sm">
  <div class="card-body border-bottom py-2">
    <form method="GET" class="row g-2 align-items-center">
      <div class="col-md-4"><input type="search" name="q" value="<?= e($buscar) ?>" class="form-control form-control-sm" placeholder="Buscar por marca, modelo, serie, cliente"></div>
      <div class="col-auto"><button class="btn btn-outline-secondary btn-sm">Buscar</button></div>
    </form>
  </div>
  <div class="table-responsive"><table class="table table-sm table-hover mb-0">
    <thead class="table-light"><tr><th>Cliente</th><th>Equipo</th><th>Marca/Modelo</th><th>Serie/IMEI</th><th>Estado</th></tr></thead>
    <tbody>
      <?php foreach ($equipos as $equipo): ?>
      <tr>
        <td><?= e($equipo['cliente_nombre'] ?? '-') ?></td>
        <td><?= e($equipo['tipo_equipo'] . ' - ' . $equipo['nombre_equipo']) ?></td>
        <td><?= e(trim(($equipo['marca'] ?? '') . ' ' . ($equipo['modelo'] ?? ''))) ?></td>
        <td><?= e($equipo['serie'] ?: ($equipo['imei'] ?? '-')) ?></td>
        <td><?= e($equipo['estado']) ?></td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table></div>
</div>
