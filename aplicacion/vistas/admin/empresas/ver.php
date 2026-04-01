<div class="d-flex justify-content-between align-items-center mb-3">
  <h1 class="h5 mb-0"><?= e($titulo ?? 'Detalle de empresa') ?></h1>
  <a href="/admin/empresas" class="btn btn-sm btn-outline-secondary">Volver al listado</a>
</div>
<div class="row g-3">
  <div class="col-lg-6">
    <div class="card card-body">
      <h2 class="h6 mb-3">Datos generales de empresa</h2>
      <form method="POST" action="/admin/empresas/editar/<?= $empresa['id'] ?>" class="row g-2">
        <?= csrf_campo() ?>
        <div class="col-12">
          <label class="form-label form-label-sm mb-1">Razón social</label>
          <input class="form-control form-control-sm" name="razon_social" value="<?= e($empresa['razon_social'] ?? '') ?>" required>
        </div>
        <div class="col-12">
          <label class="form-label form-label-sm mb-1">Nombre comercial</label>
          <input class="form-control form-control-sm" name="nombre_comercial" value="<?= e($empresa['nombre_comercial'] ?? '') ?>" required>
        </div>
        <div class="col-md-6">
          <label class="form-label form-label-sm mb-1">Identificador fiscal</label>
          <input class="form-control form-control-sm" name="identificador_fiscal" value="<?= e($empresa['identificador_fiscal'] ?? '') ?>" required>
        </div>
        <div class="col-md-6">
          <label class="form-label form-label-sm mb-1">Correo</label>
          <input type="email" class="form-control form-control-sm" name="correo" value="<?= e($empresa['correo'] ?? '') ?>" required>
        </div>
        <div class="col-md-6">
          <label class="form-label form-label-sm mb-1">Teléfono</label>
          <input class="form-control form-control-sm" name="telefono" value="<?= e($empresa['telefono'] ?? '') ?>">
        </div>
        <div class="col-md-6">
          <label class="form-label form-label-sm mb-1">Estado</label>
          <select name="estado" class="form-select form-select-sm">
            <?php foreach(['activa','suspendida','vencida','cancelada'] as $est): ?>
              <option value="<?= $est ?>" <?= ($empresa['estado'] ?? '') === $est ? 'selected' : '' ?>><?= e($est) ?></option>
            <?php endforeach; ?>
          </select>
        </div>
        <div class="col-md-6">
          <label class="form-label form-label-sm mb-1">Ciudad</label>
          <input class="form-control form-control-sm" name="ciudad" value="<?= e($empresa['ciudad'] ?? '') ?>">
        </div>
        <div class="col-md-6">
          <label class="form-label form-label-sm mb-1">País</label>
          <input class="form-control form-control-sm" name="pais" value="<?= e($empresa['pais'] ?? '') ?>">
        </div>
        <div class="col-12">
          <label class="form-label form-label-sm mb-1">Dirección</label>
          <input class="form-control form-control-sm" name="direccion" value="<?= e($empresa['direccion'] ?? '') ?>">
        </div>
        <div class="col-12">
          <button class="btn btn-primary btn-sm">Guardar datos de empresa</button>
        </div>
      </form>
    </div>
  </div>

  <div class="col-lg-6"><div class="card card-body">
    <h2 class="h6"><?= !empty($modoEdicion) ? 'Acciones de edición' : 'Acciones comerciales' ?></h2>
    <div class="small text-muted mb-2">Plan actual: <strong><?= e($empresa['plan_nombre'] ?? 'Sin plan') ?></strong></div>
    <div class="small text-muted mb-3">Suscripción: <strong><?= e($empresa['suscripcion_estado'] ?? '-') ?></strong> (vence <?= e($empresa['fecha_vencimiento'] ?? '-') ?>)</div>
    <form method="POST" action="/admin/empresas/plan/<?= $empresa['id'] ?>" class="row g-2 mb-2"><?= csrf_campo() ?>
      <div class="col-7"><select name="plan_id" class="form-select form-select-sm"><?php foreach($planes as $p): ?><option value="<?= $p['id'] ?>" <?= (int)$empresa['plan_id']===(int)$p['id']?'selected':'' ?>><?= e($p['nombre']) ?></option><?php endforeach; ?></select></div>
      <div class="col-5"><button class="btn btn-sm btn-outline-primary w-100">Cambiar plan</button></div>
      <div class="col-12"><input class="form-control form-control-sm" name="observaciones_internas" placeholder="Observación interna"></div>
    </form>
    <form method="POST" action="/admin/empresas/extender-vigencia/<?= $empresa['id'] ?>" class="row g-2"><?= csrf_campo() ?>
      <div class="col-7"><input type="number" min="1" name="dias" class="form-control form-control-sm" value="30"></div>
      <div class="col-5"><button class="btn btn-sm btn-outline-primary w-100">Extender vigencia</button></div>
    </form>
  </div></div>

  <div class="col-12"><div class="card"><div class="card-header">Administradores asociados</div><div class="table-responsive"><table class="table table-sm mb-0"><thead><tr><th>Nombre</th><th>Correo</th><th>Estado</th><th>Último acceso</th></tr></thead><tbody><?php foreach($admins as $a): ?><tr><td><?= e($a['nombre']) ?></td><td><?= e($a['correo']) ?></td><td><?= e($a['estado']) ?></td><td><?= e($a['ultimo_acceso'] ?: '-') ?></td></tr><?php endforeach; ?></tbody></table></div></div></div>
</div>
