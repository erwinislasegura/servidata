-- SQL FULL AUTOGENERADO: Servicio Técnico
-- Generado: 2026-04-01 05:07:25 UTC
-- Incluye: esquema base + semillas + datos_demo + todas las actualizaciones
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ==================================================
-- SOURCE: base_datos/esquema/esquema.sql
-- ==================================================
CREATE DATABASE IF NOT EXISTS cotiza_saas CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- USE cotiza_saas;  -- removido para instalación genérica

CREATE TABLE roles (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  codigo VARCHAR(80) NOT NULL UNIQUE,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE permisos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  codigo VARCHAR(120) NOT NULL UNIQUE,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles_permisos (
  rol_id BIGINT UNSIGNED NOT NULL,
  permiso_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (rol_id, permiso_id),
  CONSTRAINT fk_rp_rol FOREIGN KEY (rol_id) REFERENCES roles(id),
  CONSTRAINT fk_rp_permiso FOREIGN KEY (permiso_id) REFERENCES permisos(id)
);

CREATE TABLE planes (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  slug VARCHAR(150) NOT NULL UNIQUE,
  descripcion_comercial TEXT NULL,
  precio_mensual DECIMAL(12,2) NOT NULL DEFAULT 0,
  precio_anual DECIMAL(12,2) NOT NULL DEFAULT 0,
  duracion_dias INT NOT NULL DEFAULT 30,
  visible TINYINT(1) NOT NULL DEFAULT 1,
  destacado TINYINT(1) NOT NULL DEFAULT 0,
  orden_visualizacion INT NOT NULL DEFAULT 0,
  insignia VARCHAR(60) NULL,
  resumen_comercial VARCHAR(255) NULL,
  color_visual VARCHAR(20) NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  fecha_eliminacion DATETIME NULL
);

CREATE TABLE empresas (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  razon_social VARCHAR(150) NOT NULL,
  nombre_comercial VARCHAR(150) NOT NULL,
  identificador_fiscal VARCHAR(80) NOT NULL,
  correo VARCHAR(150) NOT NULL,
  telefono VARCHAR(60) NULL,
  direccion VARCHAR(200) NULL,
  ciudad VARCHAR(120) NULL,
  pais VARCHAR(120) NULL,
  logo VARCHAR(255) NULL,
  imap_host VARCHAR(180) NULL,
  imap_port SMALLINT UNSIGNED NULL,
  imap_encryption ENUM('ssl','tls','none') NULL,
  imap_usuario VARCHAR(180) NULL,
  imap_password VARCHAR(255) NULL,
  imap_remitente_correo VARCHAR(180) NULL,
  imap_remitente_nombre VARCHAR(180) NULL,
  estado ENUM('activa','suspendida','vencida','cancelada') NOT NULL DEFAULT 'activa',
  fecha_activacion DATE NULL,
  plan_id BIGINT UNSIGNED NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  fecha_eliminacion DATETIME NULL,
  INDEX idx_empresas_plan_id (plan_id),
  CONSTRAINT fk_empresas_plan FOREIGN KEY (plan_id) REFERENCES planes(id)
);

CREATE TABLE usuarios (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NULL,
  rol_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  correo VARCHAR(150) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  telefono VARCHAR(80) NULL,
  cargo VARCHAR(120) NULL,
  biografia TEXT NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  ultimo_acceso DATETIME NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  fecha_eliminacion DATETIME NULL,
  INDEX idx_usuarios_empresa (empresa_id),
  CONSTRAINT fk_usuarios_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_usuarios_rol FOREIGN KEY (rol_id) REFERENCES roles(id)
);

CREATE TABLE funcionalidades (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  codigo_interno VARCHAR(120) NOT NULL UNIQUE,
  descripcion TEXT NULL,
  tipo_valor ENUM('booleano','numerico','ilimitado') NOT NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  fecha_eliminacion DATETIME NULL
);

CREATE TABLE plan_funcionalidades (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  plan_id BIGINT UNSIGNED NOT NULL,
  funcionalidad_id BIGINT UNSIGNED NOT NULL,
  activo TINYINT(1) NOT NULL DEFAULT 1,
  valor_numerico INT NOT NULL DEFAULT 0,
  es_ilimitado TINYINT(1) NOT NULL DEFAULT 0,
  fecha_actualizacion DATETIME NULL,
  UNIQUE KEY uq_plan_funcionalidad (plan_id, funcionalidad_id),
  CONSTRAINT fk_pf_plan FOREIGN KEY (plan_id) REFERENCES planes(id),
  CONSTRAINT fk_pf_funcionalidad FOREIGN KEY (funcionalidad_id) REFERENCES funcionalidades(id)
);

CREATE TABLE suscripciones (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  plan_id BIGINT UNSIGNED NOT NULL,
  estado ENUM('activa','pendiente','por_vencer','vencida','suspendida','cancelada') NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_vencimiento DATE NOT NULL,
  renovacion_automatica TINYINT(1) NOT NULL DEFAULT 0,
  observaciones TEXT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  fecha_eliminacion DATETIME NULL,
  INDEX idx_suscripciones_empresa (empresa_id),
  INDEX idx_suscripciones_estado (estado),
  CONSTRAINT fk_suscripciones_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_suscripciones_plan FOREIGN KEY (plan_id) REFERENCES planes(id)
);

CREATE TABLE historial_suscripciones (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  suscripcion_id BIGINT UNSIGNED NOT NULL,
  accion VARCHAR(120) NOT NULL,
  observaciones TEXT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_historial_suscripcion FOREIGN KEY (suscripcion_id) REFERENCES suscripciones(id)
);

CREATE TABLE pagos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  suscripcion_id BIGINT UNSIGNED NOT NULL,
  monto DECIMAL(12,2) NOT NULL,
  moneda VARCHAR(10) NOT NULL DEFAULT 'USD',
  metodo VARCHAR(60) NULL,
  estado ENUM('pendiente','aprobado','rechazado','anulado') NOT NULL,
  referencia_externa VARCHAR(120) NULL,
  observaciones TEXT NULL,
  payload JSON NULL,
  fecha_pago DATETIME NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_pagos_empresa (empresa_id),
  CONSTRAINT fk_pagos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_pagos_suscripcion FOREIGN KEY (suscripcion_id) REFERENCES suscripciones(id)
);

CREATE TABLE logs_pagos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  pago_id BIGINT UNSIGNED NULL,
  tipo_evento VARCHAR(120) NOT NULL,
  payload JSON NULL,
  respuesta TEXT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_logs_pagos_pago FOREIGN KEY (pago_id) REFERENCES pagos(id)
);

