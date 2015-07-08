jQuery ->
  $('.chosen-select').chosen() # Add Chosen jQuery
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    $('.chosen-select').chosen() # Add Chosen jQuery
    event.preventDefault()

  $(".event-circle").on "click", (event) ->
    $(this).parent().find(".event-circle span").toggleClass("glyphicon-plus-sign").toggleClass "glyphicon-minus-sign"
    $(this).siblings(".event-details").toggleClass "collapse"
    return

  $(".event-info-text").on "click", (event) ->
    $(this).siblings(".event-details").toggleClass "collapse"
    $(this).parent().find(".event-circle span").toggleClass("glyphicon-plus-sign").toggleClass "glyphicon-minus-sign"
    return

  return