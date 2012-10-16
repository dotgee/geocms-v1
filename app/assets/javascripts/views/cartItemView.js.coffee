class App.CartItemView extends Backbone.View
  tagName: "li"
  template: _.template("<div class='grippy'></div><div class='right-infos'><a href='#'>
            <label for='<%= name %>' class='title'><input type='checkbox' class='layer-visibility' checked id='<%=name %>'><%= title %></span>
            <div class='m-btn-group control-buttons'>
              <a class='m-btn mini query' data-toggle='button'><i class='icon-info-sign'></i></a>
              <a class='m-btn mini disabled'><i class='icon-download-alt'></i></a>
              <a class='m-btn mini remove'><i class='icon-remove'></i></a>
            </div>
            </a></div>")
  events: {
    "click .remove" : "removeLayer"
    "click .query"  : "toggleClicListener"
    "change .layer-visibility" : "toggleVisibility"
  }
  removeLayer: ->
    @model.removeFromMap()
    @mapProvider.removeLayerFromMap(@model.get("leaflet"))
    @$el.remove()
  toggleClicListener: (e) ->
    $self = $(e.currentTarget)
    $(".query").not($self).removeClass("active")
    @mapProvider.toggleClicListener(!$self.hasClass("active"), @model.attributes)
  toggleVisibility: (e) ->
    if (@$el.find(".layer-visibility").attr("checked") == "checked")
      @model.get("leaflet").setOpacity(1)
    else
      @model.get("leaflet").setOpacity(0)
  initialize: ->
    @mapProvider = @options.mapProvider
  render: ->
    attributes = @model.toJSON()
    this.$el.html(@template(attributes))
    return this
