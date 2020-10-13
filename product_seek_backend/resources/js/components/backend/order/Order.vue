<template>
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-12">
				<div class="row">
				
				</div>
			</div>

			<div class="card mt-2">
				<div class="card-header">
					<h4>Orders</h4>
				</div>
				<div class="card-body table-responsive p-0">
					<table class="table text-nowrap">
            <thead>
              <tr>
                <th>Order number</th>
                <th>Customer name</th>
                <th>Status</th>
                <th>Order date</th>
                <th>Total</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody v-if='loading'>
            	<tr>
            		<td colspan="6" >
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
            	<tr v-if='!ordersLength'>
          			<td colspan="6" >Sorry no orders are made!!</td>
            	</tr>
	
            	<tr v-for='o in orders.data' :key='o.id'>
            		<td>{{ o.order_no }}</td>
            		<td><span v-for='c in o.users_order' :key='c.id'>{{ c.name }}</span></td>
            		<td>
            			{{ o.status }}
            		</td>
            		<td>{{  o.created_at| myDate }}</td>
            		<td>$ {{ o.total }}</td>
            		<td>
            			<button class="btn btn-primary" @click='loadCurrentOrder(o.id)'>
            				<i class="fas fa-eye mr-1"></i>View Order
            			</button>
            		</td>
            	</tr>
            </tbody>
          </table>
        </div>
        <div class="card-footer">
					<pagination :data="orders" @pagination-change-page="getResults"></pagination>
				</div>
      </div>
    </div>

    <!-- model  -->
    <div class="modal fade" id="order_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-lg" role="document"  >
		    <div class="modal-content" v-if='currentOrder'>
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">{{ currentOrder.order_no }}</h5>
		        <button type="button" class="close" @click='closeModal' aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <form>
			      <div class="modal-body">
				      <div class="row">  
				        <div class="col-md-12">
				        	<h6> <b>Customer</b> <span v-for='c in currentOrder.users_order'>{{ c.name }}</span><hr></h6>
				        </div>
				      </div>

			        <div class="row">
			        	<div class="col-md-4">
			        		<label for="order-Status">Order Status</label>
			        		<div class="form-group">
			        			<select  v-model='form.status' class="form-control">
			        				<option value="Processing">Processing</option>
			        				<option value="On the way">On the way</option>
			        				<option value="Delivered">Delivered</option>
			        				<option value="Returned">Returned</option>
			        				<option value="Cancled">Cancled</option>
			        			</select>
			        		</div>
			        	</div>
			        </div>
			        <div class="col-md-12">
			        	<h5>Products <hr></h5>
			        	<div class="card mt-2">
									<div class="card-body table-responsive p-0">
										<table class="table text-nowrap">
					            <thead>
					              <tr>
					                <th>Product Image</th>
					                <th>Product</th>
					                <th>Price</th>
					                <th>Quantity</th>
					                <th>Total</th>
					              </tr>
					            </thead>
					            <tbody>
					            	<tr>
					            		<td>
					            			<img :src="currentOrder.products.product_image[0]" alt="" style="width: 50px">
					            		</td>
					            		<td>{{ currentOrder.products.title }}</td>
					            		<td>$ {{ currentOrder.products.price }} </td>
					            		<td>{{ currentOrder.quantity }}</td>
					            		<td>$ {{ currentOrder.total }}</td>
					            	</tr>
					            </tbody>	
					          </table>
					        </div>
					      </div>
			        </div>
			        	
			        
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" @click='closeModal'>Close</button>
			         <button type="button" class="btn btn-primary" @click='updateOrder(currentOrder.id)'>Update</button>
			      </div>
		      </form>
		    </div>
		  </div>
		</div>
    <!-- end model -->
	</div>
</template>
<script>
	export default{
		props:['admin_url'],
		data(){
			return{
				orders:{},
				ordersLength:'',
				loading:true,
				currentOrder:null,
				form:new Form({
					status:'',
				}),
			}
		},
		methods:{
			loadOrders(){
				axios.get(this.admin_url+'/orders/paginated_orders').then(({data})=>{
					this.orders=data
					this.ordersLength=this.orders.data.length
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
        axios.get(this.store_url+'/orders/paginated_orders/?page=' + page)
        .then(response => {
            this.orders = response.data;
            this.loading=false;
        }).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
      },
      loadCurrentOrder(id){
      	this.loading=true;
      	let that=this;
      	axios.get(this.admin_url+'/orders/show/'+id).then(function(res){
      		that.currentOrder=res.data;
      		that.form.status=that.currentOrder.status
      		$('#order_modal').modal('show')
      		that.loading=false

      	}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
      },
      updateOrder(id){
      	$('#order_modal').modal('hide')
      	this.loading=true
      	this.form.put(this.admin_url+'/orders/update/'+id).then(()=>{
      		Toast.fire({
            icon: 'success',
            title: 'Order Updated successfully'
          })
          this.loadOrders()
          this.loading=false
      	}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
      },
      closeModal(){
      	$('#order_modal').modal('hide')
      }
		},

		created(){
			this.loadOrders();
		}
	}
</script>



