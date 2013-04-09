#
# Defines all variables and functions relative to EPSG:2154
#


Proj4js.defs["EPSG:2154"] = '+proj=lcc +lat_1=49 +lat_2=44 +lat_0=46.5 +lon_0=3 +x_0=700000 +y_0=6600000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs'

app = window.App

source = new Proj4js.Proj('EPSG:4326')
dest = new Proj4js.Proj('EPSG:2154')
app.dest_string = "EPSG:2154"

scale = (zoom) ->
  return 1 / (4891.96875 / Math.pow(2, zoom))

bbox = [-357823.236499999999, 6037008.69390000030,
        894521.034699999960, 7289352.96509999968]
transformation = new L.Transformation(1, -bbox[0], -1, bbox[1])
app.crs = L.CRS.proj4js('EPSG:2154',
            '+proj=lcc +lat_1=49 +lat_2=44 +lat_0=46.5 +lon_0=3 +x_0=700000 +y_0=6600000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
            transformation)

app.crs.scale = scale

app.base = L.tileLayer.wms("http://osm.geobretagne.fr/gwc01/service/wms", {
  layers: "osm:google",
  format: 'image/png',
  transparent: true,
  continuousWorld: true,
  unloadInvisibleTiles: false,
  attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
    '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    'Imagery © <a href="http://geobretagne.fr/accueil/">GeoBretagne</a>'
})

app.base.title = "OpenStreetMap"

app.base.bbox = 
  "EPSG:2154":
    table:
      bbox: [-357823.236499999999, 6037008.69390000030, 894521.034699999960, 7289352.96509999968]

app.bboxToProj = (bounds) ->
  ne = new Proj4js.Point(bounds._northEast.lng, bounds._northEast.lat)
  Proj4js.transform(source, dest, ne)
  sw = new Proj4js.Point(bounds._southWest.lng, bounds._southWest.lat)
  Proj4js.transform(source, dest, sw)
  [sw.x, sw.y, ne.x, ne.y]

app.bboxTo4326 = (bounds) ->
  ne = new Proj4js.Point(bounds[2], bounds[3])
  Proj4js.transform(dest, source, ne)
  sw = new Proj4js.Point(bounds[0], bounds[1])
  Proj4js.transform(dest, source, sw)
  new L.LatLngBounds(new L.LatLng(sw.y, sw.x) , new L.LatLng(ne.y, ne.x))