CREATE TABLE clientes (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  razon_social VARCHAR(180) NULL,
  nombre_comercial VARCHAR(180) NULL,
  identificador_fiscal VARCHAR(80) NULL,
  giro VARCHAR(180) NULL,
  correo VARCHAR(150) NULL,
  telefono VARCHAR(80) NULL,
  direccion VARCHAR(220) NULL,
  ciudad VARCHAR(120) NULL,
  vendedor_id BIGINT UNSIGNED NULL,
  notas TEXT NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  fecha_eliminacion DATETIME NULL,
  INDEX idx_clientes_empresa (empresa_id),
  CONSTRAINT fk_clientes_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

CREATE TABLE contactos_cliente (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cliente_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  cargo VARCHAR(120) NULL,
  correo VARCHAR(150) NULL,
  telefono VARCHAR(80) NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_contactos_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE categorias_productos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_categorias_empresa (empresa_id),
  CONSTRAINT fk_categorias_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

CREATE TABLE productos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  categoria_id BIGINT UNSIGNED NULL,
  tipo ENUM('producto','servicio') NOT NULL DEFAULT 'producto',
  codigo VARCHAR(60) NOT NULL,
  sku VARCHAR(80) NULL,
  codigo_barras VARCHAR(120) NULL,
  nombre VARCHAR(150) NOT NULL,
  descripcion TEXT NULL,
  unidad VARCHAR(40) NULL,
  precio DECIMAL(12,2) NOT NULL DEFAULT 0,
  costo DECIMAL(12,2) NOT NULL DEFAULT 0,
  impuesto DECIMAL(8,2) NOT NULL DEFAULT 0,
  descuento_maximo DECIMAL(8,2) NOT NULL DEFAULT 0,
  stock_minimo DECIMAL(12,2) NOT NULL DEFAULT 0,
  stock_aviso DECIMAL(12,2) NOT NULL DEFAULT 0,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  fecha_eliminacion DATETIME NULL,
  INDEX idx_productos_empresa (empresa_id),
  CONSTRAINT fk_productos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_productos_categoria FOREIGN KEY (categoria_id) REFERENCES categorias_productos(id)
);

CREATE TABLE cotizaciones (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  cliente_id BIGINT UNSIGNED NOT NULL,
  usuario_id BIGINT UNSIGNED NOT NULL,
  numero VARCHAR(60) NOT NULL,
  consecutivo INT NOT NULL,
  estado ENUM('borrador','enviada','aprobada','rechazada','vencida','anulada') NOT NULL,
  subtotal DECIMAL(12,2) NOT NULL,
  descuento_tipo ENUM('valor','porcentaje') NOT NULL DEFAULT 'valor',
  descuento_valor DECIMAL(12,2) NOT NULL DEFAULT 0,
  descuento DECIMAL(12,2) NOT NULL DEFAULT 0,
  impuesto DECIMAL(12,2) NOT NULL DEFAULT 0,
  total DECIMAL(12,2) NOT NULL,
  observaciones TEXT NULL,
  terminos_condiciones TEXT NULL,
  lista_precio_id BIGINT UNSIGNED NULL,
  token_publico CHAR(64) NULL,
  firma_cliente MEDIUMTEXT NULL,
  nombre_firmante_cliente VARCHAR(180) NULL,
  fecha_aprobacion_cliente DATETIME NULL,
  fecha_emision DATE NOT NULL,
  fecha_vencimiento DATE NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  fecha_eliminacion DATETIME NULL,
  UNIQUE KEY uq_cot_num_empresa (empresa_id, numero),
  UNIQUE KEY uq_cot_token_publico (token_publico),
  INDEX idx_cotizaciones_empresa (empresa_id),
  CONSTRAINT fk_cotizaciones_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_cotizaciones_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  CONSTRAINT fk_cotizaciones_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE items_cotizacion (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cotizacion_id BIGINT UNSIGNED NOT NULL,
  producto_id BIGINT UNSIGNED NULL,
  descripcion VARCHAR(255) NOT NULL,
  cantidad DECIMAL(12,2) NOT NULL,
  precio_unitario DECIMAL(12,2) NOT NULL,
  descuento_tipo ENUM('valor','porcentaje') NOT NULL DEFAULT 'valor',
  descuento_valor DECIMAL(12,2) NOT NULL DEFAULT 0,
  descuento_monto DECIMAL(12,2) NOT NULL DEFAULT 0,
  porcentaje_impuesto DECIMAL(8,2) NOT NULL DEFAULT 0,
  subtotal DECIMAL(12,2) NOT NULL,
  total DECIMAL(12,2) NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_items_cotizacion FOREIGN KEY (cotizacion_id) REFERENCES cotizaciones(id),
  CONSTRAINT fk_items_producto FOREIGN KEY (producto_id) REFERENCES productos(id)
);

CREATE TABLE historial_estados_cotizacion (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  cotizacion_id BIGINT UNSIGNED NOT NULL,
  estado VARCHAR(60) NOT NULL,
  observaciones TEXT NULL,
  usuario_id BIGINT UNSIGNED NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_historial_estado_cotizacion FOREIGN KEY (cotizacion_id) REFERENCES cotizaciones(id),
  CONSTRAINT fk_historial_estado_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE logs_correos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  destinatario VARCHAR(160) NOT NULL,
  asunto VARCHAR(180) NOT NULL,
  plantilla VARCHAR(120) NOT NULL,
  payload JSON NULL,
  estado VARCHAR(40) NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE logs_actividad (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NULL,
  usuario_id BIGINT UNSIGNED NULL,
  modulo VARCHAR(120) NOT NULL,
  accion VARCHAR(120) NOT NULL,
  detalle TEXT NULL,
  ip VARCHAR(45) NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_logs_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_logs_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE restablecimientos_contrasena (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  usuario_id BIGINT UNSIGNED NOT NULL,
  token VARCHAR(120) NOT NULL,
  expiracion DATETIME NOT NULL,
  usado TINYINT(1) NOT NULL DEFAULT 0,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_restablecimientos_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE configuraciones (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  clave VARCHAR(120) NOT NULL UNIQUE,
  valor TEXT NULL,
  descripcion VARCHAR(255) NULL,
  fecha_actualizacion DATETIME NULL
);

CREATE TABLE configuraciones_empresa (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  clave VARCHAR(120) NOT NULL,
  valor TEXT NULL,
  fecha_actualizacion DATETIME NULL,
  UNIQUE KEY uq_conf_empresa (empresa_id, clave),
  CONSTRAINT fk_conf_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

CREATE TABLE documentos_plantillas (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(160) NOT NULL,
  tipo_documento VARCHAR(80) NOT NULL DEFAULT 'cotizacion',
  terminos_defecto TEXT NULL,
  observaciones_defecto TEXT NULL,
  firma VARCHAR(180) NULL,
  logo VARCHAR(255) NULL,
  pie_documento VARCHAR(255) NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_documentos_empresa (empresa_id),
  CONSTRAINT fk_documentos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

-- ==================================================
-- SOURCE: base_datos/esquema/semillas.sql
-- ==================================================
-- USE cotiza_saas;  -- removido para instalación genérica

INSERT INTO roles (id, nombre, codigo) VALUES
(1, 'Superadministrador', 'superadministrador'),
(2, 'Administrador', 'administrador_empresa'),
(3, 'Vendedor', 'vendedor'),
(4, 'Administrativo', 'administrativo'),
(5, 'Contabilidad', 'contabilidad'),
(6, 'Supervisor Comercial', 'supervisor_comercial'),
(7, 'Operaciones', 'operaciones'),
(8, 'Usuario de Empresa', 'usuario_empresa');

INSERT INTO permisos (nombre, codigo) VALUES
('Acceso panel admin', 'panel_admin'),
('Gestión planes', 'planes'),
('Gestión funcionalidades', 'funcionalidades'),
('Gestión suscripciones', 'suscripciones'),
('Gestión clientes', 'clientes'),
('Gestión productos', 'productos'),
('Gestión cotizaciones', 'cotizaciones'),
('Panel empresa', 'panel_empresa');

INSERT INTO funcionalidades (id, nombre, codigo_interno, descripcion, tipo_valor, estado) VALUES
(1,'Máximo usuarios','maximo_usuarios','Límite de usuarios por empresa','numerico','activo'),
(2,'Máximo clientes','maximo_clientes','Límite de clientes por empresa','numerico','activo'),
(3,'Máximo productos','maximo_productos','Límite de productos por empresa','numerico','activo'),
(4,'Máximo cotizaciones mes','maximo_cotizaciones_mes','Límite mensual de cotizaciones','numerico','activo'),
(5,'Cotización PDF','cotizacion_pdf','Permite generar PDF','booleano','activo'),
(6,'Cotización por correo','cotizacion_correo','Permite enviar por correo','booleano','activo'),
(7,'Logo personalizado','logo_personalizado','Permite subir logo','booleano','activo'),
(8,'Reportes','reportes','Acceso a reportes avanzados','booleano','activo'),
(9,'Plantillas personalizadas','plantillas_personalizadas','Permite personalización de plantillas','booleano','activo'),
(10,'Acceso API','acceso_api','Habilita API','booleano','activo'),
(11,'Soporte prioritario','soporte_prioritario','Soporte preferencial','booleano','activo');

INSERT INTO planes (id, nombre, slug, descripcion_comercial, precio_mensual, precio_anual, duracion_dias, visible, destacado, orden_visualizacion, insignia, resumen_comercial, color_visual, estado)
VALUES
(1, 'Plan Inicial', 'plan-inicial', 'Ideal para empresas que comienzan.', 19, 190, 30, 1, 0, 1, NULL, 'Control básico y orden comercial', '#4f7ea8', 'activo'),
(2, 'Plan Profesional', 'plan-profesional', 'Para equipos que buscan productividad.', 49, 490, 30, 1, 1, 2, 'Más vendido', 'Automatización completa de cotizaciones', '#1f4f78', 'activo'),
(3, 'Plan Corporativo', 'plan-corporativo', 'Para operación avanzada multiusuario.', 99, 990, 30, 1, 0, 3, 'Escalable', 'Mayor capacidad y soporte prioritario', '#0f2f4a', 'activo');

INSERT INTO plan_funcionalidades (plan_id, funcionalidad_id, activo, valor_numerico, es_ilimitado) VALUES
(1,1,1,3,0),(1,2,1,50,0),(1,3,1,100,0),(1,4,1,80,0),(1,5,1,1,0),(1,6,0,0,0),(1,7,0,0,0),(1,8,0,0,0),
(2,1,1,10,0),(2,2,1,250,0),(2,3,1,500,0),(2,4,1,300,0),(2,5,1,1,0),(2,6,1,1,0),(2,7,1,1,0),(2,8,1,1,0),(2,9,1,1,0),
(3,1,1,0,1),(3,2,1,0,1),(3,3,1,0,1),(3,4,1,0,1),(3,5,1,1,0),(3,6,1,1,0),(3,7,1,1,0),(3,8,1,1,0),(3,9,1,1,0),(3,10,1,1,0),(3,11,1,1,0);

INSERT INTO configuraciones (clave, valor, descripcion) VALUES
('nombre_plataforma', 'CotizaPro', 'Nombre comercial de la plataforma'),
('correo_soporte', 'soporte@cotizapro.local', 'Correo principal de soporte'),
('dias_alerta_vencimiento', '7', 'Días previos para alertar vencimientos');

-- ==================================================
-- SOURCE: base_datos/esquema/datos_demo.sql
-- ==================================================
-- USE cotiza_saas;  -- removido para instalación genérica

INSERT INTO empresas (id, razon_social, nombre_comercial, identificador_fiscal, correo, telefono, direccion, ciudad, pais, estado, fecha_activacion, plan_id)
VALUES
(1, 'CotizaPro SAS', 'CotizaPro Plataforma', '900111222', 'admin@cotizapro.com', '3001002000', 'Av. SaaS 100', 'Bogotá', 'Colombia', 'activa', '2026-01-01', 3),
(2, 'Comercial Andina SAS', 'Andina Comercial', '800555444', 'contacto@andina.com', '3015550001', 'Calle 10 #20-30', 'Medellín', 'Colombia', 'activa', '2026-02-01', 2),
(3, 'Servicios Pacífico SAS', 'Pacífico Servicios', '811222333', 'ventas@pacifico.com', '3028880001', 'Av. 3 Norte', 'Cali', 'Colombia', 'vencida', '2025-10-01', 1);

INSERT INTO usuarios (empresa_id, rol_id, nombre, correo, password, estado) VALUES
(NULL, 1, 'Super Admin', 'superadmin@cotizapro.com', '$2y$12$l7d9QArsnPnqUeo/YjnXfOsDig87Wswc2LvMubdMw2kt1LRD4xhdi', 'activo'),
(2, 2, 'Laura Mejía', 'admin@andina.com', '$2y$12$l7d9QArsnPnqUeo/YjnXfOsDig87Wswc2LvMubdMw2kt1LRD4xhdi', 'activo'),
(2, 3, 'Analista Andina', 'usuario@andina.com', '$2y$12$l7d9QArsnPnqUeo/YjnXfOsDig87Wswc2LvMubdMw2kt1LRD4xhdi', 'activo'),
(2, 3, 'QA Andina', 'qa@andina.com', '$2y$12$l7d9QArsnPnqUeo/YjnXfOsDig87Wswc2LvMubdMw2kt1LRD4xhdi', 'activo'),
(3, 2, 'Carlos Reyes', 'admin@pacifico.com', '$2y$12$l7d9QArsnPnqUeo/YjnXfOsDig87Wswc2LvMubdMw2kt1LRD4xhdi', 'activo');

INSERT INTO suscripciones (id, empresa_id, plan_id, estado, fecha_inicio, fecha_vencimiento, renovacion_automatica, observaciones)
VALUES
(1,2,2,'activa','2026-03-01','2026-04-01',0,'Suscripción mensual activa'),
(2,3,1,'vencida','2026-01-01','2026-02-01',0,'Cuenta vencida sin renovación');

INSERT INTO historial_suscripciones (suscripcion_id, accion, observaciones) VALUES
(1, 'alta', 'Registro inicial de suscripción activa'),
(2, 'vencimiento', 'No se recibió renovación');

INSERT INTO clientes (empresa_id, nombre, correo, telefono, direccion, notas, estado) VALUES
(2, 'Constructora Horizonte', 'compras@horizonte.com', '3201112233', 'Calle 123', 'Cliente estratégico', 'activo'),
(2, 'Insumos del Norte', 'contacto@insumosnorte.com', '3204445566', 'Carrera 45', 'Negociación anual', 'activo'),
(3, 'Transportes del Pacífico', 'info@transportespac.com', '3102001000', 'Avenida mar', 'Cliente histórico', 'activo');

INSERT INTO productos (empresa_id, categoria_id, codigo, nombre, descripcion, unidad, precio, impuesto, estado) VALUES
(2, NULL, 'SRV-001', 'Servicio de mantenimiento', 'Mantenimiento preventivo mensual', 'servicio', 1500, 19, 'activo'),
(2, NULL, 'PRD-002', 'Kit repuestos premium', 'Incluye piezas certificadas', 'kit', 980, 19, 'activo'),
(3, NULL, 'SRV-100', 'Consultoría logística', 'Optimización operativa', 'hora', 220, 19, 'activo');

INSERT INTO cotizaciones (empresa_id, cliente_id, usuario_id, numero, consecutivo, estado, subtotal, descuento, impuesto, total, observaciones, terminos_condiciones, fecha_emision, fecha_vencimiento)
VALUES
(2,1,2,'COT-002-000001',1,'enviada',1500,0,285,1785,'Incluye visita técnica','Validez 15 días','2026-03-20','2026-04-04'),
(2,2,2,'COT-002-000002',2,'aprobada',980,0,186.2,1166.2,'Entrega en 72 horas','Pago 50% anticipado','2026-03-21','2026-04-05'),
(3,3,4,'COT-003-000001',1,'vencida',2200,0,418,2618,'Propuesta trimestral','Sujeta a disponibilidad','2026-01-10','2026-01-25');

INSERT INTO items_cotizacion (cotizacion_id, producto_id, descripcion, cantidad, precio_unitario, porcentaje_impuesto, subtotal, total) VALUES
(1,1,'Servicio de mantenimiento',1,1500,19,1500,1785),
(2,2,'Kit repuestos premium',1,980,19,980,1166.2),
(3,3,'Consultoría logística',10,220,19,2200,2618);

INSERT INTO historial_estados_cotizacion (cotizacion_id, estado, observaciones, usuario_id) VALUES
(1,'enviada','Enviada por correo al cliente',2),
(2,'aprobada','Aprobada por cliente',2),
(3,'vencida','No hubo respuesta del cliente',4);

INSERT INTO pagos (empresa_id, suscripcion_id, monto, moneda, metodo, estado, referencia_externa, observaciones, payload, fecha_pago) VALUES
(2,1,49,'USD','transferencia','aprobado','REF-AND-001','Pago mensual recibido', JSON_OBJECT('origen','demo'), '2026-03-01 10:00:00'),
(3,2,19,'USD','tarjeta','rechazado','REF-PAC-002','Tarjeta sin fondos', JSON_OBJECT('origen','demo'), '2026-02-01 10:30:00');

INSERT INTO logs_pagos (pago_id, tipo_evento, payload, respuesta) VALUES
(1, 'webhook.aprobado', JSON_OBJECT('evento','aprobado'), 'Suscripción activa confirmada'),
(2, 'webhook.rechazado', JSON_OBJECT('evento','rechazado'), 'Se notificó rechazo');

INSERT INTO configuraciones_empresa (empresa_id, clave, valor) VALUES
(2, 'moneda_preferida', 'USD'),
(2, 'terminos_cotizacion', 'Validez 15 días'),
(3, 'moneda_preferida', 'USD');

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_coherencia_planes_publicos.sql
-- ==================================================
-- USE cotiza_saas;  -- removido para instalación genérica

-- Funcionalidades faltantes + descripciones comerciales coherentes
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
VALUES
('Módulo clientes', 'modulo_clientes', 'Gestión de clientes y sus datos comerciales.', 'booleano', 'activo'),
('Módulo productos', 'modulo_productos', 'Catálogo de productos y servicios con soporte de carga masiva.', 'booleano', 'activo'),
('Módulo cotizaciones', 'modulo_cotizaciones', 'Creación, envío y seguimiento de cotizaciones.', 'booleano', 'activo'),
('Módulo POS', 'modulo_pos', 'Punto de venta para registrar ventas y movimientos de caja.', 'booleano', 'activo'),
('Módulo inventario', 'modulo_inventario', 'Inventario base con proveedores y control de stock.', 'booleano', 'activo'),
('Módulo recepciones', 'modulo_recepciones', 'Recepciones de mercadería asociadas a inventario.', 'booleano', 'activo'),
('Módulo ajustes', 'modulo_ajustes', 'Ajustes manuales de inventario por diferencias operativas.', 'booleano', 'activo'),
('Módulo movimientos', 'modulo_movimientos', 'Historial de movimientos de stock y trazabilidad.', 'booleano', 'activo'),
('Módulo contactos', 'modulo_contactos', 'Gestión de contactos comerciales vinculados a clientes.', 'booleano', 'activo'),
('Módulo vendedores', 'modulo_vendedores', 'Gestión de vendedores y asignación comercial.', 'booleano', 'activo'),
('Módulo categorías', 'modulo_categorias', 'Clasificación de productos por categorías.', 'booleano', 'activo'),
('Módulo listas de precios', 'modulo_listas_precios', 'Listas de precios por canal, cliente o condición comercial.', 'booleano', 'activo'),
('Módulo seguimiento', 'modulo_seguimiento', 'Seguimiento de oportunidades y actividades comerciales.', 'booleano', 'activo'),
('Módulo aprobaciones', 'modulo_aprobaciones', 'Flujos de aprobación para operaciones comerciales.', 'booleano', 'activo'),
('Módulo documentos', 'modulo_documentos', 'Gestión de plantillas y documentos comerciales.', 'booleano', 'activo'),
('Módulo reportes', 'modulo_reportes', 'Reportes de ventas, inventario y desempeño comercial.', 'booleano', 'activo'),
('Módulo configuración', 'modulo_configuracion', 'Configuración general de la empresa.', 'booleano', 'activo'),
('Módulo usuarios', 'modulo_usuarios', 'Gestión de usuarios internos y permisos.', 'booleano', 'activo'),
('Módulo correos stock', 'modulo_correos_stock', 'Alertas y configuración de correos de stock.', 'booleano', 'activo'),
('Módulo órdenes de compra', 'modulo_ordenes_compra', 'Gestión de órdenes de compra a proveedores.', 'booleano', 'activo'),
('Módulo notificaciones', 'modulo_notificaciones', 'Notificaciones operativas y comerciales del sistema.', 'booleano', 'activo'),
('Módulo historial', 'modulo_historial', 'Historial y auditoría de actividad operativa.', 'booleano', 'activo')
ON DUPLICATE KEY UPDATE
  nombre = VALUES(nombre),
  descripcion = VALUES(descripcion),
  tipo_valor = VALUES(tipo_valor),
  estado = VALUES(estado),
  fecha_actualizacion = NOW();

-- Coherencia de planes base
CREATE TEMPORARY TABLE IF NOT EXISTS tmp_planes_base (
  nombre VARCHAR(120) NOT NULL,
  slug VARCHAR(150) NOT NULL,
  descripcion_comercial TEXT NULL,
  precio_mensual DECIMAL(12,2) NOT NULL,
  descuento_anual_pct DECIMAL(5,2) NOT NULL,
  precio_anual DECIMAL(12,2) NOT NULL,
  duracion_dias INT NOT NULL,
  visible TINYINT(1) NOT NULL,
  destacado TINYINT(1) NOT NULL,
  recomendado TINYINT(1) NOT NULL,
  orden_visualizacion INT NOT NULL,
  insignia VARCHAR(120) NULL,
  resumen_comercial TEXT NULL,
  color_visual VARCHAR(30) NULL,
  maximo_usuarios INT NOT NULL,
  usuarios_ilimitados TINYINT(1) NOT NULL,
  observaciones_internas TEXT NULL,
  estado VARCHAR(20) NOT NULL,
  PRIMARY KEY (slug)
);

DELETE FROM tmp_planes_base;

INSERT INTO tmp_planes_base (
  nombre, slug, descripcion_comercial, precio_mensual, descuento_anual_pct, precio_anual,
  duracion_dias, visible, destacado, recomendado, orden_visualizacion, insignia,
  resumen_comercial, color_visual, maximo_usuarios, usuarios_ilimitados, observaciones_internas, estado
) VALUES
('Básico', 'basico', 'Plan de entrada para operar cotizaciones y operación comercial inicial.', 15000, 10, 162000, 30, 1, 0, 0, 1, 'Inicial', 'Ideal para comenzar con operación comercial ordenada.', '#3b82f6', 2, 0, 'Plan inicial con alcance controlado.', 'activo'),
('Profesional', 'profesional', 'Plan recomendado para escalar ventas con inventario y control comercial.', 26000, 10, 280800, 30, 1, 1, 1, 2, 'Más elegido', 'Incluye inventario completo, seguimiento y analítica base.', '#0ea5a4', 8, 0, 'Plan recomendado para la mayoría de empresas.', 'activo'),
('Empresa', 'empresa', 'Plan avanzado para operación integral con mayor capacidad y control.', 55000, 15, 561000, 30, 1, 1, 0, 3, 'Escalable', 'Acceso completo a módulos y operación multiusuario.', '#7c3aed', 0, 1, 'Plan corporativo con usuarios ilimitados.', 'activo');

INSERT INTO planes (nombre, slug, descripcion_comercial, precio_mensual, descuento_anual_pct, precio_anual, duracion_dias, visible, destacado, recomendado, orden_visualizacion, insignia, resumen_comercial, color_visual, maximo_usuarios, usuarios_ilimitados, observaciones_internas, estado)
SELECT t.nombre, t.slug, t.descripcion_comercial, t.precio_mensual, t.descuento_anual_pct, t.precio_anual, t.duracion_dias, t.visible, t.destacado, t.recomendado, t.orden_visualizacion, t.insignia, t.resumen_comercial, t.color_visual, t.maximo_usuarios, t.usuarios_ilimitados, t.observaciones_internas, t.estado FROM tmp_planes_base t LEFT JOIN planes p ON p.slug = t.slug WHERE p.id IS NULL;

UPDATE planes p
INNER JOIN tmp_planes_base t ON t.slug = p.slug
SET
  p.nombre = t.nombre,
  p.descripcion_comercial = t.descripcion_comercial,
  p.precio_mensual = t.precio_mensual,
  p.descuento_anual_pct = t.descuento_anual_pct,
  p.precio_anual = t.precio_anual,
  p.duracion_dias = t.duracion_dias,
  p.visible = t.visible,
  p.destacado = t.destacado,
  p.recomendado = t.recomendado,
  p.orden_visualizacion = t.orden_visualizacion,
  p.insignia = t.insignia,
  p.resumen_comercial = t.resumen_comercial,
  p.color_visual = t.color_visual,
  p.maximo_usuarios = t.maximo_usuarios,
  p.usuarios_ilimitados = t.usuarios_ilimitados,
  p.observaciones_internas = t.observaciones_internas,
  p.estado = t.estado,
  p.fecha_actualizacion = NOW();

DROP TEMPORARY TABLE IF EXISTS tmp_planes_base;

-- Matriz inicial de módulos por plan (idempotente)
INSERT INTO plan_funcionalidades (plan_id, funcionalidad_id, activo, valor_numerico, es_ilimitado, fecha_actualizacion)
SELECT
  p.id,
  f.id,
  CASE
    WHEN p.slug = 'basico' AND f.codigo_interno IN (
      'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_contactos','modulo_categorias','modulo_configuracion'
    ) THEN 1
    WHEN p.slug = 'profesional' AND f.codigo_interno IN (
      'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_recepciones','modulo_ajustes','modulo_movimientos',
      'modulo_contactos','modulo_vendedores','modulo_categorias','modulo_listas_precios','modulo_seguimiento','modulo_aprobaciones','modulo_documentos',
      'modulo_reportes','modulo_configuracion','modulo_usuarios','modulo_correos_stock','modulo_notificaciones','modulo_historial'
    ) THEN 1
    WHEN p.slug = 'empresa' AND f.codigo_interno IN (
      'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_recepciones','modulo_ajustes','modulo_movimientos',
      'modulo_contactos','modulo_vendedores','modulo_categorias','modulo_listas_precios','modulo_seguimiento','modulo_aprobaciones','modulo_documentos',
      'modulo_reportes','modulo_configuracion','modulo_usuarios','modulo_correos_stock','modulo_ordenes_compra','modulo_notificaciones','modulo_historial'
    ) THEN 1
    ELSE 0
  END AS activo,
  0 AS valor_numerico,
  CASE WHEN p.slug = 'empresa' THEN 1 ELSE 0 END AS es_ilimitado,
  NOW()
FROM planes p
INNER JOIN funcionalidades f ON f.codigo_interno IN (
  'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_recepciones','modulo_ajustes','modulo_movimientos',
  'modulo_contactos','modulo_vendedores','modulo_categorias','modulo_listas_precios','modulo_seguimiento','modulo_aprobaciones','modulo_documentos','modulo_reportes',
  'modulo_configuracion','modulo_usuarios','modulo_correos_stock','modulo_ordenes_compra','modulo_notificaciones','modulo_historial'
)
WHERE p.slug IN ('basico', 'profesional', 'empresa')
ON DUPLICATE KEY UPDATE
  activo = VALUES(activo),
  valor_numerico = VALUES(valor_numerico),
  es_ilimitado = VALUES(es_ilimitado),
  fecha_actualizacion = NOW();

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_configuracion_empresa_logo_imap.sql
-- ==================================================
ALTER TABLE empresas
  ADD COLUMN imap_host VARCHAR(180) NULL AFTER logo,
  ADD COLUMN imap_port SMALLINT UNSIGNED NULL AFTER imap_host,
  ADD COLUMN imap_encryption ENUM('ssl','tls','none') NULL AFTER imap_port,
  ADD COLUMN imap_usuario VARCHAR(180) NULL AFTER imap_encryption,
  ADD COLUMN imap_password VARCHAR(255) NULL AFTER imap_usuario,
  ADD COLUMN imap_remitente_correo VARCHAR(180) NULL AFTER imap_password,
  ADD COLUMN imap_remitente_nombre VARCHAR(180) NULL AFTER imap_remitente_correo;

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_cotizaciones_detalle_descuentos.sql
-- ==================================================
-- Actualización incremental para soportar múltiples líneas con descuentos por línea y descuento global.
-- USE cotiza_saas;  -- removido para instalación genérica

SET @db_name = DATABASE();

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='cotizaciones' AND COLUMN_NAME='descuento_tipo') = 0,
  "ALTER TABLE cotizaciones ADD COLUMN descuento_tipo ENUM('valor','porcentaje') NOT NULL DEFAULT 'valor' AFTER subtotal",
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='cotizaciones' AND COLUMN_NAME='descuento_valor') = 0,
  "ALTER TABLE cotizaciones ADD COLUMN descuento_valor DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER descuento_tipo",
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='items_cotizacion' AND COLUMN_NAME='descuento_tipo') = 0,
  "ALTER TABLE items_cotizacion ADD COLUMN descuento_tipo ENUM('valor','porcentaje') NOT NULL DEFAULT 'valor' AFTER precio_unitario",
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='items_cotizacion' AND COLUMN_NAME='descuento_valor') = 0,
  "ALTER TABLE items_cotizacion ADD COLUMN descuento_valor DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER descuento_tipo",
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='items_cotizacion' AND COLUMN_NAME='descuento_monto') = 0,
  "ALTER TABLE items_cotizacion ADD COLUMN descuento_monto DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER descuento_valor",
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_cotizaciones_firma_cliente.sql
-- ==================================================
ALTER TABLE cotizaciones
  ADD COLUMN firma_cliente MEDIUMTEXT NULL AFTER token_publico,
  ADD COLUMN nombre_firmante_cliente VARCHAR(180) NULL AFTER firma_cliente,
  ADD COLUMN fecha_aprobacion_cliente DATETIME NULL AFTER nombre_firmante_cliente;

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_cotizaciones_lista_precio.sql
-- ==================================================
ALTER TABLE cotizaciones
  ADD COLUMN lista_precio_id BIGINT UNSIGNED NULL AFTER terminos_condiciones;

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_cotizaciones_token_publico.sql
-- ==================================================
ALTER TABLE cotizaciones
  ADD COLUMN token_publico CHAR(64) NULL AFTER terminos_condiciones,
  ADD UNIQUE KEY uq_cot_token_publico (token_publico);

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_documentos_plantillas_correo.sql
-- ==================================================
-- Crea la tabla de plantillas de documentos/correos si no existe.
-- USE cotiza_saas;  -- removido para instalación genérica

CREATE TABLE IF NOT EXISTS documentos_plantillas (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(160) NOT NULL,
  tipo_documento VARCHAR(80) NOT NULL DEFAULT 'cotizacion',
  terminos_defecto TEXT NULL,
  observaciones_defecto TEXT NULL,
  firma VARCHAR(180) NULL,
  logo VARCHAR(255) NULL,
  pie_documento VARCHAR(255) NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_documentos_empresa (empresa_id),
  CONSTRAINT fk_documentos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_funcionalidades_admin_preconfiguradas.sql
-- ==================================================
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

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_inventario_alertas_stock.sql
-- ==================================================
-- Flujo integral de inventario: recepciones, ajustes, movimientos y alertas de stock por empresa.
SET @db_name = DATABASE();

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='stock_actual') = 0,
  'ALTER TABLE productos ADD COLUMN stock_actual DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER stock_aviso',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='stock_critico') = 0,
  'ALTER TABLE productos ADD COLUMN stock_critico DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER stock_minimo',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

UPDATE productos SET stock_critico = stock_aviso WHERE stock_critico = 0 AND stock_aviso > 0;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='ultimo_aviso_stock_bajo') = 0,
  'ALTER TABLE productos ADD COLUMN ultimo_aviso_stock_bajo DATETIME NULL AFTER stock_critico',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='ultimo_aviso_stock_critico') = 0,
  'ALTER TABLE productos ADD COLUMN ultimo_aviso_stock_critico DATETIME NULL AFTER ultimo_aviso_stock_bajo',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS proveedores_inventario (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(180) NOT NULL,
  identificador_fiscal VARCHAR(80) NULL,
  contacto VARCHAR(140) NULL,
  correo VARCHAR(160) NULL,
  telefono VARCHAR(80) NULL,
  direccion VARCHAR(200) NULL,
  ciudad VARCHAR(120) NULL,
  observacion TEXT NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_proveedores_empresa (empresa_id),
  CONSTRAINT fk_proveedores_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);


SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='proveedores_inventario' AND COLUMN_NAME='identificador_fiscal') = 0,
  'ALTER TABLE proveedores_inventario ADD COLUMN identificador_fiscal VARCHAR(80) NULL AFTER nombre',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='proveedores_inventario' AND COLUMN_NAME='contacto') = 0,
  'ALTER TABLE proveedores_inventario ADD COLUMN contacto VARCHAR(140) NULL AFTER identificador_fiscal',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='proveedores_inventario' AND COLUMN_NAME='direccion') = 0,
  'ALTER TABLE proveedores_inventario ADD COLUMN direccion VARCHAR(200) NULL AFTER telefono',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='proveedores_inventario' AND COLUMN_NAME='ciudad') = 0,
  'ALTER TABLE proveedores_inventario ADD COLUMN ciudad VARCHAR(120) NULL AFTER direccion',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='proveedores_inventario' AND COLUMN_NAME='observacion') = 0,
  'ALTER TABLE proveedores_inventario ADD COLUMN observacion TEXT NULL AFTER ciudad',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS recepciones_inventario (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  proveedor_id BIGINT UNSIGNED NULL,
  tipo_documento ENUM('guia_despacho','factura') NOT NULL,
  numero_documento VARCHAR(100) NOT NULL,
  fecha_documento DATE NOT NULL,
  referencia_interna VARCHAR(120) NULL,
  observacion TEXT NULL,
  usuario_id BIGINT UNSIGNED NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_recepciones_empresa (empresa_id, fecha_creacion),
  CONSTRAINT fk_recepciones_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_recepciones_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores_inventario(id),
  CONSTRAINT fk_recepciones_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS recepciones_inventario_detalle (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  recepcion_id BIGINT UNSIGNED NOT NULL,
  producto_id BIGINT UNSIGNED NOT NULL,
  cantidad DECIMAL(12,2) NOT NULL,
  costo_unitario DECIMAL(12,2) NOT NULL DEFAULT 0,
  subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
  INDEX idx_recepcion_detalle (recepcion_id),
  CONSTRAINT fk_recepcion_detalle_recepcion FOREIGN KEY (recepcion_id) REFERENCES recepciones_inventario(id),
  CONSTRAINT fk_recepcion_detalle_producto FOREIGN KEY (producto_id) REFERENCES productos(id)
);

CREATE TABLE IF NOT EXISTS ajustes_inventario (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  producto_id BIGINT UNSIGNED NOT NULL,
  tipo_ajuste ENUM('entrada','salida') NOT NULL,
  cantidad DECIMAL(12,2) NOT NULL,
  motivo VARCHAR(120) NOT NULL,
  observacion TEXT NULL,
  usuario_id BIGINT UNSIGNED NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_ajustes_empresa (empresa_id, fecha_creacion),
  CONSTRAINT fk_ajustes_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_ajustes_producto FOREIGN KEY (producto_id) REFERENCES productos(id),
  CONSTRAINT fk_ajustes_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS movimientos_inventario (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  producto_id BIGINT UNSIGNED NOT NULL,
  tipo_movimiento VARCHAR(80) NOT NULL,
  modulo_origen VARCHAR(80) NOT NULL,
  documento_origen VARCHAR(120) NULL,
  referencia_id BIGINT UNSIGNED NULL,
  entrada DECIMAL(12,2) NOT NULL DEFAULT 0,
  salida DECIMAL(12,2) NOT NULL DEFAULT 0,
  saldo_resultante DECIMAL(12,2) NOT NULL DEFAULT 0,
  observacion TEXT NULL,
  usuario_id BIGINT UNSIGNED NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_mov_empresa (empresa_id, fecha_creacion),
  INDEX idx_mov_producto (producto_id, fecha_creacion),
  CONSTRAINT fk_mov_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_mov_producto FOREIGN KEY (producto_id) REFERENCES productos(id),
  CONSTRAINT fk_mov_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

INSERT INTO configuraciones_empresa (empresa_id, clave, valor, fecha_actualizacion)
SELECT id, 'activar_alerta_stock_bajo', '1', NOW() FROM empresas
ON DUPLICATE KEY UPDATE fecha_actualizacion = NOW();

INSERT INTO configuraciones_empresa (empresa_id, clave, valor, fecha_actualizacion)
SELECT id, 'activar_alerta_stock_critico', '1', NOW() FROM empresas
ON DUPLICATE KEY UPDATE fecha_actualizacion = NOW();

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_listas_precios_reglas.sql
-- ==================================================
SET NAMES utf8mb4;

SET @db_name = DATABASE();

CREATE TABLE IF NOT EXISTS listas_precios (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(150) NOT NULL,
  tipo_lista ENUM('general','cliente','canal','volumen') NOT NULL DEFAULT 'general',
  moneda VARCHAR(12) NOT NULL DEFAULT 'USD',
  vigencia_desde DATE NULL,
  vigencia_hasta DATE NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  reglas_base TEXT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  INDEX idx_listas_empresa (empresa_id),
  CONSTRAINT fk_listas_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='listas_precios' AND COLUMN_NAME='canal_venta') = 0,
  'ALTER TABLE listas_precios ADD COLUMN canal_venta VARCHAR(80) NULL AFTER tipo_lista',
  'SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='listas_precios' AND COLUMN_NAME='segmento_mercado') = 0,
  'ALTER TABLE listas_precios ADD COLUMN segmento_mercado VARCHAR(120) NULL AFTER canal_venta',
  'SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='listas_precios' AND COLUMN_NAME='ajuste_tipo') = 0,
  'ALTER TABLE listas_precios ADD COLUMN ajuste_tipo ENUM("incremento","descuento") NOT NULL DEFAULT "incremento" AFTER segmento_mercado',
  'SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='listas_precios' AND COLUMN_NAME='ajuste_porcentaje') = 0,
  'ALTER TABLE listas_precios ADD COLUMN ajuste_porcentaje DECIMAL(8,4) NOT NULL DEFAULT 0 AFTER ajuste_tipo',
  'SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS clientes_listas_precios (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  cliente_id BIGINT UNSIGNED NOT NULL,
  lista_precio_id BIGINT UNSIGNED NOT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  UNIQUE KEY uniq_cliente_lista (empresa_id, cliente_id, lista_precio_id),
  INDEX idx_clientes_listas_lista (lista_precio_id),
  CONSTRAINT fk_clientes_listas_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_clientes_listas_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  CONSTRAINT fk_clientes_listas_lista FOREIGN KEY (lista_precio_id) REFERENCES listas_precios(id)
);

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='clientes_listas_precios' AND INDEX_NAME='uniq_cliente_lista' AND SEQ_IN_INDEX=3) = 0,
  'ALTER TABLE clientes_listas_precios DROP INDEX uniq_cliente_lista, ADD UNIQUE KEY uniq_cliente_lista (empresa_id, cliente_id, lista_precio_id)',
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS listas_precios_reglas (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  lista_precio_id BIGINT UNSIGNED NOT NULL,
  ambito ENUM('global','categoria','producto') NOT NULL DEFAULT 'global',
  categoria_id BIGINT UNSIGNED NULL,
  producto_id BIGINT UNSIGNED NULL,
  tipo_ajuste ENUM('incremento','descuento') NOT NULL DEFAULT 'incremento',
  porcentaje DECIMAL(8,4) NOT NULL DEFAULT 0,
  prioridad INT NOT NULL DEFAULT 100,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  observaciones VARCHAR(255) NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  INDEX idx_lpr_empresa_lista (empresa_id, lista_precio_id),
  INDEX idx_lpr_producto (producto_id),
  INDEX idx_lpr_categoria (categoria_id),
  CONSTRAINT fk_lpr_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_lpr_lista FOREIGN KEY (lista_precio_id) REFERENCES listas_precios(id),
  CONSTRAINT fk_lpr_producto FOREIGN KEY (producto_id) REFERENCES productos(id),
  CONSTRAINT fk_lpr_categoria FOREIGN KEY (categoria_id) REFERENCES categorias_productos(id)
);

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_mejora_panel_comercial.sql
-- ==================================================
-- Actualización incremental del panel comercial SaaS.
-- Recomendado: ejecutar primero un respaldo completo de la base de datos.

-- USE cotiza_saas;  -- removido para instalación genérica

-- =====================================================
-- 1) Ajustes en tablas existentes para compatibilidad.
-- =====================================================

