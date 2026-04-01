<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<title>Consulta tu dispositivo en reparación</title>

</head>

<body>
    {{-- <div class="container">
        <h3 class="mt-4">Consulta el estado de tu equipo en reparación</h3>
    <div class="input-group mb-3">
        <span class="input-group-text" id="basic-addon1">Codigo de orden</span>
        <input type="text" name="search"  class="form-control form-control-xs" placeholder="codigo de orden" aria-label="codigo" aria-describedby="basic-addon1">
    </div> --}}

    {{-- @foreach ($ordenes as $orden)
        <h1>Nombre: {{ $orden['nombreEquipo'] }}</h1>
        <h1>Nombre: {{ $orden['estado'] }}</h1>
        {{-- <p>Edad: {{ $dato['edad'] }}</p> --}}
    {{-- @endforeach --}}
    </div>
    <div class="container">
        <h3 class="mt-4">Consulta el estado de tu equipo en reparación</h3>
        <div class="row">
            <div class="col-md-6 mt-3">
                <form action="/Query" method="GET">
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon1">Numero de orden:</span>
                        <input autofocus type="text" class="form-control  " name="search" placeholder=""
                            aria-label="codigo" aria-describedby="basic-addon1">


                    </div>
                    {{-- <button class="btn btn-primary" type="submit">Buscar</button> --}}
                </form>
            </div>
            <div class="col-md-6">
                @if (isset($ordenes))
                    <ul class="list-group">
                        @foreach ($ordenes as $orden)
                            <li class="list-group-item active">Tu dispositivo es: <h4>{{ $orden->nombreEquipo }}</h4>
                            </li>
                            <li class="list-group-item ">marca: <h3>{{ $orden->marca . ' - ' . $orden->modelo }}</h3>
                            </li>
                            <li class="list-group-item">fecha de ingreso: {{ $orden->fechaEntrada }}</li>
                            <li class="list-group-item ">Estado: <span
                                    class="badge text-bg-primary">{{ $orden->estado }}</span> </li>
                        @endforeach
                    </ul>
                @endif
            </div>
        </div>


    </div>

</body>

</html>-
