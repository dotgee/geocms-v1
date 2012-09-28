class App.CartView extends Backbone.View
  el: ".hud ul"
  events: {
    "click .add-layer": "toggleCatalog"
  }
  toggleCatalog: (e) ->
    e.preventDefault()
    @catalogView.toggle()
  initialize: ->
    @mapProvider = @options.mapProvider
    @catalogView = @options.catalogView
  render: ->