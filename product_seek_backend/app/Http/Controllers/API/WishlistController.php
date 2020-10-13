<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Wishlist;
use App\Product;

class WishlistController extends Controller
{
  
  // add to wish list
  public function add_to_wishlist(Request $request){

  	$this->validate($request,[
  		'product_id'=>'required',
  		'user_id'=>'required',
  	]);

  	$product=Product::with('productCategory','productStore');
  	$product=$product->findOrFail($request->product_id);
  	$product->product_image=unserialize($product->product_image);

  	$product=serialize($product);
  	$wishlist=Wishlist::create([
  		'product'=>$product,
  		'user_id'=>$request['user_id']
  	]);

  	$wishlist->usersWishlist()->sync($request->user_id);
  }
  // add to wish list



  // remove from wish list
  public function remove_from_wishlist($id){
  	$wishlist=Wishlist::findOrFail($id);
  	$wishlist->delete();
  	$wishlist->usersWishlist()->detach();
  }
  // remove from wish list

// return wish  list as per user id
  public function show_wishlist($user_id){
  	 $wishlist=Wishlist::where('user_id',$user_id)->get();

  	 foreach($wishlist as $w){
  	 	$w->product=unserialize($w->product);
  	 }

  	 return $wishlist;
  }

  // return wish  list as per user id

}
