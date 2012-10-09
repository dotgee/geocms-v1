class App.CartView extends Backbone.View
  el: ".hud"
  events: {
    "click .add-layer": "toggleCatalog"
  }
  toggleCatalog: (e) ->
    e.preventDefault()
    $(".thumbnails").masonry("reload")
    @catalogView.toggle()
  open: ->
    @$el.css("left", "0")
    $("#map").css("left", "33.33333333%")
  close: ->
    @$el.css("left", "-33.33333333%")
    $("#map").css("left", 0)
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