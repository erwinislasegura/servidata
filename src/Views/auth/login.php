<div class="login-wrapper min-vh-100 d-flex align-items-center py-5">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-xl-8 col-lg-10">
        <div class="card login-card border-0 shadow-lg overflow-hidden">
          <div class="row g-0">
            <div class="col-md-6 login-brand p-4 p-md-5 text-white d-flex flex-column justify-content-between">
              <div>
                <div class="small text-uppercase fw-semibold opacity-75">Sistema de Gestión</div>
                <h2 class="fw-bold mt-2 mb-3">Servicio Técnico</h2>
                <p class="mb-0 opacity-75">Controla órdenes, diagnósticos, inventario y pagos en un solo lugar.</p>
              </div>
              <ul class="list-unstyled mt-4 mb-0 small opacity-75">
                <li>✔ Seguimiento de órdenes</li>
                <li>✔ Panel administrativo profesional</li>
                <li>✔ Portal público para clientes</li>
              </ul>
            </div>
            <div class="col-md-6 bg-white p-4 p-md-5">
              <h4 class="mb-1">Bienvenido</h4>
              <p class="text-muted mb-4">Ingresa con tus credenciales para acceder al panel.</p>
              <?php if ($f = get_flash()): ?>
                <div class="alert alert-<?= e($f['type']) ?>"><?= e($f['message']) ?></div>
              <?php endif; ?>
              <div class="db-status mb-3 d-flex align-items-center gap-2">
                <span class="status-dot <?= !empty($dbConnected) ? 'online' : 'offline' ?>"></span>
                <small class="text-muted">Base de datos: <strong><?= !empty($dbConnected) ? 'Conectada' : 'Sin conexión' ?></strong></small>
              </div>
              <form method="post" action="<?= url('/login') ?>" class="login-form">
                <?= csrf_field() ?>
                <div class="mb-3">
                  <label class="form-label">Usuario o email</label>
                  <input name="login" required class="form-control form-control-lg" placeholder="admin o admin@tallerlocal.com">
                </div>
                <div class="mb-3">
                  <label class="form-label">Contraseña</label>
                  <input name="password" type="password" required class="form-control form-control-lg" placeholder="••••••••">
                </div>
                <button class="btn btn-dark btn-lg w-100">Ingresar al panel</button>
              </form>
              <div class="d-flex justify-content-between mt-3 small">
                <a href="<?= url('/portal') ?>" class="text-decoration-none">Consultar estado público</a>
                <span class="text-muted">v1.0</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
