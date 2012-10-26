//= require jquery
//= require jquery_ujs
//= require vendor

//= require app
//= require router
//= require_tree ./lib
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree ./templates

$(".navbar-inner").find(".m-btn").tooltip({
  placement: "bottom"
});

// $(".category, .back-category").live("click", function(e){
//   e.preventDefault();
//   $.get(this.href, function(data) {
//     $('#categories').html(data);
//   })
// });