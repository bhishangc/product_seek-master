<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\User;
class Wishlist extends Model
{
	protected $table='wishlists';
  protected $guarded=[];

  public function usersWishlist(){
  	return $this->belongsToMany(User::class);
  }
}
