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
    candidate_id = $(this).closest('.candidate-entry').attr('id').split("-")[1]
    job_title = $(this).data('job-title')
    candidate_id = $(this).data('candidate-id')
    shortlists = $('ul.shortlists').children()
    $.post '/shortlists/create', {candidate_id: candidate_id}, (data) ->
      console.log(data)
      if (data.success)
        if (shortlists.first().text() == 'No shortlisted candidates')
          shortlists.first().remove()
        $('ul.shortlists').append('<li><i class="icon-remove-sign shortlist-remove pointer" data-shortlist-id="'+data.shortlist.id+'" data-toggle="tooltip" title="remove from shortlist"></i>'+job_title+'</li>')
        $('#candidate-shortlist-'+candidate_id).addClass('hide')

  $(document).on "click", ".shortlist-remove", ->
    $(this).parent().remove()
    shortlists = $('ul.shortlists').children()
    shortlist_id = $(this).data('shortlist-id')
    $.post '/shortlists/destroy', { _method: 'delete', shortlist_id: shortlist_id}, (data) ->
      console.log(data)
      $('#candidate-shortlist-'+data.candidate_id).removeClass('hide')
    if (shortlists.length == 0)
      $('ul.shortlists').append('<li>No shortlisted candidates</li>')