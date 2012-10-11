class App.MapToolbarView extends Backbone.View
  el: ".map-toolbar"
  events: {
    "click .cart" : "toggleHud"
    "click .globe": "setInitialView"
  }
  initialize: ->
    @mapProvider = @options.mapProvider
    @hudView = @options.hudView
    @mapView  = @options.mapView
  toggleHud: (e) ->
    $self = $(e.currentTarget)
    if $self.hasClass("active")
      @hudView.close()
    else 
      @hudView.open()
    @mapProvider.invalidateSize()
  setInitialView: (e) ->
    @mapView.setInitialView()