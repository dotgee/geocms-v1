class App.CartView extends Backbone.View
  el: ".hud"
  events: {
    "click .add-layer": "toggleCatalog"
  }
  toggleCatalog: (e) ->
    e.preventDefault()
    @catalogView.toggle()
  initialize: ->
    @mapProvider = @options.mapProvider
    @catalogView = @options.catalogView
    @model.on('add', @addOne, this)
    @model.on('removeFromMap', @removeOne, this)
  addOne: (layer) ->
    layer.addToMap()
    cartViewItem = new App.CartItemView({model: layer, mapProvider: @mapProvider})
    @$el.find(".layer-list").append(cartViewItem.render().el)
    @mapProvider.addLayerToMap(layer.attributes.leaflet)
  removeOne: (layer) ->
    @model.remove(layer)
  render: ->
    _.each @model.models, ((layer) ->
      $(@el).find(".layer-list").html new App.CartItemView({model: layer, mapProvider: @mapProvider}).render().el
    ), this
    return this