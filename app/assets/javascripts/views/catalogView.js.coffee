class App.CatalogView extends Backbone.View
  template: _.template("
    <a class='m-btn blue pull-right back'><i class='m-icon-swapleft m-icon-white'></i> Back</a>
    <div class='clearfix'></div>
  ")

  events: {
    "click .close" : "toggle"
    "click .back"  : "back"
    "click #search": "search"
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

  search: ->
    that = this
    $.ajax
      url: "/layers/search",
      dataType: 'json',
      data: {query: "Mer"},
      success: (data) ->
        layers = []
        layer_ids = _.each(data, (layer) ->
          console.log that.layers.get(layer.id)
          layers.push(that.layers.get(layer.id))
        )
        console.log(layers)
        layerCollection = new App.LayerCollection(layers)
  resetView: ->
    @$categories.html("")

  addOne: (model) ->
    @$categories.append new App.CatalogItemView({ model: model, parentView: this }).render().el

  render: ->
    @resetView()
    if @collection.parent
      @$categories.append(@template())
    @collection.forEach(@addOne, this)