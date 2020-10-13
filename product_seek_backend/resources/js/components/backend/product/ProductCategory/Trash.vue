<template>
	<div class="row">

		<loader v-if='loading'></loader>

		<div class="col-md-12">
			<a :href="product_cat_url">	
				<button class="btn btn-danger mr-1">
					<i class="fas fa-arrow-left mr-1"></i>Back to category
				</button>
			</a>
		</div>
		 <div class="col-md-12 pt-3">
				<div class="card ">
					<div class="card-header">
						<h6>Trashed Product Categories</h6>
					</div>
					<div class="card-bodytable-responsive p-0">
						<table class="table table-hover text-nowrap">
		          <thead>
		            <tr>
		              <th>Name</th>
		              <th>No of Products</th>
		              <th>Action</th>
		            </tr>
		          </thead>
		          <tbody>
		          	<tr v-if='!trashProductCatLength'>
		          		<td colspan="3">Sorry! no data found</td>
		          	</tr>
		          	<tr v-else v-for='pc in trashProductCats.data' :key='pc.id'>
		          		<td>{{ pc.name }}</td>
		          		<td>0</td>
		          		<td>
		          			<button class="btn btn-primary mr-2" @click='restoreCat(pc.id)'><i class="fas fa-recycle mr-2"></i>Restore</button>
		          			<button class="btn btn-danger"@click='deleteCat(pc.id)' ><i class="fas fa-trash mr-2"></i>Delete</button>
		          		</td>
		          	</tr>
		          </tbody>
		          <tfoot>
		            <tr>
		              <th>Name</th>
		              <th>No of Products</th>
		              <th>Action</th>
		            </tr>
		          </tfoot>
		        </table>
					</div>
					<div class="card-footer">
						<pagination :data="trashProductCats" @pagination-change-page="getResults"></pagination>
					</div>
				</div>
			</div>

	</div>
</template>
<script>
	export default{
		name:'produt-cat-trash',
		props:['product_cat_url'],
		data(){
			return{
				trashProductCats:{},
				trashProductCatLength:null,
				loading:true,
			}
		},
		methods:{
			loadCats(){
				axios.get(this.product_cat_url+'/trashed_cats/').then(({data})=>{
					this.trashProductCats=data
					this.trashProductCatLength=this.trashProductCats.data.length
					this.loading=false
				})
			},
			getResults(page = 1) {
        this.loading=true;
        axios.get(this.product_cat_url+'/trashed_cats/?page=' + page)
        .then(response => {
            this.trashProductCats = response.data;
            this.loading=false;
        });
      },
      restoreCat(id){
				this.loading=true
				axios.get(this.product_cat_url+'/restore/'+id).then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Product\'s Category restored Successfully'
          })
          this.loadCats()
          this.loading=false;

				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},
			deleteCat(id){
				this.loading=true
				axios.get(this.product_cat_url+'/delete/'+id).then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Product\'s Category deleted Successfully'
          })
          this.loadCats()
          this.loading=false;

				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},
		},
		created(){
			this.loadCats()
		}
	}
</script>
