/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');


// v-form
import { Form, HasError, AlertError } from 'vform';
window.Form=Form;
Vue.component(HasError.name, HasError);
Vue.component(AlertError.name, AlertError);
// end v-form

import Swal from 'sweetalert2';
const Toast = Swal.mixin({
  toast: true,
  position: 'top-end',
  showConfirmButton: false,
  timer: 3000,
  timerProgressBar: true,
  onOpen: (toast) => {
    toast.addEventListener('mouseenter', Swal.stopTimer)
    toast.addEventListener('mouseleave', Swal.resumeTimer)
  }
})
 window.Toast=Toast;
 

Vue.filter('Trim_title', function(string,num){
  // let array = string.trim().split(' ');
  // let end = string.length > 5 ? '...' : '';
  // return array.slice(0,5).join(' ') + end;
  if(string.length > num){ string = string.substring(0,num)+'...'};
  return string;
});

Vue.filter('dollar', function(string){
    return '$ '+string;
 })

Vue.filter('reverse', function(value) {
  // slice to make a copy of array, then reverse the copy
  return value.slice().reverse();
});

import moment from 'moment';
 Vue.filter('myDate',function(date){
  return moment(date).format('MMMM DD YYYY');
 });

 // pagination component
Vue.component('pagination',require('laravel-vue-pagination'));



Vue.component('loader',require('./components/UI/Loader.vue').default);


// product components
Vue.component('product',require('./components/backend/product/Product.vue').default);
Vue.component('produt-cat',require('./components/backend/product/ProductCategory/Productcategory.vue').default);
Vue.component('produt-cat-trash',require('./components/backend/product/ProductCategory/Trash.vue').default);
// end product components


// store components
Vue.component('store',require('./components/backend/store/Store.vue').default);
// end store components

// feed back component
Vue.component('feedback',require('./components/backend/feedback/Feedback.vue').default);
// end feedback component


// order component
Vue.component('order',require('./components/backend/order/Order.vue').default);
Vue.component('order-return',require('./components/backend/order/OrderReturn.vue').default);
// order component end


// customer component
Vue.component('customer',require('./components/backend/customer/Customer.vue').default);
//customer component

// user profile
Vue.component('user-profile',require('./components/backend/user-profile/UserProfile.vue').default);
// end user profile


const app = new Vue({
    el: '#app',
});
