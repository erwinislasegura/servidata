<?php

declare(strict_types=1);

namespace App\Models;

use PDOException;

final class User extends BaseModel
{
    public function findByLogin(string $login): ?array
    {
        try {
            $stmt = $this->db->prepare('SELECT u.*, r.name AS role_name FROM users u JOIN roles r ON r.id=u.role_id WHERE (u.username=:login OR u.email=:login) AND u.status=1 LIMIT 1');
            $stmt->execute(['login' => $login]);
            $user = $stmt->fetch();

            if (!$user) {
                return null;
            }

            try {
                $permStmt = $this->db->prepare('SELECT p.key_name FROM permissions p JOIN role_permissions rp ON rp.permission_id=p.id WHERE rp.role_id=:role');
                $permStmt->execute(['role' => $user['role_id']]);
                $user['permissions'] = array_column($permStmt->fetchAll(), 'key_name');
            } catch (PDOException) {
                $user['permissions'] = [];
            }

            return $user;
        } catch (PDOException) {
            return null;
        }
    }


    public function updatePasswordById(int $id, string $hashedPassword): void
    {
        try {
            $stmt = $this->db->prepare('UPDATE users SET password=:password, updated_at=NOW() WHERE id=:id');
            $stmt->execute(['password' => $hashedPassword, 'id' => $id]);
        } catch (PDOException) {
            // no-op en modo resiliente
        }
    }

    public function all(): array
    {
        try {
            return $this->db->query('SELECT u.id,u.username,u.email,u.status,r.name role FROM users u JOIN roles r ON r.id=u.role_id ORDER BY u.id DESC')->fetchAll();
        } catch (PDOException) {
            return [];
        }
    }
}
