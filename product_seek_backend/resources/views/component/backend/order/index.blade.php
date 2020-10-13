@extends('layouts.dashboard')

@section('content')
<div id="app">
  <div class="container">
    <order admin_url='{{ route('admin') }}'></order>
  </div>
</div>
@endsection