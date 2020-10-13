<?php

use Illuminate\Database\Seeder;
use App\Product;

class ProductsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
      $products=array(
      	[
      	  'title'         =>'Pant',
					'price'         =>55,
					'description'   =>'This is pant for male',
      		'product_image' =>array('/images/uploads/pants-1.jpeg','/images/uploads/pants-2.jpeg'),
          'warrenty'      =>'no warrenty',
      		'category_id'   => 1 ,
      		'store_id'      => 1 ,
      	],
      	[
      	  'title'         =>'Shirt',
					'price'         =>40,
					'description'   =>'This is Shirt for male ',
      		'product_image' =>array(
								      			'/images/uploads/shirt-1.jpg',
								      			'/images/uploads/shirt-2.jpeg',
								      			'/images/uploads/shirt-3.jpg'
								      		),
          'warrenty'      =>'no warrenty',
      		'category_id'   => 1 ,
      		'store_id'      => 1 ,
      	],
      	[
      	  'title'         =>'Necklace',
					'price'         =>150,
					'description'   =>'This is necklace',
      		'product_image' =>array('/images/uploads/necklace-1.jpg','/images/uploads/necklace-2.png'),
          'warrenty'      =>'no warrenty',
      		'category_id'   => 2,
      		'store_id'      => 3,
      	],
      	[
      	  'title'         =>'Ear Rings',
					'price'         =>50,
					'description'   =>'This is Ear Rings',
      		'product_image' =>array('/images/uploads/ear-ring-1.jpg','/images/uploads/ear-ring-2.jpg'),
          'warrenty'      =>'no warrenty',
      		'category_id'   => 2,
      		'store_id'      => 3,
      	],
      	[
      	  'title'         =>'Samsung S10',
					'price'         =>1100,
					'description'   =>'This is S10',
      		'product_image' =>array(
      					             '/images/uploads/s10-1.jpg',
      					             '/images/uploads/s10-2.jpg',
      					             '/images/uploads/s10-3.webp',
      					             '/images/uploads/s10-4.jpg',
      					           ),
          'warrenty'      =>'2 years',
      		'category_id'   => 4,
      		'store_id'      => 2,
      	],
      	[
      	  'title'         =>'Iphone 11',
					'price'         =>1200,
					'description'   =>'This is Iphone 11',
      		'product_image' =>array(
								      			'/images/uploads/ip11-1.jpg',
								      			'/images/uploads/ip11-2.jpeg',
								      			'/images/uploads/ip11-3.jpg'
								      		),
          'warrenty'      =>'2 years',
      		'category_id'   => 4,
      		'store_id'      => 2,
      	],
      	[
      	  'title'         =>'Knife Set',
					'price'         =>100,
					'description'   =>'This is Knife Set',
      		'product_image' =>array('/images/uploads/knife-set-1.jpg','/images/uploads/knife-set-2.jpeg'),
          'warrenty'      =>'no warrenty',
      		'category_id'   => 3,
      		'store_id'      => 1,
      	],
      	[
      	  'title'         =>'Pan',
					'price'         =>50,
					'description'   =>'This is pan',
      		'product_image' =>array('/images/uploads/pan-1.jpg','/images/uploads/pan-2.jpeg'),
          'warrenty'      =>'no warrenty',
      		'category_id'   => 3,
      		'store_id'      => 1,
      	],
      	[
      	  'title'         =>'Jersey',
					'price'         =>50,
					'description'   =>'This is Jersey',
      		'product_image' =>array('/images/uploads/jersey-1.png'),
          'warrenty'      =>'no warrenty',
      		'category_id'   => 5,
      		'store_id'      => 4,
      	],
      	[
      	  'title'         =>'Football Boots',
					'price'         =>200,
					'description'   =>'This is footballl boots.',
      		'product_image' =>array('/images/uploads/football-boot-1.jpg'),
          'warrenty'      =>'no warrenty',
      		'category_id'   => 5,
      		'store_id'      => 4,
      	],
      
      );


      foreach ($products as $product){
      	$product_img=serialize($product['product_image']);
      	$prd=Product::create([
      		'title'         =>$product['title'],
					'price'         =>$product['price'],
					'description'   =>$product['description'],
      		'product_image' =>$product_img,
          'warrenty'      =>$product['warrenty']
	      ]);
	      $prd->productCategory()->sync($product['category_id']);
	      $prd->productStore()->sync($product['store_id']);
	    }
    }
}
