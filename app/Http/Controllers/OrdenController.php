<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Orden;
use App\Models\Cliente;
use App\Models\Tecnico;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Dompdf\Dompdf;
use Illuminate\Support\Facades\DB;
class OrdenController extends Controller
{
    public function index(Request $request)
    {
       if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;

        if ($buscar == '') {
            $ordenes = Orden::join('clientes', 'orden.idcliente', '=', 'clientes.id')
                ->join('tecnicos', 'orden.idtecnico', '=', 'tecnicos.id')
                ->select(
                    'orden.id',
                    'clientes.id as idcliente', 
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
                    'orden.estado',
                    'orden.imagen'
                )
                ->orderBy('orden.id', 'desc')
                ->paginate(6);
        } else {
            $ordenes = Orden::join('clientes', 'orden.idcliente', '=', 'clientes.id')
                ->join('tecnicos', 'orden.idtecnico', '=', 'tecnicos.id')
                ->select(
                    'orden.id',
                    'clientes.id as idcliente', 
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
                    'orden.estado',
                    'orden.imagen'
                )
                ->where('orden.' . $criterio, 'like', '%' . $buscar . '%')
                ->orderBy('orden.id', 'desc')->paginate(6);
        }

        return [
            'pagination' => [
                'total'        => $ordenes->total(),
                'current_page' => $ordenes->currentPage(),
                'per_page'     => $ordenes->perPage(),
                'last_page'    => $ordenes->lastPage(),
                'from'         => $ordenes->firstItem(),
                'to'           => $ordenes->lastItem(),
            ],
            'ordenes' => $ordenes
        ];
    }
     public function indextecnico(Request $request)
    {
       //if (!$request->ajax()) return redirect('/');

        $buscar = $request->buscar;
        $criterio = $request->criterio;

        if ($buscar == '') {
            $ordenes = Orden::join('clientes', 'orden.idcliente', '=', 'clientes.id')
                ->join('tecnicos', 'orden.idtecnico', '=', 'tecnicos.id')
                ->select(
                    'orden.id',
                    'clientes.id as idcliente', 
                    'tecnicos.id as idtecnico',
                    'clientes.nombre as Cliente',                    
                    'tecnicos.nombre as Tecnico',
                    'orden.idusuario as usuario',
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
                    'orden.estado'
                )

                ->where('orden.idusuario','=',Auth::user()->id)
                ->orderBy('orden.id', 'desc')
                ->paginate(6);
        } else {
            $ordenes = Orden::join('clientes', 'orden.idcliente', '=', 'clientes.id')
                ->join('tecnicos', 'orden.idtecnico', '=', 'tecnicos.id')
                ->select(
                    'orden.id',
                    'clientes.id as idcliente', 
                    'tecnicos.id as idtecnico',
                    'clientes.nombre as Cliente',                    
                    'tecnicos.nombre as Tecnico',
                    'orden.idusuario as usuario',
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
                    'orden.estado'
                )
                ->where('orden.idusuario','=',Auth::user()->id)
                ->where('orden.' . $criterio, 'like', '%' . $buscar . '%')
                ->orderBy('orden.id', 'desc')->paginate(6);
        }

        return [
            'pagination' => [
                'total'        => $ordenes->total(),
                'current_page' => $ordenes->currentPage(),
                'per_page'     => $ordenes->perPage(),
                'last_page'    => $ordenes->lastPage(),
                'from'         => $ordenes->firstItem(),
                'to'           => $ordenes->lastItem(),
            ],
            'ordenes' => $ordenes
        ];
    }
    public function obtenerCabecera(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $id = $request->id;
        $venta = orden::join('clientes', 'orden.idcliente', '=', 'clientes.id')
            ->join('tecnicos', 'orden.idtecnico', '=', 'tecnicos.id')
            ->select(
                'orden.id',
                    'clientes.nombre',                    
                    'tecnicos.nombre',
                    'orden.nombre',
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
                    'orden.estado'
            )
            ->where('orden.id', '=', $id)
            ->orderBy('orden.id', 'desc')->take(1)->get();

        return ['venta' => $venta];
    }
    public function obtenerDetalles(Request $request)
    {
        if (!$request->ajax()) return redirect('/');

        $id = $request->id;
        $detalles = DetalleVenta::join('productos', 'detalle_ventas.idproducto', '=', 'productos.id')
            ->select('detalle_ventas.cantidad', 'detalle_ventas.precio', 'productos.nombre as articulo', 'detalle_ventas.descuento')
            ->where('detalle_ventas.idventa', '=', $id)
            ->orderBy('detalle_ventas.id', 'desc')->get();

        return ['detalles' => $detalles];
    }
    public function pdf(Request $request,$id){
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
        ->where('orden.id','=',$id)
        ->orderBy('orden.id','desc')->take(1)->get();

       /* $detalles = DetalleVenta::join('productos','detalle_ventas.idproducto','=','productos.id')
        ->select('detalle_ventas.cantidad','detalle_ventas.precio','detalle_ventas.descuento',
        'productos.nombre as articulo')
        ->where('detalle_ventas.idventa','=',$id)
        ->orderBy('detalle_ventas.id','desc')->get();*/

        $numOrden=Orden::select('id')->where('id',$id)->get();

        $pdf = \PDF::loadView('pdf.ordenTicket',['ordenes'=>$ordenes]);
       //$pdf ->setPaper('a4','portrait');
       $pdf->setPaper( [0, 0, 220.732,  841.89]); 
      // $pdf->setPaper( array(0,0,612.00,1008.0)); 

      //return $pdf->download('orden-'.$numOrden[0]->id.'.pdf');

     // $pdf->render();
//$pdf->stream('orden-'.$numOrden[0]->id.'.pdf');

        

        $pdf->render();
        return $pdf->stream();
       // return response($dompdf->output(), 200)
        //->header('Content-Type', 'application/pdf');
    }

    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        try{
            // Validar los datos del formulario
            $validated = $request->validate([
                'idcliente' => 'required|integer',
                'idtecnico' => 'required|integer',
                'idusuario' => 'required|integer',
                'nombreEquipo' => 'required|string|max:100',
                'marca' => 'required|string|max:50',
                'modelo' => 'required|string|max:50',
                'serial' => 'required|string|max:50',
                'clave' => 'nullable|string|max:50',
                'accesorios' => 'nullable|string|max:150',
                'observaciones' => 'nullable|string|max:150',
                'fallaEquipo' => 'nullable|string|max:150',
                'reparacion' => 'nullable|string|max:200',
                'fechaEntrada' => 'required|date',
                'fechaEntrega' => 'required|date',
                'adelanto' => 'required|numeric',
                'totalPagar' => 'required|numeric',
                'estado' => 'required|string|max:60',
                'imagen' => 'nullable|image|mimes:jpeg,png,jpg|max:2048', // Validar la imagen
            ]);
             // Manejar la imagen si está presente
            $imagenRuta = null;
            if ($request->hasFile('imagen')) {
                $file = $request->file('imagen');
                $imagenRuta = $file->store('uploads/ordenes', 'public'); // Guardar en storage/app/public/uploads/ordenes
            }

        
            //$fechaEntrada = Carbon::now('America/Lima');

            $orden = new Orden();
            $orden->idcliente = $request->idcliente;
           
            $orden->idtecnico = $request->idtecnico;
             //$orden->idusuario = Auth::user()->id;
             $orden->idusuario = $request->idusuario;
             // $orden->idusuario = 1;

            $orden->nombreEquipo = $request->nombreEquipo;
            $orden->marca = $request->marca;
            $orden->modelo = $request->modelo;
            //$orden->serial = $mytime->toDateString();
            $orden->serial = $request->serial;
            $orden->clave = $request->clave;
            $orden->accesorios = $request->accesorios;
            $orden->observaciones = $request->observaciones;
            $orden->fallaEquipo = $request->fallaEquipo;
            $orden->reparacion = $request->reparacion;
            //$orden->fechaEntrada = $fechaEntrada->toDateString();
            $orden->fechaEntrada =$request->fechaEntrada;
            $orden->fechaEntrega = $request->fechaEntrega;
            $orden->adelanto = $request->adelanto;
            $orden->totalPagar = $request->totalPagar;
            $orden->estado =$request->estado;
            $orden->imagen = $imagenRuta; // Guardar la ruta de la imagen
            $orden->save();

             return response()->json([
            'message' => 'El orden fue registrado correctamente',
            'persona' => $orden,
            'id' => $orden->id
        ], 200);

             //return [
             //   'id' => $orden->id
           // ];
           // return response()->json(['message' => 'Orden creada con éxito'], 201);
            //manda el id del ultimo ventas para imprimir compronate
           

        }
         catch (\Illuminate\Validation\ValidationException $e) {
            // Capturar errores de validación
            return response()->json([
                'message' => 'Errores de validación',
                'errors' => $e->errors()
            ], 422);

        }
        catch (\Exception $e) {
        // Capturar cualquier otro error
        return response()->json([
            'message' => 'Error en el servidor',
            'error' => $e->getMessage()
        ], 500);
    }

           
          
    }
    public function update(Request $request)
    { 
        if (!$request->ajax()) return redirect('/');
        $orden = Orden::findOrFail($request->id);
        $orden->idcliente = $request->idcliente;
        //$orden->idtecnico = Auth::user()->id;
        $orden->idtecnico = $request->idtecnico;
        $orden->idusuario = Auth::user()->id;
        $orden->nombreEquipo = $request->nombreEquipo;
        $orden->marca = $request->marca;
        $orden->modelo = $request->modelo;
        //$orden->serial = $mytime->toDateString();
        $orden->serial = $request->serial;
        $orden->clave = $request->clave;
        $orden->accesorios = $request->accesorios;
        $orden->observaciones = $request->observaciones;
        $orden->fallaEquipo = $request->fallaEquipo;
        $orden->reparacion = $request->reparacion;
        //$orden->fechaEntrada = $fechaEntrada->toDateString();
        $orden->fechaEntrada =$request->fechaEntrada;
        $orden->fechaEntrega = $request->fechaEntrega;
        $orden->adelanto = $request->adelanto;
        $orden->totalPagar = $request->totalPagar;
        $orden->estado =$request->estado;
        $orden->save();
        //dd($orden);
        
        
    }
    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $ordenes = orden::findOrFail($request->id);
        $ordenes->estado = 'Anulado';
        $ordenes->save();
    }
