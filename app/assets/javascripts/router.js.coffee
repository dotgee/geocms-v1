class App.Router extends Backbone.Router
  routes:
    "" : "index"
  index: ->
    @mapProvider = new App.MapProviders.Leaflet()
    @mapView = new App.MapView(
      mapProvider: @mapProvider
    )
    @catalogCollection = new App.CatalogCollection()
    @cartCollection = new App.CartCollection()
    @hudView = new App.HudView({
      cartCollection: @cartCollection
      catalogCollection: @catalogCollection
      mapProvider: @mapProvider
    })
    @mapToolbarView = new App.MapToolbarView({
      mapProvider: @mapProvider
      hudView: @hudView
      mapView: @mapView
    })

    # quick and dirty (?)
    hudView = @hudView
    @catalogCollection.fetch({
      success: (model, response) ->
        hudView.catalog.render()
        $(".thumbnails").masonry({item: "li"})
    })