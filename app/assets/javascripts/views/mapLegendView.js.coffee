class App.MapLegendView extends Backbone.View
  template: _.template("
    <% if(!base) { %>
      <h6><%= title %></h6>
      <img src='<%=data_source.wms %>?request=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&layer=<%= name %>'/></i>
    <% } %>
  ")
  events: 
    "click .close": "toggle"
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
  toggle: ->
    @toggleShow()
    $(".legend").toggleClass("active")
  render: ->
    @$legend.html("")
    @collection.forEach(@addOne, this)
