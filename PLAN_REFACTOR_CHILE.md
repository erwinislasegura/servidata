# Propuesta de refactor (Chile) + ejecución inicial

## 1) Nueva estructura de menú
- **Operación:** Dashboard, Nueva Orden/Órdenes, Diagnósticos, Cotizaciones, Caja/Pagos.
- **Registros:** Clientes, Equipos, Técnicos, Inventario.
- **Seguimiento y Admin:** Estados, Comprobantes, Reportes, Usuarios/Roles, Auditoría, Portal Público.
- Implementado con iconos Bootstrap Icons, estado activo y diseño colapsable en móvil.

## 2) Estructura visual del dashboard
- KPIs de operación: órdenes del día, diagnóstico/reparación/listas, cobros, clientes, stock bajo.
- Bloque de gráfico de órdenes por estado.
- Tabla rápida de últimas órdenes con fecha chilena.

## 3) Flujo optimizado para crear orden
- Pantalla única de mostrador con secciones:
  1. Cliente (selección existente o creación rápida).
  2. Equipo y falla.
  3. Costos/asignación.
- Guardado directo desde la misma pantalla.
- Mantiene lógica actual (clientes, equipos, órdenes, estados) y reduce cambios de pantalla.

## 4) Mejoras de base de datos sugeridas
- Crear migración incremental con:
  - `customers`: campos `rut`, `comuna`, `region`.
  - `service_orders`: `advance_paid`, `balance_due`, `ready_for_delivery`.
  - `settings`: formato monetario y localización por defecto (`CLP`, `es-CL`).
- Mantener compatibilidad con el esquema actual (sin romper tablas existentes).

## 5) Componentes reutilizables
- `layouts/app.php` como layout principal.
- `partials/sidebar.php`, `partials/topbar.php`.
- Helpers globales: `clp()`, `fecha_cl()`, `is_active()`.
- Tabla estándar para listados y badges de estado.

## 6) Plan de refactor por fases
1. **Fase 1 (hecha en este commit):** UI base (sidebar/topbar/dashboard), helper CLP/fecha, orden rápida unificada.
2. **Fase 2:** normalizar módulos “formulario arriba + listado abajo” (clientes, equipos, pagos, diagnósticos).
3. **Fase 3:** portal público y comprobantes A4/térmico.
4. **Fase 4:** permisos finos por rol + auditoría completa por acción.
5. **Fase 5:** reportes operativos/gerenciales y ajustes de performance.
