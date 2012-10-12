//= require jquery
//= require jquery_ujs
//= require bootstrap-transition
//= require bootstrap-alert

// !! Bootstrap button overriden for compatibility with microsoft style buttons !!
//= require bootstrap-button

//= require bootstrap-collapse
//= require bootstrap-dropdown
//= require bootstrap-modal
//= require bootstrap-tab
//= require bootstrap-tooltip

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
})