//buscar el comprobante

    public function buscarComprobante(Request $request){
        if (!$request->ajax()) return redirect('/');

        $filtro = $request->filtro;
       // $venta = Ventas::where('tipo_comprobante','=', $filtro)
      // $venta = Ventas::where('tipo_comprobante','=', $filtro)
       // ->select('id','tipo_comprobante','serie_comprobante','num_comprobante')
       //->max('num_comprobante')
        //->orderBy('nombre', 'asc')
        //->take(1)->get();
      //  ->first() ;
        //->get() ;
       //--------
       $venta= DB::table('ventas')
      // ->select(['id', 'tipo_comprobante', DB::raw('max(num_comprobante) AS numeroGenerado')])
       ->select( DB::raw('(max(num_comprobante)+1) as numero'))
       //->leftJoin('users_ranks AS ur', 'ur.uid', '=', 'users.id')
        //->select('id','tipo_comprobante','serie_comprobante','num_comprobante')
       ->where('tipo_comprobante', '=', $filtro)
      //->groupBy('id')
      ->take(1)->get();
      

        return ['ventas' => $venta];

    }
    //consulta de  ventas

    public function ReporteOrden(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $fechaInicio = $request->fechaInicio;
        $fechaFinal = $request->fechaFinal;
        $ordenes = Orden::join('clientes', 'orden.idcliente', '=', 'clientes.id')
        ->join('tecnicos', 'orden.idtecnico', '=', 'tecnicos.id')
        ->select(
            'orden.id',
            'clientes.id as idcliente', 
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
            'orden.estado'
        )
        ->whereBetween('fechaEntrada', [$fechaInicio, $fechaFinal])
        ->paginate(10);

        return [
            'pagination' => [
                'total'        => $ordenes->total(),
                'current_page' => $ordenes->currentPage(),
                'per_page'     => $ordenes->perPage(),
                'last_page'    => $ordenes->lastPage(),
                'from'         => $ordenes->firstItem(),
                'to'           => $ordenes->lastItem(),
            ],
            
            'ordenes' => $ordenes
        ];
    }
    public function generatePDF(Request $request,$id) {
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
        ->where('orden.id','=',$id)
        ->orderBy('orden.id','desc')->take(1)->get();

        $numOrden=Orden::select('id')->where('id',$id)->get();

        $pdf = \PDF::loadView('pdf.ordenTicket',['ordenes'=>$ordenes]);
       //$pdf ->setPaper('a4','portrait');
       $pdf->setPaper( [0, 0, 220.732,  841.89]); 
      // $pdf->setPaper( array(0,0,612.00,1008.0)); 

      //return $pdf->download('orden-'.$numOrden[0]->id.'.pdf');

     // $pdf->render();
//$pdf->stream('orden-'.$numOrden[0]->id.'.pdf');

        

        $pdf->render();
      //  return $pdf->stream();
        // Devolver el PDF como respuesta al cliente
        return response($pdf->output(), 200)
                ->header('Content-Type', 'application/pdf');
        
    }
  
    public function consultaEstadoEquipo (Request $Request, $id){
              
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
        ->where('orden.id','=',$id)
        ->orderBy('orden.id','desc')->take(1)->get();
       return ['ordenes' => $ordenes];

    }
}

