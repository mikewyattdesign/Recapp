jQuery ->
	actionCheck()
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
	$('body').on 'click', '[data-toggles-all]', (event) ->
		$target = $($(this).data('toggles-all'))
		$target.trigger 'click'

actionCheck = ->
	if $('.assign_form input.assignable-id').length == 0 || $('.assign_form input.user-id').length == 0
		$('.assign_form [type="submit"], .unassign_form [type="submit"]').attr('disabled', 'disabled')
	else
		$('.assign_form [type="submit"], .unassign_form [type="submit"]').removeAttr('disabled')
	return

addAssignable = (assignableType, assignableId) ->
	assignableIndex = $('.assign_form input.assignable-id').length
	$('.assign_form').append("<input type='hidden' id='assignment_assignables_#{assignableIndex}_assignable_id' name='assignment[assignables][#{assignableIndex}][assignable_id]' value='#{assignableId}' class='assignable-id' data-assignable='#{assignableType}:#{assignableId}'>")
	$('.assign_form').append("<input type='hidden' id='assignment_#{assignableIndex}_assignable_type' name='assignment[assignables][#{assignableIndex}][assignable_type]' value='#{assignableType}' class='assignable-type' data-assignable='#{assignableType}:#{assignableId}'>")
	$('.unassign_form').append("<input type='hidden' id='assignment_assignables_#{assignableIndex}_assignable_id' name='assignment[assignables][#{assignableIndex}][assignable_id]' value='#{assignableId}' class='assignable-id' data-assignable='#{assignableType}:#{assignableId}'>")
	$('.unassign_form').append("<input type='hidden' id='assignment_#{assignableIndex}_assignable_type' name='assignment[assignables][#{assignableIndex}][assignable_type]' value='#{assignableType}' class='assignable-type' data-assignable='#{assignableType}:#{assignableId}'>")
	actionCheck()
	return
removeAssignable = (assignableType, assignableId) ->
	$(".assign_form input[data-assignable='#{assignableType}:#{assignableId}'], .unassign_form input[data-assignable='#{assignableType}:#{assignableId}']").remove()
	actionCheck()
	return
addUser = (userId) ->
	userIndex = $('.assign_form input.user-id').length
	$('.assign_form').append("<input type='hidden' id='assignment_users_#{userIndex}_user_id' name='assignment[users][#{userIndex}][user_id]' value='#{userId}' class='user-id'>")
	$('.unassign_form').append("<input type='hidden' id='assignment_users_#{userIndex}_user_id' name='assignment[users][#{userIndex}][user_id]' value='#{userId}' class='user-id'>")
	actionCheck()
	return
removeUser = (userId) ->
	$(".assign_form input.user-id[value='#{userId}'], .unassign_form input.user-id[value='#{userId}']").remove()
	actionCheck()
	return