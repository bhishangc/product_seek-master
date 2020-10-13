<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Product;
use App\Productcategory;
use App\Store;
use App\User;
class APIController extends Controller
{

	// api to get all the products
  public function products(){
  	$products= Product::latest()->with('productCategory','productStore')->get();

  	foreach ($products as $product){
  		$product->product_image=unserialize($product->product_image);
  	}

    foreach ($products as $product){
      foreach($product->productStore as $store){
        $store->followers=unserialize($store->followers);
      }
    }

  	return $products;
  }
  // end api to get all the products


  // api to get all the products category
  public function categories(){
  	return Productcategory::latest()->get();
  }
  // end api to get all the products category

 // api to get all the products category by id
  public function show_category($id){
  	return Productcategory::findOrFail($id);
  }
  // end api to get all the products category by id

 // api to get all the products store by id
  public function show_store($id){
  	$store= Store::latest();
     $store= $store->findOrFail($id);
     $store->followers=unserialize($store->followers);
     return $store;
  }
  // end api to get all the products store by id


  // get all the store9
  public function stores(){
  	$stores= Store::latest()->get();
    foreach($stores as $store){
      $store->followers=unserialize($store->followers);
    }
    return $stores;
  }
  // end get all the store


  // filter by cat
  public function filter_by_cat($id){
  	$cat=Productcategory::findOrFail($id);
 		$products= Product::latest()->with('productStore','productCategory')->get();
      foreach ($products as $product){
      foreach($product->productStore as $store){
        $store->followers=unserialize($store->followers);
      }
    }
 		
 		//filtercategory
 		$products=$this->filter_product_cat($products,$cat->id);
 		//filtercategory

    foreach ($products as $product){
      $product->product_image=unserialize($product->product_image);
    }

 		return $products;
  }

  public function filter_product_cat($product,$category_id){
  	$filtered_products=[];
  	foreach($product as $p){
  		$productCategory=$p->productCategory;

  		$productCat_id=[];

  		foreach($productCategory as $pc){
  			array_push($productCat_id,$pc->id);
  		}	

  		if(in_array($category_id, $productCat_id)){
  			array_push($filtered_products,$p);
  		}

  	}
  	return $filtered_products;

  }
  // end filter by cat


  // filter by store
   public function filter_by_store($id){
  	$store=Store::findOrFail($id);
 		$products= Product::latest()->with('productStore','productCategory')->get();

    foreach ($products as $product){
      foreach($product->productStore as $store){
        $store->followers=unserialize($store->followers);
      }
    }
 		
 		//filtercategory
 		$products=$this->filter_product_store($products,$store->id);
 		//filtercategory
    foreach ($products as $product){
      $product->product_image=unserialize($product->product_image);
    }

 		return $products;
  }

  
   public function filter_product_store($product,$category_id){
  	$filtered_products=[];
  	foreach($product as $p){
  		$productCategory=$p->productStore;

  		$productCat_id=[];

  		foreach($productCategory as $pc){
  			array_push($productCat_id,$pc->id);
  		}	

  		if(in_array($category_id, $productCat_id)){
  			array_push($filtered_products,$p);
  		}

  	}
  	return $filtered_products;

  }

	// end filter by store
	

	// search product
	public function product_search($search_term){
		$products = Product::where('title', 'LIKE', "%{$search_term}%")->with('productCategory','productStore','productReview')->get();
    foreach ($products as $product){
      $product->product_image=unserialize($product->product_image);
    }
		return $products;
	}
	// end search product

  public function product_review($product_id){
    $product=Product::latest()->with('productReview');
    $product=$product->findOrFail($product_id);
    $reviews=$product->productReview;

    foreach($reviews as $r){
      $user=User::findOrFail($r->user_id);
      $r->username=$user->name;
    }

    return $reviews;
  }

  
}
