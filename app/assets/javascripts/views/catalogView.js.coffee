class App.CatalogView extends Backbone.View
  events: {
    "click .close" : "toggle"
  }
  initialize: ->
    @parent = @options.parentView
    @mapProvider = @parent.mapProvider
    @collection.on("reset", @render, this)
  toggle: ->
    $(@el).toggleClass("active")
  addOne: (layer) ->
    @$el.find("ul.thumbnails").append new App.CatalogItemView({ model: layer, parentView: this }).render().el
  render: ->
    @$el.find(".thumbnails").masonry({item: "li"})
    @collection.forEach(@addOne, this)