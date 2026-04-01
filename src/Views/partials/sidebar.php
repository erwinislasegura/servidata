<aside class="sidebar p-3 vh-100 position-sticky top-0">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h5 class="mb-0"><i class="bi bi-tools"></i> ServiData</h5>
    <button class="btn btn-sm btn-outline-secondary d-lg-none" type="button" data-bs-toggle="collapse" data-bs-target="#menuLateral">
      <i class="bi bi-list"></i>
    </button>
  </div>
  <nav id="menuLateral" class="nav flex-column gap-2 collapse show">
    <small class="menu-group">SERVICIO TÉCNICO</small>
    <a class="nav-link <?= is_active('/dashboard') ? 'active' : '' ?>" href="<?= url('/dashboard') ?>"><i class="bi bi-grid-1x2"></i> Dashboard</a>
    <a class="nav-link <?= is_active('/orders') ? 'active' : '' ?>" href="<?= url('/orders') ?>"><i class="bi bi-plus-square"></i> Nueva orden</a>
    <a class="nav-link <?= is_active('/customers') ? 'active' : '' ?>" href="<?= url('/customers') ?>"><i class="bi bi-people"></i> Clientes</a>
    <a class="nav-link <?= is_active('/technicians') ? 'active' : '' ?>" href="<?= url('/technicians') ?>"><i class="bi bi-person-badge"></i> Técnicos</a>

    <small class="menu-group mt-2">ADMINISTRACIÓN</small>
    <a class="nav-link <?= is_active('/users') ? 'active' : '' ?>" href="<?= url('/users') ?>"><i class="bi bi-shield-lock"></i> Usuarios</a>
    <a class="nav-link <?= is_active('/settings') ? 'active' : '' ?>" href="<?= url('/settings') ?>"><i class="bi bi-gear"></i> Configuración</a>
    <a class="nav-link text-danger-emphasis" href="<?= url('/logout') ?>"><i class="bi bi-box-arrow-left"></i> Cerrar sesión</a>
  </nav>
</aside>
