<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>App FerriTalia | Acceso al sistema</title>
  <meta name="description" content="Acceso a App FerriTalia para gestionar operaciones comerciales e inventario de forma centralizada.">
  <meta name="keywords" content="App FerriTalia, login, recuperación de acceso, sistema comercial">
  <meta name="robots" content="noindex,nofollow">
  <meta name="theme-color" content="#0d6efd">
  <meta property="og:type" content="website">
  <meta property="og:title" content="App FerriTalia | Acceso al sistema">
  <meta property="og:description" content="Portal de autenticación y recuperación de acceso para App FerriTalia.">
  <meta property="og:url" content="<?= e((isset($_SERVER['HTTPS']) ? 'https' : 'http') . '://' . ($_SERVER['HTTP_HOST'] ?? 'localhost') . ($_SERVER['REQUEST_URI'] ?? '/')) ?>">
  <meta property="og:site_name" content="App FerriTalia">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="App FerriTalia | Acceso al sistema">
  <meta name="twitter:description" content="Inicia sesión o recupera el acceso a tu cuenta en App FerriTalia.">
  <link rel="canonical" href="<?= e((isset($_SERVER['HTTPS']) ? 'https' : 'http') . '://' . ($_SERVER['HTTP_HOST'] ?? 'localhost') . ($_SERVER['REQUEST_URI'] ?? '/')) ?>">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<?= e(asset_url('/assets/css/app.css')) ?>" rel="stylesheet">
</head>
<body class="bg-light public-page">
<?php require __DIR__ . '/../parciales/navbar_publico.php'; ?>
<main>
  <?php if ($flash = obtener_flash()): ?>
    <div class="container pt-3"><div class="alert alert-<?= e($flash['tipo']) ?>"><?= e($flash['mensaje']) ?></div></div>
  <?php endif; ?>
  <?php require $contenido; ?>
</main>
<?php require __DIR__ . '/../parciales/footer_publico.php'; ?>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>window.APP_BASE_PATH = "<?= e(base_path_url()) ?>";</script>
<script src="<?= e(asset_url('/assets/js/app.js')) ?>"></script>
</body>
</html>
