<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Productcategory;
use App\Store;
use App\Review;

class Product extends Model
{
  use SoftDeletes;

	protected $data=['deleted_at'];

	protected $guarded=[];

	public function productCategory(){
		return $this->belongsToMany(Productcategory::class);
	}

	public function productStore(){
		return $this->belongsToMany(Store::class);
	}

	 public function productReview(){
  	return $this->belongsToMany(Review::class);
  }
}
