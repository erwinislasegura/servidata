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

        $userModel = new User();
        $user = $userModel->findByLogin((string) $this->input('login'));
        $inputPassword = (string) $this->input('password');

        $isValid = false;
        if ($user) {
            $storedPassword = (string) ($user['password'] ?? '');
            $isValid = password_verify($inputPassword, $storedPassword);

            // Compatibilidad con contraseñas en texto plano (migración automática).
            if (!$isValid && hash_equals($storedPassword, $inputPassword)) {
                $isValid = true;
                $userModel->updatePasswordById((int) $user['id'], password_hash($inputPassword, PASSWORD_DEFAULT));
            }
        }

        if (!$user || !$isValid) {
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
