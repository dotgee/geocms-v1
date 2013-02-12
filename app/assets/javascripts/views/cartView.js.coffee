class App.CartView extends Backbone.View
  events: 
    "click .add-layer": "toggleCatalog"

  toggleCatalog: (e) ->
    e.preventDefault()
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
    @$layerList.sortable
      handler: ".grippy"
      update: ->
        that.collection.trigger("reindex")

  addOne: (layer) ->
    layer.addToMap()
    cartViewItem = new App.CartItemView({model: layer, mapProvider: @mapProvider})
    @$layerList.prepend(cartViewItem.render().el)
    cartViewItem.model.set position: 1000 - cartViewItem.$el.index()
    @mapProvider.addLayerToMap(layer.get("leaflet"))
    @parent.switchControls(true)
    layer.get("leaflet").setOpacity(0) unless layer.get("visible")
    @cartViewItems.push(cartViewItem)

  removeOne: (layer) ->
    @mapProvider.removeLayerFromMap(layer.get("leaflet"))
    @collection.remove(layer)
    @parent.switchControls(true)

  reindex: ->
    _.each @cartViewItems, (view) ->
      zindex = 1000 - view.$el.index()
      view.model.set position: zindex
      view.model.get("leaflet").setZIndex(zindex)

  render: ->
    @collection.forEach(@addOne, this)