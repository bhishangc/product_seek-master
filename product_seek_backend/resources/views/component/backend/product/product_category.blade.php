@extends('layouts.dashboard')

@section('content')
<div id="app">
  <div class="container">
    <produt-cat product_cat_url='{{ route('admin.product_category') }}'></produt-cat>
  </div>
</div>
@endsection