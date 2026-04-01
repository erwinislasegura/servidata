<div class="d-flex justify-content-between align-items-center mb-3"><h2 class="h4 mb-0">Órdenes de Servicio</h2></div>

<div class="card shadow-sm mb-3"><div class="card-body">
<form method="POST" action="<?= e(url('/app/servicio-tecnico/ordenes')) ?>" class="row g-2">
<?= csrf_campo() ?>
<div class="col-md-2">
<select name="cliente_id" class="form-select form-select-sm" required>
<option value="">Cliente</option><?php foreach ($clientes as $cliente): ?><option value="<?= (int) $cliente['id'] ?>"><?= e(trim(($cliente['nombres'] ?? '') . ' ' . ($cliente['apellidos'] ?? ''))) ?></option><?php endforeach; ?>
</select></div>
<div class="col-md-2"><select name="equipo_id" class="form-select form-select-sm"><option value="">Equipo</option><?php foreach ($equipos as $equipo): ?><option value="<?= (int) $equipo['id'] ?>"><?= e(($equipo['tipo_equipo'] ?? '') . ' ' . ($equipo['marca'] ?? '') . ' ' . ($equipo['modelo'] ?? '')) ?></option><?php endforeach; ?></select></div>
<div class="col-md-2"><select name="tecnico_id" class="form-select form-select-sm"><option value="">Técnico</option><?php foreach ($tecnicos as $tecnico): ?><option value="<?= (int) $tecnico['id'] ?>"><?= e($tecnico['nombre']) ?></option><?php endforeach; ?></select></div>
<div class="col-md-2"><input name="problema_principal" class="form-control form-control-sm" placeholder="Problema principal" required></div>
<div class="col-md-1"><input name="adelanto" type="number" min="0" value="0" class="form-control form-control-sm" placeholder="Adelanto"></div>
<div class="col-md-1"><input name="total" type="number" min="0" value="0" class="form-control form-control-sm" placeholder="Total"></div>
<div class="col-md-2"><select name="estado" class="form-select form-select-sm"><?php foreach ($estados as $itemEstado): ?><option <?= $itemEstado === 'Ingresado' ? 'selected' : '' ?>><?= e($itemEstado) ?></option><?php endforeach; ?></select></div>

<div class="col-md-12">
  <div class="d-flex flex-wrap gap-2 mt-1">
    <button name="accion_guardado" value="guardar" class="btn btn-primary btn-sm">Guardar</button>
    <button name="accion_guardado" value="guardar_imprimir" class="btn btn-outline-primary btn-sm">Guardar + imprimir</button>
    <button name="accion_guardado" value="guardar_nueva" class="btn btn-outline-secondary btn-sm">Guardar + nueva orden</button>
  </div>
</div>
</form>

<div class="mt-3">
  <small class="fw-semibold d-block mb-1">Checklist rápido de fallas:</small>
  <div class="small text-muted">Celulares: pantalla rota, no carga, batería, micrófono, software, humedad · PC: lento, virus, formateo, no enciende, disco duro, RAM · Impresoras: no imprime, tinta, cabezal, error, mantenimiento.</div>
</div>
</div></div>

<div class="card shadow-sm">
<div class="card-body border-bottom py-2">
<form method="GET" class="row g-2 align-items-center">
<div class="col-md-4"><input type="search" name="q" value="<?= e($buscar) ?>" class="form-control form-control-sm" placeholder="Buscar orden, cliente, serie o falla"></div>
<div class="col-md-3"><select name="estado" class="form-select form-select-sm"><option value="">Todos los estados</option><?php foreach ($estados as $itemEstado): ?><option value="<?= e($itemEstado) ?>" <?= $estado === $itemEstado ? 'selected' : '' ?>><?= e($itemEstado) ?></option><?php endforeach; ?></select></div>
<div class="col-auto"><button class="btn btn-outline-secondary btn-sm">Filtrar</button></div>
</form>
</div>
<div class="table-responsive"><table class="table table-sm table-hover mb-0"><thead class="table-light"><tr><th>Orden</th><th>Cliente</th><th>Técnico</th><th>Estado</th><th>Total</th><th>Saldo</th><th class="text-end">Acciones</th></tr></thead><tbody>
<?php foreach ($ordenes as $orden): ?><tr>
<td><?= e($orden['numero_orden']) ?></td>
<td><?= e($orden['cliente_nombre']) ?></td>
<td><?= e($orden['tecnico_nombre'] ?? 'Sin asignar') ?></td>
<td><span class="badge text-bg-light"><?= e($orden['estado']) ?></span></td>
<td><?= e(formato_clp((int) ($orden['total'] ?? 0))) ?></td>
<td><?= e(formato_clp((int) ($orden['saldo'] ?? 0))) ?></td>
<td class="text-end"><button class="btn btn-outline-secondary btn-sm">Editar rápido</button></td>
</tr><?php endforeach; ?>
</tbody></table></div></div>
