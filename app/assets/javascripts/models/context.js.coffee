class App.Context extends Backbone.Model
  urlRoot: GEOCMS_PREFIX+"/contexts"
  schema:
    name:           {type: 'Text', editorClass: "m-wrap input-block-level", validators: ['required']}
    description:    {type: 'TextArea', editorClass: "m-wrap input-block-level"}
    center_lng:     {title: "Longitude", type: 'Text', editorClass: "m-wrap input-mini", fieldClass: "pull-left input-position first", validators: ['required']}
    center_lat:     {title: "Latitude", type: 'Text', editorClass: "m-wrap input-mini", fieldClass: "pull-left input-position", validators: ['required']}
    zoom:           {type: 'Text', editorClass: "m-wrap input-mini", fieldClass: "pull-left input-position", validators: ['required']}
  getInitialCenter: ->
    {
      latitude: @get("center_lat")
      longitude: @get("center_lng")
      zoom: @get("zoom")
    }
