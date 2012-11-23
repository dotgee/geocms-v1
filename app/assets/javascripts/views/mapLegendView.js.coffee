class App.MapLegendView extends Backbone.View
  template: _.template("
    <%= title %><br/>
    <img src='<%=data_source.wms %>?request=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&layer=<%= name %>'/></i>
    <br/>
  ")
  initialize: ->
    @parent = @options.parentView
    @collection = @parent.cartCollection
    @collection.on("add", @render, this)
    @collection.on("remove", @render, this)
    @$legend = this.$(".inner-legend")
  addOne: (layer) ->
    attributes = layer.toJSON()
    @$legend.append(@template(attributes))
  toggleShow: ->
    @$el.toggleClass("hide")
  render: ->
    @$legend.html("")
    @collection.forEach(@addOne, this)
