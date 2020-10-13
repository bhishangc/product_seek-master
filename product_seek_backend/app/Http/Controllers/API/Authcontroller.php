<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\User;
use Illuminate\Support\Facades\Hash;
// use Illuminate\Validation\Validator;
use Illuminate\Support\Facades\Password;
use Validator;
class Authcontroller extends Controller
{
    public function register(Request $request){

      $validateUser=$this->validate($request,[
        'name'=>['required'],
        'email'=>['email','required'],
        'password'=>['required','confirmed'],
        'address'=>['required'],
        'phone_number'=>'required',
        'role'=>['required']
      ]);

      $validateUser['password']= Hash::make($validateUser['password']);

      $user=User::create($validateUser);

      $accessToken= $user->createToken('authToken')->accessToken;

      return response(['user'=>$user,'access_token'=>$accessToken]);

    }

    public function login(Request $request){
      $loginData=$this->validate($request,[
        'email'=>'email|required',
        'password'=>'required',
      ]);

      if(!auth()->attempt($loginData)){
        return response(['message'=>'Invalid Credentials']);
      }

      $accessToken= auth()->user()->createToken('authToken')->accessToken;

      return response(['user'=>auth()->user(),'access_token'=>$accessToken]);

    }

    public function update(Request $request,$id){
       $validateUser=$this->validate($request,[
        'name'=>['required'],
        'email'=>['email','required'],
        'password'=>['required'],
        'address'=>['required'],
        'phone_number'=>'required',
      ]);

       $user=User::findOrFail($id);
      
         if(Hash::check($request->password, $user->password)){
           $user->update(
            [
              'name'=>$request['name'],
              'email'=>$request['email'],
              'address'=>$request['address'],
              'phone_number'=>$request['phone_number'],
            ]);
          $accessToken= $user->createToken('authToken')->accessToken;
          return response(['user'=>$user,'access_token'=>$accessToken]);
         }else{
            $message=[
              "message"=>"The given password is incorrect."
            ];
          
           return $message;
         }

    }

public function forgot_password(Request $request)
{
    $input = $request->all();
    $rules = array(
        'email' => "required|email",
    );
    $validator = Validator::make($input, $rules);
    if ($validator->fails()) {
        $arr = array("status" => 400, "message" => $validator->errors()->first(), "data" => array());
    } else {
        try {
            $response = Password::sendResetLink($request->only('email'), function (Message $message) {
                $message->subject($this->getEmailSubject());
            });
            switch ($response) {
                case Password::RESET_LINK_SENT:
                    return \Response::json(array("status" => 200, "message" => trans($response), "data" => array()));
                case Password::INVALID_USER:
                    return \Response::json(array("status" => 400, "message" => trans($response), "data" => array()));
            }
        } catch (\Swift_TransportException $ex) {
            $arr = array("status" => 400, "message" => $ex->getMessage(), "data" => []);
        } catch (Exception $ex) {
            $arr = array("status" => 400, "message" => $ex->getMessage(), "data" => []);
        }
    }
    return \Response::json($arr);
}

// public function change_password(Request $request)
// {
//     $input = $request->all();
//     $userid = Auth::guard('api')->user()->id;
//     $rules = array(
//         'old_password' => 'required',
//         'new_password' => 'required|min:6',
//         'confirm_password' => 'required|same:new_password',
//     );
//     $validator = Validator::make($input, $rules);
//     if ($validator->fails()) {
//         $arr = array("status" => 400, "message" => $validator->errors()->first(), "data" => array());
//     } else {
//         try {
//             if ((Hash::check(request('old_password'), Auth::user()->password)) == false) {
//                 $arr = array("status" => 400, "message" => "Check your old password.", "data" => array());
//             } else if ((Hash::check(request('new_password'), Auth::user()->password)) == true) {
//                 $arr = array("status" => 400, "message" => "Please enter a password which is not similar then current password.", "data" => array());
//             } else {
//                 User::where('id', $userid)->update(['password' => Hash::make($input['new_password'])]);
//                 $arr = array("status" => 200, "message" => "Password updated successfully.", "data" => array());
//             }
//         } catch (\Exception $ex) {
//             if (isset($ex->errorInfo[2])) {
//                 $msg = $ex->errorInfo[2];
//             } else {
//                 $msg = $ex->getMessage();
//             }
//             $arr = array("status" => 400, "message" => $msg, "data" => array());
//         }
//     }
//     return \Response::json($arr);
// }

  public function changePassword(Request $request,$id){
    $this->validate($request,[  
      'old_password'=>'required',
      'new_password'=>['required','confirmed'],
    ]);

       $user=User::findOrFail($id);
      
         if(Hash::check($request->old_password, $user->password)){
           $user->update(
            [
              'password'=>Hash::make($request['new_password'])
            ]);
          $accessToken= $user->createToken('authToken')->accessToken;
          return response(['user'=>$user,'access_token'=>$accessToken]);
         }else{
            $message=[
              "message"=>"The given old password is incorrect."
            ];
          
           return $message;
         }
  }
}
