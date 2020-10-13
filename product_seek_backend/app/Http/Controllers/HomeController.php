<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;
use App\Productcategory;
use App\Store;
use App\Order;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware(['auth','verified']);
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
      $orders=Order::where('status','Delivered')->orWhere('status','Processing')->get();
      $income=0;
       for($i=0;$i<count($orders);$i++){
        $income=$income+$orders[$i]->total;
       }
      $products=Product::latest()->get();
      $categories=Productcategory::latest()->get();
      $stores=Store::latest()->get();
      return view('home',compact('products','categories','stores','income'));
    }
}
