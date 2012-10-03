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
      zoomLevel: 4
  addLegend: ->
    watermark = L.control({position: "bottomright"})
    watermark.onAdd =  (map) ->
      this._div = L.DomUtil.create('div', 'watermark');
      this._div.innerHTML = "<img src='/assets/dotgee.png'/>"
      return this._div;
    watermark.addTo(@mapProvider.map)
  render: ->
    @mapProvider.createMap(@el.id)
    @addLegend()
    @setInitialView()
