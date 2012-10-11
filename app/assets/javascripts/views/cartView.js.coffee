class App.CartView extends Backbone.View
  events: {
    "click .add-layer": "toggleCatalog"
  }
  toggleCatalog: (e) ->
    e.preventDefault()
    $(".thumbnails").masonry("reload")
    @catalogView.toggle()
  initialize: ->
    @parent       = @options.parentView
    @mapProvider  = @parent.mapProvider
    @catalogView  = @parent.catalog
    # Listeners
    @model.on('add', @addOne, this)
    @model.on('removeFromMap', @removeOne, this)
  addOne: (layer) ->
    layer.addToMap()
    cartViewItem = new App.CartItemView({model: layer, mapProvider: @mapProvider})
    @$el.find(".layer-list").append(cartViewItem.render().el)
    @mapProvider.addLayerToMap(layer.attributes.leaflet)
    @parent.switchControls(true)
  removeOne: (layer) ->
    @model.remove(layer)
    @parent.switchControls(true)
  render: ->
    _.each @model.models, ((layer) ->
      $(@el).find(".layer-list").html new App.CartItemView({model: layer, mapProvider: @mapProvider}).render().el
    ), this
    return this