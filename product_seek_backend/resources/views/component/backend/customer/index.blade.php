@extends('layouts.dashboard')

@section('content')
<div id="app">
  <div class="container">
    <customer admin_url='{{ route('admin') }}'></customer>
  </div>
</div>
@endsection