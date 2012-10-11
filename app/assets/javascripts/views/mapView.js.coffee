class App.MapView extends Backbone.View
  el: "div#map",
  initialize: ->
    @mapProvider = this.options.mapProvider
    @initialCenter = this.options.initialCenter || { latitude: @$el.data("latitude"), longitude: @$el.data("longitude") }
    @render()
  setInitialView: ->
    @mapProvider.setViewForMap
      latitude: @initialCenter.latitude,
      longitude: @initialCenter.longitude
      zoomLevel: @$el.data("zoom")
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
      $(@_div).append("<h5>"+layer.attributes.name+"</h5>")
    @mapProvider.map.addControl(@legend)
  render: ->
    @mapProvider.createMap(@el.id)
    @addBaseLayer()
    @addWatermark()
    @addLegend()
    @addGetFeatures()
    @setInitialView()
