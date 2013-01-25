Backbone.Form.prototype.old_render = Backbone.Form.prototype.render
Backbone.Form.prototype.render = ()->

  Backbone.Form.prototype.old_render.call(this)
  $(this.el).find('select').select2()
  this
