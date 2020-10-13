<template>
<div class="row">
	<loader v-if='loading'></loader>
	<div class="col-md-12">

		<div class="card mt-2">
			<div class="card-header">
				<h4>Feedback</h4>
			</div>
			<div class="card-bodytable-responsive p-0">
				<table class="table table-hover text-nowrap">
          <thead>
            <tr>
              <th>Feedback</th>
              <th>Customer</th>
              <th>Published</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
          	<tr v-if='!fdlength'>
          		<td colspan="3">
          			Sorry no feedbacks!!
          		</td>
          	</tr>
          	<tr v-else v-for='f in feedback.data' :key='f.id'>
          		<td>{{ f.feedback | Trim_title(20) }}</td>
          		<td v-for='u in users' v-if='u.id==f.user_id'>{{ u.name }}</td>
          		<td>{{ f.created_at | myDate }}</td>
          		<td>
          			<button class="btn btn-primary" @click='openModal(f.id)'>
          				<i class="far fa-eye mr-1"></i>View
          			</button>
          		</td>
          		 <!-- Modal -->
							<div class="modal fade" :id="'feedback-'+f.id" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-centered" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h5 class="modal-title" id="exampleModalLongTitle"v-for='u in users' v-if='u.id==f.user_id'>{{ u.name }}</h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <div class="modal-body" style="white-space: normal">
							       {{ f.feedback }}
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
							      </div>
							    </div>
							  </div>
							</div>
          	</tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

 
</div>
</template>
<script>
	export default{
		name:'feedback',
		props:['feedback_url'],

		data(){
			return{
				loading:true,
				feedback:{},
				fdlength:0,
				users:[]
			}
		},


		methods:{

			loadFeedbacks(){
				axios.get(this.feedback_url+'/paginated_feedbacks').then(({data})=>{
					this.feedback=data
					this.fdlength=this.feedback.data.length
					this.loading=false
				})
			},

			getUsers(){
				axios.get(this.feedback_url+'/user/').then(({data})=>{
					this.users=data;
				})
			
			},

			openModal(id){
				$('#feedback-'+id).modal('show')
			}

		},

		created(){
			this.loadFeedbacks()
			this.getUsers()
		}
	}
</script>