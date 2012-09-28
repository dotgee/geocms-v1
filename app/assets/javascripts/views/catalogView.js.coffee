class App.CatalogView extends Backbone.View
  el: ".catalog"
  tagName: "ul"
  className: "nav nav-list"
  events: {
    "click .close" : "toggle"
  }
  initialize: ->
    @mapProvider = this.options.mapProvider
  toggle: ->
    $(@el).toggleClass("active")
  render: ->
    _.each @model.models, ((layer) ->
      $(@el).find("ul.nav-list").append new App.CatalogItemView({model: layer, mapProvider: @mapProvider}).render().el
    ), this
    return this