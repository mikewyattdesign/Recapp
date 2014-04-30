jQuery ->
    $('#s3_uploader').S3Uploader({
        remove_completed_progress_bar: true,
        progress_bar_target: $('.js-progress-bars')
    })
    $('#s3_uploader').bind 's3_upload_failed', (e, content) ->
        alert(content.filename + ' failed to upload')
    $('#s3_uploader').bind 's3_upload_complete', (e, content) ->
        $('#photo_direct_upload_url').val(content.url)
    $(document).on 'click', '[data-s3-trigger]', ->
    	$targetEl = $($(this).data('s3-trigger'))
    	$targetEl.click()