SET @db_name = DATABASE();

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='clientes' AND COLUMN_NAME='razon_social') = 0,
  'ALTER TABLE clientes ADD COLUMN razon_social VARCHAR(180) NULL AFTER nombre',
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='clientes' AND COLUMN_NAME='nombre_comercial') = 0,
  'ALTER TABLE clientes ADD COLUMN nombre_comercial VARCHAR(180) NULL AFTER razon_social','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='clientes' AND COLUMN_NAME='identificador_fiscal') = 0,
  'ALTER TABLE clientes ADD COLUMN identificador_fiscal VARCHAR(80) NULL AFTER nombre_comercial','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='clientes' AND COLUMN_NAME='giro') = 0,
  'ALTER TABLE clientes ADD COLUMN giro VARCHAR(180) NULL AFTER identificador_fiscal','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='clientes' AND COLUMN_NAME='ciudad') = 0,
  'ALTER TABLE clientes ADD COLUMN ciudad VARCHAR(120) NULL AFTER direccion','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='clientes' AND COLUMN_NAME='vendedor_id') = 0,
  'ALTER TABLE clientes ADD COLUMN vendedor_id BIGINT UNSIGNED NULL AFTER ciudad','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='tipo') = 0,
  "ALTER TABLE productos ADD COLUMN tipo ENUM('producto','servicio') NOT NULL DEFAULT 'producto' AFTER categoria_id",'SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='costo') = 0,
  'ALTER TABLE productos ADD COLUMN costo DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER precio','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='descuento_maximo') = 0,
  'ALTER TABLE productos ADD COLUMN descuento_maximo DECIMAL(8,2) NOT NULL DEFAULT 0 AFTER impuesto','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='categorias_productos' AND COLUMN_NAME='descripcion') = 0,
  'ALTER TABLE categorias_productos ADD COLUMN descripcion VARCHAR(255) NULL AFTER nombre','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='contactos_cliente' AND COLUMN_NAME='empresa_id') = 0,
  'ALTER TABLE contactos_cliente ADD COLUMN empresa_id BIGINT UNSIGNED NULL AFTER id','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='contactos_cliente' AND COLUMN_NAME='celular') = 0,
  'ALTER TABLE contactos_cliente ADD COLUMN celular VARCHAR(80) NULL AFTER telefono','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='contactos_cliente' AND COLUMN_NAME='es_principal') = 0,
  'ALTER TABLE contactos_cliente ADD COLUMN es_principal TINYINT(1) NOT NULL DEFAULT 0 AFTER celular','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='contactos_cliente' AND COLUMN_NAME='observaciones') = 0,
  'ALTER TABLE contactos_cliente ADD COLUMN observaciones TEXT NULL AFTER es_principal','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

