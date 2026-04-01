<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orden', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('idcliente')->unsigned();
            $table->foreign('idcliente')->references('id')->on('clientes');
            $table->integer('idtecnico')->unsigned();
            $table->foreign('idtecnico')->references('id')->on('tecnicos');
             $table->integer('idusuario')->unsigned();
            $table->foreign('idusuario')->references('id')->on('users');
            $table->string('nombreEquipo', 100);
            $table->string('marca', 50);
            $table->string('modelo', 50);
            $table->string('serial', 50);
            $table->string('clave', 50);
            $table->string('accesorios', 150);
            $table->string('observaciones', 150);
            $table->string('fallaEquipo', 150);
            $table->string('reparacion', 200);
            $table->dateTime('fechaEntrada');
            $table->dateTime('fechaEntrega');
            $table->decimal('adelanto', 11, 2);
            $table->decimal('totalPagar', 11, 2);            
            $table->string('estado', 60);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orden');
    }
};
