(function() {
  jQuery(function() {
    return $.getScript('https://sdk.amazonaws.com/js/aws-sdk-2.0.0-rc.14.min.js', function() {
      var $filechooser, s3;
      AWS.config.update({
        accessKeyId: 'AKIAJIH7A6UL5TW2KCNQ',
        secretAccessKey: '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'
      });
      s3 = new AWS.S3({
        params: {
          Bucket: 'nutshell-360-temp'
        }
      });
      $filechooser = $('[data-s3-direct-upload]');
      $filechooser.removeAttr('name');
      return $(document).on('change', '[data-s3-direct-upload]', function(e) {
        var file, params;
        file = $filechooser[0].files[0];
        if (file) {
          params = {
            Key: file.name,
            ContentType: file.type,
            Body: file,
            ACL: 'public-read'
          };
          return s3.putObject(params, function(err, data) {
            var uploadMessage;
            uploadMessage = err ? 'ERROR!' : 'UPLOADED.';
            return $('.photo-preview-text').text($('.photo-preview-text').text() + uploadMessage);
          });
        }
      });
    });
  });

}).call(this);
