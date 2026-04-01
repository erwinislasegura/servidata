-- Migración incremental Chile / productividad mostrador
ALTER TABLE customers
  ADD COLUMN rut VARCHAR(20) NULL AFTER last_name,
  ADD COLUMN comuna VARCHAR(100) NULL AFTER address,
  ADD COLUMN region VARCHAR(100) NULL AFTER comuna;

ALTER TABLE service_orders
  ADD COLUMN advance_paid DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER estimated_total,
  ADD COLUMN balance_due DECIMAL(12,2) NOT NULL DEFAULT 0 AFTER advance_paid,
  ADD COLUMN ready_for_delivery TINYINT(1) NOT NULL DEFAULT 0 AFTER service_status;

INSERT INTO settings (`key`, `value`, description, created_at, updated_at)
VALUES
  ('currency', 'CLP', 'Moneda de operación', NOW(), NOW()),
  ('locale', 'es-CL', 'Localización de fechas y formatos', NOW(), NOW()),
  ('money_decimals', '0', 'Cantidad de decimales para montos', NOW(), NOW())
ON DUPLICATE KEY UPDATE `value` = VALUES(`value`), updated_at = NOW();
