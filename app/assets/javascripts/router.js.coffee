class App.Router extends Backbone.Router
  routes:
    "" : "index"
  index: ->
    @mapView = new App.MapView(
      mapProvider: new App.MapProviders.Leaflet()
    )
    @cart = new App.CartCollection()
    @cartView = new App.CartView({model: @cart})
    @cart.fetch()
    console.log(@cart)
