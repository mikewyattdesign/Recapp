$ ->
  sortable_index = (sortable_list, event_type) ->
    sortable_list.each (index) ->
      $.post 'set_favorite_photo_order', {
        event_id: $(this).data('event-id')
        photo_id: $(this).data('photo-id')
        order: index
        event_type: event_type
      }
      return
    return

  $('ul.sortable').sortable
    connectWith: 'ul'
    placeholder: 'drop-placeholder'
    forcePlaceholderSize: true

  $('#sortable_favorites').on 'sortupdate sortreceive', (event, ui) ->
      sortable_index $('#sortable_favorites').sortable('widget').children(), event.type
      return
  $('#sortable_favorites').on 'sortremove', (event, ui) ->
      sortable_index ui.item, event.type
      return

  $('#sortable_favorites, #sortable_other').disableSelection()
  return