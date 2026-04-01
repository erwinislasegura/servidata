<?php

namespace Aplicacion\Modelos;

use Aplicacion\Nucleo\Modelo;
use PDO;

class ServicioTecnico extends Modelo
{
    public function listarClientes(int $empresaId, string $buscar = ''): array
    {
        $sql = 'SELECT * FROM st_clientes WHERE empresa_id = :empresa_id AND fecha_eliminacion IS NULL';
        $params = ['empresa_id' => $empresaId];

        if ($buscar !== '') {
            $sql .= ' AND (nombres LIKE :buscar OR apellidos LIKE :buscar OR rut LIKE :buscar OR telefono LIKE :buscar OR email LIKE :buscar)';
            $params['buscar'] = '%' . $buscar . '%';
        }

        $sql .= ' ORDER BY id DESC LIMIT 120';
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }

    public function crearCliente(int $empresaId, array $data): int
    {
        $stmt = $this->db->prepare('INSERT INTO st_clientes (empresa_id, nombres, apellidos, rut, tipo_documento, numero_documento, direccion, comuna, ciudad, telefono, email, observaciones, estado) VALUES (:empresa_id, :nombres, :apellidos, :rut, :tipo_documento, :numero_documento, :direccion, :comuna, :ciudad, :telefono, :email, :observaciones, :estado)');
        $stmt->execute([
            'empresa_id' => $empresaId,
            'nombres' => $data['nombres'] ?? '',
            'apellidos' => $data['apellidos'] ?? '',
            'rut' => $data['rut'] ?? null,
            'tipo_documento' => $data['tipo_documento'] ?? 'RUT',
            'numero_documento' => $data['numero_documento'] ?? null,
            'direccion' => $data['direccion'] ?? null,
            'comuna' => $data['comuna'] ?? null,
            'ciudad' => $data['ciudad'] ?? null,
            'telefono' => $data['telefono'] ?? null,
            'email' => $data['email'] ?? null,
            'observaciones' => $data['observaciones'] ?? null,
            'estado' => $data['estado'] ?? 'activo',
        ]);

        return (int) $this->db->lastInsertId();
    }

    public function listarEquipos(int $empresaId, string $buscar = ''): array
    {
        $sql = 'SELECT e.*, CONCAT(c.nombres, " ", c.apellidos) AS cliente_nombre
            FROM st_equipos e
            INNER JOIN st_clientes c ON c.id = e.cliente_id AND c.empresa_id = e.empresa_id
            WHERE e.empresa_id = :empresa_id AND e.fecha_eliminacion IS NULL';
        $params = ['empresa_id' => $empresaId];

        if ($buscar !== '') {
            $sql .= ' AND (e.nombre_equipo LIKE :buscar OR e.marca LIKE :buscar OR e.modelo LIKE :buscar OR e.serie LIKE :buscar OR c.nombres LIKE :buscar OR c.apellidos LIKE :buscar)';
            $params['buscar'] = '%' . $buscar . '%';
        }

        $sql .= ' ORDER BY e.id DESC LIMIT 120';
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }

    public function crearEquipo(int $empresaId, array $data): int
    {
        $stmt = $this->db->prepare('INSERT INTO st_equipos (empresa_id, cliente_id, tipo_equipo, nombre_equipo, marca, modelo, serie, imei, color, accesorios, clave, estado_fisico, observaciones, estado) VALUES (:empresa_id, :cliente_id, :tipo_equipo, :nombre_equipo, :marca, :modelo, :serie, :imei, :color, :accesorios, :clave, :estado_fisico, :observaciones, :estado)');
        $stmt->execute([
            'empresa_id' => $empresaId,
            'cliente_id' => (int) ($data['cliente_id'] ?? 0),
            'tipo_equipo' => $data['tipo_equipo'] ?? 'PC',
            'nombre_equipo' => $data['nombre_equipo'] ?? '',
            'marca' => $data['marca'] ?? null,
            'modelo' => $data['modelo'] ?? null,
            'serie' => $data['serie'] ?? null,
            'imei' => $data['imei'] ?? null,
            'color' => $data['color'] ?? null,
            'accesorios' => $data['accesorios'] ?? null,
            'clave' => $data['clave'] ?? null,
            'estado_fisico' => $data['estado_fisico'] ?? null,
            'observaciones' => $data['observaciones'] ?? null,
            'estado' => $data['estado'] ?? 'activo',
        ]);

        return (int) $this->db->lastInsertId();
    }

