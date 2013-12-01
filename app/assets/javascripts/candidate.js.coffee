jQuery ->
  $('#candidate-range').daterangepicker()
  $('.flip-in-candidate').click ->
    id = $(this).closest('.candidate-preview').attr('id').split("-")[1]
    $("#candidate-#{id}-preview").hide()
    $("#candidate-#{id}-detail").css('display','block').addClass('animated flipInY')
    return false
  $('.flip-out-candidate').click ->
    id = $(this).closest('.candidate-detail').attr('id').split("-")[1]
    $("#candidate-#{id}-detail").hide()
    $("#candidate-#{id}-preview").show().addClass('animated flipInY')
    return false

  # shortlisting candidates
  $('.btn-candidate-shortlist').click (e) ->
    e.preventDefault()
    if !$(this).hasClass('disabled')
      candidate_id = $(this).closest('.candidate-entry').attr('id').split("-")[1]
      job_title = $(this).data('job-title')
      candidate_id = $(this).data('candidate-id')
      shortlists = $('ul.shortlists').children()
      $.post '/shortlists/create', {candidate_id: candidate_id}, (data) ->
        if (data.success)
          if (shortlists.first().text() == 'No shortlisted candidates')
            shortlists.first().remove()
          $('ul.shortlists').append('<li id="shortlist-list-'+data.shortlist.id+'"><i class="icon-remove-sign shortlist-remove pointer" data-shortlist-id="'+data.shortlist.id+'" data-toggle="tooltip" title="remove from shortlist"></i>'+job_title+'</li>')
          target_object = $('#candidate-shortlist-'+candidate_id+', #candidate-shortlist-flipped-'+candidate_id)
          target_object.addClass('disabled').text('Shortlisted').attr('title', 'remove from shortlist')
          $("a[data-candidate-id='#{candidate_id}']").each (e) ->
            $(this).attr('data-shortlist-id', data.shortlist.id)
          shortlists = $('ul.shortlists').children()
          if (shortlists.length > 0)
            $('#download-shortlist-btn').removeClass('hide')
    else
      shortlist_id = $(this).attr('data-shortlist-id')
      $.post '/shortlists/destroy', { _method: 'delete', shortlist_id: shortlist_id}, (data) ->
        $("a[data-shortlist-id='#{shortlist_id}']").each (e) ->
          $(this).removeClass('disabled').text('+ Shortlist').attr('data-shortlist-id', '').attr('title', 'add to shortlist')
        $("#shortlist-list-#{shortlist_id}, #shortlist-list-flipped-#{shortlist_id}").remove()
        shortlists = $('ul.shortlists').children()
        if (shortlists.length == 0)
          $('ul.shortlists').append('<li>No shortlisted candidates</li>')
          $('#download-shortlist-btn').addClass('hide')

  $(document).on "click", ".shortlist-remove", ->
    $(this).parent().remove()
    shortlists = $('ul.shortlists').children()
    shortlist_id = $(this).data('shortlist-id')
    $.post '/shortlists/destroy', { _method: 'delete', shortlist_id: shortlist_id}, (data) ->
      target_object = $("#candidate-shortlist-#{data.candidate_id}, #candidate-shortlist-flipped-#{data.candidate_id}")
      target_object.removeClass('disabled').text('+ Shortlist').attr('title', 'add to shortlist')
    if (shortlists.length == 0)
      $('ul.shortlists').append('<li>No shortlisted candidates</li>')
      $('#download-shortlist-btn').addClass('hide')