<h1 class="h3 mb-4">Clientes</h1>
<div class="card">
    <div class="table-responsive">
        <table class="table table-hover mb-0">
            <thead><tr><th>ID</th><th>Nombre</th><th>Teléfono</th><th>Email</th><th>Activo</th></tr></thead>
            <tbody>
            <?php foreach ($clientes as $cliente): ?>
                <tr>
                    <td><?= (int)$cliente['id'] ?></td>
                    <td><?= htmlspecialchars($cliente['nombre']) ?></td>
                    <td><?= htmlspecialchars((string)($cliente['telefono'] ?? '')) ?></td>
                    <td><?= htmlspecialchars((string)($cliente['email'] ?? '')) ?></td>
                    <td><?= (int)$cliente['condicion'] === 1 ? 'Sí' : 'No' ?></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>
