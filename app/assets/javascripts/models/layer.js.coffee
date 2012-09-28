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
  initialize: ->
    @toLeaflet()