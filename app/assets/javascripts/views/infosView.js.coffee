class App.InfosView extends Backbone.View
  events: {
    "click .from-map" : "importCenter"
    "change input"  : "triggerChange"
  }
  initialize: ->
    @parent = @options.parentView
    @mapProvider = @parent.mapProvider
    @form = @parent.form
    @render()
  importCenter: (e) ->
    e.preventDefault()
    center = @mapProvider.map.getCenter()
    zoom = @mapProvider.map.getZoom()
    @$el.find("#context_center_lng").val(center.lng.toFixed(6))
    @$el.find("#context_center_lat").val(center.lat.toFixed(6))
    @$el.find("#context_zoom").val(zoom)
    @parent.switchControls(true)
  triggerChange: (e) ->
    @parent.switchControls(true)
  render: ->
    @$el.prepend(@form.render().el)
