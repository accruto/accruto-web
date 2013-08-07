jQuery ->
	$('#job_title, #job_company_attributes_name, #job_description').on "input", ->
		value = $(this).val()
		id = $(this).attr('id')
		$("#" + id + "_preview").html(value)
	$('#job_address_attributes_city').on "change", ->
		value = $('#job_address_attributes_city option:selected').val()
		id = $(this).attr('id')
		$("#" + id + "_preview").html(value)