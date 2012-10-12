class App.CartItemView extends Backbone.View
  tagName: "li"
  template: _.template("<a href='#'>
            <%= title %>
            <div class='m-btn-group control-buttons'>
              <a class='m-btn mini query' data-toggle='button'><i class='icon-info-sign'></i>Interrogate</a>
              <a class='m-btn mini disabled'><i class='icon-download-alt'></i>Save</a>
              <a class='m-btn mini remove'><i class='icon-remove'></i>Remove</a>
            </div>
            </a>")
  events: {
    "click .remove" : "removeLayer"
    "click .query"  : "toggleClicListener"
  }
  removeLayer: ->
    @model.removeFromMap()
    @mapProvider.removeLayerFromMap(@model.get("leaflet"))
    @$el.remove()
  toggleClicListener: (e) ->
    $self = $(e.currentTarget)
    $(".query").not($self).removeClass("active")
    @mapProvider.toggleClicListener(!$self.hasClass("active"), @model.attributes)
  initialize: ->
    @mapProvider = @options.mapProvider
  render: ->
    attributes = @model.toJSON()
    this.$el.html(@template(attributes))
    return this
