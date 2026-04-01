<section class="py-5">
    <div class="container" style="max-width:520px">
        <h1 class="h4 mb-3">Restablecer contraseña</h1>

        <?php if (!($tokenValido ?? false)): ?>
            <div class="alert alert-warning">
                El enlace no es válido o expiró. Solicita uno nuevo para recuperar el acceso.
            </div>
            <a href="<?= e(url('/recuperar-contrasena')) ?>" class="btn btn-outline-primary btn-sm">Solicitar nuevo enlace</a>
        <?php else: ?>
            <form class="card card-body shadow-sm" method="POST" action="<?= e(url('/restablecer-contrasena')) ?>">
                <?= csrf_campo() ?>
                <input type="hidden" name="token" value="<?= e($token ?? '') ?>">

                <label class="form-label small">Nueva contraseña</label>
                <input type="password" name="password" class="form-control mb-2" minlength="8" required>

                <label class="form-label small">Confirmar contraseña</label>
                <input type="password" name="password_confirmacion" class="form-control" minlength="8" required>

                <button type="submit" class="btn btn-primary btn-sm mt-3">Guardar nueva contraseña</button>
            </form>
        <?php endif; ?>
    </div>
</section>
