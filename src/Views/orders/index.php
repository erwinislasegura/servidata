<style>
  .orders-form-compact .form-label { margin-bottom: .2rem; font-size: .82rem; }
  .orders-form-compact .form-control,
  .orders-form-compact .form-select { min-height: calc(1.5em + .45rem + 2px); padding: .2rem .45rem; font-size: .9rem; }
  .orders-form-compact textarea.form-control { min-height: 58px; }
</style>

<h5 class="mb-3">Nueva Orden de Servicio (rápida de mostrador)</h5>
<div class="card mb-4">
  <div class="card-body">
    <form method="post" action="<?= url('/orders/create') ?>" class="row g-2 orders-form-compact">
      <?= csrf_field() ?>
      <div class="col-12"><h6 class="border-bottom pb-2">1) Datos del cliente</h6></div>
      <div class="col-md-4">
        <label class="form-label">Cliente existente</label>
        <select class="form-select form-select-sm" name="customer_id" id="customer_id">
          <option value="0">-- Nuevo cliente rápido --</option>
          <?php foreach ($customers as $c): ?>
            <option value="<?= e((string) $c['id']) ?>"><?= e($c['first_name'] . ' ' . $c['last_name'] . ' | ' . ($c['document_number'] ?: 'Sin RUT')) ?></option>
          <?php endforeach; ?>
        </select>
        <small class="text-muted">Si seleccionas cliente existente, se bloquea el ingreso manual para evitar doble digitación.</small>
      </div>
      <div class="col-md-4"><label class="form-label">Nombres</label><input name="customer_first_name" class="form-control"></div>
      <div class="col-md-4"><label class="form-label">Apellidos</label><input name="customer_last_name" class="form-control"></div>
      <div class="col-md-3"><label class="form-label">RUT</label><input name="customer_document" class="form-control"></div>
      <div class="col-md-3"><label class="form-label">Teléfono (+56)</label><input name="customer_phone" class="form-control"></div>
      <div class="col-md-3"><label class="form-label">Correo</label><input name="customer_email" class="form-control"></div>
      <div class="col-md-3"><label class="form-label">Comuna / Ciudad</label><input name="customer_city" class="form-control"></div>

      <div class="col-12"><h6 class="border-bottom pb-2 mt-2">2) Equipo y falla reportada</h6></div>
      <div class="col-md-3"><label class="form-label">Tipo equipo</label><select name="device_type" class="form-select"><option>computador</option><option>notebook</option><option>impresora</option><option>celular</option><option>tablet</option><option selected>otro</option></select></div>
      <div class="col-md-3"><label class="form-label">Marca</label><input name="device_brand" class="form-control"></div>
      <div class="col-md-3"><label class="form-label">Modelo</label><input name="device_model" class="form-control"></div>
      <div class="col-md-3"><label class="form-label">Serie / IMEI</label><input name="device_serial" class="form-control"></div>
      <div class="col-md-6"><label class="form-label">Problema principal</label><input name="issue_main" class="form-control" placeholder="Ej: no carga, pantalla rota, no enciende..." required></div>
      <div class="col-md-6"><label class="form-label">Detalle del problema</label><input name="issue_detail" class="form-control"></div>
      <div class="col-md-4"><label class="form-label">Accesorios</label><input name="device_accessories" class="form-control"></div>
      <div class="col-md-4"><label class="form-label">Clave / patrón</label><input name="unlock_code" class="form-control"></div>
      <div class="col-md-4"><label class="form-label">Estado físico visible</label><input name="physical_state" class="form-control"></div>
      <div class="col-12">
        <div class="form-check form-check-inline"><input class="form-check-input" type="checkbox" name="allow_review" value="1"><label class="form-check-label">Autoriza revisión</label></div>
        <div class="form-check form-check-inline"><input class="form-check-input" type="checkbox" name="allow_format" value="1"><label class="form-check-label">Autoriza formateo</label></div>
        <div class="form-check form-check-inline"><input class="form-check-input" type="checkbox" name="allow_backup" value="1"><label class="form-check-label">Autoriza respaldo</label></div>
      </div>

      <div class="col-12"><h6 class="border-bottom pb-2 mt-2">3) Costos y asignación</h6></div>
      <div class="col-md-3"><label class="form-label">Técnico</label><select name="technician_id" class="form-select"><option value="">Sin asignar</option><?php foreach ($technicians as $t): ?><option value="<?= e((string) $t['id']) ?>"><?= e($t['full_name']) ?></option><?php endforeach; ?></select></div>
      <div class="col-md-3"><label class="form-label">Estado inicial</label><select name="status_id" class="form-select"><?php foreach ($statuses as $s): ?><option value="<?= e((string) $s['id']) ?>" <?= $s['name'] === 'Ingresado' ? 'selected' : '' ?>><?= e($s['name']) ?></option><?php endforeach; ?></select></div>
      <div class="col-md-2"><label class="form-label">Prioridad</label><select name="priority" class="form-select"><option>baja</option><option selected>media</option><option>alta</option><option>urgente</option></select></div>
      <div class="col-md-2"><label class="form-label">Entrega estimada</label><input type="datetime-local" name="estimated_date" class="form-control"></div>
      <div class="col-md-2"><label class="form-label">Total estimado (CLP)</label><input name="estimated_total" class="form-control clp-input" value="0"></div>
      <div class="col-md-6"><label class="form-label">Comentarios internos</label><textarea name="internal_notes" class="form-control" rows="2"></textarea></div>
      <div class="col-md-6"><label class="form-label">Comentarios visibles cliente</label><textarea name="public_notes" class="form-control" rows="2"></textarea></div>

      <div class="col-12 d-flex gap-2">
        <button class="btn btn-primary" type="submit"><i class="bi bi-save"></i> Guardar e imprimir</button>
        <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-plus-circle"></i> Guardar y crear otra</button>
      </div>
    </form>
  </div>
