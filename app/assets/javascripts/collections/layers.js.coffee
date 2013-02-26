class App.LayerCollection extends Backbone.Collection
  model: App.Layer
  url: GEOCMS_PREFIX+"/layers"
