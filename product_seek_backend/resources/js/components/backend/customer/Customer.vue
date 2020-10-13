<template>
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-12">
				<div class="row">
				
				</div>
			</div>

			<div class="card mt-2">
				<div class="card-header">
					<h4>Customers</h4>
				</div>
				<div class="card-body table-responsive p-0">
					<table class="table text-nowrap">
            <thead>
              <tr>
                <th>Customer name</th>
                <th>Address</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Became member</th>
                <th>Wishlist</th>
                <th>Orders</th>
              </tr>
            </thead>
            <tbody v-if='loading'>
            	<tr>
            		<td colspan="7" >
            			<div class="loadingio-spinner-ellipsis-eucq25nkrmd">
            				<div class="ldio-a9gm1xgpeqf">
            					<div></div>
            					<div></div>
            					<div></div>
            					<div></div>
            					<div></div>
            				</div>
            			</div>
            		</td>
            	</tr>
          	</tbody>
          	<tbody v-else>
          		<tr v-if='!NoCustomers'>
          			<td colspan="6">Sorry no customers found</td>
          		</tr>
            	<tr v-else v-for='c in customers.data' :key='c.id'>
            		<td>{{ c.name }}</td>
            		<td>{{ c.address }}</td>
            		<td>{{ c.email }}</td>
            		<td>{{ c.phone_number }}</td>
            		<td>{{ c.created_at | myDate }}</td>
            		<td>{{ c.users_wishlist.length }} <button v-if='c.users_wishlist.length'class='wishlist-btn ml-1'@click='userWishlist(c.users_wishlist,c.name)'><i class="fas fa-heart"></i></button>
            			<button v-else class='wishlist-btn-dark ml-1'disabled><i class="fas fa-heart"></i></button></td>
            		<td>{{ c.users_order.length }}<button v-if='c.users_order.length'class='order-btn ml-1'@click='userOrder(c.users_order,c.name)'><i class="fas fa-cart-arrow-down"></i></button>
            		<button v-else class='wishlist-btn-dark ml-1'disabled><i class="fas fa-cart-arrow-down"></i></button></td>
            	</tr>
            </tbody>	
          </table>
        </div>
        <div class="card-footer">
					<pagination :data="customers" @pagination-change-page="getResults"></pagination>
				</div>
      </div>
    </div>

    <!-- wishlist model -->
    <div class="modal fade" id="wishlist" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle">Wishlist of {{ currentUsername }}</h5>
		        <button type="button" class="close" @click='closeWishlist' aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <div class="card">
		        	<div class="card-body table-responsive p-0">
								<table class="table text-nowrap">
			            <thead>
			              <tr>
			                <th>Image</th>
			                <th>Name</th>
			                <th>Price</th>
			                <th>Added date</th>
			              </tr>
			            </thead>
			            <tbody>
			            	<tr v-if='!currentWishlist'>
			            		<td colspan="3"> Sorry user doesn't have any favourites!!</td>
			            	</tr>
			            	<tr v-else v-for='w in arrReverse(currentWishlist)' :key='w.id'>
			            		<td><img :src="w.product.product_image[0]" style='width:50px;'></td>
			            		<td>{{ w.product.title }}</td>
			            		<td>$ {{ w.product.price }}</td>
			            		<td>{{ w.created_at | myDate }}</td>
			            	</tr>
			            </tbody>
			          </table>
			        </div>
		        </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" @click='closeWishlist'>Close</button>
		      </div>
		    </div>
		  </div>
		</div>

		<div class="modal fade" id="order_model" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLongTitle">Order details <{{ currentUsername }}> </h5>
			        <button type="button" class="close" @click='closeOrder' aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body" v-if='currentOrder'>
			        <div class="card"  v-for='co in arrReverse(currentOrder)' :key='co.id'>
			        	<div class="card-header">
			        		<h6>{{ co.order_no }} ({{ co.created_at | myDate }})</h6>
			        	</div>
			        	<div class="card-body table-responsive p-0">
									<table class="table text-nowrap">
				            <thead>
				            	<tr>
				            		<th colspan="5">Products</th>
				            	</tr>
				              <tr>
				                <th>Image</th>
				                <th>Name</th>
				                <th>Price</th>
				                <th>Quantity</th>
				                <th>Total</th>
				              </tr>
				            </thead>
				            <tbody>
				            	<tr>
				            		<td>
				            			<img :src="co.products.product_image[0]" style="width:50px" alt="">
				            		</td>
				            		<td>
				            			{{ co.products.title }}
				            		</td>
				            		<td>
				            			{{ co.products.price }}
				            		</td>
				            		<td>
				            			{{ co.quantity }}
				            		</td>
				            		<td>
				            			$ {{ co.total }}
				            		</td>
				            	</tr>
				            </tbody>
				          </table>
				        </div>
				        <div class="card-footer">
				        	<h6>Order Status : {{ co.status }}</h6>
				        </div>
				      </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" @click='closeOrder'>Close</button>
			      </div>
			    </div>
			  </div>
		</div>
  </div>

     
	
</template>
<script>
	export default{
		name:'customer',
		props:['admin_url'],
		data(){
			return{
				loading:true,
				customers:{},
				NoCustomers:'',
				currentWishlist:[],
				currentUsername:'',
				currentOrder:[],
			}
		},
		methods:{
			loadCustomers(){
				axios.get(this.admin_url+'/customers/paginated_customers/').then(({data})=>{
					this.customers=data
					this.NoCustomers=this.customers.data.length
					this.loading=false
				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},
			getResults(page = 1) {
      	this.loading=true;
        axios.get(this.admin_url+'/customers/paginated_customers/?page=' + page)
        .then(response => {
            this.customers = response.data;
            this.loading=false;
        }).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
      },
      userWishlist(wishlist,username){
      	this.currentWishlist=wishlist
      	this.currentUsername=username
      	$('#wishlist').modal('show')
      },
      closeWishlist(){
      	$('#wishlist').modal('hide')
      	this.currentWishlist=[]
      	this.currentUsername=''
      },
      userOrder(orderlist,username){
      	this.currentOrder=orderlist
      	this.currentUsername=username
      	$('#order_model').modal('show')
      },
      closeOrder(){
      	$('#order_model').modal('hide')
      	this.currentOrder=[]
      	this.currentUsername=''
      },
      arrReverse(value){
			  // slice to make a copy of array, then reverse the copy
			  return value.slice().reverse();
      }
		},
		created(){
			this.loadCustomers();
		}
	}
</script>
<style scoped>
	.wishlist-btn{
		background: #ec2623;
		color: white;
		padding: 5px;
		border:0px;
	}
	.wishlist-btn-dark{
		background: grey;
		color: white;
		padding: 5px;
		border:0px;
	}
	.order-btn{
		background: #38529a;
		color: white;
		padding: 5px;
		border:0px;
	}
</style>