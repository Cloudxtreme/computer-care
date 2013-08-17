$(function() {
  $(".checkout-service .checkbox input[type='checkbox']").click(function() {
    $options = $(this).closest(".checkout-service").find(".options");

    if($(this).is(":checked")) {
      $("input", $options).each(function() {
        $(this).removeAttr("disabled");
      });
      $("select", $options).each(function() {
        $(this).removeAttr("disabled");
      });    
      $options.slideDown();
    }
    else {
      $("input", $options).each(function() {
        $(this).attr("disabled", "disabled");
      });
      $("select", $options).each(function() {
        $(this).attr("disabled", "disabled");
      });    
      $options.slideUp();
    }
  });
});