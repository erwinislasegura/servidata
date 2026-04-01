<?php

declare(strict_types=1);

namespace App\Core;

final class Container
{
    private static array $items = [];

    public static function set(string $key, mixed $value): void
    {
        self::$items[$key] = $value;
    }

    public static function get(string $key): mixed
    {
        if (!array_key_exists($key, self::$items)) {
            return null;
        }

        if (self::$items[$key] instanceof \Closure) {
            self::$items[$key] = (self::$items[$key])();
        }

        return self::$items[$key];
    }
}