UPDATE contactos_cliente cc
INNER JOIN clientes c ON c.id = cc.cliente_id
SET cc.empresa_id = c.empresa_id
WHERE cc.empresa_id IS NULL;

-- =====================================================
-- 2) Nuevas tablas comerciales.
-- =====================================================

CREATE TABLE IF NOT EXISTS vendedores (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  usuario_id BIGINT UNSIGNED NULL,
  nombre VARCHAR(160) NOT NULL,
  correo VARCHAR(160) NULL,
  telefono VARCHAR(80) NULL,
  comision DECIMAL(8,2) NOT NULL DEFAULT 0,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_vendedores_empresa (empresa_id),
  INDEX idx_vendedores_usuario (usuario_id),
  CONSTRAINT fk_vendedores_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  CONSTRAINT fk_vendedores_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='vendedores' AND COLUMN_NAME='usuario_id') = 0,
  'ALTER TABLE vendedores ADD COLUMN usuario_id BIGINT UNSIGNED NULL AFTER empresa_id','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='vendedores' AND INDEX_NAME='idx_vendedores_usuario') = 0,
  'ALTER TABLE vendedores ADD INDEX idx_vendedores_usuario (usuario_id)','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;
SET @sql = IF((SELECT COUNT(*) FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='vendedores' AND CONSTRAINT_NAME='fk_vendedores_usuario') = 0,
  'ALTER TABLE vendedores ADD CONSTRAINT fk_vendedores_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)','SELECT 1'); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS listas_precios (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(160) NOT NULL,
  vigencia_desde DATE NULL,
  vigencia_hasta DATE NULL,
  tipo_lista VARCHAR(120) NOT NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  reglas_base TEXT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_listas_empresa (empresa_id),
  CONSTRAINT fk_listas_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

CREATE TABLE IF NOT EXISTS seguimientos_comerciales (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  cotizacion_id BIGINT UNSIGNED NULL,
  cliente_id BIGINT UNSIGNED NULL,
  responsable VARCHAR(160) NULL,
  proxima_accion VARCHAR(220) NULL,
  fecha_seguimiento DATE NULL,
  comentarios TEXT NULL,
  estado_comercial VARCHAR(80) NOT NULL DEFAULT 'abierto',
  probabilidad_cierre TINYINT UNSIGNED NOT NULL DEFAULT 0,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_seguimiento_empresa (empresa_id),
  CONSTRAINT fk_seguimiento_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_seguimiento_cotizacion FOREIGN KEY (cotizacion_id) REFERENCES cotizaciones(id),
  CONSTRAINT fk_seguimiento_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE IF NOT EXISTS aprobaciones_cotizacion (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  cotizacion_id BIGINT UNSIGNED NULL,
  monto DECIMAL(12,2) NOT NULL DEFAULT 0,
  motivo VARCHAR(255) NULL,
  solicitante VARCHAR(160) NULL,
  aprobador VARCHAR(160) NULL,
  estado ENUM('pendiente','aprobada','rechazada') NOT NULL DEFAULT 'pendiente',
  fecha_aprobacion DATE NULL,
  observaciones TEXT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_aprobaciones_empresa (empresa_id),
  CONSTRAINT fk_aprobacion_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_aprobacion_cotizacion FOREIGN KEY (cotizacion_id) REFERENCES cotizaciones(id)
);

CREATE TABLE IF NOT EXISTS documentos_plantillas (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(160) NOT NULL,
  tipo_documento VARCHAR(80) NOT NULL DEFAULT 'cotizacion',
  terminos_defecto TEXT NULL,
  observaciones_defecto TEXT NULL,
  firma VARCHAR(180) NULL,
  logo VARCHAR(255) NULL,
  pie_documento VARCHAR(255) NULL,
  estado ENUM('activo','inactivo') NOT NULL DEFAULT 'activo',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_documentos_empresa (empresa_id),
  CONSTRAINT fk_documentos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

CREATE TABLE IF NOT EXISTS notificaciones_empresa (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  tipo VARCHAR(80) NOT NULL DEFAULT 'sistema',
  titulo VARCHAR(180) NOT NULL,
  mensaje TEXT NULL,
  estado VARCHAR(60) NOT NULL DEFAULT 'pendiente',
  fecha_evento DATE NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_notificaciones_empresa (empresa_id),
  CONSTRAINT fk_notificaciones_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

CREATE TABLE IF NOT EXISTS historial_actividad (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  usuario_nombre VARCHAR(160) NOT NULL,
  modulo VARCHAR(120) NOT NULL,
  accion VARCHAR(120) NOT NULL,
  detalle TEXT NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_historial_empresa (empresa_id),
  CONSTRAINT fk_historial_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

-- Relación opcional entre cliente y vendedor.
SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='clientes' AND CONSTRAINT_NAME='fk_clientes_vendedor') = 0,
  'ALTER TABLE clientes ADD CONSTRAINT fk_clientes_vendedor FOREIGN KEY (vendedor_id) REFERENCES vendedores(id)',
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='contactos_cliente' AND INDEX_NAME='idx_contactos_empresa') = 0,
  'CREATE INDEX idx_contactos_empresa ON contactos_cliente (empresa_id)',
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- =====================================================
-- 3) Catálogos base sugeridos (si no existen datos).
-- =====================================================
INSERT INTO notificaciones_empresa (empresa_id, tipo, titulo, mensaje, estado, fecha_creacion)
SELECT e.id, 'sistema', 'Panel comercial actualizado', 'Se aplicó la mejora comercial con nuevos módulos.', 'pendiente', NOW()
FROM empresas e
WHERE NOT EXISTS (
  SELECT 1 FROM notificaciones_empresa n WHERE n.empresa_id = e.id AND n.titulo = 'Panel comercial actualizado'
);

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_ordenes_compra_inventario.sql
-- ==================================================
-- Módulo de órdenes de compra integrado al flujo de inventario.
SET @db_name = DATABASE();

CREATE TABLE IF NOT EXISTS ordenes_compra (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  proveedor_id BIGINT UNSIGNED NOT NULL,
  numero VARCHAR(80) NOT NULL,
  fecha_emision DATE NOT NULL,
  fecha_entrega_estimada DATE NULL,
  estado ENUM('borrador','emitida','parcial','recibida','anulada') NOT NULL DEFAULT 'emitida',
  referencia VARCHAR(120) NULL,
  observacion TEXT NULL,
  usuario_id BIGINT UNSIGNED NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  INDEX idx_orden_compra_empresa (empresa_id, fecha_creacion),
  CONSTRAINT fk_orden_compra_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_orden_compra_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores_inventario(id),
  CONSTRAINT fk_orden_compra_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS ordenes_compra_detalle (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  orden_compra_id BIGINT UNSIGNED NOT NULL,
  producto_id BIGINT UNSIGNED NOT NULL,
  cantidad DECIMAL(12,2) NOT NULL,
  costo_unitario DECIMAL(12,2) NOT NULL DEFAULT 0,
  subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_orden_compra_detalle (orden_compra_id),
  CONSTRAINT fk_orden_detalle_orden FOREIGN KEY (orden_compra_id) REFERENCES ordenes_compra(id),
  CONSTRAINT fk_orden_detalle_producto FOREIGN KEY (producto_id) REFERENCES productos(id)
);

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='recepciones_inventario' AND COLUMN_NAME='orden_compra_id') = 0,
  'ALTER TABLE recepciones_inventario ADD COLUMN orden_compra_id BIGINT UNSIGNED NULL AFTER proveedor_id',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @fk_exists = (SELECT COUNT(*) FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='recepciones_inventario' AND CONSTRAINT_NAME='fk_recepciones_orden_compra');
SET @sql = IF(@fk_exists = 0,
  'ALTER TABLE recepciones_inventario ADD CONSTRAINT fk_recepciones_orden_compra FOREIGN KEY (orden_compra_id) REFERENCES ordenes_compra(id)',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_panel_admin_saas.sql
-- ==================================================
-- USE cotiza_saas;  -- removido para instalación genérica

-- Ajustes de estructura para panel administrador SaaS
ALTER TABLE planes
  ADD COLUMN IF NOT EXISTS descuento_anual_pct DECIMAL(5,2) NOT NULL DEFAULT 0 AFTER precio_mensual,
  ADD COLUMN IF NOT EXISTS recomendado TINYINT(1) NOT NULL DEFAULT 0 AFTER destacado,
  ADD COLUMN IF NOT EXISTS maximo_usuarios INT NOT NULL DEFAULT 1 AFTER color_visual,
  ADD COLUMN IF NOT EXISTS usuarios_ilimitados TINYINT(1) NOT NULL DEFAULT 0 AFTER maximo_usuarios,
  ADD COLUMN IF NOT EXISTS observaciones_internas TEXT NULL AFTER usuarios_ilimitados;

ALTER TABLE empresas
  ADD COLUMN IF NOT EXISTS observaciones_internas TEXT NULL AFTER plan_id;

ALTER TABLE usuarios
  ADD COLUMN IF NOT EXISTS password_actualizado_en DATETIME NULL AFTER ultimo_acceso;

ALTER TABLE pagos
  ADD COLUMN IF NOT EXISTS frecuencia ENUM('mensual','anual') NULL AFTER metodo;

CREATE TABLE IF NOT EXISTS logs_administracion (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  admin_usuario_id BIGINT UNSIGNED NULL,
  empresa_id BIGINT UNSIGNED NULL,
  usuario_objetivo_id BIGINT UNSIGNED NULL,
  modulo VARCHAR(120) NOT NULL,
  accion VARCHAR(120) NOT NULL,
  detalle TEXT NULL,
  ip VARCHAR(64) NULL,
  user_agent VARCHAR(255) NULL,
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_logs_admin_usuario (admin_usuario_id),
  INDEX idx_logs_empresa (empresa_id),
  INDEX idx_logs_usuario_objetivo (usuario_objetivo_id),
  CONSTRAINT fk_logs_admin_usuario FOREIGN KEY (admin_usuario_id) REFERENCES usuarios(id),
  CONSTRAINT fk_logs_admin_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_logs_admin_usuario_obj FOREIGN KEY (usuario_objetivo_id) REFERENCES usuarios(id)
);

-- Funcionalidades SaaS orientadas a planes (idempotente por código interno)
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo clientes', 'modulo_clientes', 'Habilita gestión de clientes', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_clientes');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo productos', 'modulo_productos', 'Habilita gestión de productos', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_productos');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo cotizaciones', 'modulo_cotizaciones', 'Habilita cotizaciones', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_cotizaciones');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo POS', 'modulo_pos', 'Habilita punto de venta', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_pos');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo inventario', 'modulo_inventario', 'Habilita inventario', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_inventario');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo recepciones', 'modulo_recepciones', 'Recepciones de inventario', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_recepciones');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo ajustes', 'modulo_ajustes', 'Ajustes de inventario', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_ajustes');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo movimientos', 'modulo_movimientos', 'Movimientos de inventario', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_movimientos');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo vendedores', 'modulo_vendedores', 'Gestión de vendedores', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_vendedores');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo reportes', 'modulo_reportes', 'Acceso a reportes', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_reportes');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo listas de precios', 'modulo_listas_precios', 'Listas de precios', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_listas_precios');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo órdenes de compra', 'modulo_ordenes_compra', 'Órdenes de compra', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_ordenes_compra');
INSERT INTO funcionalidades (nombre, codigo_interno, descripcion, tipo_valor, estado)
SELECT 'Módulo usuarios', 'modulo_usuarios', 'Administración de usuarios', 'booleano', 'activo'
WHERE NOT EXISTS (SELECT 1 FROM funcionalidades WHERE codigo_interno = 'modulo_usuarios');

