jQuery ->
  $('.main-search-tab').click ->
    id = $(this).attr('id').split('_')[0]
    $('.main-search-content, .ticker').addClass('hidden')
    $("##{id}_content, .#{id}_ticker").removeClass('hidden')