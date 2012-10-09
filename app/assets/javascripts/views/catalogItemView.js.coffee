class App.CatalogItemView extends Backbone.View
  tagName: "li"
  className: "span4"
  template: _.template("<div class='thumbnail'>
                            <img src='/assets/placeholder.png' alt='' width='300' height='200'>
                            <h4><a href='#' class='catalog-layer'><%= title %></a></h4>
                            <p><%= description %></p>
                          </div>")
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
