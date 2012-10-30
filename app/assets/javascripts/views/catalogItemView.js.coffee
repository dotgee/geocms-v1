class App.CatalogItemView extends Backbone.View
  className: "media"
  template: _.template("
    <a class='pull-left' href='#'>
      <img class='media-object' src='http://placehold.it/64x64' width='64' height='64'  >
    </a>
    <div class='media-body'>
      
      <h4 class='media-heading'><%= title %></h4>
      <% if(description) { %><p> <%= description %> </p><% } %>
    </div>")
  events: {
    "click h4": "addToMap"
  }
  initialize: ->
    @cartCollection = @options.hud.cartCollection
    @parent = @options.parent
    @hud = @options.hud
  addToMap: (e) ->
    e.preventDefault()
    $e = $(e.currentTarget)
    @cartCollection.add(@model)
    $e.addClass("active")
  render: ->
    attributes = @model.toJSON()
    this.$el.html(@template(attributes))
    return this