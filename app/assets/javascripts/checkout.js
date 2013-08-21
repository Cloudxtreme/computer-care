jQuery(function($){
  $(".service").click(function() {
    if($(".service:checked[data-can-checkout='false']").length > 0) {
      $("#payment").hide();
    }
    else {
      $("#payment").show(); 
    }
  });

  $( "#datepicker" ).datepicker({minDate: +1, altField: '#date'});

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