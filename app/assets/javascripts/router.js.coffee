class App.Router extends Backbone.Router
  routes:
    "" : "index"
    ":id" : "show"
    ":id/share": "show"
  initialize: ->
    @mapProvider = new App.MapProviders.Leaflet()
    @catalogCollection = new App.CatalogCollection()
    @catalogCollection.fetch()
    @cartCollection = new App.CartCollection()
  index: ->
    @context = new App.Context()
    @hudView = new App.HudView({
      model : @context
      cartCollection: @cartCollection
      catalogCollection: @catalogCollection
      mapProvider: @mapProvider
      router: this
    })
  show: (id) ->
    @context = new App.Context({id: id})
    # Could probably be improved
    that = this
    @context.fetch
      success: (model, response) ->
        that.hudView = new App.HudView({
          model: model
          cartCollection: that.cartCollection
          catalogCollection: that.catalogCollection
          mapProvider: that.mapProvider
          router: that
        })
        _.each response.layers, (l) ->
          layer = new App.Layer(l.layer)
          that.cartCollection.add(layer)
          layer.playTimeline()