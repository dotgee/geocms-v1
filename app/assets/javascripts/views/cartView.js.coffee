class App.CartView extends Backbone.View
  tagName: "ul"
  initialize: ->
  render: ->
    console.log @model
    _.each @model.models, ((layer) ->
      console.log(layer)
      $(@el).append new App.CartItemView(model: layer).render().el
    ), this
    $(".hud").html(this)