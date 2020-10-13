<?php

use Illuminate\Database\Seeder;
use App\Store;

class storesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
      $stores=array(
      	[
      		'name'           =>'Country Classics Australia',
      		'email'          =>'uggcountryclassics@gmail.com',
      		'contact'        =>'+61292614451',
          'store_image'    =>'/images/store/1.jpg',
      		'address'        =>'46H4+6P Sydney, New South Wales, Australia',
      		'google_maps_url'=>'https://goo.gl/maps/Xpbcg8mcXxkf6MWS9',
          'followers'      =>serialize(array())
      	],
      	[
      		'name'           =>'Dymocks Sydney',
      		'email'          =>'dymocks@gmail.com',
      		'contact'        =>'+61292350155',
          'store_image'    =>'/images/store/2.jpg',
      		'address'        =>'46J4+3R Sydney, New South Wales, Australia',
      		'google_maps_url'=>'https://goo.gl/maps/ToDTeCtMoGxpHLzx6',
          'followers'      =>serialize(array()),
      	],
      	[
      		'name'           =>'Volle Jewellery Sydney',
      		'email'          =>'vollejeweller@gmail.com',
      		'contact'        =>'+61292690898',
          'store_image'    =>'/images/store/3.jpg',
      		'address'        =>'46G4+XG Sydney, New South Wales, Australia',
      		'google_maps_url'=>'https://goo.gl/maps/2aWH4KY5nwR1GqXs8',
          'followers'      =>serialize(array()),
      	],
      	[
      		'name'           =>'Sportscraft Westfield Sydney',
      		'email'          =>'uggcountryclassics@gmail.com',
      		'contact'        =>'+61292328894',
          'store_image'    =>'/images/store/4.jpg',
      		'address'        =>'Shop/2049 Market St, Sydney NSW 2000, Australia',
      		'google_maps_url'=>'https://goo.gl/maps/GftL5kAHfLrL8t8U6',
          'followers'      =>serialize(array()),
      	],

      );
      
      foreach ($stores as $store){
      	Store::create([
	      	'name'            =>$store['name'],
	      	'email'           =>$store['email'],
      		'contact'         =>$store['contact'],
          'store_image'     =>$store['store_image'],
          'followers'       =>$store['followers'],
      		'address'         =>$store['address'],
      		'google_maps_url' =>$store['google_maps_url']
	      ]);
	    }


    }
}
