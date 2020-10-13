<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\User;

class CustomerController extends Controller
{

	// get paginated customers
  public function paginated_customers(){
  	$users= User::latest()->where('role','user')->with('usersOrder','usersWishlist')->paginate(10);

  	foreach($users as $user){
  		
	  	foreach($user->usersWishlist as $w){
	  	 	$w->product=unserialize($w->product);
	  	}
	  	foreach($user->usersOrder as $o){
	  	 	$o->products=unserialize($o->products);
	  	 	$o->products->product_image=unserialize($o->products->product_image);
	  	}
  	}

  	return $users;
  }
  // get paginated customers


  // user profile 
  public function show($id){
  	return User::findOrFail($id);
  }
  //user profile get curent user


  // all user
  public function all_user(){
    return User::latest()->get();
  }
  // all user

  // update user profile
  public function update(Request $request,$id){
  	$this->validate($request,[
  		'name'=>'required',
  		'phone_number'=>'required',
  		'address'=>'required',
  	]);
  	$user= User::findOrFail($id);

  	$user->update([
  		'name'=>$request['name'],
  		'phone_number'=>$request['phone_number'],
  		'address'=>$request['address'],
  	]);
  }
  // end update user profile
}
