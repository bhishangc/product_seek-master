<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Feedback;
use App\User;

class Feedbackcontroller extends Controller
{
  
	// json for all feedbacks
  public function index(){
  	return Feedback::latest()->paginate(10);
  }
  //json for all feed backs

  public function return_user(){
  	return User::get();
  }

}
