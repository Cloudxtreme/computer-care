$(function() {
  $(".add-option").click(function(e) {
    e.preventDefault();
    $li = $(this).parent("li");
    $li.append("<div class='new-option'></div>");
    $li.find(".new-option").load($(this).attr("href"), function() {
      $li.find("#cancel").show();
    });
  });

  $("body").on("click", "#cancel", function(e) {
    e.preventDefault();
    $(this).closest(".new-option").remove();
  });
});