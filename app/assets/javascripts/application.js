//= require jquery
//= require jquery_ujs
//= require vendor

//= require app
//= require router
//= require_tree ./lib
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views

$('body').tooltip({
    selector: '[rel=tooltip]',
    placement: "top"
});

$( ".draggable" ).draggable({
  handle: '.modal-header'
});

$("a").click(function(e){
  if($(this).hasClass("disabled")) {
    e.preventDefault();
  }
})