-- Planes iniciales requeridos
INSERT INTO planes (nombre, slug, descripcion_comercial, precio_mensual, descuento_anual_pct, precio_anual, duracion_dias, visible, destacado, recomendado, orden_visualizacion, insignia, resumen_comercial, color_visual, maximo_usuarios, usuarios_ilimitados, observaciones_internas, estado)
VALUES
('Básico', 'basico', 'Plan funcional y limitado para iniciar.', 15000, 10, 162000, 30, 1, 0, 0, 1, 'Inicial', 'Incluye cotizaciones, clientes, productos y POS básico.', '#3b82f6', 2, 0, 'Límite bajo para incentivar upgrade.', 'activo'),
('Profesional', 'profesional', 'Plan recomendado para operación comercial diaria.', 26000, 10, 280800, 30, 1, 1, 1, 2, 'Más elegido', 'Incluye inventario completo y reportes operativos.', '#0ea5a4', 8, 0, 'Balance entre costo y capacidad.', 'activo'),
('Empresa', 'empresa', 'Plan completo para operación avanzada.', 55000, 15, 561000, 30, 1, 1, 0, 3, 'Escalable', 'Todas las funciones del sistema con alta capacidad.', '#7c3aed', 0, 1, 'Usuarios ilimitados con expansión corporativa.', 'activo')
ON DUPLICATE KEY UPDATE
  descripcion_comercial = VALUES(descripcion_comercial),
  precio_mensual = VALUES(precio_mensual),
  descuento_anual_pct = VALUES(descuento_anual_pct),
  precio_anual = VALUES(precio_anual),
  destacado = VALUES(destacado),
  recomendado = VALUES(recomendado),
  orden_visualizacion = VALUES(orden_visualizacion),
  insignia = VALUES(insignia),
  resumen_comercial = VALUES(resumen_comercial),
  color_visual = VALUES(color_visual),
  maximo_usuarios = VALUES(maximo_usuarios),
  usuarios_ilimitados = VALUES(usuarios_ilimitados),
  observaciones_internas = VALUES(observaciones_internas),
  estado = VALUES(estado),
  fecha_actualizacion = NOW();

-- Vinculación mínima de funcionalidades a planes por código
INSERT INTO plan_funcionalidades (plan_id, funcionalidad_id, activo, valor_numerico, es_ilimitado, fecha_actualizacion)
SELECT p.id, f.id,
  CASE
    WHEN p.slug = 'basico' AND f.codigo_interno IN ('modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario') THEN 1
    WHEN p.slug = 'profesional' AND f.codigo_interno IN ('modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_recepciones','modulo_ajustes','modulo_vendedores','modulo_reportes','modulo_listas_precios') THEN 1
    WHEN p.slug = 'empresa' THEN 1
    ELSE 0
  END,
  0,
  CASE WHEN p.slug = 'empresa' THEN 1 ELSE 0 END,
  NOW()
FROM planes p
INNER JOIN funcionalidades f ON f.codigo_interno IN (
  'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_recepciones','modulo_ajustes','modulo_movimientos','modulo_vendedores','modulo_reportes','modulo_listas_precios','modulo_ordenes_compra','modulo_usuarios'
)
WHERE p.slug IN ('basico','profesional','empresa')
ON DUPLICATE KEY UPDATE
  activo = VALUES(activo),
  es_ilimitado = VALUES(es_ilimitado),
  fecha_actualizacion = NOW();

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_planes_funcionalidades_completas.sql
-- ==================================================
START TRANSACTION;

-- Crea relaciones faltantes plan <-> funcionalidad para todos los planes y funcionalidades existentes.
INSERT INTO plan_funcionalidades (plan_id, funcionalidad_id, activo, valor_numerico, es_ilimitado, fecha_actualizacion)
SELECT
  p.id,
  f.id,
  CASE
    WHEN p.slug = 'basico' AND f.codigo_interno IN (
      'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_contactos','modulo_categorias','modulo_configuracion'
    ) THEN 1
    WHEN p.slug = 'profesional' AND f.codigo_interno IN (
      'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_recepciones','modulo_ajustes','modulo_movimientos',
      'modulo_contactos','modulo_vendedores','modulo_categorias','modulo_listas_precios','modulo_seguimiento','modulo_aprobaciones','modulo_documentos',
      'modulo_reportes','modulo_configuracion','modulo_usuarios','modulo_correos_stock','modulo_notificaciones','modulo_historial'
    ) THEN 1
    WHEN p.slug = 'empresa' AND f.codigo_interno IN (
      'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_recepciones','modulo_ajustes','modulo_movimientos',
      'modulo_contactos','modulo_vendedores','modulo_categorias','modulo_listas_precios','modulo_seguimiento','modulo_aprobaciones','modulo_documentos',
      'modulo_reportes','modulo_configuracion','modulo_usuarios','modulo_correos_stock','modulo_ordenes_compra','modulo_notificaciones','modulo_historial'
    ) THEN 1
    WHEN p.slug = 'full' THEN 1
    ELSE 0
  END AS activo,
  0 AS valor_numerico,
  CASE WHEN p.slug IN ('empresa', 'full') THEN 1 ELSE 0 END AS es_ilimitado,
  NOW()
FROM planes p
INNER JOIN funcionalidades f ON f.estado = 'activo'
LEFT JOIN plan_funcionalidades pf
  ON pf.plan_id = p.id
 AND pf.funcionalidad_id = f.id
WHERE pf.id IS NULL;

-- Reaplica matriz base de activación para los planes estándar.
UPDATE plan_funcionalidades pf
INNER JOIN planes p ON p.id = pf.plan_id
INNER JOIN funcionalidades f ON f.id = pf.funcionalidad_id
SET
  pf.activo = CASE
    WHEN p.slug = 'basico' AND f.codigo_interno IN (
      'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_contactos','modulo_categorias','modulo_configuracion'
    ) THEN 1
    WHEN p.slug = 'profesional' AND f.codigo_interno IN (
      'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_recepciones','modulo_ajustes','modulo_movimientos',
      'modulo_contactos','modulo_vendedores','modulo_categorias','modulo_listas_precios','modulo_seguimiento','modulo_aprobaciones','modulo_documentos',
      'modulo_reportes','modulo_configuracion','modulo_usuarios','modulo_correos_stock','modulo_notificaciones','modulo_historial'
    ) THEN 1
    WHEN p.slug = 'empresa' AND f.codigo_interno IN (
      'modulo_clientes','modulo_productos','modulo_cotizaciones','modulo_pos','modulo_inventario','modulo_recepciones','modulo_ajustes','modulo_movimientos',
      'modulo_contactos','modulo_vendedores','modulo_categorias','modulo_listas_precios','modulo_seguimiento','modulo_aprobaciones','modulo_documentos',
      'modulo_reportes','modulo_configuracion','modulo_usuarios','modulo_correos_stock','modulo_ordenes_compra','modulo_notificaciones','modulo_historial'
    ) THEN 1
    WHEN p.slug = 'full' THEN 1
    ELSE 0
  END,
  pf.valor_numerico = 0,
  pf.es_ilimitado = CASE WHEN p.slug IN ('empresa', 'full') THEN 1 ELSE 0 END,
  pf.fecha_actualizacion = NOW()
WHERE p.slug IN ('basico', 'profesional', 'empresa', 'full');

COMMIT;

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_pos_comercial.sql
-- ==================================================
-- Módulo POS comercial: cajas, ventas, pagos, cierres y stock operativo.
SET @db_name = DATABASE();

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='stock_actual') = 0,
  'ALTER TABLE productos ADD COLUMN stock_actual DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER stock_aviso',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

CREATE TABLE IF NOT EXISTS cajas_pos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  nombre VARCHAR(120) NOT NULL,
  codigo VARCHAR(60) NOT NULL,
  estado ENUM('activa','inactiva') NOT NULL DEFAULT 'activa',
  fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion DATETIME NULL,
  UNIQUE KEY uq_caja_empresa_codigo (empresa_id, codigo),
  INDEX idx_cajas_pos_empresa (empresa_id),
  CONSTRAINT fk_cajas_pos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

CREATE TABLE IF NOT EXISTS aperturas_caja_pos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  caja_id BIGINT UNSIGNED NOT NULL,
  usuario_id BIGINT UNSIGNED NOT NULL,
  monto_inicial DECIMAL(12,2) NOT NULL DEFAULT 0,
  observacion VARCHAR(255) NULL,
  fecha_apertura DATETIME NOT NULL,
  estado ENUM('abierta','cerrada') NOT NULL DEFAULT 'abierta',
  INDEX idx_aperturas_empresa_estado (empresa_id, estado),
  CONSTRAINT fk_aperturas_caja_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_aperturas_caja_pos FOREIGN KEY (caja_id) REFERENCES cajas_pos(id),
  CONSTRAINT fk_aperturas_usuario_pos FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS cierres_caja_pos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  apertura_caja_id BIGINT UNSIGNED NOT NULL,
  usuario_id BIGINT UNSIGNED NOT NULL,
  monto_esperado DECIMAL(12,2) NOT NULL,
  monto_contado DECIMAL(12,2) NOT NULL,
  diferencia DECIMAL(12,2) NOT NULL,
  observacion VARCHAR(255) NULL,
  fecha_cierre DATETIME NOT NULL,
  monto_efectivo DECIMAL(12,2) NOT NULL DEFAULT 0,
  monto_transferencia DECIMAL(12,2) NOT NULL DEFAULT 0,
  monto_tarjeta DECIMAL(12,2) NOT NULL DEFAULT 0,
  monto_inicial DECIMAL(12,2) NOT NULL DEFAULT 0,
  INDEX idx_cierres_empresa (empresa_id),
  CONSTRAINT fk_cierres_empresa_pos FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_cierres_apertura_pos FOREIGN KEY (apertura_caja_id) REFERENCES aperturas_caja_pos(id),
  CONSTRAINT fk_cierres_usuario_pos FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS ventas_pos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  caja_id BIGINT UNSIGNED NOT NULL,
  apertura_caja_id BIGINT UNSIGNED NOT NULL,
  cliente_id BIGINT UNSIGNED NULL,
  usuario_id BIGINT UNSIGNED NOT NULL,
  tipo_venta ENUM('registrada','rapida') NOT NULL DEFAULT 'rapida',
  subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
  descuento DECIMAL(12,2) NOT NULL DEFAULT 0,
  impuesto DECIMAL(12,2) NOT NULL DEFAULT 0,
  total DECIMAL(12,2) NOT NULL DEFAULT 0,
  estado ENUM('pagada','anulada') NOT NULL DEFAULT 'pagada',
  numero_venta VARCHAR(80) NOT NULL,
  fecha_venta DATETIME NOT NULL,
  observaciones TEXT NULL,
  monto_recibido DECIMAL(12,2) NOT NULL DEFAULT 0,
  vuelto DECIMAL(12,2) NOT NULL DEFAULT 0,
  INDEX idx_ventas_pos_empresa_fecha (empresa_id, fecha_venta),
  UNIQUE KEY uq_ventas_pos_numero_empresa (empresa_id, numero_venta),
  CONSTRAINT fk_ventas_pos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_ventas_pos_caja FOREIGN KEY (caja_id) REFERENCES cajas_pos(id),
  CONSTRAINT fk_ventas_pos_apertura FOREIGN KEY (apertura_caja_id) REFERENCES aperturas_caja_pos(id),
  CONSTRAINT fk_ventas_pos_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id),
  CONSTRAINT fk_ventas_pos_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS items_venta_pos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  venta_pos_id BIGINT UNSIGNED NOT NULL,
  producto_id BIGINT UNSIGNED NOT NULL,
  codigo_producto VARCHAR(80) NULL,
  nombre_producto VARCHAR(180) NOT NULL,
  cantidad DECIMAL(12,2) NOT NULL DEFAULT 0,
  precio_unitario DECIMAL(12,2) NOT NULL DEFAULT 0,
  descuento DECIMAL(12,2) NOT NULL DEFAULT 0,
  impuesto DECIMAL(12,2) NOT NULL DEFAULT 0,
  subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
  total DECIMAL(12,2) NOT NULL DEFAULT 0,
  INDEX idx_items_venta_pos_venta (venta_pos_id),
  CONSTRAINT fk_items_venta_pos_venta FOREIGN KEY (venta_pos_id) REFERENCES ventas_pos(id),
  CONSTRAINT fk_items_venta_pos_producto FOREIGN KEY (producto_id) REFERENCES productos(id)
);

