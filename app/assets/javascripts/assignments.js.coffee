jQuery ->
	$('#assignable-select-table tbody').on 'change','.assignable-select-checkbox', (event) ->
		assignableType = $(this).data('assignable-type')
		assignableId = $(this).data('assignable-id')
		# if selected, shove into assignment forms
		if $(this).prop('checked')
			addAssignable(assignableType, assignableId)
		# if deselected, remove from the assignment forms
		else
			removeAssignable(assignableType, assignableId)
		return

	$('#user-select-table tbody').on 'change','.user-select-checkbox', (event) ->
		userId = $(this).data('user-id')
		# if selected, shove into assignment forms
		if $(this).prop('checked')
			addUser(userId)
		# if deselected, remove from the assignment forms
		else
			removeUser(userId)
		return

addAssignable = (assignableType, assignableId) ->
	console.log "Added #{assignableType}: #{assignableId}"
	$('.assign_form').append("<input type='hidden' id='assignment_assignable_id' name='assignment[assignable_id]' value='#{assignableId}'>")
	$('.assign_form').append("<input type='hidden' id='assignment_assignable_type' name='assignment[assignable_type]' value='#{assignableType}'>")
	return
removeAssignable = (assignableType, assignableId) ->
	console.log "Removed #{assignableType}: #{assignableId}"
	return
addUser = (userId) ->
	console.log "Added User: #{userId}"
	$('.assign_form').append("<input type='hidden' id='assignment_user_id' name='assignment[user_id]' value='#{userId}'>")
	return
removeUser = (userId) ->
	console.log "Removed User: #{userId}"
	return