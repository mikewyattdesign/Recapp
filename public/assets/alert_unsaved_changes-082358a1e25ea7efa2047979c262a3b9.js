$(document).on('ready page:load', function() {
  var unsaved = false;

  $('form').on('change', "input, select, textarea", function() {
    unsaved = true;
  });

  $('form').on('click', '.add_fields', function() {
    unsaved = true;
  });

  $(document).on('page:before-change', function(e) {
      if(unsaved){
        if (confirm("You have unsaved changes on this page. Do you want to leave this page and discard your changes or stay on this page?")) {
          unsaved = false;
        } else {
          e.preventDefault();
        }
      }
  });
});
