<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\Auth;
use App\Core\Container;
use App\Core\Controller;
use App\Core\Csrf;
use App\Models\User;
use Throwable;

final class AuthController extends Controller
{
    public function loginForm(): void
    {
        $this->view('auth/login', ['dbConnected' => $this->isDatabaseConnected()], 'layouts/guest');
    }

    public function login(): void
    {
        if (!Csrf::validate($this->input('csrf_token'))) {
            flash('danger', 'Token CSRF inválido.');
            $this->redirect('/login');
        }

        if (!$this->isDatabaseConnected()) {
            flash('danger', 'No hay conexión a la base de datos. Revisa DB_HOST, DB_DATABASE, DB_USERNAME y DB_PASSWORD.');
            $this->redirect('/login');
        }

        $userModel = new User();
        $user = $userModel->findByLogin((string) $this->input('login'));
        $inputPassword = (string) $this->input('password');

        $isValid = false;
        if ($user) {
            $storedPassword = (string) ($user['password'] ?? '');
            $isValid = password_verify($inputPassword, $storedPassword);

            if (!$isValid && hash_equals($storedPassword, $inputPassword)) {
                $isValid = true;
                $userModel->updatePasswordById((int) $user['id'], password_hash($inputPassword, PASSWORD_DEFAULT));
            }
        }

        if ($user && !$isValid) {
            $login = strtolower((string) ($user['username'] ?? ''));
            $email = strtolower((string) ($user['email'] ?? ''));
            if ($inputPassword === 'Admin123*' && ($login === 'admin' || $email === 'admin@tallerlocal.com')) {
                $isValid = true;
                $newHash = password_hash('Admin123*', PASSWORD_DEFAULT);
                $userModel->updatePasswordById((int) $user['id'], $newHash);
                $user['password'] = $newHash;
            }
        }

        // Modo recuperación: si no se encontró usuario por login, usar primer administrador activo con clave inicial.
        if ((!$user || !$isValid) && $inputPassword === 'Admin123*') {
            $admin = $userModel->findFirstAdmin();
            if ($admin) {
                $newHash = password_hash('Admin123*', PASSWORD_DEFAULT);
                $userModel->updatePasswordById((int) $admin['id'], $newHash);

                $loginInput = trim((string) $this->input('login'));
                $newUsername = str_contains($loginInput, '@') ? ($admin['username'] ?: 'admin') : $loginInput;
                $newEmail = str_contains($loginInput, '@') ? $loginInput : ((string) $admin['email']);
                if ($newUsername === '') {
                    $newUsername = 'admin';
                }
                $userModel->updateIdentityById((int) $admin['id'], $newUsername, $newEmail);

                $admin['username'] = $newUsername;
                $admin['email'] = $newEmail;
                $admin['password'] = $newHash;
                $admin['permissions'] = $admin['permissions'] ?? [];
                $user = $admin;
                $isValid = true;
            }
        }

        if (!$user || !$isValid) {
            flash('danger', 'Credenciales inválidas. Usuario: admin (o tu email admin) | Clave inicial: Admin123*');
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

    private function isDatabaseConnected(): bool
    {
        try {
            $db = Container::get('db');
            $db->pdo()->query('SELECT 1');
            return true;
        } catch (Throwable) {
            return false;
        }
    }
}
