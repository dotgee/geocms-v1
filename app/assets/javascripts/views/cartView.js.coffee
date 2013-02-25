class App.CartView extends Backbone.View
  events: 
    "click .add-layer": "toggleCatalog"

  toggleCatalog: (e) ->
    e.preventDefault()
    @catalogView.toggle()

  initialize: ->
    @parent       = @options.parentView
    @mapProvider  = @parent.mapProvider
    @catalogView  = @parent.catalog
    @cartViewItems = []

    # Listeners
    @collection.on('add', @addOne, this)
    @collection.on('removeFromMap', @removeOne, this)
    @collection.on('reindex', @reindex, this)

    @$layerList = $("#layer-list")
    that = this
    @$layerList.sortable
      handler: ".grippy"
      update: ->
        that.collection.trigger("reindex")


    @addBaseLayer()

  addOne: (layer) ->
    layer.addToMap()
    cartViewItem = new App.CartItemView({model: layer, mapProvider: @mapProvider})
    @$layerList.prepend(cartViewItem.render().el)
    cartViewItem.model.set position: 1000 - cartViewItem.$el.index()
    @mapProvider.addLayerToMap(layer.get("leaflet"))
    @parent.switchControls(true)
    layer.get("leaflet").setOpacity(0) unless layer.get("visible")
    @cartViewItems.push(cartViewItem)

  removeOne: (layer) ->
    @mapProvider.removeLayerFromMap(layer.get("leaflet"))
    @collection.remove(layer)
    @parent.switchControls(true)

  reindex: ->
    _.each @cartViewItems, (view) ->
      zindex = 1000 - view.$el.index()
      view.model.set position: zindex
      view.model.get("leaflet").setZIndex(zindex)

  addBaseLayer: ->
    osm = L.tileLayer.wms("http://osm.geobretagne.fr/gwc01/service/wms", {
      layers: "osm:google",
      format: 'image/png',
      transparent: true,
      continuousWorld: true,
      unloadInvisibleTiles: false,
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
        '<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
        'Imagery © <a href="http://geobretagne.fr/accueil/">GeoBretagne</a>'
    })
    base_layer = new App.Layer
      leaflet: osm
      title: "OpenStreetMap"
      base: true
      dimension: false
      metadata_url: false
      data_source: false
      opacity: 100
      bbox:
        "EPSG:2154":
          table:
            bbox: [-357823.236499999999, 6037008.69390000030, 894521.034699999960, 7289352.96509999968]

    @collection.add(base_layer)

  render: ->
    @collection.forEach(@addOne, this)