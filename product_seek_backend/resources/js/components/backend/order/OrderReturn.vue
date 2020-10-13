<template>
	<div class="row">
		<div class="col-md-12">
			<div class="col-md-12">
				<div class="row">
				
				</div>
			</div>

			<div class="card mt-2">
				<div class="card-header">
					<h4>Return requests</h4>
				</div>
				<div class="card-body table-responsive p-0">
					<table class="table text-nowrap">
            <thead>
              <tr>
                <th>Order number</th>
                <th>Product name</th>
                <th>Customer name</th>
                <th>Delivered date</th>
                <th>Total</th>
                <th>Status</th>
                <th>Return note</th>
                <th>Action</th>
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
          		<tr v-if='!ordersLength'>
          			<td colspan="7" >Sorry no data found!!</td>
          		</tr>
          		<tr v-else v-for='rro in orders.data' :key="rro.id">
          			<td>{{ rro.order_no }}</td>
          			<td>{{ rro.products.title }}</td>
          			<td><span v-for='c in rro.users_order' :key='c.id'>{{ c.name }}</span></td>
          			<td>{{ rro.delivered_date | myDate }}</td>
          			<td>$ {{ rro.total }}</td>
          			<td>
          				<span v-if='rro.returned' style="color:green;">Approved</span>
          				<span v-else style="color:red;">Under consideration</span>
          			</td>
          			<td>
          				
									<button class='btn btn-primary' @click='openReturnNoteModel(rro)'> <i class="fas fa-clipboard mr-1"></i>View</button>

									<div class="modal fade" id="return-note" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
									  <div class="modal-dialog modal-dialog-centered" role="document">
									    <div class="modal-content" v-if='currentOrder'>
									      <div class="modal-header">
									        <h5 class="modal-title" id="exampleModalLongTitle">{{ currentOrder.order_no }}<span v-for='c in currentOrder.users_order' :key='c.id'>({{ c.name }})</span></h5>
									        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
									      </div>
									      <div class="modal-body">
									       {{ currentOrder.return_note }}
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
									      </div>
									    </div>
									  </div>
									</div>

          			</td>
          			<td>
          				<button v-if='!rro.returned' class="btn btn-primary" @click='approveReturn(rro.id)'>Approve</button>
          				<button v-else class="btn btn-danger" @click='disapproveReturn(rro.id)'>
          					On hold
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

	
	</div>
</template>
<script>
	export default{
		props:['admin_url'],
		data(){
			return{
				loading:true,
				orders:{},
				ordersLength:'',
				currentOrder:{},
			}
		},
		methods:{
			openReturnNoteModel(order){
				this.currentOrder=order
				$('#return-note').modal('show')
			},
			loadRRO(){
				axios.get(this.admin_url+'/orders/returned-requested-orders').then(({data})=>{
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
			approveReturn(id){
				this.loading=true
				axios.get(this.admin_url+'/orders/approve-return/'+id).then(()=>{
      		Toast.fire({
            icon: 'success',
            title: 'Order returned approved'
          })
          this.loadRRO()
      	}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},
			getResults(page = 1) {
        this.loading=true;
        axios.get(this.admin_url+'/orders/returned-requested-orders/?page=' + page)
        .then(response => {
            this.orders = response.data;
            this.loading=false;
        });
      },

			disapproveReturn(id){
				this.loading=true
				axios.get(this.admin_url+'/orders/disapprove-return/'+id).then(()=>{
      		Toast.fire({
            icon: 'success',
            title: 'Order returned onhold'
          })
          this.loadRRO()
      	}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			}
		},
		created(){
			this.loadRRO()
		}
	}
</script>