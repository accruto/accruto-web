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