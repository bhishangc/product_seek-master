<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Product;

class Productcategory extends Model
{
  use SoftDeletes;

	protected $data=['deleted_at'];

	protected $guarded=[];

	public function productCategory(){
		return $this->belongsToMany(Product::class);
	}
}
