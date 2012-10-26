App.Layer = Backbone.RelationalModel.extend
  urlRoot: "/layers"
  idAttribute: "id"
  defaults: {
    leaflet: false
    onMap: false
    timelineCounter: 0
    playing: false
    visible: true
  }
  toLeaflet: ( options = {} ) ->
    tileLayer = L.tileLayer.wms(@get("data_source").wms, {
      layers: @get("name"),
      format: 'image/png',
      transparent: true,
      continuousWorld: true
    })
    tileLayer.setParams(options)
    @set({leaflet : tileLayer})
  removeFromMap: ->
    @set({onMap : false})
    @trigger('removeFromMap', this)
  addToMap: ->
    options = {}
    if @get("dimensions")
      options = {time: @get("dimensions")[0].dimension.value}
    @toLeaflet(options)
    @set({onMap : true})
    @trigger('addOnMap')
  toggleVisibility: (visible, value) ->
    @get("leaflet").setOpacity(value)
    @set({visible: visible})
  playTimeline: ->
    count = @get("dimensions").length
    that = this
    @set({playing: true})
    @player = setInterval (->
      timelineCounter = that.get("timelineCounter")
      that.showtime(1)
      if timelineCounter == count-1
        that.pauseTimeline() 
    ), 2000
  pauseTimeline:  ->
    clearInterval @player
    @set({playing: false})
  showtime: (step, timelineCounter = @get("timelineCounter")) ->
    if (timelineCounter + step) >= @get("dimensions").length || (timelineCounter + step) < 0
      @set({playing: false})
    else
      @set(timelineCounter: timelineCounter + step)
    dim = @get("dimensions")[timelineCounter]
    if dim
      time = moment(dim.dimension.value).format('YYYY-MM-DD')
      @get("leaflet").setParams({time: time}).redraw()
  initialize: ->