CREATE DATABASE IF NOT EXISTS taller_servicio CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE taller_servicio;

CREATE TABLE roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL
);

CREATE TABLE permissions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  key_name VARCHAR(80) NOT NULL UNIQUE,
  label VARCHAR(120) NOT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL
);

CREATE TABLE role_permissions (
  role_id INT NOT NULL,
  permission_id INT NOT NULL,
  PRIMARY KEY(role_id, permission_id),
  CONSTRAINT fk_rp_role FOREIGN KEY (role_id) REFERENCES roles(id),
  CONSTRAINT fk_rp_permission FOREIGN KEY (permission_id) REFERENCES permissions(id)
);

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  role_id INT NOT NULL,
  username VARCHAR(60) NOT NULL UNIQUE,
  email VARCHAR(120) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  full_name VARCHAR(120) NOT NULL,
  status TINYINT(1) NOT NULL DEFAULT 1,
  last_login_at DATETIME NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  deleted_at DATETIME NULL,
  CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(80) NOT NULL,
  last_name VARCHAR(80) NOT NULL,
  document_number VARCHAR(30),
  phone VARCHAR(30),
  email VARCHAR(120),
  address VARCHAR(200),
  city VARCHAR(80),
  notes TEXT,
  status TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  deleted_at DATETIME NULL,
  INDEX idx_customer_doc (document_number),
  INDEX idx_customer_phone (phone)
);

CREATE TABLE technicians (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NULL,
  first_name VARCHAR(80) NOT NULL,
  last_name VARCHAR(80) NOT NULL,
  specialty VARCHAR(120),
  phone VARCHAR(30),
  email VARCHAR(120),
  workload INT NOT NULL DEFAULT 0,
  status TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  deleted_at DATETIME NULL,
  CONSTRAINT fk_technicians_user FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE devices (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  device_type ENUM('computador','notebook','impresora','celular','tablet','otro') NOT NULL,
  brand VARCHAR(80),
  model VARCHAR(80),
  serial_number VARCHAR(80),
  imei VARCHAR(30),
  color VARCHAR(40),
  accessories TEXT,
  reported_issue TEXT,
  physical_state TEXT,
  reception_notes TEXT,
  unlock_code VARCHAR(120),
  allow_review TINYINT(1) NOT NULL DEFAULT 0,
  allow_format TINYINT(1) NOT NULL DEFAULT 0,
  allow_backup TINYINT(1) NOT NULL DEFAULT 0,
  entry_date DATE NOT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  deleted_at DATETIME NULL,
  CONSTRAINT fk_devices_customer FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE device_photos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  device_id INT NOT NULL,
  photo_path VARCHAR(255) NOT NULL,
  type ENUM('equipo','estado_ingreso') NOT NULL DEFAULT 'equipo',
  created_at TIMESTAMP NULL,
  CONSTRAINT fk_device_photos_device FOREIGN KEY (device_id) REFERENCES devices(id)
);

CREATE TABLE service_statuses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80) NOT NULL UNIQUE,
  color VARCHAR(20) DEFAULT 'secondary',
  is_final TINYINT(1) NOT NULL DEFAULT 0,
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL
);

CREATE TABLE service_orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_number VARCHAR(25) NOT NULL UNIQUE,
  public_tracking_code VARCHAR(50) NOT NULL UNIQUE,
  customer_id INT NOT NULL,
  device_id INT NOT NULL,
  technician_id INT NULL,
  current_status_id INT NOT NULL,
  priority ENUM('baja','media','alta','urgente') NOT NULL DEFAULT 'media',
  service_category VARCHAR(80),
  failure_description TEXT,
  entry_date DATETIME NOT NULL,
  estimated_date DATETIME NULL,
  internal_notes TEXT,
  public_notes TEXT,
  review_cost DECIMAL(12,2) NOT NULL DEFAULT 0,
  labor_cost DECIMAL(12,2) NOT NULL DEFAULT 0,
  parts_cost DECIMAL(12,2) NOT NULL DEFAULT 0,
  estimated_total DECIMAL(12,2) NOT NULL DEFAULT 0,
  payment_status ENUM('pendiente','abono','pagado') NOT NULL DEFAULT 'pendiente',
  service_status ENUM('abierto','en_proceso','listo','entregado','cancelado') NOT NULL DEFAULT 'abierto',
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  deleted_at DATETIME NULL,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(id),
  CONSTRAINT fk_orders_device FOREIGN KEY (device_id) REFERENCES devices(id),
  CONSTRAINT fk_orders_technician FOREIGN KEY (technician_id) REFERENCES technicians(id),
  CONSTRAINT fk_orders_status FOREIGN KEY (current_status_id) REFERENCES service_statuses(id),
  INDEX idx_orders_entry (entry_date),
  INDEX idx_orders_status (current_status_id)
);

