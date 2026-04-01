<section class="py-5">
    <div class="container" style="max-width:520px">
        <div class="text-center mb-3">
            <span class="badge bg-warning-subtle text-warning-emphasis mb-2">Recuperación</span>
            <h1 class="h4 mb-2">Recuperar acceso</h1>
            <p class="small text-secondary mb-0">Enviaremos instrucciones de recuperación a tu correo.</p>
        </div>

        <form class="card card-body shadow-sm" method="POST" action="<?= e(url('/recuperar-contrasena')) ?>">
            <?= csrf_campo() ?>
            <label class="form-label small">Correo</label>
            <input class="form-control" type="email" name="correo" placeholder="tu@empresa.com" required>
            <button type="submit" class="btn btn-primary mt-3">Enviar instrucciones</button>
            <a class="small mt-2 text-decoration-none" href="<?= e(url('/iniciar-sesion')) ?>">Volver a iniciar sesión</a>
        </form>
    </div>
</section>
