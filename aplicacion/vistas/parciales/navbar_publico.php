<nav class="navbar navbar-expand-lg bg-white border-bottom sticky-top public-navbar">
  <div class="container">
    <a class="navbar-brand fw-semibold" href="<?= e(url('/')) ?>">App FerriTalia</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#n"><span class="navbar-toggler-icon"></span></button>
    <div class="collapse navbar-collapse" id="n">
      <ul class="navbar-nav ms-auto gap-1 small align-items-lg-center">
        <li class="nav-item"><a class="btn btn-outline-primary btn-sm w-100" href="<?= e(url('/iniciar-sesion')) ?>">Iniciar sesión</a></li>
        <li class="nav-item"><a class="btn btn-primary btn-sm w-100" href="<?= e(url('/recuperar')) ?>">Recuperar acceso</a></li>
      </ul>
    </div>
  </div>
</nav>
