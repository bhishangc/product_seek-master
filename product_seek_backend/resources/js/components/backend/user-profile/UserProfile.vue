<template>
	<div class="row justify-content-center">
		<loader v-if='loading'></loader>
		<div class="col-md-8">
			<div class="card">
				<div class="card-header">
					<h6>User Edit</h6>
				</div>
				<form @submit.prevent="updateUser()">
					<div class="card-body">
						

							<div class="form-group">
								<label for="name">Name</label>
			        	<input v-model="form.name" type="text" name="name" class="form-control" :class="{ 'is-invalid': form.errors.has('name') }">
					      <has-error :form="form" field="name"></has-error>
							</div>

							<div class="form-group">
								<label for="phone_number">Contact</label>
			        	<input v-model="form.phone_number" type="tel" name="phone_number" class="form-control" :class="{ 'is-invalid': form.errors.has('phone_number') }">
					      <has-error :form="form" field="phone_number"></has-error>
							</div>

							<div class="form-group">
								<label for="address">Address</label>
			        	<input v-model="form.address" type="text" name="address" class="form-control" :class="{ 'is-invalid': form.errors.has('address') }">
					      <has-error :form="form" field="address"></has-error>
							</div>
					</div>
					<div class="card-footer">
						<button class="btn btn-primary" type="submit">
							<i class="fas fa-check mr-1"></i>Update
						</button>
					</div>
				</form>
					
					
				
			</div>
		</div>
	</div>
</template>
<script>

	export default{
		props:['authenticated_user','admin_url'],
		data(){
			return{
				form:new Form({
					id:'',
					name:'',
					phone_number:'',
					address:'',
				}),
				loading:true,
			}
		},
		methods:{
			loadCurrentUser(){
				let that=this
				axios.get(this.admin_url+'/user-profile/show/'+this.authenticated_user.id).then(function(res){
					that.form.fill(res.data)
					that.loading=false
				})
			},
			updateUser(){
				this.loading=true
				this.form.put(this.admin_url+'/user-profile/update/'+this.form.id).then(()=>{
					this.loadCurrentUser()
					Toast.fire({
            icon: 'success',
            title: 'Profile updated Successfully'
          })
				}).catch((response)=>{
					if(response.message=='Request failed with status code 401'){
						location.reload()
					}
					this.loading=false
				});
			}
		},
		created(){
			this.loadCurrentUser()
		}
	}
	
</script>
