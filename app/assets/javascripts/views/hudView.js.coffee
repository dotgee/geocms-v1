class App.HudView extends Backbone.View
  el: ".hud",
  events: 
    "click .save": "saveContext"
    "click .share": "openSharePopup"
  
  initialize: ->
    @model.on("afterSave", @afterSave, this)
    @cartCollection     = @options.cartCollection
    @catalogCollection  = @options.catalogCollection
    @layerCollection    = @options.layerCollection
    @mapProvider        = @options.mapProvider
    @router             = @options.router
    @form               = new Backbone.Form({ model: @model, idPrefix: "context_" })
    @render()

  render: ->
    @mapView = new App.MapView({mapProvider: @mapProvider, parentView: this})
    @catalog = new App.CatalogView({ el: this.$("#catalog"), collection: @catalogCollection, layers: @layerCollection, parentView: this })
    @cart = new App.CartView({ el: this.$("#layers"), collection: @cartCollection, parentView: this })
    @infos = new App.InfosView({ el: this.$("#infos"), parentView: this })
    @toolbar = new App.MapToolbarView({ el: this.$("#ctrls"), parentView: this })
    @legend = new App.MapLegendView({ el: $("#legend-graphic"), parentView: this })

  open: ->
    @$el.css("left", "0")
    $("#map").css("left", "335px")
    @invalidateMap()

  close: ->
    @$el.css("left", -@$el.width())
    $("#map").css("left", "0")
    @invalidateMap()

  invalidateMap: ->
    that = this
    setTimeout( ->
      that.mapProvider.invalidateSize()
    ,1000);

  saveContext: (e) ->
    e.preventDefault()
    errors = @form.commit()
    if errors
      $("#hud-tab a:last").tab("show")
    else
      layers = _.map(@cartCollection.models, (layer) ->
        unless layer.get("base")
          { layer_id: layer.get("id"), opacity: layer.get('opacity'), position: layer.get("position"), visibility: layer.get("visible") }
      )
      box = new App.MapProviders.Leaflet().bboxToProj(@mapProvider.map.getBounds())

      @model.save { minx: box[0], maxx: box[2], miny: box[1], maxy: box[3], contexts_layers_attributes: layers },
        success: (model, response) ->
          model.set({uuid: response.uuid}) if model.isNew()
          model.trigger("afterSave")
          toastr.success("Your map has been correctly saved !", "Map saved")
        error: (model, response) ->
          toastr.success("There was an error while saving your map", "Error !")

  afterSave: ->
    @switchControls(false)
    @router.navigate @model.get("uuid")

  switchControls: (unsaved) ->
    if unsaved
      @$el.find(".save").removeAttr("disabled").removeClass("disabled")
      @$el.find(".share").attr("disabled", "disabled").addClass("disabled")
      $(".geovisu").addClass("disabled")
    else
      @$el.find(".share").removeAttr("disabled").removeClass("disabled")
      @$el.find(".save").attr("disabled", "disabled").addClass("disabled")
      $(".geovisu").removeClass("disabled")
      @updateShareLinks()

  updateShareLinks: ->
    href = $(".geovisu").attr("href")
    $(".geovisu").attr("href", href+@model.get("uuid")+".xml") unless href.indexOf("xml") > -1

  openSharePopup: (e) ->
    unless $("#direct-link").text().indexOf("share") > 0
      $("#share-modal")
        .find("#direct-link")
        .append("/"+@model.get("uuid")+"/share")
        .end()
        .find("#embed-link")
        .append(_.escape("/"+@model.get("uuid")+"/share</iframe>"))

    $("#share-modal").modal()
