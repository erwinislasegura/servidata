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
