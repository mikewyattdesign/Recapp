$(document).on('ready page:load', function() {
  var unsaved = false;

  $("#js-alert-unsaved-form input").change(function() {
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