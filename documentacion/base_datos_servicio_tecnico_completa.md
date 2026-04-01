# Base de datos completa (Servicio Técnico) + usuario root cliente

## Objetivo
Dejar la base de datos en estado completo con:
1. Esquema base SaaS.
2. Semillas base.
3. Todas las actualizaciones de `base_datos/actualizaciones` (incluye módulo ST).
4. Usuario root del cliente:
   - Usuario: `admin`
   - Email: `admin@tallerlocal.com`
   - Password: `Admin123*`

## Orden recomendado de ejecución
```bash
mysql -u TU_USUARIO -p TU_BD < base_datos/esquema/esquema.sql
mysql -u TU_USUARIO -p TU_BD < base_datos/esquema/semillas.sql
mysql -u TU_USUARIO -p TU_BD < base_datos/esquema/datos_demo.sql
php scripts/actualizar_base_datos_acumulativa.php
```

> La ejecución acumulativa aplica automáticamente:
- `base_datos/actualizaciones/actualizacion_servicio_tecnico.sql`
- `base_datos/actualizaciones/actualizacion_servicio_tecnico_admin_root.sql`

## Validación rápida
```sql
SELECT id, nombre, correo, estado FROM usuarios WHERE correo = 'admin@tallerlocal.com';
SELECT id, nombre_comercial, correo, estado FROM empresas WHERE correo = 'admin@tallerlocal.com';
SELECT id, estado, fecha_inicio, fecha_vencimiento FROM suscripciones WHERE empresa_id = (
    SELECT id FROM empresas WHERE correo = 'admin@tallerlocal.com' LIMIT 1
) ORDER BY id DESC;
```

## Nota de seguridad (producción)
Al primer ingreso se recomienda forzar cambio de contraseña para `admin@tallerlocal.com`.
