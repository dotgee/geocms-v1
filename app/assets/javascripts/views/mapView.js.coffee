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
    osm = L.tileLayer.wms("http://osm.geobretagne.fr/gwc01/service/wms", {
      layers: "osm:google",
      format: 'image/png',
      transparent: true,
      continuousWorld: true,
      unloadInvisibleTiles: false,
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
        'Imagery © <a href="http://geobretagne.fr/accueil/">GeoBretagne</a>'
    })
    @mapProvider.addLayerToMap(osm)
  addWatermark: ->
    watermark = L.control({position: "bottomright"})
    watermark.onAdd =  (map) ->
      @_div = L.DomUtil.create('div', 'watermark');
      @_div.innerHTML = "<img src='/assets/dotgee.png'/>"
      @_div;
    watermark.addTo(@mapProvider.map)
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
    @setInitialView()
