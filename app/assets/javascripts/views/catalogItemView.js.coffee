class App.CatalogItemView extends Backbone.View
  tagName: "li"
  className: "span4"
  template: _.template("<a href='#' class='catalog-layer'>
                          <div class='thumbnail'>
                            <img src='http://placehold.it/300x200 alt=''>
                            <h4><%= title %></h4>
                            <p><%= description %></p>
                          </div>
                        </a>")
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
