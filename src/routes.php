<?php

$router->get('/', 'AuthController@loginForm', false);
$router->get('/login', 'AuthController@loginForm', false);
$router->post('/login', 'AuthController@login', false);
$router->get('/logout', 'AuthController@logout');

$router->get('/portal', 'PortalController@searchForm', false);
$router->post('/portal/search', 'PortalController@searchResult', false);

$router->get('/dashboard', 'DashboardController@index');
$router->get('/customers', 'CustomerController@index');
$router->post('/customers/create', 'CustomerController@create');
$router->get('/devices', 'DeviceController@index');
$router->post('/devices/create', 'DeviceController@create');
$router->get('/orders', 'OrderController@index');
$router->get('/diagnostics', 'DiagnosticController@index');
$router->get('/quotations', 'QuotationController@index');
$router->get('/technicians', 'TechnicianController@index');
$router->get('/inventory', 'InventoryController@index');
$router->get('/payments', 'PaymentController@index');
$router->get('/receipts', 'ReceiptController@index');
$router->get('/reports', 'ReportController@index');
$router->get('/users', 'UserController@index');
$router->get('/audit', 'AuditController@index');
