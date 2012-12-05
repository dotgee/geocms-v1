# Base class Layer
class Layer extends Backbone.Model
  urlRoot: "/backend/layers"
  schema:   
    title: { type: "Text", validators: ['required'] }
    name: { type: "Text", validators: ['required'] }
    description: "TextArea"
    category_id: { type: "Select", options:  gon.categories, validators: ['required'] }

# Collection of imported layers
class ImportCollection extends Backbone.Collection
  model: Layer

# Modal box
class LayerModalView extends Backbone.View
  el: $("#modal-form")
  events:
    "click #save" : "save"
  initialize: ->
    @form = new Backbone.Form({ model: @model }).render()
  save: ->
    errors = @form.commit()
    unless errors
      console.log @model
      @model.save()
  render: ->
    @$el.modal()
    @$el.find(".modal-body").html(@form.el)

# View of one layer in the list
class LayerItemView extends Backbone.View
  tagName: "tr"
  template: _.template("
    <td>
      <h3> <%= title %> </h3>
      <small> <%= name %> </small>
      <div class='infos'>
      </div>
    </td>
    <td class='import'>
      <a href='#' class='m-btn blue import-btn'>
        <i class='icon-download icon-white'></i> Import
      </a>
    </td>
  ")
  events: 
    "click .import-btn": "openModal"
  initialize: ->
  openModal: (e) ->
    unless @modal
      @modal = new LayerModalView({model: @model})
    @modal.render()
  render: ->
    attributes = @model.toJSON()
    @$el.html(@template(attributes))
    return this

# List of all layers
class LayerView extends Backbone.View
  el: $("#import-layers")
  initialize: ->
  addOne: (layer) ->
    @$el.append new LayerItemView({model : layer}).render().el
  render: ->
    @collection.forEach(@addOne, this)


# Initialization
imported = new ImportCollection()
imported.reset(gon.layers)
view = new LayerView({collection: imported})
view.render()