    public function listarOrdenes(int $empresaId, string $buscar = '', string $estado = ''): array
    {
        $sql = 'SELECT o.*, CONCAT(c.nombres, " ", c.apellidos) AS cliente_nombre,
                CONCAT(e.marca, " ", e.modelo) AS equipo_nombre,
                u.nombre AS tecnico_nombre
            FROM st_ordenes o
            INNER JOIN st_clientes c ON c.id = o.cliente_id AND c.empresa_id = o.empresa_id
            LEFT JOIN st_equipos e ON e.id = o.equipo_id AND e.empresa_id = o.empresa_id
            LEFT JOIN usuarios u ON u.id = o.tecnico_id AND u.empresa_id = o.empresa_id
            WHERE o.empresa_id = :empresa_id AND o.fecha_eliminacion IS NULL';
        $params = ['empresa_id' => $empresaId];

        if ($buscar !== '') {
            $sql .= ' AND (o.numero_orden LIKE :buscar OR o.codigo_seguimiento LIKE :buscar OR c.nombres LIKE :buscar OR c.apellidos LIKE :buscar OR o.problema_principal LIKE :buscar OR e.serie LIKE :buscar OR e.imei LIKE :buscar)';
            $params['buscar'] = '%' . $buscar . '%';
        }

        if ($estado !== '') {
            $sql .= ' AND o.estado = :estado';
            $params['estado'] = $estado;
        }

        $sql .= ' ORDER BY o.id DESC LIMIT 120';
        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll();
    }

    public function crearOrden(int $empresaId, array $data): int
    {
        $numeroOrden = $this->siguienteNumeroOrden($empresaId);
        $total = (int) ($data['total'] ?? 0);
        $adelanto = (int) ($data['adelanto'] ?? 0);
        $saldo = max($total - $adelanto, 0);

        $stmt = $this->db->prepare('INSERT INTO st_ordenes (empresa_id, numero_orden, codigo_seguimiento, cliente_id, equipo_id, tecnico_id, tipo_equipo, marca, modelo, serie, imei, accesorios, clave, problema_principal, detalle_problema, sintomas, falla_equipo, reparacion_solicitada, observaciones, comentarios_internos, comentarios_cliente, fecha_ingreso, fecha_entrega_estimada, adelanto, total, saldo, estado, prioridad) VALUES (:empresa_id, :numero_orden, :codigo_seguimiento, :cliente_id, :equipo_id, :tecnico_id, :tipo_equipo, :marca, :modelo, :serie, :imei, :accesorios, :clave, :problema_principal, :detalle_problema, :sintomas, :falla_equipo, :reparacion_solicitada, :observaciones, :comentarios_internos, :comentarios_cliente, :fecha_ingreso, :fecha_entrega_estimada, :adelanto, :total, :saldo, :estado, :prioridad)');

        $codigoSeguimiento = strtoupper(substr(hash('sha256', uniqid((string) $empresaId, true)), 0, 8));

        $stmt->execute([
            'empresa_id' => $empresaId,
            'numero_orden' => $numeroOrden,
            'codigo_seguimiento' => $codigoSeguimiento,
            'cliente_id' => (int) ($data['cliente_id'] ?? 0),
            'equipo_id' => (int) ($data['equipo_id'] ?? 0) ?: null,
            'tecnico_id' => (int) ($data['tecnico_id'] ?? 0) ?: null,
            'tipo_equipo' => $data['tipo_equipo'] ?? null,
            'marca' => $data['marca'] ?? null,
            'modelo' => $data['modelo'] ?? null,
            'serie' => $data['serie'] ?? null,
            'imei' => $data['imei'] ?? null,
            'accesorios' => $data['accesorios'] ?? null,
            'clave' => $data['clave'] ?? null,
            'problema_principal' => $data['problema_principal'] ?? '',
            'detalle_problema' => $data['detalle_problema'] ?? null,
            'sintomas' => $data['sintomas'] ?? null,
            'falla_equipo' => $data['falla_equipo'] ?? null,
            'reparacion_solicitada' => $data['reparacion_solicitada'] ?? null,
            'observaciones' => $data['observaciones'] ?? null,
            'comentarios_internos' => $data['comentarios_internos'] ?? null,
            'comentarios_cliente' => $data['comentarios_cliente'] ?? null,
            'fecha_ingreso' => $data['fecha_ingreso'] ?? date('Y-m-d'),
            'fecha_entrega_estimada' => $data['fecha_entrega_estimada'] ?? null,
            'adelanto' => $adelanto,
            'total' => $total,
            'saldo' => $saldo,
            'estado' => $data['estado'] ?? 'Ingresado',
            'prioridad' => $data['prioridad'] ?? 'media',
        ]);

        return (int) $this->db->lastInsertId();
    }

