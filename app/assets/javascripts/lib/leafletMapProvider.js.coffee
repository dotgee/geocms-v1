window.App.MapProviders or= {}
map = undefined
Proj4js.defs["EPSG:2154"] = '+proj=lcc +lat_1=49 +lat_2=44 +lat_0=46.5 +lon_0=3 +x_0=700000 +y_0=6600000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'

dest = new Proj4js.Proj('EPSG:2154')
source = new Proj4js.Proj('EPSG:4326')
dest_string = "EPSG:2154"

App.MapProviders.Leaflet = ->
  # Create new map
  createMap: (elementId) ->
    # Specific to EPSG:2154
    bbox = [-357823.236499999999, 6037008.69390000030,
            894521.034699999960, 7289352.96509999968]
    transformation = new L.Transformation(1, -bbox[0], -1, bbox[1])
    crs = L.CRS.proj4js('EPSG:2154',
                        '+proj=lcc +lat_1=49 +lat_2=44 +lat_0=46.5 +lon_0=3 +x_0=700000 +y_0=6600000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
                        transformation)
    crs.scale = @scale
    @map = new L.Map(elementId, {crs: crs, continuousWorld: true})
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
      @map.addEventListener('click', @getFeatureWMS)
      @map.queryable_layer = layer
    else
      @map.removeEventListener('click', @getFeatureWMS)
      @map.queryable_layer = undefined
      $featuresInfos = $(".features-infos")
      unless $featuresInfos.css("display") == "none"
        $featuresInfos.slideToggle()
  # Specific to EPSG:2154
  scale: (zoom) ->
    return 1 / (4891.96875 / Math.pow(2, zoom))
  getFeatureWMS: (e) ->
    # EPSG:2154
    box =  new App.MapProviders.Leaflet().bboxTo2154(map.getBounds())

    BBOX = box.join(",")
    EPSG = dest_string
    WIDTH = map.getSize().x
    HEIGHT = map.getSize().y
    x = map.layerPointToContainerPoint(e.layerPoint).x
    y = map.layerPointToContainerPoint(e.layerPoint).y

    URL = map.queryable_layer.data_source.wms+'?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetFeatureInfo&LAYERS='+map.queryable_layer.name+'&QUERY_LAYERS='+map.queryable_layer.name+'&STYLES=&'+
          'BBOX='+BBOX+'&HEIGHT='+HEIGHT+'&WIDTH='+WIDTH+'&FORMAT=image%2Fpng&INFO_FORMAT=text%2Fhtml&'+
          'SRS='+EPSG+'&X='+x+'&Y='+y
    $.ajax
      # Todo:  add proxy
      url: URL
      dataType: "html"
      type: "GET"
      success: (data) ->
        $featuresInfos = $(".features-infos")
        $(".table-results").html(data)
        $featuresInfos.find("table").addClass("table")
        unless $featuresInfos.css("display") == "block"
          $featuresInfos.slideToggle()
  bboxTo2154: (bounds) ->
    ne = new Proj4js.Point(bounds._northEast.lng, bounds._northEast.lat)
    Proj4js.transform(source, dest, ne)
    sw = new Proj4js.Point(bounds._southWest.lng, bounds._southWest.lat)
    Proj4js.transform(source, dest, sw)
    [sw.x, sw.y, ne.x, ne.y]
