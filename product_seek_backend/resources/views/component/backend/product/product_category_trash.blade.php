@extends('layouts.dashboard')

@section('content')
<div id="app">
  <div class="container">
    <produt-cat-trash product_cat_url='{{ route('admin.product_category') }}'></produt-cat-trash>
  </div>
</div>
@endsection