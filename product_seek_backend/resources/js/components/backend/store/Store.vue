<template>
	<div class="row">
	<loader v-if='loading'></loader>
		<div class="col-md-12">
			<div class="col-md-12">
				<div class="row">
					<button class="btn btn-primary mr-1" @click='openModel'>
						<i class="fas fa-plus mr-1"></i>Create Store
					</button>
					<a :href="store_url+'/trashed'">
						<button class="btn btn-danger ">
							<i class="fas fa-trash mr-1"></i>Trash
						</button>
					</a>
				</div>
			</div>

			<div class="card mt-2">
				<div class="card-header">
					<h4>Stores</h4>
				</div>
				<div class="card-body table-responsive p-0">
					<table class="table table-hover text-nowrap">
            <thead>
              <tr>
                <th>Name</th>
                <th>No of Products</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Followers</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
            	<tr v-if='!storesLength'>
            		<td colspan="5">Sorry! no data found</td>
            	</tr>
            	<tr v-else v-for='pc in stores.data' :key='pc.id'>
            		<td>{{ pc.name | Trim_title(15) }}</td>
            		<td>{{ pc.product_store.length }}</td>
            		<td>{{ pc.email }}</td>
            		<td>{{ pc.contact }}</td>
            		<td>{{ pc.user_follow.length }}</td>
            		<td>
            			<button class="btn btn-primary mr-2" @click='editStore(pc.id)'><i class="fas fa-edit mr-2"></i>Edit</button>
            			<button class="btn btn-danger" @click='trashStore(pc.id)'><i class="fas fa-trash mr-2"></i>Trash</button>
            		</td>
            	</tr>
            </tbody>
             <tfoot>
		            <tr>
                <th>Name</th>
                <th>No of Products</th>
                <th>Email</th>
                <th>Contact</th>
                <th>Followers</th>
                <th>Action</th>
              </tr>
		          </tfoot>
          </table>
				</div>
				<div class="card-footer">
					<pagination :data="stores" @pagination-change-page="getResults"></pagination>
				</div>
			</div>

			<div class="modal fade" id="storeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			      	<h5 class="modal-title" v-if='editmode'id="exampleModalLongTitle">Edit Store</h5>
			        <h5 class="modal-title" v-else id="exampleModalLongTitle">Create Store</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <form @submit.prevent="editmode? updateStore() : createStore()">
				      <div class="modal-body">
				      	<div class="form-group">
				      		<div class="row justify-content-center">
				      			<figure class="image-preview" v-if='form.store_image!=null'>
			                <img :src="form.store_image" id='preview_image' alt="">
			                <figcaption>
			                  <a href="" class="reset_image" @click.prevent='resetImage'>Remove</a>
			                </figcaption>
			              </figure>
				      		</div>
			      			<div class="file-field text-center">
		                <div class="file btn btn-primary">
		                  <i class="fa fa-image mr-1"></i><span  v-if='!form.store_image'>Add store image</span><span  v-else>Change store images</span>
		                  <input type="file"  @change='StoreImgSelected' multiple>
		                </div>
			            </div>
				      	</div>
				        <div class="form-group">
				        	<label for="name">Store's name</label>
			        		<input v-model="form.name" type="text" name="name" class="form-control" :class="{ 'is-invalid': form.errors.has('name') }" placeholder="Store's Name">
					      <has-error :form="form" field="name"></has-error>
				        </div>
				         <div class="form-group">
				        	<label for="email">Email</label>
			        		<input v-model="form.email" type="email" name="email" class="form-control" :class="{ 'is-invalid': form.errors.has('email') }" placeholder="Email">
					      <has-error :form="form" field="name"></has-error>
				        </div>
			          <div class="form-group">
				        	<label for="contact">Contact</label>
			        		<input v-model="form.contact" type="tel" name="contact" class="form-control" :class="{ 'is-invalid': form.errors.has('contact') }" placeholder="Contact">
					      <has-error :form="form" field="contact"></has-error>
				        </div>
				        <div class="form-group">
				        	<label for="address">Address</label>
			        		<input v-model="form.address" type="text" name="address" class="form-control" :class="{ 'is-invalid': form.errors.has('address') }" placeholder="Address">
					      <has-error :form="form" field="contact"></has-error>
				        </div>
				         <div class="form-group">
				        	<label for="google_maps_url">Google Map Url</label>
			        		<input v-model="form.google_maps_url" type="url" name="google_maps_url" class="form-control" :class="{ 'is-invalid': form.errors.has('google_maps_url') }" placeholder="Google Map Url">
					      <has-error :form="form" field="google_maps_url"></has-error>
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
		name:'store',
		props:['store_url'],
		data(){
			return{

				form:new Form({
					id:'',
					name:'',
					store_image:null,
					email:'',
					contact:'',
					address:'',
					google_maps_url:'',
				}),

				stores:{},
				storesLength:null,
				editmode:false,
				loading:true,
				
			}
		},
		methods:{
			openModel(){
				this.editmode=false
				this.form.clear()
				this.form.reset()
				$('#storeModal').modal('show')
			},
			StoreImgSelected(event){
				let selectedFile= event.target.files[0];
				let reader= new FileReader();

				if (selectedFile['size'] < 5242880){
					reader.onloadend=(selectedFile)=>{
						this.form.store_image=reader.result;
					}
					reader.readAsDataURL(selectedFile);
				}else{
					this.resetImage();
          Swal.fire(
            'Opps!!',
            'File size exceeds 2MB.',
            'error'
          )
				}
			},

			resetImage(){
				this.form.store_image=null;
			},
			createStore(){
				this.loading=true
				this.form.post(this.store_url+'/store/').then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Store Created successfully'
          })
          this.loadStore()
					$('#storeModal').modal('hide')
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
        axios.get(this.store_url+'/cat-paginated/?page=' + page)
        .then(response => {
            this.stores = response.data;
            this.loading=false;
        });
      },

			loadStore(){
				axios.get(this.store_url+'/store-paginated/').then(({data})=>{
					this.stores=data
					this.storesLength=this.stores.data.length
					this.loading=false
				})
			},

			editStore(id){
				this.loading=true
				this.editmode=true
				let vm=this;
				axios.get(this.store_url+'/show/'+id).then(function(response){
					vm.form.fill(response.data)
					$('#storeModal').modal('show')
					vm.loading=false
				})
			},

			updateStore(){
				this.loading=true
				this.form.put(this.store_url+'/update/'+this.form.id).then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Store updated successfully'
          })
          this.loadStore()
					$('#storeModal').modal('hide')
          this.loading=false;

				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},

			trashStore(id){
				this.loading=true
				this.form.get(this.store_url+'/trash/'+id).then(()=>{

					Toast.fire({
            icon: 'success',
            title: 'Store moved to trash Successfully'
          })
          this.loadStore()
					$('#storeModal').modal('hide')
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
			this.loadStore()
		}
	}
</script>
<style scoped>
.file {
  position: relative;
  overflow: hidden;
  cursor: pointer!important;
}
.file input {
  position: absolute;
  opacity: 0;
  right: 0;
  top: 0;
  cursor: pointer!important
}
	 .image-preview {
    margin:0 !important;
  }
  figure{
  	position: relative;
  }
  .image-preview img{
    width:250px;
    padding:10px;
    filter:brightness(50%)
  }
  .reset_image{
    color: white;
    visibility:hidden;
    position: absolute;
    bottom: 5%;
    padding:1em;
  }
  
  .image-preview:hover .reset_image{
    visibility: visible;
  }
  .display-grid-justify-center{
    display: grid;
    justify-content: center;
    justify-items: center;
    width: 100%;
  }
  
</style>