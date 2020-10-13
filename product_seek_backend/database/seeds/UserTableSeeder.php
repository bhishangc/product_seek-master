<?php

use Illuminate\Database\Seeder;
use App\User;
use Illuminate\Support\Facades\Hash;

class UserTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
      $users=array(
      	[
      		'name'         =>'Administration',
      		'email'        =>'admin@admin.com',
      		'phone_number' =>'123456789',
      		'address'      =>'Sydney Australia',
      		'role'				 =>'admin',
      		'password'		 =>'123456789'
      	],
      	
      );

      foreach ($users as $user){
      	User::create([
	      	'name'         =>$user['name'],
      		'email'        =>$user['email'],
      		'phone_number' =>$user['phone_number'],
      		'address'      =>$user['address'],
      		'role'				 =>$user['role'],
      		'password'		 =>Hash::make($user['password'])
	      ]);
	    }
    }
}
