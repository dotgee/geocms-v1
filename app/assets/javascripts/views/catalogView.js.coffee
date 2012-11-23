class App.CatalogView extends Backbone.View
  template: _.template("
    <a class='m-btn blue pull-right back'><i class='m-icon-swapleft m-icon-white'></i> Back</a>
    <div class='clearfix'></div>
  ")
  events: {
    "click .close" : "toggle"
    "click .back"  : "back"
  }
  initialize: ->
    @hud = @options.parentView
    @mapProvider = @hud.mapProvider
    @layers = @options.layers
    @collection.on("reset", @render, this)
    @$categories = @$el.find("#categories")
  toggle: ->
    @$el.toggleClass("active")
    @render()
  back: ->
    @collection = @collection.parent.collection
    @render()
  resetView: ->
    @$categories.html("")
  addOne: (model) ->
    @$categories.append new App.CatalogItemView({ model: model, parentView: this }).render().el
  render: ->
    @resetView()
    if @collection.parent
      @$categories.append(@template())
    @collection.forEach(@addOne, this)
