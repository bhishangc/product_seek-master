<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
   return view('welcome'); 
});
Route::get('/password-reset-success',function(){
			return view('password-reset-redirect');
		});

Auth::routes(['verify'=>true]);

Route::get('/admin', 'HomeController@index')->name('admin');


Route::middleware(['auth','verified'])->prefix('/admin')->group(function(){


	Route::group(['prefix'=>'/product/'],function(){

		Route::get('/',function(){
			return view('component.backend.product.product');
		})->name('admin.product');

		// store product
		Route::post('/store/','Admin\Productcontroller@store');

		//paginated product
			Route::get('/product-paginated/','Admin\Productcontroller@paginated_products');
		//paginated product

		//paginated product
			Route::get('/show/{id}','Admin\Productcontroller@show');
		//paginated product

		//update product
			Route::put('/update/{id}','Admin\Productcontroller@update');
		//update product

		//trash product
			Route::get('/trash/{id}','Admin\Productcontroller@trash');
		//trash product


		Route::group(['prefix'=>'/category/'],function(){

			// product category view
			Route::get('/',function(){
				return view('component.backend.product.product_category');
			})->name('admin.product_category');

			//paginated cats
			Route::get('/cat-paginated/','Admin\Productcategorycontroller@paginated_cat');

			//paginated cats

			//all  cats
			Route::get('/all-categories/','Admin\Productcategorycontroller@all_cats');
			//all  cats

			//show cats per id
			Route::get('/show/{id}','Admin\Productcategorycontroller@show');
			//show cats per id

			Route::post('/store/','Admin\Productcategorycontroller@store');//api request to store

			//update cat
			Route::put('/update/{id}','Admin\Productcategorycontroller@update');
			//update cat

			//trash cat
			Route::get('/trash/{id}','Admin\Productcategorycontroller@trash');
			//trash cat

			//trash cat page
			Route::get('/trashed/',function(){
				return view('component.backend.product.product_category_trash');
			});
			//trash cat page


			//get trashed cats 
			Route::get('/trashed_cats','Admin\Productcategorycontroller@trashed_cats');
			//get trashed catsrestore

			//get restore cats 
			Route::get('/restore/{id}','Admin\Productcategorycontroller@restore');
			//get restore cats 

			// delete cats 
			Route::get('/delete/{id}','Admin\Productcategorycontroller@delete');
			// delete cats 

	});// product cat routes

	});//product routes


	// store routes
	Route::group(['prefix'=>'/store/'],function(){

		//store sections
		Route::get('/',function(){
			return view('component.backend.store.store');
		})->name('admin.store');

		//create store
		Route::post('/store/','Admin\StoreController@store');

		//paginated store
			Route::get('/store-paginated/','Admin\StoreController@paginated_store');
		//paginated store

		//paginated store
			Route::get('/all-store/','Admin\StoreController@all_stores');
		//paginated store

		//show store per id
		Route::get('/show/{id}','Admin\StoreController@show');
		//show store per id

			//update store per id
		Route::put('/update/{id}','Admin\StoreController@update');
		//update store per id

	});
	// end store routes


	// feedback routes
	Route::group(['prefix'=>'/feedback/'],function(){

		Route::get('/',function(){return view('component.backend.feedback.index');})->name('admin.feedback');// feedback page 

		Route::get('/paginated_feedbacks','Admin\Feedbackcontroller@index');// get feedbacks

		Route::get('/user/','Admin\Feedbackcontroller@return_user');//return user

	});
	// end feedback routes

	// order route
	Route::group(['prefix'=>'/orders'],function(){

		Route::get('/',function(){return view('component.backend.order.index');})->name('admin.order');// order page 

		Route::get('/returned',function(){return view('component.backend.order.order-return.index');})->name('admin.order_return');// order returned page

		Route::get('/returned-requested-orders','Admin\OrderController@requested_orders');//paginated return requested orders

		Route::get('/approve-return/{id}','Admin\OrderController@approve_return');//approve order return

		Route::get('/disapprove-return/{id}','Admin\OrderController@disapprove_return');//disapprove order return

		Route::get('/paginated_orders','Admin\OrderController@paginated_orders');// get order

		Route::get('/show/{id}','Admin\OrderController@show');// get order by id

		Route::put('/update/{id}','Admin\OrderController@update');// update order by id
	});
	
	// end order route

	// customers routes
	Route::group(['prefix'=>'/customers'],function(){

		Route::get('/',function(){return view('component.backend.customer.index');})->name('admin.customers');// customers page

		//paginated customers
		Route::get('/paginated_customers','Admin\CustomerController@paginated_customers');
		//get paginated customers

	});
	// end customers routes

	Route::group(['prefix'=>'/user-profile/'],function(){

		Route::get('/',function(){return view('component.backend.user-profile.index');})->name('admin.user-profile');// customers page

		//paginated customers
		Route::get('/show/{id}','Admin\CustomerController@show');
		//get paginated customers

		//all customers
		Route::get('/all-user/','Admin\CustomerController@all_user');
		//get all customer

		// update user from user profile
		Route::put('/update/{id}','Admin\CustomerController@update');
		// end update user from user profile

	});

	// user profile routes

	// end user profile routes

});//admin routes 
