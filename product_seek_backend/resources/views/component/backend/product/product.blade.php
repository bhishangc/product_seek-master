@extends('layouts.dashboard')

@section('content')
<div id="app">
  <div class="container">
    <product admin_url='{{ route('admin') }}'></product>
  </div>
</div>
@endsection