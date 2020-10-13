@extends('layouts.dashboard')

@section('content')

@php
$product_count=count($products);
$cat_count=count($categories);
$store_count=count($stores);
@endphp
<div class="container">
  <h3>Dashboard</h3>
  <div class="row">
    <div class="col-lg-3 col-6">
      <!-- small box -->
      <div class="small-box bg-info">
        <div class="inner">
          <h3>{{ $product_count }}</h3>

          <p>Products</p>
        </div>
        <div class="icon">
          <i class="fas fa-shopping-basket"></i>
        </div>
        <a href="{{ route('admin.product') }}" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
      </div>
    </div>
    <!-- ./col -->
    <div class="col-lg-3 col-6">
      <!-- small box -->
      <div class="small-box bg-success">
        <div class="inner">
          <h3>{{ $cat_count }}</h3>

          <p>Categories</p>
        </div>
        <div class="icon">
          <i class="fas fa-shopping-basket"></i>
        </div>
        <a href="{{ route('admin.product_category') }}" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
      </div>
    </div>

    <div class="col-lg-3 col-6">
      <!-- small box -->
      <div class="small-box bg-danger">
        <div class="inner">
          <h3>{{ $store_count }}</h3>

          <p>Stores</p>
        </div>
        <div class="icon">
          <i class="fas fa-store-alt"></i>
        </div>
        <a href="{{ route('admin.store') }}" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
      </div>
    </div>
    <!-- ./col -->

     <div class="col-lg-3 col-6">
      <!-- small box -->
      <div class="small-box bg-info">
        <div class="inner">
          <h3>$ {{ $income }}</h3>

          <p>Total Sales</p>
        </div>
        <div class="icon">
          <i class="fas fa-money-bill-alt"></i>
        </div>
        <a href="{{ route('admin.order') }}" class="small-box-footer">More info <i class="fas fa-arrow-circle-right"></i></a>
      </div>
    </div>
  </div>
</div>
@endsection
