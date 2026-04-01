# Base de datos FULL (sin errores) para montar y usar

Para dejar todo listo (tablas + actualizaciones + usuarios root) usa el instalador automático:

```bash
php scripts/instalar_base_datos_full_tallerlocal.php
```

Este instalador aplica, en orden:
1. `base_datos/esquema/esquema.sql`
2. `base_datos/esquema/semillas.sql`
3. `base_datos/esquema/datos_demo.sql`
4. Todas las actualizaciones de `base_datos/actualizaciones/*.sql`

Además valida al final:
- Tabla `st_clientes`
- Tabla `st_ordenes`
- Usuario root activo `root@tallerlocal.com`
- Usuario admin activo `admin@tallerlocal.com`

## Credenciales root iniciales
- Root plataforma: `root@tallerlocal.com`
- Admin cliente: `admin@tallerlocal.com`
- Password inicial (ambos): `Admin123*`

## Opción alternativa (SQL único)
Si prefieres importar un solo archivo:

```bash
mysql -u TU_USUARIO -p TU_BASE < base_datos/instalacion/base_datos_full_servicio_tecnico.sql
```

> Recomendado: usar el instalador PHP para validar automáticamente y evitar errores de carga.
