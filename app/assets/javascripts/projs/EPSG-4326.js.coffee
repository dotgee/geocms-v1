app = window.App

app.dest_string = "EPSG:4326"
app.base = L.tileLayer("http://{s}.tiles.mapbox.com/v3/impeyal.map-el9s7flv/{z}/{x}/{y}.png", {
  attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
    '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://www.mapbox.com">MapBox</a>'
})

app.base.title = "OpenStreetMap"

app.crs = L.CRS.EPSG4326

app.base.bbox =
  "EPSG:4326":
    table:
      bbox: [-1, -1, 1, 1]

app.bboxToProj = (bounds) ->
  [bounds._southWest.lng, bounds._southWest.lat, bounds._northEast.lng, bounds._northEast.lat]

app.bboxTo4326 = (bounds) ->
  new L.LatLngBounds(new L.LatLng(bounds[0], bounds[1]) , new L.LatLng(bounds[2], bounds[3]))