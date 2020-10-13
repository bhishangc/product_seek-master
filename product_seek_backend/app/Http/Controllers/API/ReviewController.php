<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Review;
use App\Product;
class ReviewController extends Controller
{
   
  public function addReview(Request $request){

  	$this->validate($request,[
  		'review'=>'required',
  		'user_id'=>'required',
  		'product_id'=>'required',
  	]);

  	$review = Review::create([
  		'review'=> $request['review'],
  		'user_id'=>$request['user_id']
  	]);


  	$review->productReview()->sync($request['product_id']);
   	
  }

  public function delete_review($review_id){
  	$review=Review::findOrFail($review_id);
  	$review->delete();
  	$review->productReview()->detach();
  }

  public function update_review(Request $request,$review_id){
  	$this->validate($request,[
  		'review'=>'required',
  	]);


  	$review=Review::findOrFail($review_id);
  	$review->update([
  		'review'=>$request['review'],
  	]);
   }

   public function get_review_product_user(Request $request){

      $product_id=$request->product_id;

      $product=Product::latest()->with('productReview');
      $product=$product->findOrFail($product_id);
      $product_reviews=$product->productReview;

      $filtered_reviews=[];

      foreach($product_reviews as $r){
        if($r->user_id==$request->user_id){
          array_push($filtered_reviews,$r);
        }
      }


      return $filtered_reviews;
   }
}
