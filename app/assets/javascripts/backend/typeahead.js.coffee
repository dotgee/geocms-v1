if $("input.input-add-colaborator").length > 0
  engine = compile: (template) ->
    compiled = _.template(template)
    render: (context) ->
      compiled context

  $("input.input-add-colaborator").typeahead
    prefetch: GEOCMS_PREFIX+"/backend/users/network.json"
    engine: engine
    template: "<img src='<%= profileImageUrl %>' width='20' height='20'><p><strong><%= value %></strong><% if(name) { %>&nbsp;-&nbsp;<small><%= name %></small><% } %></p>"

  $(".btn-add-colaborator").click (e) ->
    $.ajax
      type: "POST"
      url: GEOCMS_PREFIX+"/backend/users/add"
      data: {username: $("input.input-add-colaborator").val() }
      success: (data) ->
        $(".table-users").append(data)