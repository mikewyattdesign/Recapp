(function() {
  $(function() {
    var sortable_index;
    sortable_index = function(sortable_list, event_type) {
      sortable_list.each(function(index) {
        $.post('set_favorite_photo_order', {
          event_id: $(this).data('event-id'),
          photo_id: $(this).data('photo-id'),
          order: index,
          event_type: event_type
        });
      });
    };
    $('.sortable').sortable({
      connectWith: '.sortable',
      placeholder: 'drop-placeholder',
      forcePlaceholderSize: true
    });
    $('#sortable_favorites').on('sortupdate sortreceive', function(event, ui) {
      sortable_index($('#sortable_favorites').sortable('widget').children(), event.type);
    });
    $('#sortable_favorites').on('sortremove', function(event, ui) {
      sortable_index(ui.item, event.type);
    });
    $('#sortable_favorites, #sortable_other').disableSelection();
  });

}).call(this);
