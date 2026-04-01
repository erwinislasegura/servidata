<aside class="sidebar p-3 vh-100 position-sticky top-0">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h5 class="mb-0"><i class="bi bi-tools"></i> ServiData</h5>
    <button class="btn btn-sm btn-outline-secondary d-lg-none" type="button" data-bs-toggle="collapse" data-bs-target="#menuLateral">
      <i class="bi bi-list"></i>
    </button>
  </div>
  <nav id="menuLateral" class="nav flex-column gap-2 collapse show">
    <small class="menu-group">OPERACIÓN</small>
    <a class="nav-link <?= is_active('/dashboard') ? 'active' : '' ?>" href="<?= url('/dashboard') ?>"><i class="bi bi-grid-1x2"></i> Dashboard</a>
    <a class="nav-link <?= is_active('/orders') ? 'active' : '' ?>" href="<?= url('/orders') ?>"><i class="bi bi-plus-square"></i> Nueva / Órdenes</a>
    <a class="nav-link <?= is_active('/diagnostics') ? 'active' : '' ?>" href="<?= url('/diagnostics') ?>"><i class="bi bi-clipboard2-pulse"></i> Diagnósticos</a>
    <a class="nav-link <?= is_active('/quotations') ? 'active' : '' ?>" href="<?= url('/quotations') ?>"><i class="bi bi-receipt"></i> Cotizaciones</a>
    <a class="nav-link <?= is_active('/payments') ? 'active' : '' ?>" href="<?= url('/payments') ?>"><i class="bi bi-cash-coin"></i> Caja / Pagos</a>

    <small class="menu-group mt-2">REGISTROS</small>
    <a class="nav-link <?= is_active('/customers') ? 'active' : '' ?>" href="<?= url('/customers') ?>"><i class="bi bi-people"></i> Clientes</a>
    <a class="nav-link <?= is_active('/devices') ? 'active' : '' ?>" href="<?= url('/devices') ?>"><i class="bi bi-laptop"></i> Equipos</a>
    <a class="nav-link <?= is_active('/technicians') ? 'active' : '' ?>" href="<?= url('/technicians') ?>"><i class="bi bi-person-badge"></i> Técnicos</a>
    <a class="nav-link <?= is_active('/inventory') ? 'active' : '' ?>" href="<?= url('/inventory') ?>"><i class="bi bi-box-seam"></i> Inventario</a>

    <small class="menu-group mt-2">SEGUIMIENTO Y ADMIN</small>
    <a class="nav-link <?= is_active('/statuses') ? 'active' : '' ?>" href="<?= url('/statuses') ?>"><i class="bi bi-diagram-3"></i> Estados</a>
    <a class="nav-link <?= is_active('/receipts') ? 'active' : '' ?>" href="<?= url('/receipts') ?>"><i class="bi bi-printer"></i> Comprobantes</a>
    <a class="nav-link <?= is_active('/reports') ? 'active' : '' ?>" href="<?= url('/reports') ?>"><i class="bi bi-bar-chart-line"></i> Reportes</a>
    <a class="nav-link <?= is_active('/users') ? 'active' : '' ?>" href="<?= url('/users') ?>"><i class="bi bi-shield-lock"></i> Usuarios / Roles</a>
    <a class="nav-link <?= is_active('/audit') ? 'active' : '' ?>" href="<?= url('/audit') ?>"><i class="bi bi-journal-text"></i> Auditoría</a>
    <a class="nav-link" href="<?= url('/portal') ?>" target="_blank"><i class="bi bi-globe2"></i> Portal Público</a>
    <a class="nav-link text-danger-emphasis" href="<?= url('/logout') ?>"><i class="bi bi-box-arrow-left"></i> Cerrar sesión</a>
  </nav>
</aside>
