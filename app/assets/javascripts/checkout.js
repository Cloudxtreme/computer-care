jQuery(function($){
  // accordian effect
  initialize_form();
  $("#order-form").on("click", "fieldset.active a.next", function() {
    $fieldset = $(this).closest("fieldset");
    if($fieldset.attr("id") == "options") {
      // make sure atleast one service was selected
      if($("input[type='checkbox']:checked", $fieldset).length > 0) {
        open_next_section($fieldset);
      }
    }
    else if($fieldset.attr("id") == "user") {
      // make sure all fields were filled out
      var can_continue = true;
      $("input[type='text']", $fieldset).each(function() {
        if(!$(this).val()) {
          can_continue = false;
        }
      });
      if(can_continue) {
        open_next_section($fieldset);
      }
    }
    else if($fieldset.attr("id") == "collection") {
      open_next_section($fieldset);
    } 
  });

  $("#order-form").on("click", "fieldset.active a.back", function() {
    $fieldset = $(this).closest("fieldset");
    open_previous_section($fieldset);
  });

  $(".service").click(function() {
    if($(".service:checked[data-can-checkout='false']").length > 0) {
      // make payment form disabled
      $("#payment input[type='text']").attr("disabled", "disabled").hide();
      //show message
      $("#payment .alert").show();
    }
    else {
      // enable payment form 
      $("#payment input[type='text']").removeAttr("disabled").show();
      // hide message
      $("#payment .alert").hide();
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

function initialize_form() {
  if(!$("#order-form").hasClass("error")) {
    $("#order-form fieldset").first().addClass("active");
    $("#order-form fieldset:not(:first)").hide();
    $("#order-form header.stripe").each(function(i) {
      i++;
      if(i>2) {
        $(this).find(".img-shadow.left").hide();
        $(this).find(".img-shadow.right").hide();
      }
      else if(i==2) {
        $(this).find(".img-shadow.left:not(.top)").hide();
        $(this).find(".img-shadow.right:not(.top)").hide();
      }
    });
    $("#order-form footer.stripe .img-shadow").hide();  
  }
  else {
    $(".next").hide();
  }
}

function open_next_section($current) {
  $current.hide();
  $current.prev("header").find(".img-shadow").hide();
  $current.next().next("fieldset").addClass("active").slideDown();
  $current.next("header").find(".img-shadow").show();  
  $current.next("header").find(".img-shadow.top").hide();
  $current.next().next().next().find(".img-shadow.top").show();
  $current.removeClass("active");
  if($("fieldset.active").is(":nth-last-child(2)")) {
    $("footer.stripe .img-shadow").show();
  }
}

function open_previous_section($current) {
  $(".img-shadow").hide();
  $current.hide();
  $current.prev().prev("fieldset").addClass("active").slideDown();
  $current.prev("header").find(".img-shadow").hide();
  $current.prev("header").find(".img-shadow.top").show();
  $current.prev().prev().prev().find(".img-shadow:not(.top)").show();
  $current.removeClass("active");
}