(function() {
  var actionCheck, addAssignable, addUser, removeAssignable, removeUser;

  jQuery(function() {
    actionCheck();
    $('#assignable-select-table tbody').on('change', '.assignable-select-checkbox', function(event) {
      var assignableId, assignableType;
      assignableType = $(this).data('assignable-type');
      assignableId = $(this).data('assignable-id');
      if ($(this).prop('checked')) {
        addAssignable(assignableType, assignableId);
      } else {
        removeAssignable(assignableType, assignableId);
      }
    });
    $('#user-select-table tbody').on('change', '.user-select-checkbox', function(event) {
      var userId;
      userId = $(this).data('user-id');
      if ($(this).prop('checked')) {
        addUser(userId);
      } else {
        removeUser(userId);
      }
    });
    $('body').on('click', '[data-toggles-all]', function(event) {
      var $target;
      $target = $($(this).data('toggles-all'));
      return $target.trigger('click');
    });
    return $('#user-select-table tbody .edit_user').on('change', '[name="user[role]"]', function(event) {
      return $(this).parent().submit();
    });
  });

  actionCheck = function() {
    if ($('.assign_form input.assignable-id').length === 0 || $('.assign_form input.user-id').length === 0) {
      $('.assign_form [type="submit"], .unassign_form [type="submit"]').attr('disabled', 'disabled');
    } else {
      $('.assign_form [type="submit"], .unassign_form [type="submit"]').removeAttr('disabled');
    }
  };

  addAssignable = function(assignableType, assignableId) {
    var assignableIndex;
    assignableIndex = $('.assign_form input.assignable-id').length;
    $('.assign_form').append("<input type='hidden' id='assignment_assignables_" + assignableIndex + "_assignable_id' name='assignment[assignables][" + assignableIndex + "][assignable_id]' value='" + assignableId + "' class='assignable-id' data-assignable='" + assignableType + ":" + assignableId + "'>");
    $('.assign_form').append("<input type='hidden' id='assignment_" + assignableIndex + "_assignable_type' name='assignment[assignables][" + assignableIndex + "][assignable_type]' value='" + assignableType + "' class='assignable-type' data-assignable='" + assignableType + ":" + assignableId + "'>");
    $('.unassign_form').append("<input type='hidden' id='assignment_assignables_" + assignableIndex + "_assignable_id' name='assignment[assignables][" + assignableIndex + "][assignable_id]' value='" + assignableId + "' class='assignable-id' data-assignable='" + assignableType + ":" + assignableId + "'>");
    $('.unassign_form').append("<input type='hidden' id='assignment_" + assignableIndex + "_assignable_type' name='assignment[assignables][" + assignableIndex + "][assignable_type]' value='" + assignableType + "' class='assignable-type' data-assignable='" + assignableType + ":" + assignableId + "'>");
    actionCheck();
  };

  removeAssignable = function(assignableType, assignableId) {
    $(".assign_form input[data-assignable='" + assignableType + ":" + assignableId + "'], .unassign_form input[data-assignable='" + assignableType + ":" + assignableId + "']").remove();
    actionCheck();
  };

  addUser = function(userId) {
    var userIndex;
    userIndex = $('.assign_form input.user-id').length;
    $('.assign_form').append("<input type='hidden' id='assignment_users_" + userIndex + "_user_id' name='assignment[users][" + userIndex + "][user_id]' value='" + userId + "' class='user-id'>");
    $('.unassign_form').append("<input type='hidden' id='assignment_users_" + userIndex + "_user_id' name='assignment[users][" + userIndex + "][user_id]' value='" + userId + "' class='user-id'>");
    actionCheck();
  };

  removeUser = function(userId) {
    $(".assign_form input.user-id[value='" + userId + "'], .unassign_form input.user-id[value='" + userId + "']").remove();
    actionCheck();
  };

}).call(this);
