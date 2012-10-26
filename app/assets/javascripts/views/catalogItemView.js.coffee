class App.CatalogItemView extends Backbone.View
  tagName: "li"
  className: "span4"
  template: _.template("<div class='thumbnail'>
                          <h4><%= title %></h4>
                          <a href='#' class='pull-right m-btn blue catalog-layer icn-only mini'>
                            <i class='icon-plus icon-white'></i>
                          </a>
                          <p><%= description %></p>
                        </div>")
  events: {
    "click .catalog-layer": "addToMap"
  }
  initialize: ->
    @cartCollection = @options.hud.cartCollection
  addToMap: (e) ->
    e.preventDefault()
    $e = $(e.currentTarget)
    @cartCollection.add(@model)
    $e.addClass("active")
  render: ->
    attributes = @model.toJSON()
    this.$el.html(@template(attributes))
    return this

#<img src='<%= data_source.wms %>?LAYERS=<%= name %>&FORMAT=image%2Fpng&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&SRS=EPSG%3A2154&BBOX=314937.1221424626,6772829.587208792,388010.9053456147,6802831.114308483&WIDTH=300&HEIGHT=200' alt='' width='300' height='200'>