class App.MapToolbarView extends Backbone.View
  el: ".map-toolbar"
  events: {
    "click .cart" : "toggleCart"
  }
  initialize: ->
    @mapProvider = @options.mapProvider
    @cartView = @options.cartView
  toggleCart: (e) ->
    $self = $(e.currentTarget)
    if $self.hasClass("active")
      @cartView.close()
    else 
      @cartView.open()
    @mapProvider.invalidateSize()
