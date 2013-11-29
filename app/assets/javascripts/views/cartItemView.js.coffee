class App.CartItemView extends Backbone.View
  tagName: "li"
  template: _.template("<div class='grippy'></div>
    <div class='right-infos'>
      <label for='<%= name %>' class='title'>
        <input type='checkbox' class='layer-visibility' <% if(opacity > 0) { %> checked <% } %> id='<%=name %>'>
        <a title='<%= title %>' class='unstyled'><%= title %></a>
      </label>
      <% if(data_source) { %><p class='source'>Source : <a href='<%= data_source.ogc %>' target='_blank'><%= data_source.name %></a></p> <% } %>
      <div class='cart-item-controls'>
	<div class='m-btn-group control-buttons'>
	  <a class='m-btn mini first query' data-toggle='button' rel='tooltip' data-original-title='Interroger'><i class='carticon-info'></i></a>
	  <a class='m-btn mini opacity <% if(controllingOpacity) { %> active <% } %>' data-toggle='button' rel='tooltip' data-original-title='Opacité'><i class='carticon-adjust'></i></a>
	  <a class='m-btn mini center' rel='tooltip' data-original-title='Centrer'><i class='carticon-target'></i></a>
	  <a class='m-btn mini toggle-dimension <% if (!dimension) { %> disabled <% } %> <% if(controllingDimension) { %> active <% } %>' data-toggle='button' rel='tooltip' data-original-title='Temporalité'><i class='carticon-clock'></i></a>
	  <a class='m-btn mini metadata-iframe <% if (!metadata_url) { %> disabled <% } %> ' rel='tooltip' data-original-title='Métadonnées' href='<% if(metadata_url) { %> <%= metadata_url %> <% } else { %> # <% } %>' <% if(metadata_url) { %> target='geonetwork' <% } %> ><i class='carticon-vcard'></i></a>
	  <a class='m-btn mini <% if (!LOGGED_IN || data_source.not_internal || base) { %> disabled <% } %>' rel='tooltip' data-original-title='Télécharger' href='<% if (LOGGED_IN && !(data_source.not_internal || base)) { %> <%= data_source.wms %>?REQUEST=getFeature&service=wfs&outputFormat=shape-zip&typename=<%= name %>'  target='_blank' <% } else { %> #' <% } %>><i class='carticon-download'></i></a>
	  <a class='m-btn mini remove' rel='tooltip' data-original-title='Supprimer'><i class='carticon-trash'></i></a>
	</div>
	<% if(dimension) { %>
	  <div class='dimensionable <% if(!controllingDimension) { %> hide <% } %>'>
	    <div class='m-btn-group control-buttons'>
	      <a class='m-btn first mini backward' ><i class='icon-step-backward'></i></a>
	      <a class='m-btn mini play <% if(playing) { %> active <% } %>'><i class=<% if(playing) { %>'icon-pause' <% } else { %> 'icon-play' <% } %>></i></a>
	      <a class='m-btn mini forward'><i class=' icon-step-forward'></i></a>
	    </div>
	    <div class='dimension-value'><%= moment(currentTime).format('DD/MM/YYYY') %></div>
	    <div class='clearfix'></div>
	    <div class='pull-left wrap-dates'><%= moment(dimensions[0].dimension.value).format('DD/MM/YYYY') %></div>
	    <div class='dimensions-list'>
	      <div class='dimensions-slider'></div>
	    </div>
	    <div class='pull-left wrap-dates'><%= moment(dimensions[dimensions.length-1].dimension.value).format('DD/MM/YYYY') %></div>
          </div>
	<% } %>
	<div class='opacity-controler <% if(!controllingOpacity) { %> hide <% } %>'>
	  <div class='opacity-slider'></div>
        </div>
      </div>
    </div>"
  )

  events:
    "click  .remove"           : "removeLayer"
    "click  .query"            : "toggleClicListener"
    "click  .backward"         : "backwardTimeline"
    "click  .forward"          : "forwardTimeline"
    "click  .play"             : "toggleTimeline"
    "change .layer-visibility" : "toggleVisibility"
    "click  .center"           : "panToLayer"
    "click  .opacity"          : "toggleOpacity"
    "click  .toggle-dimension" : "toggleDimension"
    # "mouseenter .title" : "showControls"
    # "mouseleave" : "hideControls"

  removeLayer: ->
    @model.removeFromMap()
  toggleClicListener: (e) ->
    $self = $(e.currentTarget)
    $(".query").not($self).removeClass("active")
    @mapProvider.toggleClicListener(!$self.hasClass("active"), @model.attributes)

  toggleVisibility: (e) ->
    if (@$el.find(".layer-visibility").attr("checked") == "checked")
      @model.toggleVisibility(true, 90)
    else
      @model.toggleVisibility(false, 0)

  toggleOpacity: (e) ->
    $e = $(e.currentTarget)
    if $e.hasClass("active")
      @$el.find(".opacity-controler").hide()
      @model.set controllingOpacity: false
    else
      @$el.find(".opacity-controler").show()
      @model.set controllingOpacity: true

  changeOpacity: ->
    @model.get("leaflet").setOpacity(@model.get("opacity")/100)
    @render()

  toggleDimension: (e) ->
    $e = $(e.currentTarget)
    if $e.hasClass("active")
      @$el.find(".dimensionable").hide()
      @model.set controllingDimension: false
    else
      @$el.find(".dimensionable").show()
      @model.set controllingDimension: true

  toggleTimeline: (e) ->
    $e = $(e.currentTarget)
    if $e.hasClass("active")
      $e.removeClass("active").find("i").removeClass("icon-pause").addClass("icon-play")
      @model.pauseTimeline()
    else
      $e.addClass("active").find("i").removeClass("icon-play").addClass("icon-pause")
      @model.playTimeline()

  backwardTimeline: (e) ->
    @model.checkTime(-1)

  forwardTimeline: (e) ->
    @model.checkTime(1)

  panToLayer: (e) ->
    box = @model.getBBOX()
    bbox = new L.LatLngBounds(new L.LatLng(box[0], box[1]) , new L.LatLng(box[2], box[3]))
    @mapProvider.fitBounds(bbox)

  showControls: (e) ->
    @$el.find(".cart-item-controls").css("visibility", "visible")

  hideControls: (e) ->
    @$el.find(".cart-item-controls").css("visibility", "hidden")

  initialize: ->
    @changeOpacity()
    @model.on("change:playing", @render, this)
    @model.on("redraw", @render, this)
    @model.on("change:opacity", @changeOpacity, this)
    @model.on("removeFromMap", @destroy, this)
    @mapProvider = @options.mapProvider

  destroy: ->
    @$el.remove()

  render: ->
    that = @
    attributes = @model.toJSON()
    # escape quotes
    attributes.title = attributes.title.replace(/'/g, "&#39;")
    @$el.html(@template(attributes))
    @$el.find('.opacity-slider').slider
      value: attributes.opacity
      range: "min"
      change: (e, ui) ->
        that.model.set opacity: ui.value
        true
    if @model.get("dimensions")
      @$el.find(".dimensions-slider").slider
        value: that.model.get("timelineCounter")
        step: 1
        min: 1
        max: that.model.get("dimensions").length-1
        slide: (event, ui) ->
          dim = that.model.get("dimensions")[ui.value].dimension.value
          that.$el.find(".dimension-value").text( moment(dim).format('DD/MM/YYYY') )
          that.model.showTime(dim, ui.value)
    return this
