(function() {
  jQuery(function() {
    return $("[data-tag-list]").tokenInput("/tags.json", {
      crossDomain: false,
      prePopulate: $("[data-tag-list]").data('pre'),
      tokenValue: "name",
      preventDuplicates: true,
      theme: "facebook",
      allowFreeTagging: true
    });
  });

  jQuery(function() {
    $(".tags-button").on("click", function() {
      return $(this).parent().prev(".tag-list").toggleClass("inactive").toggleClass("active");
    });
    return $(".favorite-button").on("click", function() {
      return $(this).parents(".favorite-box").toggleClass("active");
    });
  });

}).call(this);
