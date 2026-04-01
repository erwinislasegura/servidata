# Base de datos FULL (lista para cargar)

Si quieres **llegar y cargar en un solo paso**, usa este archivo:

- `base_datos/instalacion/base_datos_full_servicio_tecnico.sql`

Incluye todo:
1. Esquema base SaaS
2. Semillas base
3. Datos demo
4. Todas las actualizaciones de `base_datos/actualizaciones`
   - incluido módulo Servicio Técnico (`st_*`)
   - incluido root cliente `admin@tallerlocal.com`

## Carga directa (1 comando)
```bash
mysql -u TU_USUARIO -p TU_BASE < base_datos/instalacion/base_datos_full_servicio_tecnico.sql
```

## Credenciales iniciales cliente
- Usuario: `admin`
- Email: `admin@tallerlocal.com`
- Password: `Admin123*`

## Verificación rápida
```sql
SELECT id, nombre, correo, estado
FROM usuarios
WHERE correo = 'admin@tallerlocal.com';
```

> Nota: el SQL FULL está preparado para instalación genérica (se removieron `USE ...` hardcodeados).
