<?php $auth = $_SESSION['auth'] ?? null; ?>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ServiData MVC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="/dashboard">ServiData MVC</a>
        <?php if ($auth): ?>
            <div class="d-flex gap-2 align-items-center text-white">
                <span><?= htmlspecialchars($auth['usuario']) ?></span>
                <a href="/clientes" class="btn btn-sm btn-outline-light">Clientes</a>
                <a href="/ordenes" class="btn btn-sm btn-outline-light">Órdenes</a>
                <form action="/logout" method="post" class="m-0">
                    <button class="btn btn-sm btn-danger">Salir</button>
                </form>
            </div>
        <?php endif; ?>
    </div>
</nav>
<div class="container">
