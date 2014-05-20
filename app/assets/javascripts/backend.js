//= require jquery
//= require jquery_ujs
//= require vendor
//= require ckeditor/init
//= require backbone-form-hacks

$(document).ready(function(){
  $('select').select2();
});

$('body').tooltip({
    selector: '[rel=tooltip]',
    placement: "top"
});
