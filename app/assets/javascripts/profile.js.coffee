jQuery ->
  $experience_counter = 0
  $qualification_counter = 0
  $education_counter = 0

  $('.select2').select2()
  $('.add-field').click ->
    partial_form = $(this).siblings(".partial-form-fields").html()
    partial_form = "<div class='partial-form-fields'>#{partial_form}</div>"
    $(this).before(partial_form)
    return false

  $('.add-experience-field').click (e) ->
    e.preventDefault()
    experience_form = $('.experience-form-fields:last')
    experience_form.find('.experience_select').each ->
      $(this).select2('destroy')

    object_id = experience_form.find('.experiences_company').attr('id')
    counter = parseInt(object_id.split('_')[3]) + 1
    if ($experience_counter < counter)
      $experience_counter = counter

    new_object = experience_form.children().first().clone()
    new_object.find('.experiences_company').val("")
      .attr('id', 'candidate_experiences_experience_company_' + $experience_counter)
      .attr('name', 'candidate[experiences_attributes]['+$experience_counter+'][company]')
    new_object.find('.experiences_job_title').val("")
      .attr('id', 'candidate_experiences_experience_job_title_' + $experience_counter)
      .attr('name', 'candidate[experiences_attributes]['+$experience_counter+'][job_title]')
    new_object.find('.experience_start').val("").prop('selected', true)
      .attr('id', 'experience_start_' + $experience_counter).select2()
      .attr('name', 'candidate[experiences_attributes]['+$experience_counter+'][started_at_text]')
    new_object.find('.experience_end').val("").prop('selected', true)
      .attr('id', 'experience_end_' + $experience_counter).select2()
      .attr('name', 'candidate[experiences_attributes]['+$experience_counter+'][ended_at_text]')
    new_object.find('.icon-remove').removeClass('hide')
    new_object.find('.experience_select').each ->
      $(this).removeClass('experience_select')
    new_object.insertBefore('.add-experience-field');

    experience_form.find('.experience_select').each ->
      $(this).select2()

    $experience_counter++

  $('.add-qualification-field').click (e) ->
    e.preventDefault()
    qualification_form = $('.qualification-form-fields:last')
    qualification_form.find('.qualification_select').select2('destroy')

    object_id = qualification_form.find('.qualification_name').attr('id')
    counter = parseInt(object_id.split('_')[4]) + 1
    if ($qualification_counter < counter)
      $qualification_counter = counter

    new_object = qualification_form.children().first().clone()
    new_object.find('.qualification_name').val("")
      .attr('id', 'profile_trade_qualification_name_' + $qualification_counter)
      .attr('name', 'candidate[trade_qualifications_attributes]['+$qualification_counter+'][name]')
    new_object.find('.qualification_year').val("").prop('selected', true)
      .attr('id', 'qualification_year_' + $qualification_counter).select2()
      .attr('name', 'candidate[trade_qualifications_attributes]['+$qualification_counter+'][attained_at_text]')
    new_object.insertBefore('.add-qualification-field')
    new_object.find('.icon-remove').removeClass('hide')
    qualification_form.find('.qualification_select').select2()
    $qualification_counter++

  $('.add-education-field').click (e) ->
    e.preventDefault()
    education_form = $('.education-form-fields:last')
    education_form.find('.education_select').each ->
      $(this).select2('destroy')

    object_id = education_form.find('.education_institution').attr('id')
    counter = parseInt(object_id.split('_')[3]) + 1
    if ($education_counter < counter)
      $education_counter = counter

    new_object = education_form.children().first().clone()
    new_object.find('.education_institution').val("")
      .attr('id', 'profile_education_institution_' + $education_counter)
      .attr('name', 'candidate[educations_attributes]['+$education_counter+'][institution]')
    new_object.find('.education_qualification').val("")
      .attr('id', 'profile_education_qualification_' + $education_counter)
      .attr('name', 'candidate[educations_attributes]['+$education_counter+'][qualification]')
    new_object.find('.education_qualification_type').val("")
      .attr('id', 'profile_education_qualification_type_' + $education_counter).select2()
      .attr('name', 'candidate[educations_attributes]['+$education_counter+'][qualification_type]')
    new_object.find('.graduated_at').val("").prop('selected', true)
      .attr('id', 'profile_education_graduated_at_in_years_' + $education_counter).select2()
      .attr('name', 'candidate[educations_attributes]['+$education_counter+'][graduated_at_text]')
    new_object.find('.icon-remove').removeClass('hide')
    new_object.find('.education_select').each ->
      $(this).removeClass('education_select')
    new_object.insertBefore('.add-education-field')
    education_form.find('.education_select').each ->
      $(this).select2()

    $education_counter++

  $('body').on 'click', '.experience-row-remove, .education-row-remove, .qualification-row-remove', (e) ->
    e.preventDefault()
    closest_form_fields = $(this).closest('.partial-form-fields')
    closest_form_fields.next().attr('value', 'true')
    closest_form_fields.remove()