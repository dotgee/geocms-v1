window.App =
  start: ->
    new App.Router()
    Backbone.history.start(
      pushState: true, root: "/"
    )
$(App.start)
