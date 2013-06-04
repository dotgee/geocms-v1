window.App =
  start: ->
    new App.Router()
    enablePushState = true
    # Disable for older browsers
    pushState = !!(enablePushState && window.history && window.history.pushState)

    Backbone.history.start(
      pushState: pushState, root: GEOCMS_PREFIX
    )
$(App.start)