CREATE TABLE service_order_status_history (
  id INT AUTO_INCREMENT PRIMARY KEY,
  service_order_id INT NOT NULL,
  order_number VARCHAR(25) NOT NULL,
  old_status_name VARCHAR(80) NULL,
  new_status_name VARCHAR(80) NOT NULL,
  changed_by_user_id INT NOT NULL,
  internal_comment TEXT,
  public_comment TEXT,
  changed_at DATETIME NOT NULL,
  created_at TIMESTAMP NULL,
  CONSTRAINT fk_history_order FOREIGN KEY (service_order_id) REFERENCES service_orders(id),
  CONSTRAINT fk_history_user FOREIGN KEY (changed_by_user_id) REFERENCES users(id),
  INDEX idx_history_order (service_order_id, changed_at)
);

CREATE TABLE diagnostics (
  id INT AUTO_INCREMENT PRIMARY KEY,
  service_order_id INT NOT NULL,
  technician_id INT NOT NULL,
  general_diagnosis TEXT,
  technical_detail TEXT,
  tests_performed TEXT,
  suggested_parts TEXT,
  recommended_solution TEXT,
  estimated_time VARCHAR(80),
  labor_cost DECIMAL(12,2) NOT NULL DEFAULT 0,
  parts_cost DECIMAL(12,2) NOT NULL DEFAULT 0,
  estimated_total DECIMAL(12,2) NOT NULL DEFAULT 0,
  observations TEXT,
  released_to_client TINYINT(1) NOT NULL DEFAULT 0,
  diagnosed_at DATETIME NOT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  CONSTRAINT fk_diagnostics_order FOREIGN KEY (service_order_id) REFERENCES service_orders(id),
  CONSTRAINT fk_diagnostics_technician FOREIGN KEY (technician_id) REFERENCES technicians(id)
);

CREATE TABLE quotations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  quote_number VARCHAR(25) NOT NULL UNIQUE,
  service_order_id INT NOT NULL,
  quote_date DATE NOT NULL,
  valid_until DATE,
  subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
  discount DECIMAL(12,2) NOT NULL DEFAULT 0,
  total DECIMAL(12,2) NOT NULL DEFAULT 0,
  status ENUM('pendiente','aprobado','rechazado','vencido') NOT NULL DEFAULT 'pendiente',
  approval_channel VARCHAR(80) NULL,
  observations TEXT,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  CONSTRAINT fk_quotations_order FOREIGN KEY (service_order_id) REFERENCES service_orders(id)
);

CREATE TABLE quotation_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  quotation_id INT NOT NULL,
  description VARCHAR(255) NOT NULL,
  quantity DECIMAL(10,2) NOT NULL DEFAULT 1,
  unit_price DECIMAL(12,2) NOT NULL DEFAULT 0,
  total DECIMAL(12,2) NOT NULL DEFAULT 0,
  created_at TIMESTAMP NULL,
  CONSTRAINT fk_quote_items_quote FOREIGN KEY (quotation_id) REFERENCES quotations(id)
);

CREATE TABLE suppliers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  phone VARCHAR(40),
  email VARCHAR(120),
  address VARCHAR(200),
  status TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL
);

CREATE TABLE inventory_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  supplier_id INT NULL,
  name VARCHAR(120) NOT NULL,
  internal_code VARCHAR(50) NOT NULL UNIQUE,
  category VARCHAR(80),
  brand VARCHAR(80),
  compatible_model VARCHAR(120),
  stock_current INT NOT NULL DEFAULT 0,
  stock_minimum INT NOT NULL DEFAULT 0,
  cost DECIMAL(12,2) NOT NULL DEFAULT 0,
  sale_price DECIMAL(12,2) NOT NULL DEFAULT 0,
  location VARCHAR(80),
  status TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  CONSTRAINT fk_inventory_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);

CREATE TABLE inventory_movements (
  id INT AUTO_INCREMENT PRIMARY KEY,
  inventory_item_id INT NOT NULL,
  service_order_id INT NULL,
  movement_type ENUM('entrada','salida','ajuste') NOT NULL,
  quantity INT NOT NULL,
  unit_cost DECIMAL(12,2) NOT NULL DEFAULT 0,
  notes TEXT,
  moved_by_user_id INT NOT NULL,
  moved_at DATETIME NOT NULL,
  created_at TIMESTAMP NULL,
  CONSTRAINT fk_moves_item FOREIGN KEY (inventory_item_id) REFERENCES inventory_items(id),
  CONSTRAINT fk_moves_order FOREIGN KEY (service_order_id) REFERENCES service_orders(id),
  CONSTRAINT fk_moves_user FOREIGN KEY (moved_by_user_id) REFERENCES users(id)
);

