<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Orden extends Model
{
    //use HasFactory;
    protected $table = 'orden';
    protected $fillable =[
        'id',
        'idcliente', 
        'idtecnico',
        'nombreEquipo',
        'marca',
        'modelo',
        'serial',
        'clave',
        'accesorios',
        'observaciones',
        'fallaEquipo',
        'reparacion',
        'fechaEntrada',
        'fechaEntrega',
        'adelanto',
        'totalPagar',
        'estado'
    ];
    public function cliente(){
        return $this->belongsTo(Cliente::class);
    }
    public function tecnico(){
        return $this->belongsTo(Tecnico::class);
    }
}
