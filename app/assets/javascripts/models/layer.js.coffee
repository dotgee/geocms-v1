class App.Layer extends Backbone.Model
  defaults: {
    leaflet: false
    onMap: false
  }
  toLeaflet: ->
    @attributes.leaflet =  L.tileLayer.wms(@attributes.data_source.wms, {
      layers: @attributes.name,
      format: 'image/png',
      transparent: true,
      continuousWorld: true
    })
  removeFromMap: ->
    @attributes.onMap = false
    @trigger('removeFromMap', this)
  addToMap: ->
    @attributes.onMap = true
    @trigger('addOnMap')
  initialize: ->
    @toLeaflet()