class App.CatalogCollection extends Backbone.Collection
  model: (attrs, options) ->
    if (attrs.type == "category")
      new App.Category(attrs, options)
    else
      new App.Layer(attrs, options)

  url: GEOCMS_PREFIX+"/categories"
