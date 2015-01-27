jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    $('.chosen-select').chosen() // Add Chosen jQuery
    event.preventDefault()

  $(".collapse-box").on "click", (event) ->
    $(this).find("span").toggleClass("glyphicon-plus-sign").toggleClass "glyphicon-minus-sign" 
    $(this).siblings(".event-details").toggleClass "collapse"
    return
