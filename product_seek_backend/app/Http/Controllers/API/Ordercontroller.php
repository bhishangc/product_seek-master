<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Order;
use App\Product;

class Ordercontroller extends Controller
{
  
  // make order
	public function store(Request $request){

		$this->validate($request,[
			'user_id'=>'required',
		]);


		$orderno='order-'.strtotime(date('m/d/Y h:i:s a', time()));


		$products=json_decode($request->products);

		foreach ($products as $product){

			$p=$product->product;

			$prod=$p->id;

			$order=Order::create([
				'order_no'       => $orderno,
				'products'       => $prod,
				'user_id'        => $request['user_id'],
				'quantity'       => $product->quantity,
				'status'         => 'Processing',
				'return_request' => false,
				'returned'       => false,
				'total'          => $product->total_price,
			]);

			$order->usersOrder()->sync($request->user_id);
		}


		// return $products;

	}
  // end make order function

  // update order
	public function cancle($id){
		$order=Order::findOrFail($id);

		$order->update([
			'status'=>'Canceled'
		]);
	}
  // end update order


  // get orders by user id
	public function get_order($user_id){
		$orders = Order::latest()->where('user_id',$user_id);
		$orders=$orders->where('delivered_date',null)->get();
		foreach($orders as $order){
			$product=Product::Latest()->with('productCategory','productStore','productReview');
			$product=$product->findOrFail($order->products);
			$order->products=$product;
			$order->products->product_image=unserialize($order->products->product_image);
		}

		return $orders;
	}
  //end get order by user id

	// request return
  public function request_return(Request $request,$order_id){
  	$this->validate($request,[
  		'return_note'=>'required',
  	]);

  	$order=Order::findOrFail($order_id);

  	$order->update([
  		'return_note'=>$request['return_note'],
  		'return_request'=>true,
  	]);
  }
  // request return

  //delivered orders
	public function get_delivered_order($user_id){
		$orders = Order::latest()->where('user_id',$user_id);
		$orders=$orders->where('status','Delivered')->get();

		foreach($orders as $order){
			$product=Product::Latest()->with('productCategory','productStore','productReview');
			$product=$product->findOrFail($order->products);
			$order->products=$product;
			$order->products->product_image=unserialize($order->products->product_image);

			$delivered_date=$order->delivered_date;
			$returnable=$this->returnableCheck($delivered_date);
			$order->returnable=$returnable;
		}

		return $orders;
	}
  //end delivered orders

  public function returnableCheck($delivered_date){
  	$current_date=date("Y/m/d");
  	$returnable_valid_date=date('Y/m/d', strtotime($delivered_date. ' + 7 days'));

  	if($current_date<=$returnable_valid_date){
  		return true;
  	}

  	return false;
  }

	public function get_returned_order($user_id){
		$orders = Order::latest()->where('user_id',$user_id);
		$orders=$orders->where('status','Returned')->get();
		foreach($orders as $order){
			$product=Product::Latest()->with('productCategory','productStore','productReview');
			$product=$product->findOrFail($order->products);
			$order->products=$product;
			$order->products->product_image=unserialize($order->products->product_image);
		}

		return $orders;
	}

}

// [
//    {
//       "product":{
//          "id":1,
//          "title":"Pant",
//          "price":55.0,
//          "description":"This is pant for male",
//          "product_image":"[\"/images/uploads/pants-1.jpeg\",\"/images/uploads/pants-2.jpeg\"]",
//          "product_category_id":1,
//          "product_store_id":1
//       },
//       "quantity":1,
//       "total_price":55.0
//    },
//    {
//       "product":{
//          "id":4,
//          "title":"Ear Rings",
//          "price":50.0,
//          "description":"This is Ear Rings",
//          "product_image":"[\"/images/uploads/ear-ring-1.jpg\",\"/images/uploads/ear-ring-2.jpg\"]",
//          "product_category_id":2,
//          "product_store_id":3
//       },
//       "quantity":3,
//       "total_price":150.0
//    }
// ]


