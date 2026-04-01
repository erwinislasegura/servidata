<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\Auth;
use App\Core\Controller;
use App\Core\Csrf;
use App\Models\User;

final class AuthController extends Controller
{
    public function loginForm(): void
    {
        $this->view('auth/login', [], 'layouts/guest');
    }

    public function login(): void
    {
        if (!Csrf::validate($this->input('csrf_token'))) {
            flash('danger', 'Token CSRF inválido.');
            $this->redirect('/login');
        }

        $user = (new User())->findByLogin((string) $this->input('login'));
        if (!$user || !password_verify((string) $this->input('password'), $user['password'])) {
            flash('danger', 'Credenciales inválidas.');
            $this->redirect('/login');
        }

        Auth::login($user);
        $this->redirect('/dashboard');
    }

    public function logout(): void
    {
        Auth::logout();
        $this->redirect('/login');
    }
}
