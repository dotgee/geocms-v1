App.Category = Backbone.RelationalModel.extend
  urlRoot: "/categories"
  idAttribute: "id"
  defaults: {
    model: "category"
  }
  relations: [
    {
      type: Backbone.HasMany,
      key: 'children',
      relatedModel: 'App.Category',
      reverseRelation: {
          key: 'parent',
          includeInJSON: 'id',
      },
    },
    {
      type: Backbone.HasMany,
      key: 'layers',
      relatedModel: 'App.Layer',
      reverseRelation: {
          key: 'category',
          includeInJSON: 'id',
      },
    }
  ]