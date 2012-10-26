class App.CatalogCategoryView extends Backbone.View
  template: _.template("<a href='#' class='category'><%= name %></a>")
  events: {
    "click .category" : "displayChildren"
  }
  initialize: ->
    @parentView = @options.parentView
    @hud = @parentView.hud
  displayChildren: (e) ->
    console.log  @model.get("layers").length
    if @model.get("layers").length == 0
      @parentView.collection = @model.get("children")
    else
      @parentView.resetView()
      @model.get("layers").forEach(@addOneLayer, this)
    @parentView.render()
  addOneLayer: (layer) ->
    l = new App.Layer(layer)
    $("#categories").append new App.CatalogItemView({ model: l, hud: @hud }).render().el
  render: ->
    attributes = @model.toJSON()
    @$el.html(@template(attributes))
    this