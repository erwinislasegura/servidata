<style>
  /* Fallback visual layer when Bootstrap CSS is not available */
  .card { border: 1px solid #d9dce2; border-radius: .45rem; background: #fff; margin-bottom: 1rem; }
  .card-body { padding: .75rem; }
  .border-bottom { border-bottom: 1px solid #e5e7eb; }
  .rounded { border-radius: .35rem; }
  .p-2 { padding: .5rem; }
  .mb-0 { margin-bottom: 0; }
  .mb-2 { margin-bottom: .5rem; }
  .mb-3 { margin-bottom: .8rem; }
  .mb-4 { margin-bottom: 1rem; }
  .mt-2 { margin-top: .5rem; }
  .pb-2 { padding-bottom: .5rem; }
  .d-flex { display: flex; }
  .justify-content-between { justify-content: space-between; }
  .align-items-center { align-items: center; }
  .gap-2 { gap: .5rem; }
  .w-auto { width: auto; }
  .text-muted { color: #6b7280; }
  .small { font-size: .82rem; }

  .row { display: flex; flex-wrap: wrap; margin: -.35rem; }
  .row > [class*="col-"] { padding: .35rem; box-sizing: border-box; width: 100%; }
  .col-12 { width: 100% !important; }
  @media (min-width: 768px) {
    .col-md-2 { width: 16.6667% !important; }
    .col-md-3 { width: 25% !important; }
    .col-md-4 { width: 33.3333% !important; }
    .col-md-6 { width: 50% !important; }
  }

  .form-control, .form-select {
    display: block;
    width: 100%;
    border: 1px solid #b9c0cb;
    border-radius: .35rem;
    padding: .35rem .5rem;
    background: #fff;
    color: #111827;
  }
  .form-check { display: inline-flex; align-items: center; gap: .25rem; margin-right: .6rem; }
  .btn { border: 1px solid #b9c0cb; border-radius: .35rem; background: #f8f9fb; color: #111827; cursor: pointer; }
  .btn-primary { background: #0d6efd; border-color: #0d6efd; color: #fff; }
  .btn-outline-secondary { background: #fff; border-color: #9ca3af; color: #374151; }

  .table { width: 100%; border-collapse: collapse; font-size: .88rem; }
  .table th, .table td { border-bottom: 1px solid #e5e7eb; padding: .4rem; text-align: left; }
  .table-responsive { overflow-x: auto; }

  .orders-form-compact { font-size: .9rem; }
  .orders-form-compact .form-label { margin-bottom: .2rem; font-size: .82rem; }
  .orders-form-compact .form-control,
  .orders-form-compact .form-select { min-height: calc(1.5em + .45rem + 2px); padding: .2rem .45rem; font-size: .9rem; }
  .orders-form-compact textarea.form-control { min-height: 58px; }
  .orders-form-compact .btn { padding: .32rem .55rem; font-size: .86rem; }
  .customer-preview-item { font-size: .86rem; margin-bottom: .15rem; }
  .customer-preview-box { border: 1px solid #d9dce2; border-radius: .35rem; padding: .45rem; background: #f7f8fa; }
  .icon-btn { border: 0; background: transparent; color: #0d6efd; font-size: .82rem; padding: 0; cursor: pointer; }
  .icon-btn:hover { text-decoration: underline; }

  .simple-modal {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(19, 28, 45, .48);
    z-index: 9999;
    padding: 1rem;
    overflow: auto;
  }
  .simple-modal.show { display: block; }
  .simple-modal-dialog {
    width: min(860px, 100%);
    margin: 2rem auto;
    background: #fff;
    border-radius: .5rem;
    box-shadow: 0 12px 36px rgba(0, 0, 0, .18);
    border: 1px solid #d8dde6;
  }
  .simple-modal-header, .simple-modal-footer { padding: .6rem .8rem; border-bottom: 1px solid #e7eaf0; }
  .simple-modal-footer { border-bottom: 0; border-top: 1px solid #e7eaf0; display: flex; justify-content: flex-end; gap: .45rem; }
  .simple-modal-body { padding: .8rem; }
  .simple-close { border: 0; background: transparent; font-size: 1.2rem; line-height: 1; cursor: pointer; }
</style>

<h5 class="mb-3">Nueva Orden de Servicio (rápida de mostrador)</h5>
<div class="card mb-4">
  <div class="card-body">
    <form method="post" action="<?= url('/orders/create') ?>" class="row g-2 orders-form-compact">
      <?= csrf_field() ?>
      <div class="col-12"><h6 class="border-bottom pb-2">1) Datos del cliente</h6></div>
      <div class="col-md-4">
        <label class="form-label">Buscar cliente (nombre o RUT)</label>
        <input type="search" id="customer_search" class="form-control" placeholder="Ej: Juan Pérez o 12.345.678-9">
      </div>
      <div class="col-md-4">
        <label class="form-label d-flex justify-content-between align-items-center">
          <span>Cliente existente</span>
          <button class="icon-btn" id="open_new_customer_modal" type="button" title="Nuevo cliente">
            <i class="bi bi-person-plus"></i> Nuevo
          </button>
        </label>
        <select class="form-select form-select-sm" name="customer_id" id="customer_id">
          <option value="">-- Selecciona un cliente --</option>
          <?php foreach ($customers as $c): ?>
            <option
              value="<?= e((string) $c['id']) ?>"
              data-first-name="<?= e((string) ($c['first_name'] ?? '')) ?>"
              data-last-name="<?= e((string) ($c['last_name'] ?? '')) ?>"
              data-document="<?= e((string) ($c['document_number'] ?? '')) ?>"
              data-phone="<?= e((string) ($c['phone'] ?? '')) ?>"
              data-email="<?= e((string) ($c['email'] ?? '')) ?>"
              data-city="<?= e((string) ($c['city'] ?? '')) ?>"
              data-address="<?= e((string) ($c['address'] ?? '')) ?>"
            ><?= e($c['first_name'] . ' ' . $c['last_name'] . ' | ' . ($c['document_number'] ?: 'Sin RUT')) ?></option>
          <?php endforeach; ?>
        </select>
        <small class="text-muted">No se digitan datos de cliente en esta orden: se toman del registro seleccionado.</small>
      </div>
      <div class="col-md-4">
        <label class="form-label">Datos del cliente seleccionado</label>
        <div id="customer_preview" class="customer-preview-box">
          <div class="customer-preview-item text-muted">Selecciona un cliente para ver sus datos.</div>
        </div>
      </div>

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
      <div class="col-md-2"><label class="form-label">Entrega estimada</label><input type="date" name="estimated_date" class="form-control"></div>
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

<div class="simple-modal" id="newCustomerModal" aria-hidden="true">
  <div class="simple-modal-dialog">
    <div class="simple-modal-header d-flex justify-content-between align-items-center">
      <h6 class="mb-0">Nuevo cliente</h6>
      <button type="button" class="simple-close" id="close_new_customer_modal" aria-label="Cerrar">×</button>
    </div>
    <form id="new_customer_form">
      <div class="simple-modal-body">
        <input type="hidden" name="csrf_token" value="<?= e((string) csrf_token()) ?>">
        <div class="row g-2 orders-form-compact">
          <div class="col-md-4"><label class="form-label">Nombres</label><input required name="first_name" class="form-control"></div>
          <div class="col-md-4"><label class="form-label">Apellidos</label><input required name="last_name" class="form-control"></div>
          <div class="col-md-4"><label class="form-label">RUT</label><input name="document_number" class="form-control"></div>
          <div class="col-md-4"><label class="form-label">Teléfono</label><input name="phone" class="form-control"></div>
          <div class="col-md-4"><label class="form-label">Correo</label><input name="email" type="email" class="form-control"></div>
          <div class="col-md-4"><label class="form-label">Ciudad</label><input name="city" class="form-control"></div>
          <div class="col-md-6"><label class="form-label">Dirección</label><input name="address" class="form-control"></div>
          <div class="col-md-6"><label class="form-label">Notas</label><input name="notes" class="form-control"></div>
        </div>
        <div id="new_customer_feedback" class="small mt-2"></div>
      </div>
      <div class="simple-modal-footer">
          <button type="button" class="btn btn-outline-secondary btn-sm" id="cancel_new_customer_modal">Cancelar</button>
          <button type="submit" class="btn btn-primary btn-sm"><i class="bi bi-save"></i> Guardar cliente</button>
      </div>
    </form>
  </div>
</div>

<script>
  (() => {
    const orderForm = document.querySelector('form[action="<?= url('/orders/create') ?>"]');
    const customerSelect = document.getElementById('customer_id');
    const customerSearch = document.getElementById('customer_search');
    const customerPreview = document.getElementById('customer_preview');
    const newCustomerForm = document.getElementById('new_customer_form');
    const feedback = document.getElementById('new_customer_feedback');
    const modal = document.getElementById('newCustomerModal');
    const openModalBtn = document.getElementById('open_new_customer_modal');
    const closeModalBtn = document.getElementById('close_new_customer_modal');
    const cancelModalBtn = document.getElementById('cancel_new_customer_modal');

    if (!orderForm || !customerSelect || !customerPreview) return;

    const renderCustomerPreview = () => {
      const option = customerSelect.options[customerSelect.selectedIndex];
      if (!option || !option.value) {
        customerPreview.innerHTML = '<div class="customer-preview-item text-muted">Selecciona un cliente para ver sus datos.</div>';
        return;
      }

      const values = [
        ['Cliente', `${option.dataset.firstName || ''} ${option.dataset.lastName || ''}`.trim()],
        ['RUT', option.dataset.document || 'No registrado'],
        ['Teléfono', option.dataset.phone || 'No registrado'],
        ['Correo', option.dataset.email || 'No registrado'],
        ['Ciudad', option.dataset.city || 'No registrada'],
        ['Dirección', option.dataset.address || 'No registrada'],
      ];

      customerPreview.innerHTML = values.map(([label, value]) => `<div class="customer-preview-item"><strong>${label}:</strong> ${value}</div>`).join('');
    };

    customerSearch?.addEventListener('input', () => {
      const term = customerSearch.value.trim().toLowerCase();
      Array.from(customerSelect.options).forEach((option, index) => {
        if (index === 0) return;
        const text = option.text.toLowerCase();
        option.hidden = term !== '' && !text.includes(term);
      });
    });

    customerSelect.addEventListener('change', renderCustomerPreview);

    const toggleModal = (show) => {
      if (!modal) return;
      modal.classList.toggle('show', show);
      modal.setAttribute('aria-hidden', show ? 'false' : 'true');
      document.body.style.overflow = show ? 'hidden' : '';
    };

    openModalBtn?.addEventListener('click', () => toggleModal(true));
    closeModalBtn?.addEventListener('click', () => toggleModal(false));
    cancelModalBtn?.addEventListener('click', () => toggleModal(false));
    modal?.addEventListener('click', (event) => {
      if (event.target === modal) toggleModal(false);
    });

    orderForm.addEventListener('submit', (event) => {
      if (!customerSelect.value) {
        event.preventDefault();
        alert('Debes seleccionar un cliente registrado o crear uno nuevo.');
      }
    });

    if (newCustomerForm) {
      newCustomerForm.addEventListener('submit', async (event) => {
        event.preventDefault();
        feedback.className = 'small mt-2 text-muted';
        feedback.textContent = 'Guardando cliente...';

        try {
          const response = await fetch('<?= url('/orders/customers/create') ?>', {
            method: 'POST',
            body: new FormData(newCustomerForm),
            headers: { 'X-Requested-With': 'XMLHttpRequest' }
          });
          const result = await response.json();
          if (!response.ok || !result.ok) {
            throw new Error(result.message || 'No fue posible guardar el cliente.');
          }

          const customer = result.customer;
          const option = document.createElement('option');
          option.value = String(customer.id);
          option.textContent = `${customer.first_name} ${customer.last_name} | ${customer.document_number || 'Sin RUT'}`;
          option.dataset.firstName = customer.first_name || '';
          option.dataset.lastName = customer.last_name || '';
          option.dataset.document = customer.document_number || '';
          option.dataset.phone = customer.phone || '';
          option.dataset.email = customer.email || '';
          option.dataset.city = customer.city || '';
          option.dataset.address = customer.address || '';

          customerSelect.appendChild(option);
          customerSelect.value = option.value;
          renderCustomerPreview();
          feedback.className = 'small mt-2 text-success';
          feedback.textContent = 'Cliente creado correctamente.';
          newCustomerForm.reset();

          toggleModal(false);
        } catch (error) {
          feedback.className = 'small mt-2 text-danger';
          feedback.textContent = error.message || 'Error al guardar cliente.';
        }
      });
    }

    renderCustomerPreview();
  })();
</script>
