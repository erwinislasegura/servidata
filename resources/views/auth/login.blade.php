@extends('auth.contenido')

@section('login')

<div class="row justify-content-center">
  
      <div class=" col-md-6 col-12 col-lg-6">
        <div id="radius-shape-1" class="position-absolute rounded-circle shadow-5-strong "></div>
        <div id="radius-shape-2" class="position-absolute shadow-5-strong "></div>
        <div class="card-group bg-glass mb-0">
          <div class="card  p-4">
          <form class="form-horizontal  was-validated" method="POST" action="{{ route('login')}}">
          {{ csrf_field() }}
              <div class="card-body">
              <h1 class="text-center">Acceder</h1>
              <p class="text-center">Control de acceso al sistema</p>
              
              
              <div class="form-group mb-3 {{$errors->has('usuario' ? 'is-invalid' : '')}}">
                <label for="">Usuario <i class="icon-user"></i></label>
                {{-- <span class="input-group-addon"><i class="icon-user"></i></span> --}}
                <input type="text" value="{{old('usuario')}}" name="usuario" id="usuario" class="form-control" placeholder="Usuario">
                {!!$errors->first('usuario','<span class="invalid-feedback">:message</span>')!!}

              </div>
              <div class="form-group mb-4 {{$errors->has('password' ? 'is-invalid' : '')}}">
                <label for="">Password <i class="icon-lock"></i></label>
                {{-- <span class="input-group-addon"><i class="icon-lock"></i></span> --}}
                <input type="password" name="password" id="password" class="form-control" placeholder="Password">
                {!!$errors->first('password','<span class="invalid-feedback">:message</span>')!!}

              </div>
              <div class="row">
                <div class="col-12">
                  <button type="submit" class="btn btn-primary btn-lg btn-block ">Acceder</button>
                </div>
              </div>
            </div>
          </form>
          </div>
          
          <div class="card text-white bg-primary py-6 d-md-down-none" style="width:40%">
            <div class="card-body text-center">
              <div class="">
                <img class="img-fluid rounded-circle" src="img/login.png" alt="cpiprodesign">
              </div>
              <div>
                <h4>AppTaller </h4>
                <p>Sistema de gestión para administrar tu taller </p>
                <a href="https://cpiprodesign.com" target="_blank" class="btn btn-danger active mt-3">más detalles!</a>
              </div>
            </div>
          </div>
        </div>
        <div class="posicion text-center">
          <p class=" blanco   ">© Copyright 2024. Todos los derechos reservados</p>
      </div>
      </div>
    </div>
   
@endsection