CREATE TABLE payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  service_order_id INT NOT NULL,
  paid_at DATETIME NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  payment_method ENUM('efectivo','transferencia','debito','credito','otro') NOT NULL,
  reference VARCHAR(80),
  observations TEXT,
  created_by_user_id INT NOT NULL,
  created_at TIMESTAMP NULL,
  CONSTRAINT fk_payments_order FOREIGN KEY (service_order_id) REFERENCES service_orders(id),
  CONSTRAINT fk_payments_user FOREIGN KEY (created_by_user_id) REFERENCES users(id)
);

CREATE TABLE receipts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  service_order_id INT NOT NULL,
  receipt_type ENUM('recepcion','diagnostico','cotizacion','pago','entrega') NOT NULL,
  receipt_number VARCHAR(25) NOT NULL UNIQUE,
  payload_json JSON,
  issued_by_user_id INT NOT NULL,
  issued_at DATETIME NOT NULL,
  created_at TIMESTAMP NULL,
  CONSTRAINT fk_receipts_order FOREIGN KEY (service_order_id) REFERENCES service_orders(id),
  CONSTRAINT fk_receipts_user FOREIGN KEY (issued_by_user_id) REFERENCES users(id)
);

CREATE TABLE settings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  `key` VARCHAR(120) NOT NULL UNIQUE,
  `value` TEXT,
  description VARCHAR(255),
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL
);

CREATE TABLE audit_logs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NULL,
  action VARCHAR(120) NOT NULL,
  table_name VARCHAR(120),
  related_id BIGINT NULL,
  ip_address VARCHAR(45),
  user_agent VARCHAR(255),
  created_at DATETIME NOT NULL,
  CONSTRAINT fk_audit_user FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO roles (id, name, created_at, updated_at) VALUES
(1,'Administrador',NOW(),NOW()),
(2,'Recepcionista',NOW(),NOW()),
(3,'Técnico',NOW(),NOW()),
(4,'Caja',NOW(),NOW()),
(5,'Supervisor',NOW(),NOW());

INSERT INTO permissions (key_name, label, created_at, updated_at) VALUES
('customers.view','Ver clientes',NOW(),NOW()),('customers.edit','Editar clientes',NOW(),NOW()),
('orders.create','Crear órdenes',NOW(),NOW()),('orders.status','Cambiar estados',NOW(),NOW()),
('costs.view','Ver costos',NOW(),NOW()),('payments.register','Registrar pagos',NOW(),NOW()),
('reports.view','Ver reportes',NOW(),NOW()),('users.manage','Administrar usuarios',NOW(),NOW()),
('settings.manage','Administrar configuración',NOW(),NOW());

INSERT INTO role_permissions (role_id, permission_id)
SELECT 1, id FROM permissions;

INSERT INTO role_permissions (role_id, permission_id) VALUES
(2,1),(2,2),(2,3),(2,4),
(3,4),
(4,6),
(5,1),(5,3),(5,4),(5,5),(5,7);

INSERT INTO users (role_id, username, email, password, full_name, status, created_at, updated_at) VALUES
(1,'admin','admin@tallerlocal.com','$2y$12$QaeYlvlWPKMQCDFEhhxBTOe.JO78HsXDfTY7B5jiV.H.6NvDQCbeq','Administrador General',1,NOW(),NOW());

INSERT INTO customers (first_name,last_name,document_number,phone,email,address,city,notes,status,created_at,updated_at) VALUES
('Juan','Pérez','12.345.678-9','+56911111111','juan@example.com','Calle 123','Santiago','Cliente recurrente',1,NOW(),NOW()),
('María','González','98.765.432-1','+56922222222','maria@example.com','Av. Central 456','Santiago','Prefiere WhatsApp',1,NOW(),NOW());

INSERT INTO technicians (first_name,last_name,specialty,phone,email,workload,status,created_at,updated_at) VALUES
('Carlos','Ruiz','Celulares','+56933333333','carlos@tallerlocal.com',2,1,NOW(),NOW());

INSERT INTO devices (customer_id,device_type,brand,model,serial_number,imei,color,accessories,reported_issue,physical_state,reception_notes,unlock_code,allow_review,allow_format,allow_backup,entry_date,created_at,updated_at) VALUES
(1,'notebook','Lenovo','ThinkPad E14','SN001',NULL,'Negro','Cargador','No enciende','Golpe menor en tapa','Sin observaciones','1234',1,1,1,CURDATE(),NOW(),NOW());

