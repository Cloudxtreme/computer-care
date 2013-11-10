jQuery(function($){
  $("#order-form").show();
  
  $("#order-form fieldset a.second-last, #quote-form fieldset a.second-last").click(function() {
    $("footer.stripe").show();
  });

  $("#order-form fieldset a.last, #quote-form fieldset a.last").click(function() {
    $("footer.stripe").hide();
  });

  var $preselected = $(".checkout-service .checkbox input[type='checkbox']:checked");
  var $container = $preselected.closest(".checkout-service");
  $container.addClass("selected", function() {
    open_service_options($preselected);
  });

  // hide service options
  $(".checkout-service .hidden-option").hide();
  $(".disabled-option").attr("disabled", "disabled");

  $("#order-form .btn.js").show();
  $("#quote-form .btn.js").show();

  // disable finalize button until user has accepted the TOC's
  $("#summary-next").attr("disabled", "disabled");
  $("body").on("click", ".checkbox .required.agreement", function() {
    if($(this).is(":checked")) {
      $("#summary-next").removeAttr("disabled");
    }
    else {
      $("#summary-next").attr("disabled", "disabled");
    }
  });

  // turn off form autocomplete
  $(":input").attr("autocomplete", "off");

  // form validation
  if(($("#order-form.first").length > 0) || ($("#quote-form.first").length > 0)) {
    var is_order_form = $("#order-form.first").length > 0;
    var is_quote_form = $("#quote-form.first").length > 0;
    if($preselected.length > 0) {
      $("#options a.btn").removeAttr("disabled");
    }
    else if(is_order_form) {
      $("#options a.next").attr("disabled", "disabled");
    }

    $("#options input[type='checkbox']").click(function() {
      if($("#options input[type='checkbox']:checked").length > 0) {
        $("#options a.next").removeAttr("disabled");
      }
      else {
        $("#options a.next").attr("disabled", "disabled");         
      }
    });

    var first_name = new LiveValidation( "first-name", { validMessage: " ", wait: 500 } );
    first_name.add( Validate.Presence, { failureMessage: "*" } );
    first_name.add( Validate.Length, { minimum: 2, tooShortMessage: "*" } );

    var last_name = new LiveValidation( "last-name", { validMessage: " ", wait: 500 } );
    last_name.add( Validate.Presence, { failureMessage: "*" } );
    last_name.add( Validate.Length, { minimum: 2, tooShortMessage: "*" } );

    var email = new LiveValidation( "email", { validMessage: " ", wait: 500 } );
    email.add( Validate.Presence, { failureMessage: "*" } );
    email.add( Validate.Email, { failureMessage: "*" } );

    var telephone = new LiveValidation( "telephone", { validMessage: " ", wait: 500 } );
    telephone.add( Validate.Presence, { failureMessage: "*" } );
    telephone.add( Validate.Numericality, { onlyInteger: true, notANumberMessage: "*", notAnIntegerMessage: "*"  } );
    telephone.add( Validate.Length, { minimum: 11, tooShortMessage: "*" } );

    var building = new LiveValidation( "building", { validMessage: " ", wait: 500 } );
    building.add( Validate.Presence, { failureMessage: "*" } );

    var street = new LiveValidation( "street", { validMessage: " ", wait: 500 } );
    street.add( Validate.Presence, { failureMessage: "*" } );
    street.add( Validate.Length, { minimum: 2, tooShortMessage: "*" } );

    var town = new LiveValidation( "town", { validMessage: " ", wait: 500 } );
    town.add( Validate.Presence, { failureMessage: "*" } );
    town.add( Validate.Length, { minimum: 2, tooShortMessage: "*" } );

    $("#postcode").blur(function() {
      var postcode_value = $(this).val();
      var newPostCode = checkPostCode($.trim(postcode_value));
      if(newPostCode) {
        $(this).addClass("LV_valid_field");
        $(this).removeClass("LV_invalid_field");
        $(this).next("span").remove();
        $(this).val(newPostCode);
      } else {
        $(this).removeClass("LV_valid_field");      
        $(this).addClass("LV_invalid_field");
        if($(this).next("span").length == 0) {
          $(this).after("<span class='LV_validation_message LV_invalid'>*</span>");
        }
      }
    });

    $("#user .next").attr("disabled", "disabled");
    validate_user_details();

    $("#user input").keyup(function() {
      setTimeout(function() { validate_user_details(); }, 500);     
    });
  }

  function validate_user_details() {
    var areAllValid = true;

    try {
      Validate.Presence($("#first-name").val());
      Validate.Length($("#first-name").val(), { minimum: 2 });

      Validate.Presence($("#last-name").val());
      Validate.Length($("#last-name").val(), { minimum: 2 });

      Validate.Presence($("#email").val());
      Validate.Email($("#email").val());

      Validate.Presence($("#telephone").val());
      Validate.Numericality($("#telephone").val(), { onlyInteger: true });
      Validate.Length($("#telephone").val(), { minimum: 11 });

      Validate.Presence($("#building").val());

      Validate.Presence($("#street").val());
      Validate.Length($("#street").val(), { minimum: 2 });

      Validate.Presence($("#town").val());
      Validate.Length($("#town").val(), { minimum: 2 });
    }
    catch(err) {
      areAllValid = false;
    }
    var postcode_val = $.trim($("#postcode").val());
    if(!checkPostCode(postcode_val)) {
      areAllValid = false;
    }

    if(areAllValid) {
      $("#user .next").removeAttr("disabled");
    } else {
      $("#user .next").attr("disabled", "disabled"); 
    }
  }

  // accordian effect
  if($("#order-form").length > 0) {
    initialize_form($("#order-form"));
  }
  else if($("#quote-form").length > 0) {
    initialize_form($("#quote-form")); 
  }
  $("#quote-form").on("click", "fieldset.active a.next[disabled!='disabled']", function() {
    $fieldset = $(this).closest("fieldset");
    open_next_section($fieldset);
  });  
  $("#order-form").on("click", "fieldset.active a.next[disabled!='disabled']", function() {
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
    else {
      open_next_section($fieldset); 
    }
  });

  $("#order-form, #quote-form").on("click", "fieldset.active a.back", function() {
    $fieldset = $(this).closest("fieldset");
    open_previous_section($fieldset);
  });

  // make all services de-selected
  $(".checkout-service input[type='checkbox']").each(function() {
    //$(this).attr("checked", false);
  });

  $(".options select").change(function() {
    update_cost();
  });

  $(".checkout-service .checkbox input[type='checkbox']").click(function() {
    var $clicked = $(this);
    var $container = $clicked.closest(".checkout-service");
    $container.toggleClass("selected", function() {
      open_service_options($clicked);
    });

    update_cost();
  });
});

