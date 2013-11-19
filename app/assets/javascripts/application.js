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

$(".draggable").draggable({
  handle: '.modal-header'
});

$("a").click(function (e) {
  if ($(this).hasClass("disabled")) {
    e.preventDefault();
  }
});

function startProgress() {
  if ($("#progress").length === 0) {
    $("body").append($("<div><dt/><dd/></div>").attr("id", "progress"));
    $("#progress").width((50 + Math.random() * 30) + "%");
  }
}

function stopProgress() {
  //End loading animation
  $("#progress").width("101%").delay(200).fadeOut(400, function () {
    $(this).remove();
  });
}

$(document).ajaxComplete(function () {
  stopProgress();
});

$(document).ajaxStart(function () {
  startProgress();
});
