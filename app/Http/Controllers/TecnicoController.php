<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Tecnico;
class TecnicoController extends Controller
{
    public function index(Request $request)
    {
        if(!$request->ajax())return redirect('/');
        $buscar = $request->buscar;
        $criterio = $request->criterio;
        if($buscar==''){
            $tecnicos = Tecnico::orderBy('id','desc')->paginate(6);
          }
        else{
            $tecnicos = Tecnico::where($criterio, 'like','%'.$buscar.'%')->orderBy('id','desc')->paginate(6);//elocuen
        }
        //$personas =DB::table('categorias')->paginate(6);//generador de paginacio

        return [
            'pagination' =>[
                'total'   =>$tecnicos->total(),
                'current_page' => $tecnicos->currentPage(),
                'per_page' => $tecnicos->perPage(),
                'last_page' => $tecnicos->lastPage(),
                'from'=> $tecnicos->firstItem(),
                'to' => $tecnicos->lastItem(),
        ],
        'tecnicos' => $tecnicos
        ];
        //return $personas;
    }
    public function listarPdf(){
        $tecnicos = Tecnico::orderBy('id','desc')->get();

        $cont=Tecnico::count();

        $pdf = \PDF::loadView('pdf.tecnicospdf',['tecnicos'=>$tecnicos,'cont'=>$cont]);
        return $pdf->download('tecnicos.pdf');
    }
    public function selectTecnico(Request $request){
        if(!$request->ajax())return redirect('/');

         $tecnicos = Tecnico::where('condicion','=','1')
            ->select('id','nombre')->orderBy('nombre','desc')->get();

        return ['tecnicos'=>$tecnicos];
    }

    public function store(Request $request)
    {
        if(!$request->ajax())return redirect('/');
        $tecnico = new Tecnico();
        $tecnico->nombre=$request->nombre;
        $tecnico->tipo_documento=$request->tipo_documento;
        $tecnico->num_documento=$request->num_documento;
        $tecnico->direccion=$request->direccion;
        $tecnico->telefono=$request->telefono;
        $tecnico->email=$request->email;
        $tecnico->condicion='1';
        $tecnico->save();



    }
    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $tecnico = Tecnico::findOrFail($request->id);
        $tecnico->nombre = $request->nombre;
        $tecnico->tipo_documento = $request->tipo_documento;
        $tecnico->num_documento = $request->num_documento;
        $tecnico->direccion = $request->direccion;
        $tecnico->telefono = $request->telefono;
        $tecnico->email = $request->email;
        $tecnico->condicion='1';
        $tecnico->save();


    }
    public function desactivar(Request $request)
    {
        if(!$request->ajax())return redirect('/');
        $tecnico = Tecnico::findOrFail($request->id);
        $tecnico->condicion='0';
        $tecnico->save();

    }
    public function activar(Request $request)
    {
        if(!$request->ajax())return redirect('/');
        $tecnico = Tecnico::findOrFail($request->id);
        $tecnico->condicion='1';
        $tecnico->save();
    }
}
