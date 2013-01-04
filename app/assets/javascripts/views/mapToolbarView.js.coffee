class App.MapToolbarView extends Backbone.View
  events: {
    "click .legend" : "toggleLegend"
    "click .togglehud" : "toggleHud"
    "click .globe": "setInitialView"
    # "click .tools": "localize"
    "click .fullscreen": "fullscreen"
  }
  initialize: ->
    @parent       = @options.parentView
    @mapProvider  = @parent.mapProvider
    @mapView      = @parent.mapView
    @$togglehud   = @$el.find(".togglehud i")
  toggleHud: () ->
    $e = @$togglehud
    if $e.hasClass("m-icon-swapright")
      @openHud()
    else
      @closeHud()
  closeHud: ->
    @parent.close()
    @$togglehud.removeClass("m-icon-swapleft").addClass("m-icon-swapright")
  openHud: ->
    @parent.open()
    @$togglehud.removeClass("m-icon-swapright").addClass("m-icon-swapleft")
  toggleLegend: (e) ->
    @parent.legend.toggleShow()
  fullscreen: (e) ->
    $e = $(e.currentTarget)
    if $e.hasClass("active")
      $(".wrapper").css("top", "50px")
      @openHud()
    else
      $(".wrapper").css("top", 0)
      @closeHud()
  setInitialView: (e) ->
    @mapView.setInitialView()
