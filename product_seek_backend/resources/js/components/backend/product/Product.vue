<template>
	<div class="row">
		<loader v-if='loading'></loader>
		<div class="col-md-12">
			<button class="btn btn-primary" @click='openModal'>
				<i class="fas fa-plus mr-1"></i>
				Add product
			</button>
			<button class="btn btn-danger" @click='openTrash'>
				<i class="fas fa-trash mr-1"></i>
				Trash
			</button>
		</div>
		<div class="col-md-12">
			<div class="card mt-2">
				<div class="card-header">
					<h5>Products</h5>
				</div>
				<div class="card-bodytable-responsive p-0">
					<table class="table table-hover text-nowrap">
            <thead>
              <tr>
                <th>Name</th>
                <th>Category</th>
                <th>Store</th>
                <th>Price</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
            	<tr v-if='!productsLength'>
            		<td colspan="5">Sorry no data found!!</td>
            	</tr>
            	<tr v-else v-for='p in products.data' :key='p.id' >
            		<td>{{ p.title }}</td>
            		<td><span v-for='c in p.product_category' :key='c.id'>{{ c.name }}</span></td>
            		<td><span v-for='s in p.product_store' :key='s.id'>{{ s.name }}</span></td>
            		<td>$ {{ p.price }}</td>
            		<td>
            			<button class="btn btn-primary mr-1" @click='editProduct(p.id)'><i class="fas fa-edit mr-2"></i>Edit</button>
            			<button class="btn btn-secondary mr-1" disabled v-if='!p.product_review.length'> <i class='fas fa-eye mr-1'></i>Reviews</button>
            			<button class="btn btn-success mr-1" v-else @click='showReview(p.product_review)'> <i class='fas fa-eye mr-1'></i>Reviews</button>
            			<button class="btn btn-danger" @click='trashProducts(p.id)'><i class="fas fa-trash mr-1"></i>Trash</button>
            		</td>
            	</tr>
            </tbody>
          </table>
        </div>
        <div class="card-footer">
					<pagination :data="products" @pagination-change-page="getResults"></pagination>
				</div>
      </div>
		</div>




		<!-- product model -->
		<div class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
		  <div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		      	<h5 class="modal-title" v-if='editMode'id="exampleModalLongTitle">Edit Product</h5>
		        <h5 class="modal-title" v-else id="exampleModalLongTitle">Add new Product</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <form @submit.prevent="editMode?updateProduct() : addProduct()">
			      <div class="modal-body">
			      	<div class="row">
				        <div class="col-md-6 form-group">
					        <label for="title">Title</label>
				        	<input v-model="form.title" type="text" name="title" class="form-control" :class="{ 'is-invalid': form.errors.has('title') }" placeholder="Title">
						      <has-error :form="form" field="title"></has-error>
				        </div>
				        <div class="col-md-6 form-group">
					        <label for="price">Price</label>
				        	<input v-model="form.price" type="number" name="price" class="form-control" :class="{ 'is-invalid': form.errors.has('price') }">
						      <has-error :form="form" field="price"></has-error>
				        </div>
				        <div class="col-md-6 form-group">
					        <label for="category">Category</label>
				        	<select class="form-control" required v-model='form.category_id'>
				        		<option value="" selected disabled> Select category </option>
				        		<option v-for='cat in categories':key='cat.id' :value="cat.id"> {{ cat.name }} </option>
				        	</select>
				        </div>
				        <div class="col-md-6 form-group">
					        <label for="store">Store</label>
				        	<select class="form-control" required v-model='form.store_id'>
				        		<option value="" selected disabled> Select Store </option>
				        		<option v-for='s in stores':key='s.id' :value="s.id"> {{ s.name }} </option>
				        	</select>
				        </div>
				        <div class="col-md-12">
				        	<div class="card ">
							     	<div class="card-header">
							     		<h6>Product Images</h6>
							     	</div>
										<div class="card-body">
								     	<div class="row m-auto" v-if='form.product_image.length'>
								     		<div class="p-image" v-for='img,index in form.product_image'>
								     			<figure>
									     			<img :src="img"alt="">
									     			<figcaption @click='removeImg(index)'>
									     				<i class="fas fa-times"></i>
									     			</figcaption>
								     			</figure>
								     		</div>	
								     	</div>
								     	<p style='margin:0;'v-else>Add some product images</p>
							     	</div>
							     	<div class="card-footer">
							     		<div class="row">
							     		<div class="mr-2" v-if='form.product_image.length>1'>
							     			<button class="btn btn-danger" @click='removeallimage'><i class="fas fa-trash mr-1"></i>Clear all</button>
							     		</div>
							 
							     		<div class="file-field text-center">
				                <div class="file btn btn-primary">
				                  <i class="fa fa-image mr-1"></i><span  v-if='!form.product_image.length'>Add Product image</span><span  v-else>Add more product images</span>
				                  <input type="file"  @change='productImageSelected' multiple>
				                </div>
					            </div>
					          
					            </div>
							     	</div>
						      </div>
				        </div>
				         <div class="col-md-12">
				         	<input type="checkbox" v-model='hasWarrenty'>
				        	<label for="warrenty">Does this product has Warrenty??</label>
				        </div>
				        <div class="form-group">
					        <div class="col-md-12" v-if='hasWarrenty'>
					        	<label for="warrenty">Warrenty</label>
					        	<input v-model="form.warrenty" type="text" name="warrenty" class="form-control" :class="{ 'is-invalid': form.errors.has('warrenty') }" placeholder="warrenty">
							      <has-error :form="form" field="warrenty"></has-error>
					        </div>
				        </div>

				        <div class="col-md-12">
				        	<label for="description">Description</label>
				        	<textarea name="description" class='form-control' rows="10" v-model='form.description':class="{ 'is-invalid': form.errors.has('description') }"></textarea>
				        	<has-error :form="form" field="description"></has-error>
				        </div>
				       
				      </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			        <button type="submit" v-if='editMode' class="btn btn-primary">Update product</button>
			        <button type="submit" v-else class="btn btn-primary">Add product</button>
			      </div>
		      </form>
		    </div>
		  </div>
		</div>
		<!-- end product model -->

		<!-- trashed products  model-->
		<div class="modal fade" id="trashproduct" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
		  <div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLongTitle">Trash</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- trashed products  model-->

		<div class="modal fade" id="review-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content" v-if='currentUser  || currentReview'>
		      <div class="modal-header">
		        <h5 class="modal-title" id="staticBackdropLabel">Reviews</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <ul class="review">
		        	<li v-for='r in currentReview' :key='r.id'>
		        		<p>{{ r.review }}</p>
		        		<span>- {{ showReviewuser(r.user_id) }}</span>
		        	</li>
		        </ul>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
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
				products:{},
				productsLength:'',
				editMode:false,
				hasWarrenty:false,
				form: new Form({
					id:'',
					title:'',
					price:'',
					description:'',
					product_image:[],
					store_id:'',
					warrenty:'',
					category_id:'',
				}),
				current_product_images:[],
				categories:[],
				stores:[],
				currentUser:[],
				currentReview:[],
			}
		},
		methods:{
			openModal(){
				this.editMode=false
				this.form.clear()
				this.form.reset()
				$('#productModal').modal('show')
			},

			productImageSelected(event){
      	let fileList = Array.prototype.slice.call(event.target.files);

      	fileList.forEach(f => {
	        let reader = new FileReader();
	        let that = this;
	      	if (f['size'] < 2111775) {
		        reader.onload = function (event) {
		          that.form.product_image.push(event.target.result);
		        }
		      }else{
		      	Swal.fire(
	            'Opps!!',
	            'File size exceeds 2MB.',
	            'error'
	          );
		      }
	        reader.readAsDataURL(f); 
	      });
			},

			removeImg(index){
				this.form.product_image.splice(index,1)
			},

			removeallimage(){
				this.form.product_image=[];
			},

			addProduct(){
				this.loading=true
				this.form.post(this.admin_url+'/product/store/').then(()=>{
					Toast.fire({
            icon: 'success',
            title: 'Product\'s added successfully'
          })
         	this.loadProducts()
          this.loading=false
					$('#productModal').modal('hide')
				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},

			loadCategory(){
				axios.get(this.admin_url+'/product/category/all-categories').then(({data})=>{
					this.categories=data
				});
			},

			loadStore(){
				axios.get(this.admin_url+'/store/all-store').then(({data})=>{
					this.stores=data
				});
			},

			loadProducts(){
				axios.get(this.admin_url+'/product/product-paginated').then(({data})=>{
					this.products=data
					this.productsLength=this.products.data.length
					this.loading=false
				})
			},

			getIdarray(array){
      	 let categories_id=array[0]['id']; 
          return categories_id;
      },

			editProduct(id){
				this.editMode=true
				this.loading=true
				let vm=this
				this.form.get(this.admin_url+'/product/show/'+id).then(function(response){
					vm.form.fill(response.data)
					let product=response.data
					if(vm.form.warrenty!='no warrenty'){
						vm.hasWarrenty=true;
					}else{
						vm.form.warrenty='';
					}

					vm.form.category_id=vm.getIdarray(product.product_category)
					vm.form.store_id=vm.getIdarray(product.product_store)
					vm.current_product_images=response.data.product_image;
					$('#productModal').modal('show')
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
        axios.get(this.admin_url+'/product/product-paginated/?page=' + page)
        .then(response => {
            this.products = response.data;
            this.loading=false;
        });
      },

			updateProduct(){
				this.loading=true
				this.form.put(this.admin_url+'/product/update/'+this.form.id).then(()=>{
					this.loadProducts()
					Toast.fire({
            icon: 'success',
            title: 'Product Updated successfully'
          })
          $('#productModal').modal('hide')
					this.loading=false
				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},

			trashProducts(id){
				this.loading=true
				this.form.get(this.admin_url+'/product/trash/'+id).then(()=>{
					this.loadProducts()
					Toast.fire({
            icon: 'success',
            title: 'Product moved to trash successfully'
          })
					this.loading=false
				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			},
			openTrash(){
				$('#trashproduct').modal('show')
			},

			showReview(review){
				this.currentReview=review
				$('#review-modal').modal('show')
			},

			showReviewuser(user_id){
				let user={};
				this.currentUser.forEach(u=>{
					if(u.id==user_id){
						user=u;
					}
				});

				return user.name;
			},

			getUser(){
				let that=this
				axios.get(this.admin_url+'/user-profile/all-user/').then(function(res){
					that.currentUser=res.data
				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			}

		},
		created(){
			this.getUser()
			this.loadCategory()
			this.loadStore()
			this.loadProducts()
		}
	}
</script>
<style scoped lang='scss'>
	.p-image{
		margin: 5px;
		figure{
			position: relative;
			height: 110px;
			width: 110px;
			margin-bottom: 0;
			img{
				height: 100%;
				width: 100%;
				object-fit: cover;
			}
			figcaption{
				position: absolute;
				top: 0;
				right: 0;
				cursor: pointer;
				i{
					background: white;
					padding:3px;
					border: 1px solid #bcbcbc;
				}
			}
		}
		
	}
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
.review{
	list-style: none;
	padding:0;
	li{
		padding: 0.5em;
		span{
			font-weight: bold;
		}
		border-bottom: 1px solid #bcbcbc;
	}
}

</style>