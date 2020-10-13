<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Feedback;

class FeedbackController extends Controller
{
	// create feedback
	public function store(Request $request){
		$this->validate($request,[
			'feedback'=>'required',
		]);

		$feedback=Feedback::create([
			'feedback'=>$request['feedback'],
			'user_id'=>$request['user_id'],
		]);

	}//create feedback

	//update feedback
	public function update(Request $request,$id){
		$feedback=Feedback::findOrFail($id);
		$this->validate($request,[
			'feedback'=>'required',
		]);
		$feedback->update([
			'feedback'=>$request['feedback'],
		]);
	}
	//update feed back

	public function getFeedback($user_id){
		return Feedback::where('user_id',$user_id)->first();
	}

}
