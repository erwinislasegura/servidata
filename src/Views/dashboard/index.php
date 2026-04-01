<div class="row g-3 mb-4">
  <?php
    $cards = [
      'Órdenes hoy' => $metrics['orders_today'] ?? 0,
      'Órdenes en diagnóstico' => $statusChart[0]['total'] ?? 0,
      'Órdenes en reparación' => $statusChart[1]['total'] ?? 0,
      'Listas para entrega' => $statusChart[2]['total'] ?? 0,
      'Pendiente de cobro' => clp($metrics['income_month'] ?? 0),
      'Cobrado hoy' => clp($metrics['income_today'] ?? 0),
      'Cobrado mes' => clp($metrics['income_month'] ?? 0),
      'Clientes' => $metrics['customers_total'] ?? 0,
      'Stock bajo' => $metrics['low_stock'] ?? 0,
    ];
  ?>
  <?php foreach ($cards as $label => $value): ?>
  <div class="col-md-3"><div class="card card-kpi shadow-sm"><div class="card-body"><small class="text-muted"><?= e($label) ?></small><h3><?= e((string)$value) ?></h3></div></div></div>
  <?php endforeach; ?>
</div>
<div class="row g-3">
  <div class="col-lg-6"><div class="card h-100"><div class="card-body"><h6>Órdenes por estado</h6><canvas id="statusChart" data-chart='<?= json_encode($statusChart) ?>'></canvas></div></div></div>
  <div class="col-lg-6"><div class="card h-100"><div class="card-body"><h6>Últimos servicios ingresados</h6><table class="table table-sm"><tr><th>Orden</th><th>Cliente</th><th>Estado</th><th>Ingreso</th></tr><?php foreach ($latestOrders as $o): ?><tr><td><?= e($o['order_number']) ?></td><td><?= e($o['customer']) ?></td><td><span class="badge text-bg-light"><?= e($o['status_name']) ?></span></td><td><?= e(fecha_cl($o['entry_date'])) ?></td></tr><?php endforeach; ?></table></div></div></div>
</div>
