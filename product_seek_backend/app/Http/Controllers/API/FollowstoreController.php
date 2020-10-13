<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\User;
use App\Store;

class FollowstoreController extends Controller
{
	//follow store function
  public function user_follow(Request $request){
  	$this->validate($request,[
  		'user_id' => 'required',
  		'store_id' => 'required',
  	]);

  	$store=Store::findOrFail($request['store_id']);
   
    $store_followers=[];
    if($store->followers){
      $store_followers=unserialize($store->followers);
      array_push($store_followers,$request['user_id']);
      $store_followers=serialize($store_followers);
    }else{
       $store_followers=serialize(array($request['user_id']));
    }

  	$store->update([
      'followers'=>$store_followers,
    ]);

    $store->userFollow()->sync(unserialize($store_followers));
  }
  //follow store function


  // unfollow store funtion
  public function user_unfollow(Request $request){
  	$this->validate($request,[
  		'user_id' => 'required',
  		'store_id' => 'required',
  	]);
		$store=Store::findOrFail($request['store_id']);
    $store_followers=unserialize($store->followers);

		if (($key = array_search($request['user_id'], $store_followers)) !== false) {
      unset($store_followers[$key]);
    }

    $store->update([
      'followers'=>serialize($store_followers),
    ]);
  }
  // end unfollow store function


  public function userFollowedStore($user_id){
    $user=User::latest()->with('userFollow');
    $user=$user->findOrFail($user_id);

    return $user->userFollow;
  }
}
