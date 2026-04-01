<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Orden;
use App\Models\Cliente;
use App\Models\Tecnico;
//use Dompdf\Dompdf;
use Illuminate\Support\Facades\DB;

class ConsultaController extends Controller
{
        public function Consulta()
        {
            $datos = ['nombre' => 'Ejemplo', 'edad' => 30];
            
            return view('consultas', compact('datos'));
        }

        public function consultaEstadoEquipo (Request $Request){
            $search = $Request->input('search');
            $ordenes = Orden::join('clientes', 'orden.idcliente', '=', 'clientes.id')
            ->join('tecnicos', 'orden.idtecnico', '=', 'tecnicos.id')
            ->select('orden.id',
            'clientes.id as idcliente',
            'clientes.nombre as nombreCliente', 
            'tecnicos.id as idtecnico',
            'clientes.nombre as Cliente',                    
            'tecnicos.nombre as Tecnico',
            'orden.nombreEquipo',
            'orden.marca',
            'orden.modelo',
            'orden.serial',
            'orden.clave',
            'orden.accesorios',
            'orden.observaciones',
            'orden.fallaEquipo',
            'orden.reparacion',
            'orden.fechaEntrada',
            'orden.fechaEntrega',
            'orden.adelanto',
            'orden.totalPagar',
            'orden.estado')
            ->where('orden.id','=',$search)
            ->orderBy('orden.id','desc')->take(6)->get();
          // return ['ordenes' => $ordenes];
          return view('consultas', compact('ordenes'));
    
        }
}
