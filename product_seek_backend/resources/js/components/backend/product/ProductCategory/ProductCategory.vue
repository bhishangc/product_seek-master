<template>
	<div class="row">
	<loader v-if='loading'></loader>
		<div class="col-md-12">
			<div class="col-md-12">
				<div class="row">
					<button class="btn btn-primary mr-1" @click='openModel'>
						<i class="fas fa-plus mr-1"></i>Create category
					</button>
					<a :href="product_cat_url+'/trashed/'">
						<button class="btn btn-danger ">
							<i class="fas fa-trash mr-1"></i>Trash
						</button>
					</a>
				</div>
			</div>

			<div class="card mt-2">
				<div class="card-header">
					<h6>Product Categories</h6>
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
            	<tr v-if='!productCatLength'>
            		<td colspan="3">Sorry! no data found</td>
            	</tr>
            	<tr v-else v-for='pc in productCats.data' :key='pc.id'>
            		<td>{{ pc.name }}</td>
            		<td>{{ pc.product_category.length }}</td>
            		<td>
            			<button class="btn btn-primary mr-2" @click='editCat(pc.id)'><i class="fas fa-edit mr-2"></i>Edit</button>
            			<button class="btn btn-danger" @click='trashCat(pc.id)'><i class="fas fa-trash mr-2"></i>Trash</button>
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
					<pagination :data="productCats" @pagination-change-page="getResults"></pagination>
				</div>
			</div>

			<div class="modal fade" id="productCatModel" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			      	<h5 class="modal-title" v-if='editmode'id="exampleModalLongTitle">Edit category</h5>
			        <h5 class="modal-title" v-else id="exampleModalLongTitle">Create category</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <form @submit.prevent="editmode? updateCat() : createCat()">
				      <div class="modal-body">
				        <div class="form-group">
				        	<label for="name">Category name</label>
			        		<input v-model="form.name" type="text" name="name" class="form-control" :class="{ 'is-invalid': form.errors.has('name') }" placeholder="Category Name">
					      <has-error :form="form" field="name"></has-error>
				        </div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancle</button>
				        <button type="submit" class="btn btn-primary" v-if='editmode'>Update</button>
				        <button type="submit" class="btn btn-primary" v-else>Create</button>
				      </div>
				    </form>
			    </div>
			  </div>
			</div>

		</div>
		
	</div>
</template>
<script>
	export default{
		name:'produt-cat',
		props:['product_cat_url'],
		data(){
			return{

				form:new Form({
					id:'',
					name:''
				}),

				productCats:{},
				productCatLength:null,
				editmode:false,
				loading:true,
				
			}
		},
		methods:{
			openModel(){
				this.editmode=false
				this.form.clear()
				this.form.reset()
				$('#productCatModel').modal('show')
			},
			createCat(){
				this.loading=true
				this.form.post(this.product_cat_url+'/store/').then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Product\'s Category Created successfully'
          })
          this.loadCats()
					$('#productCatModel').modal('hide')
          this.loading=false;

				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},

			getResults(page = 1) {
        this.loading=true;
        axios.get(this.product_cat_url+'/cat-paginated/?page=' + page)
        .then(response => {
            this.productCats = response.data;
            this.loading=false;
        });
      },

			loadCats(){
				axios.get(this.product_cat_url+'/cat-paginated/').then(({data})=>{
					this.productCats=data
					this.productCatLength=this.productCats.data.length
					this.loading=false
				})
			},

			editCat(id){
				this.loading=true
				this.editmode=true
				let vm=this;
				axios.get(this.product_cat_url+'/show/'+id).then(function(response){
					vm.form.fill(response.data)
					$('#productCatModel').modal('show')
					vm.loading=false
				})
			},

			updateCat(){
				this.loading=true
				this.form.put(this.product_cat_url+'/update/'+this.form.id).then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Product\'s Category updated successfully'
          })
          this.loadCats()
					$('#productCatModel').modal('hide')
          this.loading=false;

				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},

			trashCat(id){
				this.loading=true
				this.form.get(this.product_cat_url+'/trash/'+id).then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Product\'s Category moved to trash Successfully'
          })
          this.loadCats()
					$('#productCatModel').modal('hide')
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