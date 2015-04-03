(function() {
  this.IMAGE_UPLOAD_PREVIEW = (function() {
    var init, readURL;
    readURL = function(input) {
      var $target, reader;
      $target = $($(input).data('image-upload-preview'));
      if (input.files && input.files[0]) {
        reader = new FileReader();
        reader.onload = function(e) {
          $target.attr('src', e.target.result);
          $('.current-photo-container').hide();
          $target.fadeIn('slow');
        };
        reader.readAsDataURL(input.files[0]);
      } else {
        $target.attr('src', '');
        $target.hide();
        $('.current-photo-container').fadeIn('slow');
      }
    };
    init = function() {
      $('[data-image-upload-preview]').change(function() {
        readURL(this);
      });
    };
    return {
      init: init
    };
  })();

  jQuery(function() {
    return IMAGE_UPLOAD_PREVIEW.init();
  });

}).call(this);