CREATE TABLE IF NOT EXISTS pagos_venta_pos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  venta_pos_id BIGINT UNSIGNED NOT NULL,
  metodo_pago ENUM('efectivo','transferencia','tarjeta') NOT NULL,
  monto DECIMAL(12,2) NOT NULL DEFAULT 0,
  referencia VARCHAR(120) NULL,
  fecha_pago DATETIME NOT NULL,
  INDEX idx_pagos_venta_pos_venta (venta_pos_id),
  CONSTRAINT fk_pagos_venta_pos_venta FOREIGN KEY (venta_pos_id) REFERENCES ventas_pos(id)
);

CREATE TABLE IF NOT EXISTS movimientos_caja_pos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  caja_id BIGINT UNSIGNED NOT NULL,
  apertura_caja_id BIGINT UNSIGNED NOT NULL,
  tipo_movimiento ENUM('ingreso_venta','egreso_manual','ingreso_manual') NOT NULL,
  concepto VARCHAR(255) NOT NULL,
  monto DECIMAL(12,2) NOT NULL,
  usuario_id BIGINT UNSIGNED NOT NULL,
  fecha_movimiento DATETIME NOT NULL,
  venta_pos_id BIGINT UNSIGNED NULL,
  INDEX idx_movimientos_caja_pos (empresa_id, fecha_movimiento),
  CONSTRAINT fk_mov_caja_empresa_pos FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_mov_caja_pos FOREIGN KEY (caja_id) REFERENCES cajas_pos(id),
  CONSTRAINT fk_mov_apertura_pos FOREIGN KEY (apertura_caja_id) REFERENCES aperturas_caja_pos(id),
  CONSTRAINT fk_mov_usuario_pos FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
  CONSTRAINT fk_mov_venta_pos FOREIGN KEY (venta_pos_id) REFERENCES ventas_pos(id)
);

CREATE TABLE IF NOT EXISTS movimientos_inventario_pos (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  empresa_id BIGINT UNSIGNED NOT NULL,
  venta_pos_id BIGINT UNSIGNED NOT NULL,
  producto_id BIGINT UNSIGNED NOT NULL,
  tipo_movimiento ENUM('salida_venta','ajuste_manual') NOT NULL DEFAULT 'salida_venta',
  cantidad DECIMAL(12,2) NOT NULL,
  stock_anterior DECIMAL(12,2) NOT NULL,
  stock_actual DECIMAL(12,2) NOT NULL,
  usuario_id BIGINT UNSIGNED NOT NULL,
  fecha_movimiento DATETIME NOT NULL,
  INDEX idx_mov_inv_pos_empresa (empresa_id, fecha_movimiento),
  CONSTRAINT fk_mov_inv_pos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
  CONSTRAINT fk_mov_inv_pos_venta FOREIGN KEY (venta_pos_id) REFERENCES ventas_pos(id),
  CONSTRAINT fk_mov_inv_pos_producto FOREIGN KEY (producto_id) REFERENCES productos(id),
  CONSTRAINT fk_mov_inv_pos_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS configuracion_pos (
  empresa_id BIGINT UNSIGNED PRIMARY KEY,
  permitir_venta_sin_stock TINYINT(1) NOT NULL DEFAULT 0,
  impuesto_por_defecto DECIMAL(8,2) NOT NULL DEFAULT 0,
  usar_decimales TINYINT(1) NOT NULL DEFAULT 1,
  cantidad_decimales TINYINT UNSIGNED NOT NULL DEFAULT 2,
  fecha_actualizacion DATETIME NULL,
  CONSTRAINT fk_configuracion_pos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);


SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='configuracion_pos' AND COLUMN_NAME='usar_decimales') = 0,
  'ALTER TABLE configuracion_pos ADD COLUMN usar_decimales TINYINT(1) NOT NULL DEFAULT 1 AFTER impuesto_por_defecto',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='configuracion_pos' AND COLUMN_NAME='cantidad_decimales') = 0,
  'ALTER TABLE configuracion_pos ADD COLUMN cantidad_decimales TINYINT UNSIGNED NOT NULL DEFAULT 2 AFTER usar_decimales',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_pos_moneda.sql
-- ==================================================
-- Agrega configuración de moneda al POS por empresa.
SET @db_name = DATABASE();

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='configuracion_pos' AND COLUMN_NAME='moneda') = 0,
  'ALTER TABLE configuracion_pos ADD COLUMN moneda ENUM("CLP","USD","EU") NOT NULL DEFAULT "CLP" AFTER cantidad_decimales',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

UPDATE configuracion_pos SET moneda = 'CLP' WHERE moneda IS NULL OR moneda = '';

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_productos_campos_inventario.sql
-- ==================================================
-- Agrega campos operativos para productos: SKU, código de barras y alertas de stock.

SET @db_name = DATABASE();

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='sku') = 0,
  'ALTER TABLE productos ADD COLUMN sku VARCHAR(80) NULL AFTER codigo',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='codigo_barras') = 0,
  'ALTER TABLE productos ADD COLUMN codigo_barras VARCHAR(120) NULL AFTER sku',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='stock_minimo') = 0,
  'ALTER TABLE productos ADD COLUMN stock_minimo DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER descuento_maximo',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='productos' AND COLUMN_NAME='stock_aviso') = 0,
  'ALTER TABLE productos ADD COLUMN stock_aviso DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER stock_minimo',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_roles_empresa.sql
-- ==================================================
-- USE cotiza_saas;  -- removido para instalación genérica

INSERT INTO roles (nombre, codigo) VALUES
('Administrador', 'administrador_empresa'),
('Vendedor', 'vendedor'),
('Administrativo', 'administrativo'),
('Contabilidad', 'contabilidad'),
('Supervisor Comercial', 'supervisor_comercial'),
('Operaciones', 'operaciones'),
('Usuario de Empresa', 'usuario_empresa')
ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_servicio_tecnico.sql
-- ==================================================
-- Módulo Servicio Técnico (Chile)
-- Ejecutar sobre MySQL 8+

CREATE TABLE IF NOT EXISTS st_clientes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    nombres VARCHAR(120) NOT NULL,
    apellidos VARCHAR(120) NOT NULL,
    rut VARCHAR(20) NULL,
    tipo_documento VARCHAR(30) NULL DEFAULT 'RUT',
    numero_documento VARCHAR(30) NULL,
    direccion VARCHAR(180) NULL,
    comuna VARCHAR(80) NULL,
    ciudad VARCHAR(80) NULL,
    telefono VARCHAR(30) NULL,
    email VARCHAR(120) NULL,
    observaciones TEXT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_eliminacion TIMESTAMP NULL,
    INDEX idx_st_clientes_empresa_estado (empresa_id, estado),
    INDEX idx_st_clientes_rut (rut),
    CONSTRAINT fk_st_clientes_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

CREATE TABLE IF NOT EXISTS st_equipos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    cliente_id BIGINT UNSIGNED NOT NULL,
    tipo_equipo VARCHAR(30) NOT NULL,
    nombre_equipo VARCHAR(120) NOT NULL,
    marca VARCHAR(80) NULL,
    modelo VARCHAR(80) NULL,
    serie VARCHAR(80) NULL,
    imei VARCHAR(40) NULL,
    color VARCHAR(40) NULL,
    accesorios TEXT NULL,
    clave VARCHAR(120) NULL,
    estado_fisico TEXT NULL,
    observaciones TEXT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_eliminacion TIMESTAMP NULL,
    INDEX idx_st_equipos_empresa_cliente (empresa_id, cliente_id),
    INDEX idx_st_equipos_serie (serie),
    INDEX idx_st_equipos_imei (imei),
    CONSTRAINT fk_st_equipos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
    CONSTRAINT fk_st_equipos_cliente FOREIGN KEY (cliente_id) REFERENCES st_clientes(id)
);

CREATE TABLE IF NOT EXISTS st_ordenes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    numero_orden VARCHAR(20) NOT NULL,
    codigo_seguimiento VARCHAR(20) NOT NULL,
    cliente_id BIGINT UNSIGNED NOT NULL,
    equipo_id BIGINT UNSIGNED NULL,
    tecnico_id BIGINT UNSIGNED NULL,
    tipo_equipo VARCHAR(30) NULL,
    marca VARCHAR(80) NULL,
    modelo VARCHAR(80) NULL,
    serie VARCHAR(80) NULL,
    imei VARCHAR(40) NULL,
    accesorios TEXT NULL,
    clave VARCHAR(120) NULL,
    problema_principal VARCHAR(200) NOT NULL,
    detalle_problema TEXT NULL,
    sintomas TEXT NULL,
    falla_equipo TEXT NULL,
    reparacion_solicitada TEXT NULL,
    observaciones TEXT NULL,
    comentarios_internos TEXT NULL,
    comentarios_cliente TEXT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_entrega_estimada DATE NULL,
    adelanto INT NOT NULL DEFAULT 0,
    total INT NOT NULL DEFAULT 0,
    saldo INT NOT NULL DEFAULT 0,
    estado VARCHAR(40) NOT NULL DEFAULT 'Ingresado',
    prioridad VARCHAR(20) NOT NULL DEFAULT 'media',
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_eliminacion TIMESTAMP NULL,
    UNIQUE KEY uk_st_ordenes_empresa_numero (empresa_id, numero_orden),
    UNIQUE KEY uk_st_ordenes_codigo (codigo_seguimiento),
    INDEX idx_st_ordenes_estado (empresa_id, estado),
    INDEX idx_st_ordenes_fecha_ingreso (empresa_id, fecha_ingreso),
    CONSTRAINT fk_st_ordenes_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
    CONSTRAINT fk_st_ordenes_cliente FOREIGN KEY (cliente_id) REFERENCES st_clientes(id),
    CONSTRAINT fk_st_ordenes_equipo FOREIGN KEY (equipo_id) REFERENCES st_equipos(id),
    CONSTRAINT fk_st_ordenes_tecnico FOREIGN KEY (tecnico_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS st_historial_estados (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    orden_id BIGINT UNSIGNED NOT NULL,
    estado_anterior VARCHAR(40) NULL,
    estado_nuevo VARCHAR(40) NOT NULL,
    comentario TEXT NULL,
    usuario_id BIGINT UNSIGNED NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_st_historial_orden (orden_id, fecha_creacion),
    CONSTRAINT fk_st_historial_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
    CONSTRAINT fk_st_historial_orden FOREIGN KEY (orden_id) REFERENCES st_ordenes(id),
    CONSTRAINT fk_st_historial_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS st_diagnosticos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    orden_id BIGINT UNSIGNED NOT NULL,
    tecnico_id BIGINT UNSIGNED NULL,
    diagnostico TEXT NOT NULL,
    detalle TEXT NULL,
    pruebas TEXT NULL,
    repuestos TEXT NULL,
    mano_obra INT NOT NULL DEFAULT 0,
    costo_repuestos INT NOT NULL DEFAULT 0,
    total INT NOT NULL DEFAULT 0,
    observaciones TEXT NULL,
    fecha DATE NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_eliminacion TIMESTAMP NULL,
    CONSTRAINT fk_st_diagnostico_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
    CONSTRAINT fk_st_diagnostico_orden FOREIGN KEY (orden_id) REFERENCES st_ordenes(id),
    CONSTRAINT fk_st_diagnostico_tecnico FOREIGN KEY (tecnico_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS st_cotizaciones (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    orden_id BIGINT UNSIGNED NOT NULL,
    subtotal INT NOT NULL DEFAULT 0,
    descuento INT NOT NULL DEFAULT 0,
    total INT NOT NULL DEFAULT 0,
    estado VARCHAR(30) NOT NULL DEFAULT 'pendiente',
    vigencia DATE NULL,
    observaciones TEXT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_eliminacion TIMESTAMP NULL,
    CONSTRAINT fk_st_cotizacion_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
    CONSTRAINT fk_st_cotizacion_orden FOREIGN KEY (orden_id) REFERENCES st_ordenes(id)
);

CREATE TABLE IF NOT EXISTS st_detalle_cotizaciones (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    cotizacion_id BIGINT UNSIGNED NOT NULL,
    descripcion VARCHAR(180) NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio INT NOT NULL DEFAULT 0,
    total INT NOT NULL DEFAULT 0,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_st_detalle_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
    CONSTRAINT fk_st_detalle_cotizacion FOREIGN KEY (cotizacion_id) REFERENCES st_cotizaciones(id)
);

CREATE TABLE IF NOT EXISTS st_pagos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    orden_id BIGINT UNSIGNED NOT NULL,
    monto INT NOT NULL,
    metodo_pago ENUM('efectivo','transferencia','debito','credito') NOT NULL,
    fecha DATE NOT NULL,
    observaciones TEXT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_eliminacion TIMESTAMP NULL,
    INDEX idx_st_pagos_fecha (empresa_id, fecha),
    CONSTRAINT fk_st_pagos_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
    CONSTRAINT fk_st_pagos_orden FOREIGN KEY (orden_id) REFERENCES st_ordenes(id)
);

CREATE TABLE IF NOT EXISTS st_inventario (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    nombre VARCHAR(120) NOT NULL,
    codigo VARCHAR(60) NULL,
    categoria VARCHAR(80) NULL,
    marca VARCHAR(80) NULL,
    compatibilidad VARCHAR(180) NULL,
    stock INT NOT NULL DEFAULT 0,
    stock_minimo INT NOT NULL DEFAULT 0,
    costo INT NOT NULL DEFAULT 0,
    precio INT NOT NULL DEFAULT 0,
    proveedor VARCHAR(120) NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_eliminacion TIMESTAMP NULL,
    INDEX idx_st_inventario_stock (empresa_id, stock, stock_minimo),
    CONSTRAINT fk_st_inventario_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id)
);

CREATE TABLE IF NOT EXISTS st_auditoria (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    usuario_id BIGINT UNSIGNED NULL,
    modulo VARCHAR(80) NOT NULL,
    accion VARCHAR(80) NOT NULL,
    detalle TEXT NULL,
    ip VARCHAR(45) NULL,
    user_agent VARCHAR(255) NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_st_auditoria_empresa_fecha (empresa_id, fecha_creacion),
    CONSTRAINT fk_st_auditoria_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id),
    CONSTRAINT fk_st_auditoria_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_servicio_tecnico_admin_root.sql
-- ==================================================
-- Provisionamiento cliente Servicio Técnico (Chile)
-- Credenciales iniciales solicitadas:
-- Usuario: admin
-- Email: admin@tallerlocal.com
-- Password: Admin123*

SET @hash_admin_tallerlocal = '$2y$12$zh8NzBuzvus1gxOO5mQnmuUA8i3jHJb3WLBWjHXrSZk3mIDtPWPKG';

-- 1) Asegura empresa cliente
INSERT INTO empresas (
    razon_social,
    nombre_comercial,
    identificador_fiscal,
    correo,
    telefono,
    direccion,
    ciudad,
    pais,
    estado,
    fecha_activacion,
    plan_id,
    fecha_creacion
)
SELECT
    'Taller Local SpA',
    'Taller Local',
    '76.123.456-7',
    'admin@tallerlocal.com',
    '+56 9 1234 5678',
    'Av. Principal 123',
    'Santiago',
    'Chile',
    'activa',
    CURDATE(),
    (SELECT id FROM planes WHERE estado = 'activo' ORDER BY precio_mensual DESC, id DESC LIMIT 1),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM empresas WHERE correo = 'admin@tallerlocal.com'
);

