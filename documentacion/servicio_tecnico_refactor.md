# Propuesta y refactor del Sistema de Gestión de Servicio Técnico (Chile)

## 1) Estructura de menú profesional
Se incorporó en el sidebar una sección **Servicio técnico** con grupos:
- **Operación:** Dashboard, Nueva Orden/Órdenes, Entregas, Diagnósticos, Cotizaciones, Caja/Pagos.
- **Registros:** Clientes, Equipos, Técnicos, Inventario/Repuestos, Proveedores.
- **Seguimiento:** Estados de servicio, historial de cambios, pendientes, en proceso y listos.
- **Administración:** Usuarios, roles, configuración, portal público, auditoría.

## 2) Flujo de orden ultra rápido
1. Recepción abre **Órdenes**.
2. Selecciona cliente/equipo y técnico en la misma pantalla.
3. Registra falla principal, monto total y adelanto.
4. Sistema calcula saldo automáticamente y crea N° de orden + código de seguimiento.
5. Opciones de guardado:
   - Guardar
   - Guardar + imprimir
   - Guardar + nueva orden

## 3) Mejoras de base de datos
Se agregó script SQL con enfoque producción:
- Tablas dedicadas `st_*` para evitar conflicto con módulos comerciales existentes.
- Llaves foráneas entre clientes, equipos, órdenes, diagnósticos, cotizaciones, pagos e inventario.
- Índices para búsquedas de mostrador y dashboard (estado, fechas, serie/IMEI, stock).
- Soft delete mediante `fecha_eliminacion`.
- Campos de auditoría y timestamps.

## 4) Diseño de dashboard
Dashboard operativo con:
- KPIs del día/mes (órdenes, estados, cobranzas, stock, no retirados).
- Tabla de últimas órdenes.
- Lista de próximas entregas.
- Formato moneda chilena en CLP sin decimales.

## 5) Resultado del refactor (fase actual)
Se implementó una base funcional profesional del módulo de servicio técnico reutilizando la arquitectura MVC existente:
- Nuevo controlador `ServicioTecnicoControlador`.
- Nuevo modelo `ServicioTecnico` (PDO prepared statements).
- Nuevas vistas para dashboard, clientes, equipos, órdenes y portal público.
- Nuevas rutas bajo `/app/servicio-tecnico/*`.
- Menú lateral actualizado para operación rápida de mostrador.

> Próxima fase recomendada: completar edición inline avanzada por fila, impresión térmica/A4 con comprobantes y reportes gráficos con series temporales.
