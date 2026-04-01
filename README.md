# Sistema de Gestión de Servicio Técnico

Aplicación web en **PHP 8 + MySQL** con arquitectura **MVC** para gestión de taller técnico (computadores, impresoras, celulares).

## Características implementadas

- Arquitectura MVC real (`src/Core`, `src/Controllers`, `src/Models`, `src/Views`).
- Autenticación segura con `password_hash/password_verify`.
- Protección CSRF básica.
- Panel administrativo responsive con sidebar y dashboard.
- Portal público de seguimiento de órdenes.
- Módulos base listos para ampliar: clientes, equipos, órdenes, diagnósticos, cotizaciones, inventario, pagos, reportes, usuarios, auditoría.
- SQL completo con tablas, claves, índices y datos semilla.

## Estructura de carpetas

```text
.
├── index.php
├── .htaccess
├── public/
│   └── assets/
│       ├── css/app.css
│       └── js/app.js
├── src/
│   ├── bootstrap.php
│   ├── routes.php
│   ├── Config/config.php
│   ├── Core/
│   ├── Controllers/
│   ├── Helpers/helpers.php
│   ├── Models/
│   └── Views/
│       ├── layouts/
│       ├── partials/
│       ├── auth/
│       ├── dashboard/
│       ├── customers/
│       ├── devices/
│       ├── orders/
│       ├── portal/
│       ├── diagnostics/
│       ├── quotations/
│       ├── inventory/
│       ├── payments/
│       ├── receipts/
│       ├── reports/
│       ├── technicians/
│       ├── users/
│       └── audit/
└── database/
    └── taller_servicio.sql
```

## Instalación local

1. Clona/copia el proyecto.
2. Crea la base de datos ejecutando:
   ```bash
   mysql -u root -p < database/taller_servicio.sql
   ```
3. Configura variables de entorno (opcional) o edita `src/Config/config.php`:
   - `DB_HOST`
   - `DB_PORT`
   - `DB_DATABASE`
   - `DB_USERNAME`
   - `DB_PASSWORD`
   - `APP_URL`
4. Levanta servidor local:
   ```bash
   php -S localhost:8080
   ```
5. Abre:
   - Panel: `http://localhost:8080/login`
   - Portal público: `http://localhost:8080/portal`

## Instalación en hosting compartido / VPS

- Subir archivos al `public_html` (o configurar virtual host apuntando a la raíz del proyecto).
- Activar `mod_rewrite` y permitir `.htaccess`.
- Importar `database/taller_servicio.sql`.
- Configurar credenciales de BD en variables de entorno o `src/Config/config.php`.
- Asegurar permisos de escritura para `storage/`.
- Activar HTTPS en producción.

## Credenciales iniciales

- Usuario: `admin`
- Email: `admin@tallerlocal.com`
- Password: `Admin123*`

## Esquema de base de datos

Tablas principales:

- `users`, `roles`, `permissions`, `role_permissions`
- `customers`, `devices`, `device_photos`
- `technicians`
- `service_orders`, `service_statuses`, `service_order_status_history`
- `diagnostics`
- `quotations`, `quotation_items`
- `inventory_items`, `inventory_movements`, `suppliers`
- `payments`, `receipts`
- `settings`, `audit_logs`

> Revisa `database/taller_servicio.sql` para el esquema completo y datos de ejemplo.
