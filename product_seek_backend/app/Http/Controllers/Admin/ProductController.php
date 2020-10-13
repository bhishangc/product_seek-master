<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Product;
use Illuminate\Support\Str;

class ProductController extends Controller

{

	// paginated products
	public function paginated_products(){
		return Product::latest()->with('productCategory','productStore','productReview')->paginate(10);
	}

	// end paginated products
	//add product

  public function store(Request $request){
  	$this->validate($request,[
  		'title'=>'required',
  		'price'=>'required',
  	]);

  	$slug=Str::slug($request->title,'-');
  	$images=$request->product_image;

  	if($images){

  		for($i=0; $i<count($images);$i++){
  			$product_images[$i]=$this->makeStoreProductImage($images[$i],$slug,$i);
  		}

  		$request->merge(['product_image'=>serialize($product_images)]);

  	}else{
  		$noImg=array('no-image.jpg');
      $request->merge(['product_image'=>serialize($noImg)]);
  	}

    if($request->warrenty==''){
      $request->merge(['warrenty'=>'no warrenty']);
    }

  	$product=Product::create([

  		'title'=>$request['title'],
  		'price'=>$request['price'],
  		'product_image'=>$request['product_image'],
  		'description'=>$request['description'],
      'warrenty'=> $request['warrenty'],

  	]);

  	if($request->category_id){
  		$product->productCategory()->sync($request->category_id);
  	}

  	if($request->store_id){
  		$product->productStore()->sync($request->store_id);
  	}

  }
  //add product

  // make store product image function
  public function makeStoreProductImage($image,$title,$index){
  	if($image){
			$imageName=$title.'-'.$index.'-'.time().'.'.explode('/',explode(':',substr($image,0,strpos($image, ';')))[1])[1];
			$imageExt=explode('.',$imageName);

			preg_match("/data:image\/(.*?);/",$image,$imageExt[1]); // extract the image extension
			$image = preg_replace('/data:image\/(.*?);base64,/','',$image); // remove the type part
			$image = str_replace(' ', '+', $image);

			\File::put(public_path('/images/uploads/') . $imageName, base64_decode($image));
		}else{
			$imageName='no-image.jpg';
		}

		return '/images/uploads/'.$imageName;
  }
  // end make store product image function

  //edit 
  public function show($id){
		$product =  Product::latest()->with('productCategory','productStore','productReview');
		$current_product=$product->findOrFail($id);
		if($current_product->product_image!='no-image.jpg'){
      $current_product->product_image=unserialize($current_product->product_image);
    }
		return $current_product;
	}
	//edit


  // update product
  public function update(Request $request, $id){
    $this->validate($request,[
      'title'=>'required',
      'price'=>'required',
    ]);

    $current_product=Product::findOrFail($id);
    $slug=Str::slug($request->title,'-');
    $current_images=unserialize($current_product->product_image);
    $images=$request->product_image;

    if($images){
      // incase of new related images
      $product_images=[];
      $remaining=[];
      $i=0;
      $j=0;
      foreach($images as $image){
        if(!in_array($image, $current_images)){
          $product_images[$i]=$this->makeStoreProductImage($image,$slug,$i);
          $i++;
        }else{
          $remaining[$j]=$image;
          $j++;
        }
      }
      // incase of new related images

      $request->merge(['product_image'=>serialize(array_merge($product_images,$remaining))]);//array to be saved into database is being serialized
      
      // remove the related image which in not in the update
      foreach($current_images as $ci){
        if(!in_array($ci, unserialize($request->product_image))){
          $ci_file=public_path($ci);//current image file
          //delete file
          if(file_exists($ci_file)){
            @unlink($ci_file);
          }
          //delete file
        }
      }
      // remove the related image which in not in the update    
    }
    else{
      foreach($current_images as $ci){
        $ci_file=public_path($ci);//current image file
        //delete file
        if(file_exists($ci_file)){
          @unlink($ci_file);
        }
        //delete file

        $noImg=array('no-image.jpg');// arry to be save in case of no product image

        $request->merge(['product_image'=>serialize($noImg)]);//value to be stored in database
      }
    }
    //incase of no image in 

    if($request->warrenty==''){
      $request->merge(['warrenty'=>'no warrenty']);
    }
    $current_product->update([
      'title'=>$request['title'],
      'price'=>$request['price'],
      'product_image'=>$request['product_image'],
      'description'=>$request['description'],
      'warrenty'=> $request['warrenty'],
    ]);
    return $request->product_image;
  }
  //update product


  // trash product
  public function trash($id){
    $current_product=Product::findOrFail($id);
    $current_product->delete();
  }
  // / trash product








}
