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
