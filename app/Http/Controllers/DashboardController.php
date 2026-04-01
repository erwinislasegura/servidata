<?php

namespace App\Http\Controllers;
use App\Models\Orden;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
class DashboardController extends Controller
{
    public function __invoke(Request $request)
    {
               $anio = date('Y'); // Obtiene el año

// Configura el locale en español para que los nombres de los meses se traduzcan
setlocale(LC_TIME, 'es_ES.UTF-8'); // Para sistemas Unix
setlocale(LC_TIME, 'Spanish_Spain.1252'); // Para sistemas Windows (opcional según el sistema operativo)

$totalServicioGrafico = DB::table('orden as o')
    ->select(
        DB::raw("DATE_FORMAT(o.fechaEntrada, '%M') as mes"), // Formato en español
        DB::raw('YEAR(o.fechaEntrada) as anio'),
        DB::raw('SUM(o.totalPagar) as total')
    )
    ->whereYear('o.fechaEntrada', $anio)
    ->groupBy(
        DB::raw('MONTH(o.fechaEntrada)'),
        DB::raw("DATE_FORMAT(o.fechaEntrada, '%M')"),
        DB::raw('YEAR(o.fechaEntrada)')
    )
    ->orderBy(DB::raw('MONTH(o.fechaEntrada)')) // Ordena por mes
    ->get();




        //DISPOSITIVOS NO ENTREGADOS
        $totalDispositosNoEntregados = DB::table('orden')
            ->select('id')
            ->where('estado', '=', 'Reparacion finalizado')
            // ->where('orden.idusuario','=',Auth::user()->id)//solo muestra por usuario
            ->get();
        //dispostivos  en reparacion
        $totalDispositosEnReparacion = DB::table('orden')
            ->select('id')
            ->where('estado', '=', 'Reparando')
            //->where('orden.idusuario','=',Auth::user()->id)
            ->get();
        //total servicio
        //ventas todo
        $totalServicio = DB::table('orden')
            ->select('id', 'totalPagar', 'adelanto')
            ->get();

        return [
            'dispositivosNoEntregados' => $totalDispositosNoEntregados,
            'dispositivosEnReparacion' => $totalDispositosEnReparacion,
            'totalServicio' => $totalServicio,
            'totalServicioGrafico' => $totalServicioGrafico
        ];
    }
}
