class App.MapView extends Backbone.View
  el: "div#map",
  initialize: ->
    @mapProvider = @options.mapProvider
    @parent = @options.parentView
    unless @parent.model.isNew()
      initialCenter = @parent.model.getInitialCenter()
    @initialCenter = initialCenter || { latitude: @$el.data("latitude"), longitude: @$el.data("longitude"), zoom: @$el.data("zoom") }
    @render()
  setInitialView: ->
    @mapProvider.setViewForMap
      latitude:  @initialCenter.latitude,
      longitude: @initialCenter.longitude
      zoomLevel: @initialCenter.zoom
  addBaseLayer: ->
    streets = new L.TileLayer('http://a.tiles.mapbox.com/v3/impeyal.map-y0tjnwbb/{z}/{x}/{y}.png', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
        'Imagery © <a href="http://mapbox.com/">MapBox</a>'
    })
    @mapProvider.addLayerToMap(streets)
  addWatermark: ->
    watermark = L.control({position: "bottomright"})
    watermark.onAdd =  (map) ->
      @_div = L.DomUtil.create('div', 'watermark');
      @_div.innerHTML = "<img src='/assets/dotgee.png'/>"
      @_div;
    watermark.addTo(@mapProvider.map)
  addGetFeatures: ->
    features = L.control({position: "bottomleft"})
    features.onAdd= ->
      @_div = L.DomUtil.create('div', 'features-infos');
      @_div.innerHTML = "<div class='table-results'></div>"
      @_div
    @mapProvider.map.addControl(features)
  addLegend: ->
    @legend = L.control({position: "bottomright"})
    @legend.onAdd = (map) ->
      @_div = L.DomUtil.create("div", "legend")
      @_div
    @legend.onUpdate = (layer) ->
      $(@_div).append("<h5>"+layer.get("name")+"</h5>")
    @mapProvider.map.addControl(@legend)
  render: ->
    @mapProvider.createMap(@el.id)
    @addBaseLayer()
    @addWatermark()
    @addLegend()
    @addGetFeatures()
    @setInitialView()
