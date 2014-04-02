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
	assignableIndex = $('input.assignable-id').length
	console.log "Added #{assignableType}: #{assignableId}"
	$('.assign_form').append("<input type='hidden' id='assignment_assignables_#{assignableIndex}_assignable_id' name='assignment[assignables][#{assignableIndex}][assignable_id]' value='#{assignableId}' class='assignable-id' data-assignable='#{assignableType}:#{assignableId}'>")
	$('.assign_form').append("<input type='hidden' id='assignment_#{assignableIndex}_assignable_type' name='assignment[assignables][#{assignableIndex}][assignable_type]' value='#{assignableType}' class='assignable-type' data-assignable='#{assignableType}:#{assignableId}'>")
	return
removeAssignable = (assignableType, assignableId) ->
	console.log "Removed #{assignableType}: #{assignableId}"
	$(".assign_form input[data-assignable='#{assignableType}:#{assignableId}']").remove()
	return
addUser = (userId) ->
	userIndex = $('input.user-id').length
	console.log "Added User: #{userId}"
	$('.assign_form').append("<input type='hidden' id='assignment_users_#{userIndex}_user_id' name='assignment[users][#{userIndex}][user_id]' value='#{userId}' class='user-id'>")
	return
removeUser = (userId) ->
	console.log "Removed User: #{userId}"
	$(".assign_form input.user-id[value='#{userId}']").remove()
	return