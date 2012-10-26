class App.CatalogView extends Backbone.View
  template: _.template("<a class='m-btn blue mini back'><i class='m-icon-swapleft m-icon-white'></i>Back</a>")
  events: {
    "click .close" : "toggle"
    "click .back"  : "back"
  }
  initialize: ->
    @hud = @options.parentView
    @mapProvider = @hud.mapProvider
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
  addOne: (category) ->
    @$categories.append new App.CatalogCategoryView({ model: category, parentView: this }).render().el
  render: ->
    @resetView()
    if @collection.parent
      @$categories.append(@template())
    @collection.forEach(@addOne, this)