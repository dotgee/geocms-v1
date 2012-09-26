# App or= {}

App.MapProviders or= {}

App.MapProviders.Leaflet = ->
  # Create new map
  createMap: (elementId) ->
    # Specific to EPSG:2154
    bbox = [700000, 6325197, 1060000, 6617738]
    transformation = new L.Transformation(1, -bbox[0], -1, bbox[3])
    crs = L.CRS.proj4js('EPSG:2154',
                        '+proj=lcc +lat_1=49 +lat_2=44 +lat_0=46.5 +lon_0=3 +x_0=700000 +y_0=6600000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
                        transformation)
    crs.scale = @scale
    @map = new L.Map(elementId, {crs: crs, scale: @scale, continuousWorld: true})
    @createLayer("http://geo.devel.dotgee.fr/geoserver/wms", "departements-bretagne_region_2154")
    map
  createLayer: (wms, name) ->
    layer = L.tileLayer.wms(wms, {
      layers: name,
      format: 'image/png',
      transparent: true,
      continuousWorld: true
    })
    @addLayerToMap(layer)
  addLayerToMap: (layer) ->
    @map.addLayer(layer)
  setViewForMap: (options) ->
    point = new L.LatLng(options.latitude, options.longitude)
    @map.setView(point, options.zoomLevel)
  # Specific to EPSG:2154
  scale: (zoom) ->
    return 1 / (1142.7383 / Math.pow(2, zoom))