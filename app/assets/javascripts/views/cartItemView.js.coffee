class App.CartItemView extends Backbone.View
  tagName: "li"
  template: _.template("<a href='#'>
            <%= title %>
            <div class='btn-group'>
              <button class='btn btn-mini query' data-toggle='button'><i class='icon-info-sign'></i>Interrogate</button>
              <button class='btn btn-mini disabled'><i class='icon-download-alt'></i>Save</button>
              <button class='btn btn-mini remove'><i class='icon-remove'></i>Remove</button>
            </div>
            </a>")
  events: {
    "click .remove" : "removeLayer"
    "click .query"  : "toggleClicListener"
  }
  removeLayer: ->
    @model.removeFromMap()
    @mapProvider.removeLayerFromMap(@model.attributes.leaflet)
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
