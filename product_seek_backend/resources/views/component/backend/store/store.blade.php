@extends('layouts.dashboard')

@section('content')
<div id="app">
  <div class="container">
    <store store_url='{{ route('admin.store') }}'></store>
  </div>
</div>
@endsection