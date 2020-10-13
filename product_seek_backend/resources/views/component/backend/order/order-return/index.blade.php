
@extends('layouts.dashboard')

@section('content')
<div id="app">
  <div class="container">
    <order-return admin_url='{{ route('admin') }}'></order-return>
  </div>
</div>
@endsection