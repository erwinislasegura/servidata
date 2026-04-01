<?php $flash = get_flash(); ?>
<header class="topbar bg-white border-bottom p-3 d-flex justify-content-between align-items-center">
  <h4 class="m-0">Panel Administrativo</h4>
  <span class="text-muted">Usuario: <?= e(App\Core\Auth::user()['username'] ?? '-') ?></span>
</header>
<?php if ($flash): ?>
<div class="px-4 pt-3"><div class="alert alert-<?= e($flash['type']) ?> mb-0"><?= e($flash['message']) ?></div></div>
<?php endif; ?>
