<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\User;

class Order extends Model
{
  protected $table='orders';
  protected $guarded=[];

  public function usersOrder(){
  	return $this->belongsToMany(User::class);
  }
}
