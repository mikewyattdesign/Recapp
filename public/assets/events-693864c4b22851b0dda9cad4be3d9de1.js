(function() {
  jQuery(function() {
    $('form').on('click', '.remove_fields', function(event) {
      $(this).prev('input[type=hidden]').val('1');
      $(this).closest('fieldset').hide();
      return event.preventDefault();
    });
    $('form').on('click', '.add_fields', function(event) {
      var regexp, time;
      time = new Date().getTime();
      regexp = new RegExp($(this).data('id'), 'g');
      $(this).before($(this).data('fields').replace(regexp, time));
      Math.floor($('.chosen-select').chosen() / Add(Chosen(jQuery)));
      return event.preventDefault();
    });
    return $(".collapse-box").on("click", function(event) {
      $(this).find("span").toggleClass("glyphicon-plus-sign").toggleClass("glyphicon-minus-sign");
      $(this).siblings(".event-details").toggleClass("collapse");
    });
  });

}).call(this);
