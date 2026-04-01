# ServiData - PHP MVC (raíz)

Este repositorio ahora deja el proyecto PHP MVC directamente en la **raíz**.

## Estructura principal

- `index.php` Front Controller
- `.htaccess` Rewrite para rutas limpias
- `src/Core` Router, Controller base, View y Database (PDO)
- `src/Controllers` Auth, Dashboard, Cliente, Orden
- `src/Models` User, Cliente, Orden
- `src/Views` Vistas Bootstrap
- `src/config.php` Configuración de base de datos

## Ejecutar

```bash
php -S localhost:8080
```

Abrir: http://localhost:8080

## Variables de entorno opcionales

- `DB_HOST`
- `DB_PORT`
- `DB_DATABASE`
- `DB_USERNAME`
- `DB_PASSWORD`
- `APP_URL`

## Nota

La base usa la misma BD del sistema anterior (`users`, `clientes`, `orden`).
