# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('.datatable').dataTable
	  sDom: "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-6'i><'col-md-6'p>>",
	  sPaginationType: "bootstrap"
	$('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '200px'

  $('.add-to-favourite-btn').each ->
    $(this).click (e) ->
      e.preventDefault()
      job_id = $(this).data('job-id')
      # $($(this).children()[1]).hide()
      # span_loader = $(this).children()[0]
      # span_loader = $(span_loader)
      # loader_image_url = span_loader.data('image-url')
      # span_loader.html('<img src="'+loader_image_url+'" id="image-loader-'+job_id+'"/>')

      if $(this).hasClass('favourite-job')
        $(this).removeClass('favourite-job')
      else
        $(this).addClass('favourite-job')
      action = $(this).data('action')
      $.post(action, {job_id: job_id})

  $('.add-to-favourite-btn-blocked').each ->
    $(this).click (e) ->
      e.preventDefault()
      $('#favourite-blocker-modal').modal('show')

  $('body').on 'click', '.remove-favourite-item', (event) ->
    job_id = $(this).data('job-id')
    $(this).hide()
    span_loader = $(this).prev()
    loader_image_url = span_loader.data('image-url')
    span_loader.html('<img src="'+loader_image_url+'" id="image-loader-'+job_id+'"/>')

    $.post('/jobs/remove_favourite', {job_id: job_id})

  $('#remove-all-favourites').click (e) ->
    e.preventDefault()
    $('#remove-all-favourites-modal').modal('show')

  $('#remove-all-favourites-yes').click (e) ->
    e.preventDefault()
    $.post('/jobs/clear_favourites',{'_method': 'delete'})

  $('#remove-all-searches').click (e) ->
    e.preventDefault()
    $('#remove-all-searches-modal').modal('show')

  $('#remove-all-searches-yes').click (e) ->
    e.preventDefault()
    $.post('/jobs/clear_searches',{'_method': 'delete'})

  $('.set-alert-button').each ->
    $(this).click (e) ->
      e.preventDefault()
      if $(this).hasClass("search-alert-blocked")
        $('#search-alert-modal').modal('show')
      else
        id = $(this).data('recent-search-id')
        $(this).hide()
        span_loader = $(this).prev()
        loader_image_url = span_loader.data('image-url')
        span_loader.html('<img src="'+loader_image_url+'" id="image-loader-'+id+'"/>')
        action = $(this).data('action')
        $.post(action, {id: id})
