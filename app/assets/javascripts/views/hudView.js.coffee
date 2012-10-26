class App.HudView extends Backbone.View
  el: ".hud",
  events: {
    "click .save": "saveContext"
    "click .share": "openSharePopup"
  }
  initialize: ->
    @model.on("afterSave", @afterSave, this)
    @cartCollection     = @options.cartCollection
    @catalogCollection  = @options.catalogCollection
    @mapProvider        = @options.mapProvider
    @router             = @options.router
    @form               = new Backbone.Form({ model: @model, idPrefix: "context_" })
    @render()
  render: ->
    @mapView = new App.MapView({mapProvider: @mapProvider, parentView: this})
    @catalog = new App.CatalogView({ el: this.$("#catalog"), collection: @catalogCollection, parentView: this })
    @cart = new App.CartView({ el: this.$("#layers"), collection: @cartCollection, parentView: this })
    @infos = new App.InfosView({ el: this.$("#infos"), parentView: this })
    @toolbar = new App.MapToolbarView({ parentView: this })
  open: ->
    @$el.css("left", "0")
    $(".leaflet-control-zoom ").animate({"left": @$el.width()}, 200)
  close: ->
    @$el.css("left", -@$el.width())
    $(".leaflet-control-zoom").animate({"left": 0}, 200)
  saveContext: (e) ->
    e.preventDefault()
    errors = @form.commit()
    unless errors
      layer_ids = _.map(@cartCollection.models, (layer) ->
        layer.get("id")
      )
      box = new App.MapProviders.Leaflet().bboxTo2154(@mapProvider.map.getBounds())
      
      minx = box[0]
      maxx = box[2]
      miny = box[1]
      maxy = box[3]
      @model.save {layer_ids: layer_ids, minx: minx, maxx: maxx, miny: miny, maxy: maxy},
        success: (model, response) ->
          if model.isNew()
            model.set({uuid: response.uuid})
          model.trigger("afterSave")
  afterSave: ->
    @switchControls(false)
    @router.navigate @model.get("uuid")
  switchControls: (unsaved) ->
    if unsaved
      @$el.find(".save").removeAttr("disabled").removeClass("disabled")
      @$el.find(".share").attr("disabled", "disabled").addClass("disabled")   
    else
      @$el.find(".share").removeAttr("disabled").removeClass("disabled")
      @$el.find(".save").attr("disabled", "disabled").addClass("disabled")
  updateShareLinks: ->

  openSharePopup: (e) ->
    unless $("#direct-link").text().indexOf("share") > 0
      $("#share-modal")
        .find("#direct-link")
        .append("/"+@model.get("uuid")+"/share")
        .end()
        .find("#embed-link")
        .append(_.escape("/"+@model.get("uuid")+"/share</iframe>"))

    $("#share-modal").modal()