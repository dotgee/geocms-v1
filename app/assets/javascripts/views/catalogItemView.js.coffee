class App.CatalogItemView extends Backbone.View
  tagName: "li"
  template: _.template("<a href='#' class='catalog-layer'><%= title %></a>")
  events: {
    "click .catalog-layer": "addToMap"
  }
  initialize: ->
    @mapProvider = this.options.mapProvider
    @router = @options.router
  addToMap: (e) ->
    e.preventDefault()
    @router.cart.add(@model)
  render: ->
    attributes = @model.toJSON()
    this.$el.html(@template(attributes))
    return this
