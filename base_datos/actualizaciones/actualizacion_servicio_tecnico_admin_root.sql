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

-- 2) Asegura usuario root del cliente
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
    SELECT 1 FROM usuarios WHERE correo = 'admin@tallerlocal.com'
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
