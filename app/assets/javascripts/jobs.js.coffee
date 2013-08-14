# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('.datatable').dataTable
	  sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	  sPaginationType: "bootstrap"
	$('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '200px'

  $('.add-to-favourite-btn').each ->
    $(this).click (e) ->
      e.preventDefault()
      job_id = $(this).data('job-id');
      $.post('/jobs/add_to_favourite', {job_id: job_id});

  $('.add-to-favourite-btn-blocked').each ->
    $(this).click (e) ->
      e.preventDefault()
      $('#favourite-blocker-modal').modal('show');

  $('#go-to-signup-btn').click ->
    window.location.href = "/users/sign_up";
