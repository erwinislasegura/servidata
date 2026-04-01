<?php

declare(strict_types=1);

namespace App\Models;

use App\Core\Container;
use App\Core\Database;
use PDO;

abstract class BaseModel
{
    protected PDO $db;

    public function __construct()
    {
        /** @var Database $database */
        $database = Container::get('db');
        $this->db = $database->pdo();
    }
}
