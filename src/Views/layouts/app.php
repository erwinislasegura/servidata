<!doctype html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= e(App\Core\Container::get('config')['app']['name']) ?></title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<?= asset('assets/css/app.css') ?>" rel="stylesheet">
</head>
<body>
<div class="d-flex">
  <?php require __DIR__ . '/../partials/sidebar.php'; ?>
  <main class="flex-grow-1">
    <?php require __DIR__ . '/../partials/topbar.php'; ?>
    <div class="container-fluid p-4"><?= $content ?></div>
  </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
<script src="<?= asset('assets/js/app.js') ?>"></script>
</body>
</html>
