<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Product;

class Review extends Model
{
  protected $guarded=[];

  public function productReview(){
  	return $this->belongsToMany(Product::class);
  }
}
