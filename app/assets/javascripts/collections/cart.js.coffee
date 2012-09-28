class App.CartCollection extends Backbone.Collection
  model: App.Layer
  initialize: ->
    this.on "add", (layer) ->