class App.MapToolbarView extends Backbone.View
  el: ".map-toolbar"
  events: {
    "click .cart" : "toggleHud"
    "click .globe": "setInitialView"
  }
  initialize: ->
    @parent       = @options.parentView
    @mapProvider  = @parent.mapProvider
    @mapView      = @parent.mapView
  toggleHud: (e) ->
    $self = $(e.currentTarget)
    if $self.hasClass("active")
      @parent.close()
    else 
      @parent.open()
    @mapProvider.invalidateSize()
  setInitialView: (e) ->
    @mapView.setInitialView()