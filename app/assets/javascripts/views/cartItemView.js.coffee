class App.CartItemView extends Backbone.View
  tagName: "li"
  template: -> _.template("<%= id %>")
  initialize: ->
  render: ->
    attributes = this.model.toJSON()
    console.log(attributes)
    this.$el.html(this.template(attributes))
    return this
