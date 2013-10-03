jQuery ->
  $('.select2').select2()
  $('.add-field').click ->
    partial_form = $(this).siblings(".partial-form-fields").html()
    partial_form = "<div class='partial-form-fields'>#{partial_form}</div>"
    $(this).before(partial_form)
    return false