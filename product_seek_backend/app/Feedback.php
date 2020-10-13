<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\User;

class Feedback extends Model
{
   protected $guarded=[];

   protected $table= 'feedbacks';

  public function userFeedback(){
   	return $this->belongsTo(User::class);
  }

}
