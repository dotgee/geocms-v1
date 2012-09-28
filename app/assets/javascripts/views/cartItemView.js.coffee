class App.CartItemView extends Backbone.View
  tagName: "li"
  template: _.template("<a href='#' class='catalog-layer'><%= title %></a>")
  initialize: ->
    @mapProvider = this.options.mapProvider
  render: ->
    attributes = @model.toJSON()
    this.$el.html(@template(attributes))
    return this
