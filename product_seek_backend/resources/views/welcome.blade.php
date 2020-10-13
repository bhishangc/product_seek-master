<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Product Seek</title>

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,600" rel="stylesheet">

        <!-- Styles -->
        <style>
            .div-one {
  background:red;
  width: 100vw;
  height: 100vh;
   background: url('/images/front-1.jpg');
  width: 100vw;
  height: 100vh;
  filter: brightness(70%);
  background-repeat:no-repeat;
  background-size:cover;
  background-position:center;
}

.div-two {
  -webkit-clip-path: polygon(100vw 0, 0% 100%, 100vw 100vh);
  clip-path: polygon(100vw 0, 0% 100vh, 100vw 100vh);
  background: url('/images/front-1.jpg');
  width: 100vw;
  height: 100vh;
  filter: brightness(70%);
  background-repeat:no-repeat;
  background-size:cover;
  background-position:bottom;
}

body {
  margin: 0;
}
div {
  position: absolute;
}

/* Decoration */

.overlay {
  width: 100vw;
  height: 100vh;
  background: rgba( 0, 0, 0, 0.3)
}

.box {
  position: absolute; 
  top: 50%; 
  left: 50%; 
  transform:translate(-50%, -50%); 
  text-align: center; color: white;
}

.box h1 {
  font-size: 11vh; 
  padding: 0 1em; 
  font-family: Quicksand;
}
.db-a{
  color: white;
padding: 0.5em 1em;
font-size: 20px;
background: transparent;
text-decoration: none;
border: 2px solid white;
}
        </style>
    </head>
    <body>
        {{-- <div class="flex-center position-ref full-height">
            @if (Route::has('login'))
                <div class="top-right links">
                    @auth
                        <a href="{{ url('/home') }}">Home</a>
                    @else
                        <a href="{{ route('login') }}">Login</a>

                        @if (Route::has('register'))
                            <a href="{{ route('register') }}">Register</a>
                        @endif
                    @endauth
                </div>
            @endif

            <div class="content">
                <div class="title m-b-md">
                    Laravel
                </div>

                <div class="links">
                    <a href="https://laravel.com/docs">Docs</a>
                    <a href="https://laracasts.com">Laracasts</a>
                    <a href="https://laravel-news.com">News</a>
                    <a href="https://blog.laravel.com">Blog</a>
                    <a href="https://nova.laravel.com">Nova</a>
                    <a href="https://forge.laravel.com">Forge</a>
                    <a href="https://vapor.laravel.com">Vapor</a>
                    <a href="https://github.com/laravel/laravel">GitHub</a>
                </div>
            </div>
        </div> --}}

        <div class="div-one"></div>

        <div class="div-two" ></div>

        <!-- Decoration-->

        <div class="overlay"></div>

        <div class="box">
          @auth
            <h1>Welcome to ProductSeeker {{ Auth::user()->name }}</h1>
             @if(Auth::user()->role=='admin')
              <a class="db-a "  href="{{ url('/admin') }}">Administration</a>
               <a class="db-a "   href="{{ route('logout') }}"
                onclick="event.preventDefault();
                document.getElementById('logout-form').submit();">
                <i class="nav-icon fas fa-power-off"></i>
                  Logout
              </a>
              <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display:none;">
                @csrf
              </form>
              @else
              <a class="db-a "   href="{{ route('logout') }}"
                onclick="event.preventDefault();
                document.getElementById('logout-form').submit();">
                <i class="nav-icon fas fa-power-off"></i>
                  Logout
              </a>
              <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display:none;">
                @csrf
              </form>
              @endif
          @else
          <h1>Welcome to Product Seek</h1>
          <a class="db-a "  href="{{ route('login') }}">Login</a>
          @endauth
        </div>

    </body>
</html>
