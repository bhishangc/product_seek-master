<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Productcategory;
use Illuminate\Support\Str;

class Productcategorycontroller extends Controller
{

	//get paginated categories
	public function paginated_cat(){
		return Productcategory::latest()->with('productCategory')->paginate(10);
	}
	//get paginated categories


  //get all categories
  public function all_cats(){
    return Productcategory::latest()->with('productCategory')->get();
  }
  //get all categories



  public function store(Request $request){//create category
  		$this->validate($request,[
  			'name'=>'required'
  		]);
  		$slug=Str::slug($request->name,'-');

  		Productcategory::create(
  			[
  				'name'=>$request['name'],
  				'slug'=>$slug
  			]
  		);
  }//create category


  //show categories
	public function show($id){
		$prd =  Productcategory::latest();
		return $prd->findOrFail($id);
	}
	//show categories


	public function update(Request $request,$id){//update category
  		$this->validate($request,[
  			'name'=>'required'
  		]);
  		$slug=Str::slug($request->name,'-');

  		$prdCat=Productcategory::findOrFail($id);

  		$prdCat->update(
  			[
  				'name'=>$request['name'],
  				'slug'=>$slug
  			]
  		);
  }//update category

  public function trash($id){
  	$prd=Productcategory::findOrFail($id);
  	$prd->delete();
  }

  // get trashed Productcategory
  public function trashed_cats(){
  	$prd=Productcategory::onlyTrashed();
  	return $prd->paginate(10);
  }
  // get trashed Productcategory

  // get restore Productcategory
  public function restore($id){
  	$prd=Productcategory::onlyTrashed();
  	$prd=$prd->findOrFail($id);
	  $prd->restore();
  }
  // get restore Productcategory


  // delete
	public function delete($id){
    $prd=Productcategory::onlyTrashed()->findOrFail($id);
    $prd->forceDelete();
  }
  // end delete

}