INSERT INTO service_statuses (id,name,color,is_final,sort_order,created_at,updated_at) VALUES
(1,'Ingresado','secondary',0,1,NOW(),NOW()),
(2,'En espera de revisión','warning',0,2,NOW(),NOW()),
(3,'En diagnóstico','info',0,3,NOW(),NOW()),
(4,'Presupuesto enviado','primary',0,4,NOW(),NOW()),
(5,'Esperando aprobación del cliente','warning',0,5,NOW(),NOW()),
(6,'Aprobado por cliente','success',0,6,NOW(),NOW()),
(7,'Rechazado por cliente','danger',1,7,NOW(),NOW()),
(8,'En reparación','info',0,8,NOW(),NOW()),
(9,'Esperando repuesto','warning',0,9,NOW(),NOW()),
(10,'En pruebas','info',0,10,NOW(),NOW()),
(11,'Listo para entrega','success',0,11,NOW(),NOW()),
(12,'Entregado','success',1,12,NOW(),NOW()),
(13,'No reparado','secondary',1,13,NOW(),NOW()),
(14,'Cancelado','dark',1,14,NOW(),NOW());

INSERT INTO service_orders (order_number,public_tracking_code,customer_id,device_id,technician_id,current_status_id,priority,service_category,failure_description,entry_date,estimated_date,internal_notes,public_notes,review_cost,labor_cost,parts_cost,estimated_total,payment_status,service_status,created_at,updated_at) VALUES
('OT-2026-0001','TRK8F9K2',1,1,1,3,'alta','Reparación placa','Equipo no enciende',NOW(),DATE_ADD(NOW(), INTERVAL 3 DAY),'Revisar fuente','Estamos diagnosticando su equipo',10000,25000,15000,50000,'abono','en_proceso',NOW(),NOW());

INSERT INTO service_order_status_history (service_order_id,order_number,old_status_name,new_status_name,changed_by_user_id,internal_comment,public_comment,changed_at,created_at) VALUES
(1,'OT-2026-0001','Ingresado','En diagnóstico',1,'Inicio de diagnóstico','Equipo en revisión técnica',NOW(),NOW());

INSERT INTO diagnostics (service_order_id,technician_id,general_diagnosis,technical_detail,tests_performed,suggested_parts,recommended_solution,estimated_time,labor_cost,parts_cost,estimated_total,observations,released_to_client,diagnosed_at,created_at,updated_at) VALUES
(1,1,'Falla de energía','MOSFET dañado en etapa de carga','Prueba de fuente y consumo','MOSFET 4435','Cambio de componente y limpieza','24 horas',25000,15000,50000,'Recomendado respaldo de datos',1,NOW(),NOW(),NOW());

INSERT INTO quotations (quote_number,service_order_id,quote_date,valid_until,subtotal,discount,total,status,observations,created_at,updated_at) VALUES
('COT-2026-0001',1,CURDATE(),DATE_ADD(CURDATE(), INTERVAL 5 DAY),50000,0,50000,'pendiente','Incluye garantía 30 días',NOW(),NOW());

INSERT INTO quotation_items (quotation_id,description,quantity,unit_price,total,created_at) VALUES
(1,'Cambio MOSFET + servicio técnico',1,50000,50000,NOW());

INSERT INTO suppliers (name,phone,email,address,status,created_at,updated_at) VALUES
('Proveedor Tech Spa','+5622000000','ventas@proveedor.cl','Santiago Centro',1,NOW(),NOW());

INSERT INTO inventory_items (supplier_id,name,internal_code,category,brand,compatible_model,stock_current,stock_minimum,cost,sale_price,location,status,created_at,updated_at) VALUES
(1,'MOSFET 4435','REP-0001','Microelectrónica','Genérico','Placas notebook',5,3,2500,7000,'Estante A1',1,NOW(),NOW());

INSERT INTO inventory_movements (inventory_item_id,service_order_id,movement_type,quantity,unit_cost,notes,moved_by_user_id,moved_at,created_at) VALUES
(1,1,'salida',1,2500,'Uso en orden OT-2026-0001',1,NOW(),NOW());

INSERT INTO payments (service_order_id,paid_at,amount,payment_method,reference,observations,created_by_user_id,created_at) VALUES
(1,NOW(),20000,'transferencia','TRX-2026-1001','Abono inicial',1,NOW());

INSERT INTO receipts (service_order_id,receipt_type,receipt_number,payload_json,issued_by_user_id,issued_at,created_at) VALUES
(1,'recepcion','REC-2026-0001',JSON_OBJECT('order','OT-2026-0001','client','Juan Pérez'),1,NOW(),NOW());

INSERT INTO settings (`key`,`value`,description,created_at,updated_at) VALUES
('company_name','Taller Local','Nombre comercial',NOW(),NOW()),
('company_phone','+56912345678','Teléfono principal',NOW(),NOW()),
('company_email','contacto@tallerlocal.com','Correo principal',NOW(),NOW()),
('show_balance_public','0','Mostrar saldo en portal público',NOW(),NOW());

INSERT INTO audit_logs (user_id,action,table_name,related_id,ip_address,user_agent,created_at) VALUES
(1,'CREAR_ORDEN','service_orders',1,'127.0.0.1','seed',NOW());
