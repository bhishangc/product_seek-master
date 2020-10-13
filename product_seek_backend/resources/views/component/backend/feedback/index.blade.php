@extends('layouts.dashboard')

@section('content')
<div id="app">
  <div class="container">
    <feedback feedback_url='{{ route('admin.feedback') }}'></feedback>
  </div>
</div>
@endsection