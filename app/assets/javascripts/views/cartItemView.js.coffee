class App.CartItemView extends Backbone.View
  tagName: "li"
  template: _.template("<div class='grippy'></div>
    <div class='right-infos'>
      <a href='#'>
          <label for='<%= name %>' class='title'>
            <input type='checkbox' class='layer-visibility' <% if(visible) { %> checked <% } %> id='<%=name %>'>
            <span><%= title %></span>
          </label>
          <% if(dimension) { %>
            <div class='m-btn-group control-buttons'>
              <a class='m-btn mini backward'><i class='icon-step-backward'></i></a>
              <a class='m-btn mini play <% if(playing) { %> active <% } %>'><i class=<% if(playing) { %>'icon-pause' <% } else { %> 'icon-play' <% } %>></i></a>
              <a class='m-btn mini forward'><i class=' icon-step-forward'></i></a>
            </div>
          <% } %>
          <div class='m-btn-group control-buttons'>
            <a class='m-btn mini query' data-toggle='button'><i class='icon-info-sign'></i></a>

            <a class='m-btn mini remove'><i class='icon-remove'></i></a>
          </div>
          <% if(dimension) { %>
              <ul class='unstyled dimensions-list'>
                <% _.each(dimensions, function(dim, i) { %>
                  <li class='dimension<% if (i == timelineCounter) { %> active <% } %>'><%= moment(dim.dimension.value).calendar() %></li>
                <% }) %>
              </ul>
          <% } %>
        <div class='opacity-controler'></div>
      </a>
    </div>"
  )
  events: {
    "click  .remove"           : "removeLayer"
    "click  .query"            : "toggleClicListener"
    "click  .backward"         : "backwardTimeline"
    "click  .forward"          : "forwardTimeline"
    "click  .play"             : "toggleTimeline"
    "click  .dimension"        : "gotoTime"
    "change .layer-visibility" : "toggleVisibility"
  }
  removeLayer: ->
    @model.removeFromMap()
  toggleClicListener: (e) ->
    $self = $(e.currentTarget)
    $(".query").not($self).removeClass("active")
    @mapProvider.toggleClicListener(!$self.hasClass("active"), @model.attributes)
  toggleVisibility: (e) ->
    if (@$el.find(".layer-visibility").attr("checked") == "checked")
      @model.toggleVisibility(true, 1)
    else
      @model.toggleVisibility(false, 0)
  toggleTimeline: (e) ->
    $e = $(e.currentTarget)
    #@$el.find(".dimensions-list").slideToggle()
    if $e.hasClass("active")
      $e.removeClass("active").find("i").removeClass("icon-pause").addClass("icon-play")
      @model.pauseTimeline()
    else
      $e.addClass("active").find("i").removeClass("icon-play").addClass("icon-pause")
      @model.playTimeline()
  backwardTimeline: (e) ->
    @model.showtime(-1)
  forwardTimeline: (e) ->
    @model.showtime(1)
  gotoTime: (e) ->
    $e = $(e.currentTarget)
    @model.showtime(0, $e.index())
  initialize: ->
    @model.on("change:playing", @render, this)
    @model.on("change:timelineCounter", @render, this)
    @model.on("removeFromMap", @destroy, this)
    @mapProvider = @options.mapProvider
  destroy: ->
    @$el.remove()
  render: ->
    attributes = @model.toJSON()
    this.$el.html(@template(attributes))
    return this
