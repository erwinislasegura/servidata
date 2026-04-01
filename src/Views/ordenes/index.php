<h1 class="h3 mb-4">Órdenes</h1>
<div class="card">
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Cliente</th><th>Técnico</th><th>Equipo</th><th>Marca</th><th>Modelo</th><th>Estado</th><th>Total</th></tr></thead>
            <tbody>
            <?php foreach ($ordenes as $orden): ?>
                <tr>
                    <td><?= (int)$orden['id'] ?></td>
                    <td><?= htmlspecialchars($orden['cliente']) ?></td>
                    <td><?= htmlspecialchars($orden['tecnico']) ?></td>
                    <td><?= htmlspecialchars($orden['nombreEquipo']) ?></td>
                    <td><?= htmlspecialchars($orden['marca']) ?></td>
                    <td><?= htmlspecialchars($orden['modelo']) ?></td>
                    <td><?= htmlspecialchars($orden['estado']) ?></td>
                    <td>$<?= number_format((float)$orden['totalPagar'], 0, ',', '.') ?></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>