SET @empresa_tallerlocal = (SELECT id FROM empresas WHERE correo = 'admin@tallerlocal.com' LIMIT 1);
SET @rol_admin_empresa = (SELECT id FROM roles WHERE codigo = 'administrador_empresa' LIMIT 1);

INSERT INTO usuarios (
    empresa_id,
    rol_id,
    nombre,
    correo,
    password,
    cargo,
    estado,
    fecha_creacion
)
SELECT
    @empresa_tallerlocal,
    @rol_admin_empresa,
    'admin',
    'admin@tallerlocal.com',
    @hash_admin_tallerlocal,
    'Administrador General',
    'activo',
    NOW()
WHERE NOT EXISTS (
    SELECT 1
    FROM usuarios
    WHERE correo = 'admin@tallerlocal.com'
);

UPDATE usuarios
SET
    empresa_id = @empresa_tallerlocal,
    rol_id = @rol_admin_empresa,
    nombre = 'admin',
    password = @hash_admin_tallerlocal,
    cargo = 'Administrador General',
    estado = 'activo',
    fecha_eliminacion = NULL
WHERE correo = 'admin@tallerlocal.com';

-- 3) Suscripción activa base para el cliente
INSERT INTO suscripciones (
    empresa_id,
    plan_id,
    estado,
    fecha_inicio,
    fecha_vencimiento,
    renovacion_automatica,
    observaciones,
    fecha_creacion
)
SELECT
    @empresa_tallerlocal,
    (SELECT id FROM planes WHERE estado = 'activo' ORDER BY precio_mensual DESC, id DESC LIMIT 1),
    'activa',
    CURDATE(),
    DATE_ADD(CURDATE(), INTERVAL 30 DAY),
    1,
    'Suscripción inicial habilitada para Servicio Técnico',
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM suscripciones WHERE empresa_id = @empresa_tallerlocal AND estado IN ('activa','por_vencer','pendiente')
);

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_usuarios_perfil_contacto.sql
-- ==================================================
-- Agrega campos de perfil/contacto al módulo de usuarios de empresa.
-- USE cotiza_saas;  -- removido para instalación genérica

SET @db_name = DATABASE();

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='usuarios' AND COLUMN_NAME='telefono') = 0,
  'ALTER TABLE usuarios ADD COLUMN telefono VARCHAR(80) NULL AFTER password',
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='usuarios' AND COLUMN_NAME='cargo') = 0,
  'ALTER TABLE usuarios ADD COLUMN cargo VARCHAR(120) NULL AFTER telefono',
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = IF(
  (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=@db_name AND TABLE_NAME='usuarios' AND COLUMN_NAME='biografia') = 0,
  'ALTER TABLE usuarios ADD COLUMN biografia TEXT NULL AFTER cargo',
  'SELECT 1'
); PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_usuarios_root_tallerlocal.sql
-- ==================================================
-- Usuarios root para instalación inicial sin fricción
SET @hash_root = '$2y$12$zh8NzBuzvus1gxOO5mQnmuUA8i3jHJb3WLBWjHXrSZk3mIDtPWPKG'; -- Admin123*

SET @rol_superadmin = (SELECT id FROM roles WHERE codigo = 'superadministrador' LIMIT 1);
SET @rol_admin_empresa = (SELECT id FROM roles WHERE codigo = 'administrador_empresa' LIMIT 1);

INSERT INTO usuarios (empresa_id, rol_id, nombre, correo, password, cargo, estado, fecha_creacion)
SELECT NULL, @rol_superadmin, 'root', 'root@tallerlocal.com', @hash_root, 'Superadministrador', 'activo', NOW()
WHERE NOT EXISTS (SELECT 1 FROM usuarios WHERE correo = 'root@tallerlocal.com');

UPDATE usuarios
SET rol_id = @rol_superadmin,
    nombre = 'root',
    password = @hash_root,
    cargo = 'Superadministrador',
    estado = 'activo',
    fecha_eliminacion = NULL
WHERE correo = 'root@tallerlocal.com';

SET @empresa_tallerlocal = (SELECT id FROM empresas WHERE correo = 'admin@tallerlocal.com' LIMIT 1);

INSERT INTO usuarios (empresa_id, rol_id, nombre, correo, password, cargo, estado, fecha_creacion)
SELECT @empresa_tallerlocal, @rol_admin_empresa, 'admin', 'admin@tallerlocal.com', @hash_root, 'Administrador General', 'activo', NOW()
WHERE NOT EXISTS (SELECT 1 FROM usuarios WHERE correo = 'admin@tallerlocal.com');

UPDATE usuarios
SET empresa_id = @empresa_tallerlocal,
    rol_id = @rol_admin_empresa,
    nombre = 'admin',
    password = @hash_root,
    cargo = 'Administrador General',
    estado = 'activo',
    fecha_eliminacion = NULL
WHERE correo = 'admin@tallerlocal.com';

-- ==================================================
-- SOURCE: base_datos/actualizaciones/actualizacion_usuarios_superadmin_admin_cliente.sql
-- ==================================================
START TRANSACTION;

-- Hash bcrypt para la clave demo: Demo1234*
SET @hash_demo = '$2y$12$l7d9QArsnPnqUeo/YjnXfOsDig87Wswc2LvMubdMw2kt1LRD4xhdi';

-- Roles base (idempotente)
INSERT INTO roles (nombre, codigo) VALUES
('Superadministrador', 'superadministrador'),
('Administrador', 'administrador_empresa')
ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);

SET @rol_superadmin = (SELECT id FROM roles WHERE codigo = 'superadministrador' LIMIT 1);
SET @rol_admin_empresa = (SELECT id FROM roles WHERE codigo = 'administrador_empresa' LIMIT 1);
SET @plan_base = (SELECT id FROM planes ORDER BY id ASC LIMIT 1);

-- Plan FULL para administrador cliente (idempotente)
INSERT INTO planes (
    nombre,
    slug,
    descripcion_comercial,
    precio_mensual,
    precio_anual,
    duracion_dias,
    visible,
    destacado,
    orden_visualizacion,
    estado
)
VALUES (
    'Full',
    'full',
    'Plan completo con acceso a todas las funcionalidades disponibles.',
    0,
    0,
    30,
    1,
    1,
    99,
    'activo'
)
ON DUPLICATE KEY UPDATE
    nombre = VALUES(nombre),
    descripcion_comercial = VALUES(descripcion_comercial),
    visible = VALUES(visible),
    destacado = VALUES(destacado),
    estado = VALUES(estado),
    fecha_actualizacion = NOW();

SET @plan_full = (SELECT id FROM planes WHERE slug = 'full' LIMIT 1);

-- Empresa cliente demo para alojar al admin de cliente (idempotente)
INSERT INTO empresas (
    razon_social,
    nombre_comercial,
    identificador_fiscal,
    correo,
    telefono,
    direccion,
    ciudad,
    pais,
    estado,
    fecha_activacion,
    plan_id,
    fecha_creacion
)
SELECT
    'Cliente Demo S.A.S.',
    'Cliente Demo',
    'CDS-0001',
    'cliente.demo@cotizapro.com',
    '+57 300 000 0000',
    'Dirección demo',
    'Bogotá',
    'Colombia',
    'activa',
    CURDATE(),
    COALESCE(@plan_full, @plan_base),
    NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM empresas WHERE correo = 'cliente.demo@cotizapro.com'
);

SET @empresa_cliente_demo = (SELECT id FROM empresas WHERE correo = 'cliente.demo@cotizapro.com' LIMIT 1);

UPDATE empresas
SET plan_id = COALESCE(@plan_full, @plan_base),
    fecha_actualizacion = NOW()
WHERE id = @empresa_cliente_demo;

-- El plan FULL debe tener todas las funcionalidades activas e ilimitadas
INSERT INTO plan_funcionalidades (plan_id, funcionalidad_id, activo, valor_numerico, es_ilimitado, fecha_actualizacion)
SELECT @plan_full, f.id, 1, 0, 1, NOW()
FROM funcionalidades f
WHERE @plan_full IS NOT NULL
ON DUPLICATE KEY UPDATE
    activo = 1,
    valor_numerico = 0,
    es_ilimitado = 1,
    fecha_actualizacion = NOW();

-- 1) Usuario superadministrador global
INSERT INTO usuarios (empresa_id, rol_id, nombre, correo, password, estado, fecha_creacion)
SELECT NULL, @rol_superadmin, 'Super Admin', 'superadmin@cotizapro.com', @hash_demo, 'activo', NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM usuarios WHERE correo = 'superadmin@cotizapro.com'
);

UPDATE usuarios
SET rol_id = @rol_superadmin,
    empresa_id = NULL,
    password = @hash_demo,
    estado = 'activo',
    fecha_actualizacion = NOW()
WHERE correo = 'superadmin@cotizapro.com';

-- 2) Usuario administrador de cliente
INSERT INTO usuarios (empresa_id, rol_id, nombre, correo, password, estado, fecha_creacion)
SELECT @empresa_cliente_demo, @rol_admin_empresa, 'Admin Cliente', 'admin.cliente@cotizapro.com', @hash_demo, 'activo', NOW()
WHERE @empresa_cliente_demo IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM usuarios WHERE correo = 'admin.cliente@cotizapro.com'
);

UPDATE usuarios
SET empresa_id = @empresa_cliente_demo,
    rol_id = @rol_admin_empresa,
    password = @hash_demo,
    estado = 'activo',
    fecha_actualizacion = NOW()
WHERE correo = 'admin.cliente@cotizapro.com';

COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
