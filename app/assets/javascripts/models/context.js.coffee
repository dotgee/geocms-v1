class App.Context extends Backbone.Model
  urlRoot: "/contexts"
  schema: {
    name:           {type: 'Text', editorClass: "m-wrap"}
    description:    {type: 'TextArea', editorClass: "m-wrap"}
    public:         {type: 'Checkbox', editorClass: "m-wrap"}
    center_lng:     {title: "Longitude", type: 'Number', editorClass: "m-wrap"}
    center_lat:     {title: "Latitude", type: 'Number', editorClass: "m-wrap"}
    zoom:           {type: 'Number', editorClass: "m-wrap"}
  }