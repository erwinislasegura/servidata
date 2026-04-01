START TRANSACTION;

-- Catálogo base de funcionalidades para que /admin/funcionalidades tenga configuración inicial completa.
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
VALUES
('Máximo usuarios', 'maximo_usuarios', 'Límite de usuarios por empresa.', 'numerico', 'activo'),
('Máximo clientes', 'maximo_clientes', 'Límite de clientes por empresa.', 'numerico', 'activo'),
('Máximo productos', 'maximo_productos', 'Límite de productos por empresa.', 'numerico', 'activo'),
('Máximo cotizaciones mes', 'maximo_cotizaciones_mes', 'Límite mensual de cotizaciones por empresa.', 'numerico', 'activo'),
('Cotización PDF', 'cotizacion_pdf', 'Permite generar PDF de cotizaciones.', 'booleano', 'activo'),
('Cotización por correo', 'cotizacion_correo', 'Permite enviar cotizaciones por correo.', 'booleano', 'activo'),
('Logo personalizado', 'logo_personalizado', 'Permite subir logo propio de la empresa.', 'booleano', 'activo'),
('Reportes', 'reportes', 'Acceso a reportes avanzados.', 'booleano', 'activo'),
('Plantillas personalizadas', 'plantillas_personalizadas', 'Permite personalizar plantillas comerciales.', 'booleano', 'activo'),
('Acceso API', 'acceso_api', 'Habilita el acceso a API.', 'booleano', 'activo'),
('Soporte prioritario', 'soporte_prioritario', 'Habilita soporte prioritario.', 'booleano', 'activo'),
('Módulo clientes', 'modulo_clientes', 'Gestión de clientes y sus datos comerciales.', 'booleano', 'activo'),
('Módulo productos', 'modulo_productos', 'Catálogo de productos y servicios.', 'booleano', 'activo'),
('Módulo cotizaciones', 'modulo_cotizaciones', 'Creación, envío y seguimiento de cotizaciones.', 'booleano', 'activo'),
('Módulo POS', 'modulo_pos', 'Punto de venta y control de caja.', 'booleano', 'activo'),
('Módulo inventario', 'modulo_inventario', 'Control de inventario y stock.', 'booleano', 'activo'),
('Módulo recepciones', 'modulo_recepciones', 'Recepciones de mercadería en inventario.', 'booleano', 'activo'),
('Módulo ajustes', 'modulo_ajustes', 'Ajustes manuales de inventario.', 'booleano', 'activo'),
('Módulo movimientos', 'modulo_movimientos', 'Trazabilidad de movimientos de stock.', 'booleano', 'activo'),
('Módulo contactos', 'modulo_contactos', 'Gestión de contactos comerciales.', 'booleano', 'activo'),
('Módulo vendedores', 'modulo_vendedores', 'Gestión de vendedores y asignaciones.', 'booleano', 'activo'),
('Módulo categorías', 'modulo_categorias', 'Gestión de categorías de productos.', 'booleano', 'activo'),
('Módulo listas de precios', 'modulo_listas_precios', 'Listas de precios por canal/cliente.', 'booleano', 'activo'),
('Módulo seguimiento', 'modulo_seguimiento', 'Seguimiento de actividades comerciales.', 'booleano', 'activo'),
('Módulo aprobaciones', 'modulo_aprobaciones', 'Flujos de aprobación comercial.', 'booleano', 'activo'),
('Módulo documentos', 'modulo_documentos', 'Gestión de documentos y plantillas.', 'booleano', 'activo'),
('Módulo configuración', 'modulo_configuracion', 'Configuración general de empresa.', 'booleano', 'activo'),
('Módulo usuarios', 'modulo_usuarios', 'Gestión de usuarios internos.', 'booleano', 'activo'),
('Módulo correos stock', 'modulo_correos_stock', 'Configuración de alertas por correo de stock.', 'booleano', 'activo'),
('Módulo órdenes de compra', 'modulo_ordenes_compra', 'Gestión de órdenes de compra.', 'booleano', 'activo'),
('Módulo notificaciones', 'modulo_notificaciones', 'Notificaciones operativas y comerciales.', 'booleano', 'activo'),
('Módulo historial', 'modulo_historial', 'Historial y auditoría de acciones.', 'booleano', 'activo')
ON DUPLICATE KEY UPDATE
    nombre = VALUES(nombre),
    descripcion = VALUES(descripcion),
    tipo_valor = VALUES(tipo_valor),
    estado = VALUES(estado),
    fecha_actualizacion = NOW();

COMMIT;
