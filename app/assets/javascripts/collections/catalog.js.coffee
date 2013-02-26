class App.CatalogCollection extends Backbone.Collection
  model: App.Category
  url: GEOCMS_PREFIX+"/categories"