    public function listarTecnicos(int $empresaId): array
    {
        $stmt = $this->db->prepare("SELECT id, nombre FROM usuarios WHERE empresa_id = :empresa_id AND rol IN ('admin','usuario','tecnico') AND estado = 'activo' ORDER BY nombre ASC");
        $stmt->execute(['empresa_id' => $empresaId]);
        return $stmt->fetchAll();
    }

    public function dashboard(int $empresaId): array
    {
        $metricas = [
            'ordenes_hoy' => "SELECT COUNT(*) FROM st_ordenes WHERE empresa_id=:empresa_id AND DATE(fecha_ingreso)=CURDATE() AND fecha_eliminacion IS NULL",
            'en_diagnostico' => "SELECT COUNT(*) FROM st_ordenes WHERE empresa_id=:empresa_id AND estado='Diagnóstico' AND fecha_eliminacion IS NULL",
            'en_reparacion' => "SELECT COUNT(*) FROM st_ordenes WHERE empresa_id=:empresa_id AND estado='En reparación' AND fecha_eliminacion IS NULL",
            'listas_entrega' => "SELECT COUNT(*) FROM st_ordenes WHERE empresa_id=:empresa_id AND estado='Listo' AND fecha_eliminacion IS NULL",
            'entregadas' => "SELECT COUNT(*) FROM st_ordenes WHERE empresa_id=:empresa_id AND estado='Entregado' AND fecha_eliminacion IS NULL",
            'por_cobrar' => "SELECT COALESCE(SUM(saldo),0) FROM st_ordenes WHERE empresa_id=:empresa_id AND estado <> 'Entregado' AND fecha_eliminacion IS NULL",
            'cobrado_hoy' => "SELECT COALESCE(SUM(monto),0) FROM st_pagos WHERE empresa_id=:empresa_id AND DATE(fecha)=CURDATE() AND fecha_eliminacion IS NULL",
            'total_mensual' => "SELECT COALESCE(SUM(monto),0) FROM st_pagos WHERE empresa_id=:empresa_id AND MONTH(fecha)=MONTH(CURDATE()) AND YEAR(fecha)=YEAR(CURDATE()) AND fecha_eliminacion IS NULL",
            'no_retirados' => "SELECT COUNT(*) FROM st_ordenes WHERE empresa_id=:empresa_id AND estado='Listo' AND fecha_entrega_estimada < CURDATE() AND fecha_eliminacion IS NULL",
            'stock_bajo' => "SELECT COUNT(*) FROM st_inventario WHERE empresa_id=:empresa_id AND stock <= stock_minimo AND fecha_eliminacion IS NULL",
        ];

        $salida = [];
        foreach ($metricas as $k => $q) {
            $stmt = $this->db->prepare($q);
            $stmt->execute(['empresa_id' => $empresaId]);
            $salida[$k] = (int) $stmt->fetchColumn();
        }

        $salida['ultimas_ordenes'] = $this->listarOrdenes($empresaId, '', '');

        $stmt = $this->db->prepare('SELECT numero_orden, cliente_id, fecha_entrega_estimada, estado FROM st_ordenes WHERE empresa_id=:empresa_id AND fecha_entrega_estimada IS NOT NULL AND estado <> "Entregado" AND fecha_eliminacion IS NULL ORDER BY fecha_entrega_estimada ASC LIMIT 10');
        $stmt->execute(['empresa_id' => $empresaId]);
        $salida['proximas_entregas'] = $stmt->fetchAll();

        return $salida;
    }

    private function siguienteNumeroOrden(int $empresaId): string
    {
        $stmt = $this->db->prepare('SELECT COUNT(*) + 1 FROM st_ordenes WHERE empresa_id = :empresa_id');
        $stmt->execute(['empresa_id' => $empresaId]);
        return 'OST-' . str_pad((string) $stmt->fetchColumn(), 6, '0', STR_PAD_LEFT);
    }
}
