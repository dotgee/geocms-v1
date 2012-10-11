class App.CatalogView extends Backbone.View
  events: {
    "click .close" : "toggle"
  }
  initialize: ->
    @parent = @options.parentView
    @mapProvider = @parent.mapProvider
  toggle: ->
    $(@el).toggleClass("active")
  render: ->
    _.each @model.models, ((layer) ->
      $(@el).find("ul.thumbnails").append new App.CatalogItemView({ model: layer, parentView: this }).render().el
    ), this
    return this