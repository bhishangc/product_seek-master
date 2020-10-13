<?php

use Illuminate\Database\Seeder;
use App\Productcategory;

class ProductcategoriesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
       $categories=array(
      	[
      		'name'=>'Clothes',
      		'slug'=>'clothes'
      	],
      	[
      		'name'=>'Accessories',
      		'slug'=>'accessories'
      	],
      	[
      		'name'=>'Kitchen',
      		'slug'=>'kitchen'
      	],
      	[
      		'name'=>'Electronics',
      		'slug'=>'electronics'
      	],
      	[
      		'name'=>'Sports',
      		'slug'=>'sports'
      	],
      );

       foreach ($categories as $category){
      	Productcategory::create([
	      	'name' =>$category['name'],
      		'slug' =>$category['slug'],
	      ]);
	    }
    }
}
