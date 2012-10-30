class App.CatalogCategoryView extends Backbone.View
  className: "media"
  template: _.template("
    <div class='media-body'>
      <h4 class='media-heading category'>
        <i class='icon-folder-open'></i>
        &nbsp;
        <%= name %>
      </h4>
    </div>")
  events: {
    "click .category" : "displayChildren"
  }
  initialize: ->
    @parentView = @options.parentView
    @layers = @parentView.layers
    @hud = @parentView.hud
  displayChildren: (e) ->
    if @model.get("children").length == 0
      layers = @layers.where({category_id: @model.get("id")})
      layerCollection = new App.LayerCollection(layers)
      layerCollection.parent = {}
      layerCollection.parent.collection = @model.collection
      @parentView.collection = layerCollection
      @parentView.render()
    else      
      @parentView.collection = @model.get("children")
      @parentView.render()
  render: ->
    attributes = @model.toJSON()
    @$el.html(@template(attributes))
    this