class App.CatalogView extends Backbone.View
  breadcrumbCategoryTemplate: _.template("
   <li> <a href='/'><i class='icon-home'></i></a>
      <% if(categories.length) {%><span class='divider'>/</span> <% } %>
   </li>
   <% _.each( categories, function( cat, i ){ %>
        <% if(categories.length != i +1 ) {%>
        <li>
          <a class='category-link' href='/category/<%= cat.attributes.id %>'><%= cat.attributes.name %></a>
	  <span class='divider'>/</span>
        </li>
        <% }else { %>
          <li class='active'><%= cat.attributes.name %></li>
        <% } %>
   <%}) %>
  ")

  events:
    "click .close" : "toggle"
    "click #search": "search"
    "keypress .layers-search input": "searchOnEnter"
    "click .category-link" : "show"
    "click .icon-home" : "toRoot"


  initialize: ->
    @hud = @options.parentView
    @mapProvider = @hud.mapProvider
    @layers = @options.layers
    @collection.on("reset", @render, this)
    @initialCollection = @collection
    @$categories = @$el.find("#catalog-categories")
    @$layers = @$el.find("#catalog-layers")
    @$query = $(".layers-search").find("input")
    @currentCategories = []
    @$layers.masonry
      itemSelector: ".media.layer"
      isAnimated: true
      columnWidth: ( containerWidth ) ->
	containerWidth / 2
  toggle: ->
    @$el.toggleClass("active")
    @render()
  searchOnEnter: (e) ->
    if (e.keyCode != 13)
      return
    @search()
  search: ->
    that = this
    $.ajax
      url: GEOCMS_PREFIX+"/layers/search",
      dataType: 'json',
      data: {query: that.$query.val()},
      success: (data) ->
        layers = []
        layer_ids = _.each(data, (layer) ->
	  l = that.layers.get(layer.id)
	  layers.push(l) if l?
        )
        layerCollection = new App.LayerCollection(layers)
        that.collection = layerCollection
        that.render()
    @onSearch = true
  resetView: ->
    @$categories.html("")
    @$layers.html("")
  addOne: (model) ->
    item = new App.CatalogItemView({ model: model, parentView: this }).render().el
    @$categories.append item if model.get("type") == "category"
    @$layers.append item if model.get("type") == "layer"
  toRoot: (e)->
    e.preventDefault()
    if !@currentCategories.length && !@onSearch
      @toggle()
    @onSearch = false
    @collection = @initialCollection
    @currentCategories = []
    @render()

  appendCategory: (category) ->
    @currentCategories.push(category)
    @render()

  show: (e)->
    e.preventDefault()
    idx = @$el.find('.breadcrumb a.category-link').index(e.currentTarget)

    if idx > -1
      children = @currentCategories[idx].get("children").models
      that = this
      layers = @layers.filter( (layer) ->
	_.contains(layer.get("category_ids"), that.currentCategories[idx].get("id"))
      )
      resources = _.union(layers, children)
      @collection = new App.CatalogCollection(resources)
      @currentCategories = @currentCategories.slice(0, idx + 1)
      @render()
    true

  render: ->
    @resetView()
    @$el.find('.breadcrumb').html(@breadcrumbCategoryTemplate
                                      categories: @currentCategories
                                  )
    @collection.forEach(@addOne, this)
    @$layers.masonry( 'reload' )
