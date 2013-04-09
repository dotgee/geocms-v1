window.App.MapProviders or= {}
app = window.App
map = undefined

app.ProxyURL = '/proxy.php?url='

tableToJSON = (data) ->
  p = {}
  headers = $(data).find("th")
  row = $(data).find("tr:last-child").find("td")
  i = 0
  _.each(headers, (header) ->
    key = header.textContent
    value = row[i].textContent
    p[key] = value
    i++
  )
  p

App.MapProviders.Leaflet = ->

  createMap: (elementId) ->
    @map = if app.crs? then new L.Map(elementId, {crs: app.crs, continuousWorld: true}) else new L.Map(elementId)
    @map.attributionControl.addAttribution("Developed by <a href='http://www.dotgee.fr' target='_blank'>Dotgee</a>")
    map = @map

  addLayerToMap: (layer) ->
    @map.addLayer(layer)

  removeLayerFromMap: (layer) ->
    @map.removeLayer(layer)

  setViewForMap: (options) ->
    point = new L.LatLng(options.latitude, options.longitude)
    @map.setView(point, options.zoomLevel)

  invalidateSize: ->
    @map.invalidateSize()

  toggleClicListener: (status, layer) ->
    if status
      $("#map").css("cursor", "crosshair")
      @map.addEventListener('click', @getFeatureWMS)
      @map.queryable_layer = layer
    else
      $("#map").css("cursor", "")
      @map.removeEventListener('click', @getFeatureWMS)
      @map.queryable_layer = undefined
      $featuresInfos = $(".features-infos")
      unless $featuresInfos.css("display") == "none"
        $featuresInfos.slideToggle()

  getFeatureWMS: (e) ->
    box =  new App.MapProviders.Leaflet().bboxToProj(map.getBounds())
    BBOX = box.join(",")
    EPSG = app.dest_string
    WIDTH = map.getSize().x
    HEIGHT = map.getSize().y
    x = map.layerPointToContainerPoint(e.layerPoint).x
    y = map.layerPointToContainerPoint(e.layerPoint).y

    URL = map.queryable_layer.data_source.wms+'?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&LAYERS='+map.queryable_layer.name+'&QUERY_LAYERS='+map.queryable_layer.name+'&STYLES=&'+
          'BBOX='+BBOX+'&HEIGHT='+HEIGHT+'&WIDTH='+WIDTH+'&FORMAT=image/png&INFO_FORMAT=text/html&'+
          'SRS='+EPSG+'&X='+x+'&Y='+y
    if map.queryable_layer.currentTime
      URL += '&TIME='+map.queryable_layer.currentTime

    $.ajax
      url: app.ProxyURL + encodeURIComponent(URL)
      dataType: "html"
      type: "GET"
      success: (data) ->
        if(data.indexOf("<table") > -1)
          data = tableToJSON(data)
          template = map.queryable_layer.template
          content = Mustache.render(template, data)
        else
          content = "Pas d'informations disponibles sur ce point."
        popup = L.popup({ maxWidth: 800, maxHeight: 600 })
            .setLatLng(e.latlng)
            .setContent(content)
            .openOn(map)

  bboxToProj: (bounds) ->
    app.bboxToProj(bounds)

  bboxTo4326: (bounds) ->
    app.bboxTo4326(bounds)

  arrayToLatLngBounds: (array, srs) ->
    ne = if srs == "CRS:84" then new L.LatLng(array[3], array[2]) else new L.LatLng(array[2], array[3])
    sw = if srs == "CRS:84" then new L.LatLng(array[1], array[0]) else new L.LatLng(array[0], array[1])
    new L.LatLngBounds(sw, ne)

  fitBounds: (bounds) ->
    @map.fitBounds(bounds)

  invalidateSize: ->
    @map.invalidateSize()
