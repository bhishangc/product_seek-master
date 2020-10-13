<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Store;

class StoreController extends Controller
{

	// get paginated stores
	public function paginated_store(){
		return Store::latest()->with('productStore','userFollow')->paginate(10);
	}
	//get paginated stores

	// get all stores
	public function all_stores(){
		return Store::latest()->with('productStore','userFollow')->get();
	}
	//get all stores


	// create new store
  public function store(Request $request){
  	$this->validate($request,[
			'name'=>'required',
			'email'=>'required|email',
			'contact'=>'required',
			'address'=>'required',
			'google_maps_url'=>'required',
		]);

		$image=$this->makeStoreImage($request->store_image);

		Store::create([
			'name'=>$request['name'],
			'email'=>$request['email'],
			'contact'=>$request['contact'],
			'store_image'=>$image,
			'address'=>$request['address'],
			'followers'=>serialize(array()),
			'google_maps_url'=>$request['google_maps_url'],
		]);
  }
  // create new store	 

  public function show($id){
		$store =  Store::latest();
		return $store->findOrFail($id);
	}

	// create new store
  public function update(Request $request,$id){
  	$store=Store::findOrFail($id);
  	$this->validate($request,[
			'name'=>'required',
			'email'=>'required|email',
			'contact'=>'required',
			'address'=>'required',
			'google_maps_url'=>'required',
		]);

  	if($request->store_image){
			if($request->store_image!=$store->store_image){
				$oldfile=public_path($store->store_image);
				@unlink($oldfile);
				$image=$this->makeStoreImage($request->store_image);
			}
		}else{
			$oldfile=public_folder($store->store_image);
			@unlink($oldfile);
			$image='no-img.jpg';
		}

		$store->update([
			'name'=>$request['name'],
			'email'=>$request['email'],
			'contact'=>$request['contact'],
			'address'=>$request['address'],
			'store_image'=>$image, 
			'google_maps_url'=>$request['google_maps_url'],
		]);
  }
  // create new store	 


  public function makeStoreImage($image){

		if($image){
			$imageName=time().'.'.explode('/',explode(':',substr($image,0,strpos($image, ';')))[1])[1];
			$imageExt=explode('.',$imageName);

			preg_match("/data:image\/(.*?);/",$image,$imageExt[1]); // extract the image extension
			$image = preg_replace('/data:image\/(.*?);base64,/','',$image); // remove the type part
			$image = str_replace(' ', '+', $image);

			\File::put(public_path('/images/store/') . $imageName, base64_decode($image));
		}else{
			$imageName='no-image.jpg';
		}

		return '/images/store/'.$imageName;

	}

}
