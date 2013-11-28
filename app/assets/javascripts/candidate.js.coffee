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
          $('ul.shortlists').append('<li><i class="icon-remove-sign shortlist-remove pointer" data-shortlist-id="'+data.shortlist.id+'" data-toggle="tooltip" title="remove from shortlist"></i>'+job_title+'</li>')
          target_object = $('#candidate-shortlist-'+candidate_id+', #candidate-shortlist-flipped-'+candidate_id)
          target_object.addClass('disabled')
          target_object.text('Shortlisted')

  $(document).on "click", ".shortlist-remove", ->
    $(this).parent().remove()
    shortlists = $('ul.shortlists').children()
    shortlist_id = $(this).data('shortlist-id')
    $.post '/shortlists/destroy', { _method: 'delete', shortlist_id: shortlist_id}, (data) ->
      target_object = $('#candidate-shortlist-'+data.candidate_id+', #candidate-shortlist-flipped-'+data.candidate_id)
      target_object.removeClass('disabled')
      target_object.text('+ Shortlist')
    if (shortlists.length == 0)
      $('ul.shortlists').append('<li>No shortlisted candidates</li>')