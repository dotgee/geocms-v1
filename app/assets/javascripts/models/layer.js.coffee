class App.Layer extends Backbone.Model
  defaults: {
    leaflet: false
    onMap: false
  }
  toLeaflet: ->
    tileLayer = L.tileLayer.wms(@get("data_source").wms, {
      layers: @get("name"),
      format: 'image/png',
      transparent: true,
      continuousWorld: true
    })
    @set({leaflet : tileLayer})
  removeFromMap: ->
    @set({onMap : false})
    @trigger('removeFromMap', this)
  addToMap: ->
    @set({onMap : true})
    @trigger('addOnMap')
  initialize: ->
    @toLeaflet()