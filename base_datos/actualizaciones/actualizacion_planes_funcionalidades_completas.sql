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
