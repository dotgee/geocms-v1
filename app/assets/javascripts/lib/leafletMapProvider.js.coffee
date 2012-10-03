# App or= {}

App.MapProviders or= {}

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
    osm = L.tileLayer.wms("http://osm.geobretagne.fr/gwc01/service/wms", {
      layers: "osm:google",
      format: 'image/png',
      transparent: true,
      continuousWorld: true
    })
    console.log(osm)
    @addLayerToMap(osm)
    map
  addLayerToMap: (layer) ->
    @map.addLayer(layer)
  setViewForMap: (options) ->
    point = new L.LatLng(options.latitude, options.longitude)
    @map.setView(point, options.zoomLevel)
  # Specific to EPSG:2154
  scale: (zoom) ->
    return 1 / (4891.96875 / Math.pow(2, zoom))