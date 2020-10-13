<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Order;
use App\Product;
class OrderController extends Controller
{
  // paginated orders
  public function paginated_orders(){
  	$orders = Order::latest()->with('usersOrder')->paginate(10);

  	foreach($orders as $order){
  		$product=Product::Latest()->with('productCategory','productStore','productReview');
      $product=$product->findOrFail($order->products);
      $order->products=$product;
      $order->products->product_image=unserialize($order->products->product_image);
  	}

  	return $orders;
  }
  //get paginated orders


  // show particular order
  public function show($id){
  	$order = Order::latest()->with('usersOrder');

  	$order = $order->findOrFail($id);
  	
  	$product=Product::Latest()->with('productCategory','productStore','productReview');
    $product=$product->findOrFail($order->products);
    $order->products=$product;
    $order->products->product_image=unserialize($order->products->product_image);

  	return  $order ;
  }
  // end show particular order

   // update order
	public function update(Request $request,$id){
		$order=Order::findOrFail($id);

		$order->update([
			'status'=>$request['status']
		]);
    $current_date=date("Y/m/d");
    if($request['status']=='Delivered'){
      $order->update([
        'delivered_date'=>$current_date,
      ]);
    }else{
      $order->update([
        'delivered_date'=>null,
      ]);
    }
	}
  // end update order



  //return requested orders
  public function requested_orders(){
    $orders = Order::latest()->with('usersOrder')->where('return_request',true)->paginate(10);

    foreach($orders as $order){
      $product=Product::Latest()->with('productCategory','productStore','productReview');
      $product=$product->findOrFail($order->products);
      $order->products=$product;
      $order->products->product_image=unserialize($order->products->product_image);
    }

    return $orders;
  }
  //end return requested orders

  // approve return  
  public function approve_return($id){
    $order=Order::findOrFail($id);

    $order->update([
      'status'=>'Returned',
      'returned'=>true,
    ]);
  }
  // approve return

   // approve return  
  public function disapprove_return($id){
    $order=Order::findOrFail($id);

    $order->update([
      'status'=>'Processing',
      'returned'=>false,
    ]);
  }
  // approve return
}
