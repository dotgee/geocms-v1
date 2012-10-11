class App.HudView extends Backbone.View
  el: ".hud",
  events: {
    "click .save": "saveMap"
    "click .share": "openSharePopup"
  }
  initialize: ->
    @cartCollection     = @options.cartCollection
    @catalogCollection  = @options.catalogCollection
    @mapProvider        = @options.mapProvider
    @context            = new App.Context()
    @form               = new Backbone.Form({ model: @context, idPrefix: "context_" })
    @render()
  render: ->
    @catalog = new App.CatalogView({ el: this.$("#catalog"), model: @catalogCollection, parentView: this })
    @cart = new App.CartView({ el: this.$("#layers"), model: @cartCollection, parentView: this })
    @infos = new App.InfosView({ el: this.$("#infos"), parentView: this })
  open: ->
    @$el.css("left", "0")
    $("#map").css("left", "33.33333333%")
  close: ->
    @$el.css("left", "-33.33333333%")
    $("#map").css("left", 0)
  saveMap: (e) ->
    @form.commit()
    layer_ids = 
    @context.attributes.layer_ids = _.map(@cartCollection.models, (layer) ->
      layer.attributes.id
    )
    @context.save()
    @switchControls(false)
  switchControls: (unsaved) ->
    if unsaved
      @$el.find(".save").removeAttr("disabled").removeClass("disabled")
      @$el.find(".share").attr("disabled", "disabled").addClass("disabled")   
    else
      @$el.find(".share").removeAttr("disabled").removeClass("disabled")
      @$el.find(".save").attr("disabled", "disabled").addClass("disabled")
  openSharePopup: (e) ->
    $("#share-modal").modal()