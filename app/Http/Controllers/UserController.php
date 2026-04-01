<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\User;
use App\Models\Tecnico;
class UserController extends Controller
{
    
     public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
 
        $buscar = $request->buscar;
        $criterio = $request->criterio;
         
        if ($buscar==''){
            $tecnicos = User::join('tecnicos','users.idtecnico','=','tecnicos.id')
            ->join('roles','users.idrol','=','roles.id')
            ->select('tecnicos.id','tecnicos.nombre','tecnicos.tipo_documento',
            'tecnicos.num_documento','tecnicos.direccion','tecnicos.telefono',
            'tecnicos.email','users.usuario','users.password',
            'users.condicion','users.idrol','roles.nombre as rol','users.idtecnico')
            ->orderBy('tecnicos.id', 'desc')->paginate(10);
        }
        else{
            $tecnicos = User::join('tecnicos','users.idtecnico','=','tecnicos.id')
            ->join('roles','users.idrol','=','roles.id')
            ->select('tecnicos.id','tecnicos.nombre','tecnicos.tipo_documento',
            'tecnicos.num_documento','tecnicos.direccion','tecnicos.telefono',
            'tecnicos.email','users.usuario','users.password',
            'users.condicion','users.idrol','roles.nombre as rol','users.idtecnico')            
            ->where('tecnicos.'.$criterio, 'like', '%'. $buscar . '%')
            ->orderBy('tecnicos.id', 'desc')->paginate(4);
        }
         
 
        return [
            'pagination' => [
                'total'        => $tecnicos->total(),
                'current_page' => $tecnicos->currentPage(),
                'per_page'     => $tecnicos->perPage(),
                'last_page'    => $tecnicos->lastPage(),
                'from'         => $tecnicos->firstItem(),
                'to'           => $tecnicos->lastItem(),
            ],
            'tecnicos' => $tecnicos
        ];
    }

    public function selectUser(Request $request){
        if(!$request->ajax())return redirect('/');
        $filtro = $request->filtro;
       /* $users = User::where('condicion','=','1')
        ->select('id','usuario')->orderBy('id','desc')->get();

        return ['users'=>$users];*/
         $users = User::join('tecnicos','users.id','=','tecnicos.id')
            ->join('roles','users.idrol','=','roles.id')
            ->select('tecnicos.id','tecnicos.nombre','tecnicos.tipo_documento',
            'tecnicos.num_documento','tecnicos.direccion','tecnicos.telefono',
            'tecnicos.email',
            'users.condicion','users.idrol','users.id as idusuario','roles.nombre as rol')            
           ->where('tecnicos.id', '=', $filtro)
            ->orderBy('tecnicos.id', 'desc')->get();
             return ['users'=>$users];
    }
     public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
         
        try{
            DB::beginTransaction();
            //registra el tecnico
            $tecnico = new Tecnico();
            $tecnico->nombre = $request->nombre;
            $tecnico->tipo_documento = $request->tipo_documento;
            $tecnico->num_documento = $request->num_documento;
            $tecnico->direccion = $request->direccion;
            $tecnico->telefono = $request->telefono;
            $tecnico->email = $request->email;
            $tecnico->save();
            //registra usuario
            $user = new User();
            $user->usuario = $request->usuario;
            $user->password = bcrypt( $request->password);
            $user->condicion = '1';
            $user->idrol = $request->idrol; 
            $user->id= $tecnico->id;         
 
            $user->idtecnico =$tecnico->id ;
 
            $user->save();
 
            DB::commit();
 
        } catch (Exception $e){
            DB::rollBack();
        }
 
         
         
    }
     public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
         
        try{
            DB::beginTransaction();
 
            //Buscar primero el usuario a modificar
            $user = User::findOrFail($request->id);
 
            $tecnico = Tecnico::findOrFail($user->id);
 
            $tecnico->nombre = $request->nombre;
            $tecnico->tipo_documento = $request->tipo_documento;
            $tecnico->num_documento = $request->num_documento;
            $tecnico->direccion = $request->direccion;
            $tecnico->telefono = $request->telefono;
            $tecnico->email = $request->email;
            $tecnico->save();
 
             
            $user->usuario = $request->usuario;
            $user->password = bcrypt( $request->password);
            $user->condicion = '1';
            $user->idrol = $request->idrol;
            $user->idtecnico = $request->idtecnico;
            $user->save();
 
 
            DB::commit();
 
        } catch (Exception $e){
            DB::rollBack();
        }
 
    }
     public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $user = User::findOrFail($request->id);
        $user->condicion = '0';
        $user->save();
    }
 
    public function activar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $user = User::findOrFail($request->id);
        $user->condicion = '1';
        $user->save();
    }
}
