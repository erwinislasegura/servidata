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
