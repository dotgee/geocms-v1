class App.CartItemView extends Backbone.View
  tagName: "li"
  template: _.template("<a href='#'>
            <%= title %>
            <div class='btn-group'>
              <button class='btn btn-mini disabled' data-toggle='button'><i class='icon-info-sign'></i>Interrogate</button>
              <button class='btn btn-mini disabled'><i class='icon-download-alt'></i>Save</button>
              <button class='btn btn-mini remove'><i class='icon-remove'></i>Remove</button>
            </div>
            </a>")
  events: {
    "click .remove" : "removeLayer"
  }
  removeLayer: ->
    @model.removeFromMap()
    @mapProvider.removeLayerFromMap(@model.attributes.leaflet)
    @$el.remove()
  initialize: ->
    @mapProvider = @options.mapProvider
  render: ->
    attributes = @model.toJSON()
    this.$el.html(@template(attributes))
    return this
