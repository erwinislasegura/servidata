<h1 class="h3 mb-4">Dashboard</h1>
<div class="row g-3 mb-4">
    <div class="col-md-4"><div class="card"><div class="card-body"><h5>Total órdenes</h5><p class="display-6"><?= (int)$resumen['total'] ?></p></div></div></div>
    <div class="col-md-4"><div class="card"><div class="card-body"><h5>Entregadas</h5><p class="display-6 text-success"><?= (int)$resumen['entregados'] ?></p></div></div></div>
    <div class="col-md-4"><div class="card"><div class="card-body"><h5>En reparación</h5><p class="display-6 text-warning"><?= (int)$resumen['reparacion'] ?></p></div></div></div>
</div>

<div class="card">
    <div class="card-header">Últimas órdenes</div>
    <div class="table-responsive">
        <table class="table table-striped mb-0">
            <thead><tr><th>ID</th><th>Cliente</th><th>Técnico</th><th>Equipo</th><th>Estado</th><th>Total</th></tr></thead>
            <tbody>
            <?php foreach ($ultimasOrdenes as $orden): ?>
                <tr>
                    <td><?= (int)$orden['id'] ?></td>
                    <td><?= htmlspecialchars($orden['cliente']) ?></td>
                    <td><?= htmlspecialchars($orden['tecnico']) ?></td>
                    <td><?= htmlspecialchars($orden['nombreEquipo']) ?></td>
                    <td><?= htmlspecialchars($orden['estado']) ?></td>
                    <td>$<?= number_format((float)$orden['totalPagar'], 0, ',', '.') ?></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>
