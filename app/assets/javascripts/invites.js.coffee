jQuery ->
  $('#invite_name').keyup (e) ->
    name = $('#invite_name').val()
    $('#invite-name-preview').text(name)

  $('#invite_email').keyup (e) ->
    email = $('#invite_email').val()
    $('#invite-email-preview').text(email)

  $('#invite_message').keyup (e) ->
    message = $('#invite_message').val()
    $('#invite-message-preview').text(message)

  $('#invite-message-preview').text($('#invite_message').val())