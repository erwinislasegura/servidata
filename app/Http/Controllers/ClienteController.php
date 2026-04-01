<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Cliente;
use App\Http\Controllers\ClienteController;
class ClienteController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax())
            return redirect('/');
        $buscar = $request->buscar;
        $criterio = $request->criterio;
        if ($buscar == '') {
            $clientes = Cliente::orderBy('id', 'desc')->paginate(10);
        } else {
            $clientes = Cliente::where($criterio, 'like', '%' . $buscar . '%')
                ->orderBy('id', 'desc')->paginate(6);//elocuen
        }
        //$personas =DB::table('categorias')->paginate(6);//generador de paginacio

        return [
            'pagination' => [
                'total' => $clientes->total(),
                'current_page' => $clientes->currentPage(),
                'per_page' => $clientes->perPage(),
                'last_page' => $clientes->lastPage(),
                'from' => $clientes->firstItem(),
                'to' => $clientes->lastItem(),
            ],
            'clientes' => $clientes
        ];
        //return $personas;
    }
    public function listarPdf()
    {
        $clientes = Cliente::orderBy('id', 'desc')->get();

        $cont = Cliente::count();

        $pdf = \PDF::loadView('pdf.clientespdf', ['clientes' => $clientes, 'cont' => $cont]);
        return $pdf->download('clientes.pdf');
    }
    public function selectCliente(Request $request)
    {
        if (!$request->ajax())
            return redirect('/');

        $clientes = Cliente::where('condicion', '=', '1')
            ->select('id', 'nombre')->orderBy('id', 'desc')->get();

        return ['clientes' => $clientes];
    }

    public function store(Request $request)
    {
        if (!$request->ajax())
            return redirect('/');
        $cliente = new Cliente();
        $cliente->nombre = $request->nombre;
        $cliente->tipo_documento = $request->tipo_documento;
        $cliente->num_documento = $request->num_documento;
        $cliente->direccion = $request->direccion;
        $cliente->telefono = $request->telefono;
        $cliente->email = $request->email;
        $cliente->condicion = '1';
        $cliente->save();



    }
    public function update(Request $request)
    {
        if (!$request->ajax())
            return redirect('/');
        $cliente = Cliente::findOrFail($request->id);
        $cliente->nombre = $request->nombre;
        $cliente->tipo_documento = $request->tipo_documento;
        $cliente->num_documento = $request->num_documento;
        $cliente->direccion = $request->direccion;
        $cliente->telefono = $request->telefono;
        $cliente->email = $request->email;
        $cliente->condicion = '1';
        $cliente->save();


    }
    public function desactivar(Request $request)
    {
        if (!$request->ajax())
            return redirect('/');
        $cliente = Cliente::findOrFail($request->id);
        $cliente->condicion = '0';
        $cliente->save();

    }
    public function activar(Request $request)
    {
        if (!$request->ajax())
            return redirect('/');
        $cliente = Cliente::findOrFail($request->id);
        $cliente->condicion = '1';
        $cliente->save();
    }
}
