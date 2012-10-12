class App.CartView extends Backbone.View
  events: {
    "click .add-layer": "toggleCatalog"
  }
  toggleCatalog: (e) ->
    e.preventDefault()
    @catalogView.$el.css("left", @parent.$el.width())
    $(".thumbnails").masonry("reload")
    @catalogView.toggle()
  initialize: ->
    @parent       = @options.parentView
    @mapProvider  = @parent.mapProvider
    @catalogView  = @parent.catalog
    # Listeners
    @collection.on('add', @addOne, this)
    @collection.on('removeFromMap', @removeOne, this)
  addOne: (layer) ->
    layer.addToMap()
    cartViewItem = new App.CartItemView({model: layer, mapProvider: @mapProvider})
    @$el.find(".layer-list").append(cartViewItem.render().el)
    @mapProvider.addLayerToMap(layer.get("leaflet"))
    @parent.switchControls(true)
  removeOne: (layer) ->
    @collection.remove(layer)
    @parent.switchControls(true)
  render: ->
    @collection.forEach(@addOne, this);