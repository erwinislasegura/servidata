<div class="container py-5">
  <div class="row justify-content-center">
    <div class="col-md-4">
      <div class="card shadow-sm">
        <div class="card-body">
          <h4 class="mb-3">Ingreso al sistema</h4>
          <?php if ($f = get_flash()): ?><div class="alert alert-<?= e($f['type']) ?>"><?= e($f['message']) ?></div><?php endif; ?>
          <form method="post" action="/login">
            <?= csrf_field() ?>
            <div class="mb-3"><label class="form-label">Usuario o email</label><input name="login" required class="form-control"></div>
            <div class="mb-3"><label class="form-label">Contraseña</label><input name="password" type="password" required class="form-control"></div>
            <button class="btn btn-dark w-100">Entrar</button>
          </form>
          <a href="/portal" class="btn btn-link mt-3 p-0">Ir a portal público</a>
        </div>
      </div>
    </div>
  </div>
</div>
