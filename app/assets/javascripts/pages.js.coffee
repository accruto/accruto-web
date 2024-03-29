# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#navbar-button').click ->
    $('#navbar-menu').toggle()

  $("#job_title").autocomplete
    source: (request, response) ->
      $.getJSON "/jobs/list.json", (data) ->
        jobList = data
        outputArray = new Array()
        i = 0

        while i < jobList.length
          outputArray.push jobList[i]  unless jobList[i].label.toLowerCase().indexOf(request.term.toLowerCase()) is -1
          i++
        if not outputArray or outputArray.length is 0
          outputArray[0] =
            label: "No Matches"
            value: "No Matches"
            item: ""
        response outputArray.slice(0, 8) #limit to first 8 items
    minLength: 0
    html: true
    select: (event, ui) ->
      return false  if ui.item.label is "No Matches"
      item = ui.item

  if $("#address").autocomplete({}).data("ui-autocomplete")?
    $("#address").autocomplete(
      source: (request, response) ->
        $.getJSON "/jobs/location.json", (data) ->
          location = data
          outputArray = new Array()
          i = 0

          while i < location.length
            outputArray.push location[i]  unless location[i].label.toLowerCase().indexOf(request.term.toLowerCase()) is -1
            i++
          if not outputArray or outputArray.length is 0
            outputArray[0] =
              label: "No Matches"
              value: "No Matches"
              item: ""
          response outputArray.slice(0, 8)

      minLength: 0
      html: true
      select: (event, ui) ->
        return false  if ui.item.label is "No Matches"
        item = ui.item
    ).data("ui-autocomplete")._renderItem = (ul, item) ->
      if item.label isnt "No Matches" and item.state isnt 0 and item.merged isnt 'merged'
        $("<li>").append("<a>" + item.label + "<br><div class='state-location'>" + item.state + "</div></a>").appendTo ul
      else if item.label isnt "No Matches" and item.state isnt 0 and item.merged is 'merged'
        $("<li>").append("<a>" + item.id + "<br><div class='state-location'>" + item.state + "</div></a>").appendTo ul
      else
        $("<li>").append("<a>" + item.label + "</a>").appendTo ul



