 <!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4">
  <!-- Brand Logo -->
  <a href="index3.html" class="brand-link">
    <img src="dist/img/AdminLTELogo.png" alt='PS' class="brand-image img-circle elevation-3" style="opacity: .8">
    <span class="brand-text font-weight-light">Product Seeker</span>
  </a>

  <!-- Sidebar -->
  <div class="sidebar">
    <!-- Sidebar user panel (optional) -->
    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
    
      <div class="info">
        <a href="#" class="d-block">{{ Auth::User()->name }}</a>
      </div>
    </div>

    <!-- Sidebar Menu -->
    <nav class="mt-2">
      <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        <!-- Add icons to the links using the .nav-icon class
             with font-awesome or any other icon font library -->
        <li class="nav-item has-treeview">
          <a href="{{ route('admin') }}" class="nav-link">
            <i class="nav-icon fas fa-award"></i>
            <p>
              Dashboard
            </p>
          </a>
        </li>

        <li class="nav-header">Products & Stores</li>
        <li class="nav-item has-treeview">
          <a href="#" class="nav-link">
            <i class="nav-icon fas fa-shopping-basket"></i>
            <p>
              Products
              <i class="right fas fa-angle-left"></i>
            </p>
          </a>
          <ul class="nav nav-treeview">
            <li class="nav-item">
              <a href="{{ route('admin.product') }}" class="nav-link">
                <i class="fas fa-angle-right nav-icon"></i>
                <p>All products</p>
              </a>
            </li>
            <li class="nav-item">
              <a href="{{ route('admin.product_category') }}" class="nav-link">
                <i class="fas fa-angle-right nav-icon"></i>
                <p>Product Categories</p>
              </a>
            </li>
          </ul>
        </li>
        <li class="nav-item has-treeview">
          <a href="#" class="nav-link">
            <i class="nav-icon fas fa-store-alt"></i>
            <p>
              Store
              <i class="right fas fa-angle-left"></i>
            </p>
          </a>
          <ul class="nav nav-treeview">
            <li class="nav-item">
              <a href="{{ route('admin.store') }}" class="nav-link">
                <i class="fas fa-angle-right nav-icon"></i>
                <p>All Stores</p>
              </a>
            </li>
          </ul>
        </li>

        <li class="nav-header">Orders & Customers</li>
        <li class="nav-item has-treeview">
          <a href="{{ route('admin.order') }}" class="nav-link">
            <i class="nav-icon fas fa-cart-arrow-down"></i>
            <p>
              Orders
            </p>
          </a>
        </li>
         <li class="nav-item has-treeview">
          <a href="{{ route('admin.order_return') }}" class="nav-link">
            <i class="nav-icon fas fa-undo"></i>
            <p>
              Orders returned
            </p>
          </a>
        </li>
        <li class="nav-item has-treeview">
          <a href="{{ route('admin.customers') }}" class="nav-link">
            <i class="nav-icon fas fa-user-friends"></i>
            <p>
              Customers
            </p>
          </a>
        </li>
         <li class="nav-item has-treeview">
          <a href="{{ route('admin.feedback') }}" class="nav-link">
            <i class="nav-icon fas fa-comment"></i>
            <p>
              Feedbacks
            </p>
          </a>
        </li>

        <li class="nav-header">Customization</li>
        <li class="nav-item has-treeview">
          <a href="{{ route('admin.user-profile') }}" class="nav-link">
            <i class="nav-icon fas fa-user-cog"></i>
            <p>
              Profile
            </p>
          </a>
        </li>

        <li class="nav-item">
          <a class="nav-link"  href="{{ route('logout') }}"
            onclick="event.preventDefault();
            document.getElementById('logout-form').submit();">
            <i class="nav-icon fas fa-power-off"></i>
            <p>
              Logout
            </p>
          </a>
          <form id="logout-form" action="{{ route('logout') }}" method="POST" style="display:none;">
            @csrf
          </form>
        </li>
        
      </ul>
    </nav>
    <!-- /.sidebar-menu -->
  </div>
  <!-- /.sidebar -->
</aside>