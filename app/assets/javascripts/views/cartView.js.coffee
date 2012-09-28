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
  addOne: (layer) ->
    cartViewItem = new App.CartItemView({model: layer})
    @$el.find(".layer-list").append(cartViewItem.render().el)

    unless layer.attributes.onMap
      leaflet = layer.attributes.leaflet
      @mapProvider.addLayerToMap(leaflet)
      layer.attributes.onMap = true
  render: ->
    _.each @model.models, ((layer) ->
      $(@el).find(".layer-list").html new App.CartItemView({model: layer}).render().el
    ), this
    return this