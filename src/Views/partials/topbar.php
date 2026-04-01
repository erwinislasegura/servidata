<?php $flash = get_flash(); ?>
<header class="topbar bg-white border-bottom p-3 d-flex flex-wrap gap-2 justify-content-between align-items-center">
  <form class="d-flex topbar-search" role="search">
    <input class="form-control" type="search" placeholder="Buscar orden, cliente, RUT o teléfono" aria-label="Buscar">
  </form>
  <div class="d-flex align-items-center gap-2 flex-wrap">
    <a href="<?= url('/orders') ?>" class="btn btn-primary btn-sm"><i class="bi bi-plus-circle"></i> Nueva orden</a>
    <a href="<?= url('/customers') ?>" class="btn btn-outline-secondary btn-sm"><i class="bi bi-person-plus"></i> Nuevo cliente</a>
    <a href="<?= url('/receipts') ?>" class="btn btn-outline-secondary btn-sm"><i class="bi bi-printer"></i> Último comprobante</a>
    <span class="badge text-bg-light"><i class="bi bi-bell"></i> 0</span>
    <span class="text-muted">Usuario: <strong><?= e(App\Core\Auth::user()['username'] ?? '-') ?></strong></span>
  </div>
</header>
<?php if ($flash): ?>
<div class="px-4 pt-3"><div class="alert alert-<?= e($flash['type']) ?> mb-0"><?= e($flash['message']) ?></div></div>
<?php endif; ?>
