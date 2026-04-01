<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\Request;

class ImageController extends Controller
{
    public function store(Request $request)
    {
        // Validar que se reciba la imagen en base64
        $request->validate([
            'image' => 'required|string',
        ]);

        // Decodificar la imagen en base64
        $imageData = $request->input('image');
        $image = base64_decode(preg_replace('/^data:image\/\w+;base64,/', '', $imageData));

        // Crear un nombre único para el archivo
        $imageName = uniqid() . '.png';

        // Guardar la imagen en el almacenamiento local
        Storage::disk('public')->put('images/' . $imageName, $image);

        return response()->json(['message' => 'Imagen guardada exitosamente', 'path' => $imageName]);
    }

}
