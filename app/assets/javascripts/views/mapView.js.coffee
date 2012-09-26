class App.MapView extends Backbone.View
  el: "div#map",
  initialize: ->
    @mapProvider = this.options.mapProvider
    @initialCenter = this.options.initialCenter || { latitude: 48.118434, longitude: -1.676239 }
    @render()
  setInitialView: ->
    @mapProvider.setViewForMap
      latitude: @initialCenter.latitude,
      longitude: @initialCenter.longitude
      zoomLevel: 2
  render: ->
    @mapProvider.createMap(@el.id)
    @setInitialView()
