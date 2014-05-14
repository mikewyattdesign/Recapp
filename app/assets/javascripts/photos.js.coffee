jQuery ->
    $('#s3_uploader').S3Uploader({
        remove_completed_progress_bar: true,
        progress_bar_target: $('.js-progress-bars')
    })
    $('#s3_uploader').bind 's3_upload_failed', (e, content) ->
        alert(content.filename + ' failed to upload')
    $('#s3_uploader').bind 's3_upload_complete', (e, content) ->
        $('#direct_upload_url').val(content.url)
        $('#photo_image_file_name').val(content.filename)
        $('#photo_image_file_size').val(content.filesize)
        $('#photo_image_content_type').val(content.filetype)
        window.uploadContent = content
    $('[data-s3-trigger]').on 'click', ->
    	$targetEl = $($(this).data('s3-trigger'))
    	$targetEl.click()

        # /:class/:attachment/:id_partition/:style/:filename
