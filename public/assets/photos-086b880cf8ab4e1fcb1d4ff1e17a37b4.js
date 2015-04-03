(function() {
  jQuery(function() {
    $('#s3_uploader').S3Uploader({
      remove_completed_progress_bar: true,
      progress_bar_target: $('.js-progress-bars')
    });
    $('#s3_uploader').bind('s3_upload_failed', function(e, content) {
      return alert(content.filename + ' failed to upload');
    });
    $('#s3_uploader').bind('s3_upload_complete', function(e, content) {
      $('#direct_upload_url').val(content.url);
      $('#photo_image_file_name').val(content.filename);
      $('#photo_image_file_size').val(content.filesize);
      $('#photo_image_content_type').val(content.filetype);
      return window.uploadContent = content;
    });
    return $('[data-s3-trigger]').on('click', function() {
      var $targetEl;
      $targetEl = $($(this).data('s3-trigger'));
      return $targetEl.click();
    });
  });

}).call(this);
