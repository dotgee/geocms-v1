class App.CatalogItemView extends Backbone.View
  tagName: "li"
  template: _.template("<a href='#' class='catalog-layer'><%= title %></a>")
  events: {
    "click .catalog-layer": "addToMap"
  }
  initialize: ->
    @mapProvider = this.options.mapProvider
  addToMap: (e) ->
    e.preventDefault()
    unless @model.attributes.onMap
      layer = @model.attributes.leaflet or= @model.toLeaflet()
      @mapProvider.addLayerToMap(layer)
      @model.attributes.onMap = true
  render: ->
    attributes = @model.toJSON()
    this.$el.html(@template(attributes))
    return this
