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

  addControls: ->
    drawControl = new L.Control.Draw(
      position: "topleft"
      marker: false
      rectangle: false
      polygon:
        title: "Dessiner un polygon"
        allowIntersection: false
        drawError:
          color: "#b00b00"
          timeout: 1000

        shapeOptions:
          color: "#bada55"

      circle:
        shapeOptions:
          color: "#662d91"
    )
    @mapProvider.map.addControl drawControl

    drawnItems = new L.LayerGroup()
    @mapProvider.map.on "draw:polyline-created", (e) ->
      drawnItems.addLayer e.poly
      e.poly.bindPopup('Distance: '+ formatDistance(e.poly.distanceInMeters())).openPopup()

    @mapProvider.map.on "draw:polygon-created", (e) ->
      drawnItems.addLayer e.poly
      #e.poly.bindPopup('Surface: '+ formatSurface(e.poly.areaInMeters())).openPopup()

    @mapProvider.map.on "draw:rectangle-created", (e) ->
      drawnItems.addLayer e.rect

    @mapProvider.map.on "draw:circle-created", (e) ->
      drawnItems.addLayer e.circ

    @mapProvider.map.on "draw:marker-created", (e) ->
      e.marker.bindPopup "A popup!"
      drawnItems.addLayer e.marker

    @mapProvider.map.addLayer drawnItems


  render: ->
    @mapProvider.createMap(@el.id)
    @addBaseLayer()
    @addWatermark()
    @addLegend()
    @setInitialView()
    @addControls()

formatSurface = (surface)->
  if (surface  > 1000) then (surface  / 1000).toFixed(2) + ' km' else Math.ceil(surface) + ' m'

formatDistance = (distance)->
  if (distance  > 1000000) then (distance  / 1000000).toFixed() + ' km' else Math.ceil(distance) + ' m'

