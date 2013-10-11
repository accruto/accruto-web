jQuery ->
  $("#invite_name, #invite_email").on "input", ->
    $(".email-content").css('display','block')