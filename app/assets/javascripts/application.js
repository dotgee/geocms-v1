//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require hamlcoffee

//= require vendor
//= require app
//= require router
//= require_tree ./lib
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree ./templates

//= require hud_panel

var hud = new $.hudPanel($('.hud'));

// $(".toggle-hud").click(function(e){
//   hud.toggle();
// });

// $(".layer a").click(function(e){
//   var _self = $(this);
//   e.preventDefault();
//   addLayer(_self.parent());
// });

// $(".add-layer").click(function(e){
//   var _self = $(this);
//   e.preventDefault();
//   $(".selector").toggleClass("active");
// });