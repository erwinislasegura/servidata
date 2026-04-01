<section class="py-5">
    <div class="container" style="max-width: 560px;">
        <div class="text-center mb-3">
            <span class="badge bg-info-subtle text-info-emphasis mb-2">Acceso seguro</span>
            <h1 class="h3 mb-2">Iniciar sesión en App FerriTalia</h1>
            <p class="text-secondary small mb-0">Ingresa con tu cuenta para acceder a tu panel de gestión.</p>
        </div>

        <form method="POST" action="<?= e(url('/iniciar-sesion')) ?>" class="card card-body shadow-sm">
            <?= csrf_campo() ?>
            <label class="form-label small">Correo</label>
            <input type="email" name="correo" class="form-control" placeholder="tu@empresa.com" required>

            <label class="form-label small mt-3">Contraseña</label>
            <input type="password" name="password" class="form-control" placeholder="Ingresa tu contraseña" required>

            <button class="btn btn-primary mt-3" type="submit">Ingresar</button>
            <a class="small mt-2 text-decoration-none" href="<?= e(url('/recuperar')) ?>">¿Olvidaste tu contraseña?</a>
        </form>
    </div>
</section>
