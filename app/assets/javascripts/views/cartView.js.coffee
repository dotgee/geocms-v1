class App.CartView extends Backbone.View
  events: {
    "click .add-layer": "toggleCatalog"
  }
  toggleCatalog: (e) ->
    e.preventDefault()
    @catalogView.$el.css("left", @parent.$el.width())
    @catalogView.toggle()
  initialize: ->
    @parent       = @options.parentView
    @mapProvider  = @parent.mapProvider
    @catalogView  = @parent.catalog
    @cartViewItems = []
    # Listeners
    @collection.on('add', @addOne, this)
    @collection.on('removeFromMap', @removeOne, this)
    @collection.on('reindex', @reindex, this)

    @$layerList = $("#layer-list")
    that = this
    @$layerList.sortable(
      handler: ".grippy"
      update: ->
        that.collection.trigger("reindex")
    )
  addOne: (layer) ->
    layer.addToMap()
    cartViewItem = new App.CartItemView({model: layer, mapProvider: @mapProvider})
    @$layerList.append(cartViewItem.render().el)
    @mapProvider.addLayerToMap(layer.get("leaflet"))
    @parent.switchControls(true)
    @cartViewItems.push(cartViewItem)
  removeOne: (layer) ->
    console.log "removed"
    @mapProvider.removeLayerFromMap(layer.get("leaflet"))
    @collection.remove(layer)
    @parent.switchControls(true)
  reindex: ->
    _.each @cartViewItems, (view) ->
      view.model.get("leaflet").setZIndex(1000 - view.$el.index())
  render: ->
    @collection.forEach(@addOne, this)
