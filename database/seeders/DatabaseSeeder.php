<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

// use App\Models\Cliente;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
        // $usuario = new User();
        // $usuario->usuario="admin";
        // $usuario->password='$2y$10$CD10K3aY2qqzh0vzqmREs.8lrWQgoxN97lQJxWBm6vYtbmK0N47rK';
        // $usuario->condicion="1";
        // $usuario->save();
        DB::table('users')->insert([
            'usuario' => 'admin',
            //'password' => Str::random(10).'@gmail.com',
            // 'password' => Hash::make('password'),
            'password' => ('$2y$10$CD10K3aY2qqzh0vzqmREs.8lrWQgoxN97lQJxWBm6vYtbmK0N47rK'),
            'condicion' => (1),
        ]);

    }
}
