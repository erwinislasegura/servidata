# Migración base a PHP MVC + Bootstrap

Se creó una versión inicial del proyecto en arquitectura **PHP MVC puro** (sin framework) con interfaz **Bootstrap 5**.

## Incluye

- Login contra tabla `users` (`usuario` + `password` bcrypt).
- Dashboard con métricas básicas de `orden`.
- Listado de clientes.
- Listado de órdenes con joins a clientes y técnicos.
- Router simple y estructura MVC (`Controllers`, `Models`, `Views`, `Core`).

## Estructura

- `public/index.php`: front controller y rutas.
- `app/Core`: Router, Controller base, View renderer, Database (PDO).
- `app/Controllers`: Auth, Dashboard, Cliente, Orden.
- `app/Models`: User, Cliente, Orden.
- `app/Views`: vistas Bootstrap.

## Ejecución local

```bash
cd php-mvc/public
php -S localhost:8080
```

Abrir: `http://localhost:8080`

## Variables de entorno (opcional)

- `DB_HOST`
- `DB_PORT`
- `DB_DATABASE`
- `DB_USERNAME`
- `DB_PASSWORD`
- `APP_URL`

## Nota

Esta migración es una **base funcional inicial** para reemplazar gradualmente Laravel.
Faltan por migrar módulos avanzados del sistema original (reportes PDF, carga de imágenes, código de barras, mensajería, y CRUDs completos).