</div>

<div class="card">
  <div class="card-body">
    <div class="d-flex justify-content-between mb-2">
      <h6 class="mb-0">Listado de órdenes</h6>
      <input class="form-control form-control-sm w-auto" placeholder="Buscar rápido">
    </div>
    <div class="table-responsive">
      <table class="table table-hover align-middle">
        <tr><th>Acciones</th><th>Orden</th><th>Seguimiento</th><th>Cliente</th><th>Técnico</th><th>Equipo</th><th>Ingreso</th><th>Total</th><th>Estado</th></tr>
        <?php foreach($orders as $o): ?>
          <tr>
            <td><div class="btn-group btn-group-sm"><button class="btn btn-outline-secondary">Ver</button><button class="btn btn-outline-secondary">Imprimir</button></div></td>
            <td><?= e($o['order_number']) ?></td>
            <td><code><?= e($o['public_tracking_code']) ?></code></td>
            <td><?= e($o['customer']) ?></td>
            <td><?= e($o['tech_name'] ?: 'Sin asignar') ?></td>
            <td><?= e(ucfirst((string)($o['device_type'] ?? '-')) . ' ' . ($o['brand'] ?? '') . ' ' . ($o['model'] ?? '')) ?></td>
            <td><?= e(fecha_cl($o['entry_date'])) ?></td>
            <td><?= e(clp($o['estimated_total'])) ?></td>
            <td><span class="badge text-bg-light"><?= e($o['status_name']) ?></span></td>
          </tr>
        <?php endforeach; ?>
      </table>
    </div>
  </div>
</div>

<script>
  (() => {
    const customerSelect = document.getElementById('customer_id');
    if (!customerSelect) return;

    const customerFields = [
      'customer_first_name',
      'customer_last_name',
      'customer_document',
      'customer_phone',
      'customer_email',
      'customer_city'
    ].map((name) => document.querySelector(`input[name="${name}"]`)).filter(Boolean);

    const toggleCustomerFields = () => {
      const useExistingCustomer = customerSelect.value !== '0' && customerSelect.value !== '';
      customerFields.forEach((field) => {
        field.disabled = useExistingCustomer;
        field.classList.toggle('bg-light', useExistingCustomer);
      });
    };

    customerSelect.addEventListener('change', toggleCustomerFields);
    toggleCustomerFields();
  })();
</script>
