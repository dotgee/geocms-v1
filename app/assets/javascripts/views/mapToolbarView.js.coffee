class App.MapToolbarView extends Backbone.View
  el: ".map-toolbar"
  initialize: ->
    @mapProvider = this.options.mapProvider