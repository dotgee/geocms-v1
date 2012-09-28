class App.Router extends Backbone.Router
  routes:
    "" : "index"
  index: ->
    router = this
    @mapProvider = new App.MapProviders.Leaflet()
    @mapView = new App.MapView(
      mapProvider: @mapProvider
    )
    @catalog = new App.CatalogCollection()
    @cart = new App.CartCollection()
    @catalogView = new App.CatalogView({
      model: @catalog
      mapProvider: @mapProvider
    })
    @cartView = new App.CartView({
      mapProvider: @mapProvider
      catalogView: @catalogView
      model: @cart
    })
    @catalog.fetch({
      success: (model, response) ->
        router.catalogView.render()
    })