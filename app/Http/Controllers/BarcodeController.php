<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Picqer\Barcode\BarcodeGeneratorPNG;


class BarcodeController extends Controller
{
    // metodo para generar codigo qr
    public function generate($text)
    {
        $generator = new BarcodeGeneratorPNG();
        $code = $generator->getBarcode($text, $generator::TYPE_CODE_128);
        
        // Puedes devolver la imagen directamente
        return response($code, 200)
                  ->header('Content-Type', 'image/png');
    }
}
