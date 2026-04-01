<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::group(['middleware' => ['guest']], function () {

    Route::get('/login', [App\Http\Controllers\Auth\LoginController::class, 'showLoginForm']);
    Route::get('/', [App\Http\Controllers\Auth\LoginController::class, 'showLoginForm']);
    //Route::get('/login',[App\Http\Controllers\Auth\LoginController::class,'showLoginForm'])->name('login');
    //Route::post('/login', 'Auth\LoginController@login')->name('login');
    Route::post('/login', [App\Http\Controllers\Auth\LoginController::class, 'login'])->name('login');

    //Route::get('/ordenestado/{id}', [App\Http\Controllers\OrdenController::class,'consultaEstadoEquipo']);

    Route::get('/Query/', [App\Http\Controllers\ConsultaController::class, 'consultaEstadoEquipo']);
});



Route::group(['middleware' => ['auth']], function () {



    Route::get('/main', function () {//aqui cambie de main a nada
        return view('contenido/contenido');
    })->name('main');

    Route::group(['middleware' => ['Tecnico']], function () {
        //clientes
        Route::get('cliente', [App\Http\Controllers\ClienteController::class, 'index'])->name('cliente');
        Route::post('/cliente/registrar', [App\Http\Controllers\ClienteController::class, 'store']);
        Route::put('/cliente/actualizar', [App\Http\Controllers\ClienteController::class, 'update']);
        Route::put('/cliente/desactivar', [App\Http\Controllers\ClienteController::class, 'desactivar']);
        Route::put('/cliente/activar', [App\Http\Controllers\ClienteController::class, 'activar']);
        Route::get('/cliente/selectCliente', [App\Http\Controllers\ClienteController::class, 'selectCliente']);
        Route::get('/cliente/listarPdf', [App\Http\Controllers\ClienteController::class, 'listarPdf'])->name('clientes_pdf');

        // orden
        Route::get('orden', [App\Http\Controllers\OrdenController::class, 'index'])->name('orden');
        Route::get('ordentecnico', [App\Http\Controllers\OrdenController::class, 'indextecnico'])->name('ordentecnico');
        Route::post('/orden/registrar', [App\Http\Controllers\OrdenController::class, 'store']);
        Route::put('/orden/actualizar', [App\Http\Controllers\OrdenController::class, 'update']);
        //Route::get('/orden/pdf/{id}', 'VentaController@pdf')->name('venta_pdf');//para reportes de comprobante
        Route::get('/orden/pdf/{id}', [App\Http\Controllers\OrdenController::class, 'pdf'])->name('orden_pdf');//para reportes de comprobante
        //repote rango de fechas
        Route::get('/orden/reportes', [App\Http\Controllers\OrdenController::class, 'ReporteOrden']);
        //practicando 
        Route::get('/orden1/pdf/{id}', [App\Http\Controllers\OrdenController::class, 'generatePDF']);

        //dashboard
        Route::get('/dashboard', [App\Http\Controllers\DashboardController::class, '__invoke']);

    });

    //----ruta administrador
    Route::group(['middleware' => ['Administrador']], function () {
        //clientes
        Route::get('cliente', [App\Http\Controllers\ClienteController::class, 'index'])->name('cliente');
        Route::post('/cliente/registrar', [App\Http\Controllers\ClienteController::class, 'store']);
        Route::put('/cliente/actualizar', [App\Http\Controllers\ClienteController::class, 'update']);
        Route::put('/cliente/desactivar', [App\Http\Controllers\ClienteController::class, 'desactivar']);
        Route::put('/cliente/activar', [App\Http\Controllers\ClienteController::class, 'activar']);
        Route::get('/cliente/selectCliente', [App\Http\Controllers\ClienteController::class, 'selectCliente']);
        Route::get('/cliente/listarPdf', [App\Http\Controllers\ClienteController::class, 'listarPdf'])->name('clientes_pdf');

        //tecnicos

        Route::get('tecnico', [App\Http\Controllers\TecnicoController::class, 'index'])->name('tecnico');
        Route::post('/tecnico/registrar', [App\Http\Controllers\TecnicoController::class, 'store']);
        Route::put('/tecnico/actualizar', [App\Http\Controllers\TecnicoController::class, 'update']);
        Route::put('/tecnico/desactivar', [App\Http\Controllers\TecnicoController::class, 'desactivar']);
        Route::put('/tecnico/activar', [App\Http\Controllers\TecnicoController::class, 'activar']);
        Route::get('/tecnico/selectTecnico', [App\Http\Controllers\TecnicoController::class, 'selectTecnico']);
        Route::get('/tecnico/listarPdf', [App\Http\Controllers\TecnicoController::class, 'listarPdf'])->name('tecnicos_pdf');

        // orden
        Route::get('orden', [App\Http\Controllers\OrdenController::class, 'index'])->name('orden');
        Route::post('/orden/registrar', [App\Http\Controllers\OrdenController::class, 'store']);
        Route::put('/orden/actualizar', [App\Http\Controllers\OrdenController::class, 'update']);
        //Route::get('/orden/pdf/{id}', 'VentaController@pdf')->name('venta_pdf');//para reportes de comprobante
        Route::get('/orden/pdf/{id}', [App\Http\Controllers\OrdenController::class, 'pdf'])->name('orden_pdf');//para reportes de comprobante
        //repote rango de fechas
        Route::get('/orden/reportes', [App\Http\Controllers\OrdenController::class, 'ReporteOrden']);
        //practicando 
        Route::get('/orden1/pdf/{id}', [App\Http\Controllers\OrdenController::class, 'generatePDF']);

        //dashboard
        Route::get('/dashboard', [App\Http\Controllers\DashboardController::class, '__invoke']);
        //logout
        //Route::post('/logout', [App\Http\Controllers\Auth\LoginController::class,'logout'])->name('logout');

        Route::post('/logout', [App\Http\Controllers\Auth\LoginController::class, 'logout'])->name('logout');
    });

    //users
    Route::get('/user', [App\Http\Controllers\UserController::class, 'index']);
    Route::get('/user/selectuser', [App\Http\Controllers\UserController::class, 'selectUser']);
    //Route::get('user', [UserController::class, 'index'])->name('user');
    Route::post('/user/registrar', [App\Http\Controllers\UserController::class, 'store']);
    Route::put('/user/actualizar', [App\Http\Controllers\UserController::class, 'update']);
    Route::put('/user/desactivar', [App\Http\Controllers\UserController::class, 'desactivar']);
    Route::put('/user/activar', [App\Http\Controllers\UserController::class, 'activar']);

    //Roles
    Route::get('/rol', [App\Http\Controllers\RolController::class, 'index'])->name('roles');
    Route::get('rol/selectRol', [App\Http\Controllers\RolController::class, 'selectRol']);

    //imagenorden
    Route::post('/api/upload-image', [App\Http\Controllers\ImageController::class, 'store']);
    //genera codigo qr
    Route::get('api/barcode/{text}', [App\Http\Controllers\BarcodeController::class, 'generate']);
    //envio de mensaje a whatsapp
    Route::get('msg', [App\Http\Controllers\MensajeController::class, 'msg']);

});



//Auth::routes();


//Route::post('/logout', [App\Http\Controllers\Auth\LoginController::class,'logout'])->name('logout');

