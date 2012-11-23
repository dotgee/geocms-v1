class App.Context extends Backbone.Model
  urlRoot: "/contexts"
  schema: {
    name:           {type: 'Text', editorClass: "m-wrap", validators: ['required']}
    description:    {type: 'TextArea', editorClass: "m-wrap"}
    public:         {type: 'Checkbox', editorClass: "m-wrap"}
    center_lng:     {title: "Longitude", type: 'Text', editorClass: "m-wrap", validators: ['required']}
    center_lat:     {title: "Latitude", type: 'Text', editorClass: "m-wrap", validators: ['required']}
    zoom:           {type: 'Text', editorClass: "m-wrap", validators: ['required']}
  }
  getInitialCenter: ->
    {
      latitude: @get("center_lat")
      longitude: @get("center_lng")
      zoom: @get("zoom")
    }
