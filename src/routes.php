<?php

$router->get('/', 'AuthController@loginForm', false);
$router->get('/login', 'AuthController@loginForm', false);
$router->post('/login', 'AuthController@login', false);
$router->get('/logout', 'AuthController@logout');

$router->get('/dashboard', 'DashboardController@index');
$router->get('/customers', 'CustomerController@index');
$router->post('/customers/create', 'CustomerController@create');
$router->get('/orders', 'OrderController@index');
$router->post('/orders/create', 'OrderController@create');
$router->post('/orders/customers/create', 'OrderController@createCustomer');
$router->get('/technicians', 'TechnicianController@index');
$router->get('/users', 'UserController@index');
$router->get('/settings', 'SettingController@index');
