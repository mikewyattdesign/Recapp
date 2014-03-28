@IMAGE_UPLOAD_PREVIEW = do ->
	readURL = (input) ->
		$target = $($(input).data('image-upload-preview')) 
		if input.files && input.files[0]
			reader = new FileReader()
			reader.onload = (e) ->
				$target.attr 'src', e.target.result
				$('.current-photo-container').hide()
				$target.fadeIn 'slow'
				return
			reader.readAsDataURL input.files[0]
		else
			$target.attr 'src', ''	
			$target.hide()
			$('.current-photo-container').fadeIn 'slow'
		return
	init = ->
		$('[data-image-upload-preview]').change ->
			readURL this
			return
		return
	return {
		init
	}

jQuery ->
	IMAGE_UPLOAD_PREVIEW.init()