function initialize_form($form) {
  if(!$form.hasClass("error")) {
    if($form.hasClass("reverse")) {
      $("fieldset", $form).last().addClass("active");
      $("fieldset:not(:last)", $form).hide();
    }
    else {
      $("fieldset", $form).first().addClass("active");
      $("fieldset:not(:first)", $form).hide();
    }
    $(".img-shadow").hide();
    $("fieldset.active", $form).prev(".stripe").find(".img-shadow:not(.top)").show();
    $("fieldset.active", $form).next(".stripe").find(".img-shadow.top").show();
    /*$("#order-form header.stripe").each(function(i) {
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
    $("#order-form footer.stripe .img-shadow").hide();  */
  }
  else {
    $(".next").hide();
  }
}

function open_next_section($current) {
  $current.hide();
  $current.prev("header").removeClass("active");
  $current.prev("header").find(".img-shadow").hide();
  $current.next().next("fieldset").addClass("active").slideDown();
  $current.next("header").find(".img-shadow").show();  
  $current.next("header").find(".img-shadow.top").hide();
  $current.next("header").addClass("active");
  $current.next().next().next().find(".img-shadow.top").show();
  $current.removeClass("active");
  if($("fieldset.active").is(":nth-last-child(2)")) {
    $("footer.stripe .img-shadow").show();
  }
}

function open_previous_section($current) {
  $(".img-shadow").hide();
  $current.hide();
  $current.prev().prev().prev("header").addClass("active");
  $current.prev("header").removeClass("active");
  $current.prev().prev("fieldset").addClass("active").slideDown();
  $current.prev("header").find(".img-shadow").hide();
  $current.prev("header").find(".img-shadow.top").show();
  $current.prev().prev().prev().find(".img-shadow:not(.top)").show();
  $current.removeClass("active");
}

function update_cost() {
  var total = 0.0;
  $("input[type='checkbox']:checked").each(function() {
    var cost = parseFloat($(this).data("base"));
    if(cost && cost > 0) {
      total = total + cost;
    }
  });
  $(".selected :selected", "#options").each(function() {
    var cost = parseFloat($(this).data("additional"));
    if(cost && cost > 0) {
      total = total + cost;
    }
  });

  $("#total-cost").html(total);
}

function open_service_options($clicked) {  
  $options = $clicked.closest(".checkout-service").find(".options");  
  if($clicked.is(":checked")) {    
    $("input", $options).each(function() {
      $(this).removeAttr("disabled");
    });
    $("textarea", $options).each(function() {
      $(this).removeAttr("disabled");
    });      
    $("select", $options).each(function() {
      $(this).removeAttr("disabled");
    });        
    $options.slideDown(function() {
      update_cost();
    });
  }
  else {
    $("input", $options).each(function() {
      $(this).attr("disabled", "disabled");
    });
    $("textarea", $options).each(function() {
      $(this).attr("disabled", "disabled");
    });        
    $("select", $options).each(function() {
      $(this).attr("disabled", "disabled");
    });    
    $options.slideUp(function() {
      update_cost();
    });
  }
}