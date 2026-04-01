<div class="d-flex justify-content-between align-items-center mb-3">
  <div>
    <h2 class="h4 mb-0">Dashboard Servicio Técnico</h2>
    <small class="text-muted">Vista operativa para mostrador y control diario.</small>
  </div>
  <a href="<?= e(url('/app/servicio-tecnico/ordenes')) ?>" class="btn btn-primary btn-sm"><i class="bi bi-plus-circle me-1"></i>Nueva orden</a>
</div>

<div class="row g-3 mb-3">
  <?php
  $cards = [
    'Órdenes hoy' => $ordenes_hoy ?? 0,
    'En diagnóstico' => $en_diagnostico ?? 0,
    'En reparación' => $en_reparacion ?? 0,
    'Listas para entrega' => $listas_entrega ?? 0,
    'Entregadas' => $entregadas ?? 0,
    'Total por cobrar' => formato_clp($por_cobrar ?? 0),
    'Total cobrado hoy' => formato_clp($cobrado_hoy ?? 0),
    'Total mensual' => formato_clp($total_mensual ?? 0),
    'Equipos no retirados' => $no_retirados ?? 0,
    'Stock bajo' => $stock_bajo ?? 0,
  ];
  ?>
  <?php foreach ($cards as $titulo => $valor): ?>
    <div class="col-6 col-md-4 col-xl-2">
      <div class="card shadow-sm h-100">
        <div class="card-body py-2">
          <div class="text-muted small"><?= e($titulo) ?></div>
          <div class="h5 mb-0"><?= e((string) $valor) ?></div>
        </div>
      </div>
    </div>
  <?php endforeach; ?>
</div>

<div class="row g-3">
  <div class="col-lg-8">
    <div class="card shadow-sm">
      <div class="card-header bg-white"><strong>Últimas órdenes</strong></div>
      <div class="table-responsive">
        <table class="table table-sm table-hover mb-0">
          <thead class="table-light"><tr><th>N° Orden</th><th>Cliente</th><th>Estado</th><th>Total</th><th>Saldo</th></tr></thead>
          <tbody>
            <?php foreach (array_slice($ultimas_ordenes ?? [], 0, 8) as $orden): ?>
              <tr>
                <td><?= e($orden['numero_orden']) ?></td>
                <td><?= e($orden['cliente_nombre']) ?></td>
                <td><span class="badge text-bg-secondary"><?= e($orden['estado']) ?></span></td>
                <td><?= e(formato_clp((int) ($orden['total'] ?? 0))) ?></td>
                <td><?= e(formato_clp((int) ($orden['saldo'] ?? 0))) ?></td>
              </tr>
            <?php endforeach; ?>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <div class="col-lg-4">
    <div class="card shadow-sm">
      <div class="card-header bg-white"><strong>Próximas entregas</strong></div>
      <ul class="list-group list-group-flush">
        <?php foreach ($proximas_entregas ?? [] as $entrega): ?>
          <li class="list-group-item d-flex justify-content-between align-items-center">
            <span><?= e($entrega['numero_orden']) ?></span>
            <small class="text-muted"><?= e((string) $entrega['fecha_entrega_estimada']) ?></small>
          </li>
        <?php endforeach; ?>
      </ul>
    </div>
  </div>
</div>
