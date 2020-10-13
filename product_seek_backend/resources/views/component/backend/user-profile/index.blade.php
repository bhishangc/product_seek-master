@extends('layouts.dashboard')

@section('content')
<div id="app">
  <div class="container">
    <user-profile :authenticated_user='{{ Auth::user() }}' admin_url='{{ route('admin') }}'></user-profile>
  </div>
</div>
@endsection