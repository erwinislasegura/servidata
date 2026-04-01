<div class="row g-3 mb-4">
  <?php
    $cards = [
      'Órdenes hoy' => $metrics['orders_today'] ?? 0,
      'Clientes' => $metrics['customers_total'] ?? 0,
      'Ingresos hoy' => '$' . number_format((float)($metrics['income_today'] ?? 0), 0, ',', '.'),
      'Ingresos mes' => '$' . number_format((float)($metrics['income_month'] ?? 0), 0, ',', '.'),
      'Stock bajo' => $metrics['low_stock'] ?? 0,
    ];
  ?>
  <?php foreach ($cards as $label => $value): ?>
  <div class="col-md-3"><div class="card shadow-sm"><div class="card-body"><small class="text-muted"><?= e($label) ?></small><h3><?= e((string)$value) ?></h3></div></div></div>
  <?php endforeach; ?>
</div>
<div class="row g-3">
  <div class="col-lg-6"><div class="card"><div class="card-body"><h6>Órdenes por estado</h6><canvas id="statusChart" data-chart='<?= json_encode($statusChart) ?>'></canvas></div></div></div>
  <div class="col-lg-6"><div class="card"><div class="card-body"><h6>Últimos servicios ingresados</h6><table class="table table-sm"><tr><th>Orden</th><th>Cliente</th><th>Estado</th></tr><?php foreach ($latestOrders as $o): ?><tr><td><?= e($o['order_number']) ?></td><td><?= e($o['customer']) ?></td><td><span class="badge bg-secondary"><?= e($o['status_name']) ?></span></td></tr><?php endforeach; ?></table></div></div></div>
</div>
