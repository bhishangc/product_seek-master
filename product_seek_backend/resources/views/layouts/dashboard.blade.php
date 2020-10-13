@include('component/backend/header')
@include('component/backend/left-sidebar')

<div class="content-wrapper" style="min-height: 189px;">
  <div class="content">
    <div class="container-fluid">
      <main class="py-4">
        @yield('content')
      </main>
    </div>
  </div> 
</div>

@include('component/backend/right-sidebar')
@include('component/backend/footer')
