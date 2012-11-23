class App.MapToolbarView extends Backbone.View
  events: {
    "click .legend" : "toggleLegend"
    "click .swapleft" : "toggleHud"
    "click .globe": "setInitialView"
    "click .geoloc": "localize"
  }
  initialize: ->
    @parent       = @options.parentView
    @mapProvider  = @parent.mapProvider
    @mapView      = @parent.mapView
  toggleHud: (e) ->
    @parent.close()
  toggleLegend: (e) ->
    @parent.legend.toggleShow()
  localize: (e) ->
    @mapProvider.map.locate({ setView: true, enableHighAccuracy: true, maxZoom: 10 })
  setInitialView: (e) ->
    @mapView.setInitialView()
