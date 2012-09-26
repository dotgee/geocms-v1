;(function($) {

  $.hudPanel = function(el, options) {

    var defaults = {
      opened: false,
    }

    var plugin = this;

    plugin.settings = {}

    var init = function() {
      plugin.settings = $.extend({}, defaults, options);
      plugin.el = el;
      // code goes here
    }

    plugin.toggle = function() {
      if($("body").hasClass("editor")) {
        $(".hud").css("left", "-33.33333333%");
        $("#map").css("left", "0%");
        $("body").removeClass("editor");
      } else {
        $(".hud").css("left", "0%");
        $("#map").css("left", "33.33333333%");
        $("body").addClass("editor");
      }
    }

    var foo_private_method = function() {
      // code goes here
    }

    init();

  }

})(jQuery);