const mix = require('laravel-mix');

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */mix.styles([
    'resources/css/font-awesome.min.css',
    'resources/css/simple-line-icons.min.css',   
    'resources/css/bootstrap.min.css',
    'resources/css/style.css',
    'resources/css/main.css'
 
 ], 'public/css/plantilla.css');
 
 mix.scripts([
    'resources/js/jquery.min.js',
    'resources/js/popper.min.js',
    'resources/js/bootstrap.min.js',
    'resources/js/Chart.min.js',   
    'resources/js/pace.min.js',   
    'resources/js/template.js',
    'resources/js/sweetalert2.all.min.js'
 
 ], 'public/js/plantilla.js');
 


mix.js('resources/js/app.js', 'public/js')
    .vue()
    .sass('resources/sass/app.scss', 'public/css');
