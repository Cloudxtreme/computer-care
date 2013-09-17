jQuery(function($){
  // form validation
  if($("#order-form").length > 0) {    
    $("#options a.next").attr("disabled", "disabled"); 

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
    first_name.add( Validate.Length, { minimum: 2, failureMessage: " " } );

    var last_name = new LiveValidation( "last-name", { validMessage: " ", wait: 500 } );
    last_name.add( Validate.Presence, { failureMessage: "*" } );
    last_name.add( Validate.Length, { minimum: 2, failureMessage: " " } );

    var email = new LiveValidation( "email", { validMessage: " ", wait: 500 } );
    email.add( Validate.Presence, { failureMessage: "*" } );
    email.add( Validate.Email, { failureMessage: " " } );

    var telephone = new LiveValidation( "telephone", { validMessage: " ", wait: 500 } );
    telephone.add( Validate.Presence, { failureMessage: "*" } );
    telephone.add( Validate.Numericality, { onlyInteger: true } );
    telephone.add( Validate.Length, { minimum: 11 } );

    var building = new LiveValidation( "building", { validMessage: " ", wait: 500 } );
    building.add( Validate.Presence, { failureMessage: "*" } );

    var street = new LiveValidation( "street", { validMessage: " ", wait: 500 } );
    street.add( Validate.Presence, { failureMessage: "*" } );
    street.add( Validate.Length, { minimum: 2 } );

    var town = new LiveValidation( "town", { validMessage: " ", wait: 500 } );
    town.add( Validate.Presence, { failureMessage: "*" } );
    town.add( Validate.Length, { minimum: 2 } );

    $("#postcode").blur(function() {
      var newPostCode = checkPostCode($(this).val());
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

    $("#user a.next").attr("disabled", "disabled");

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
    if(!checkPostCode($("#postcode").val())) {
      areAllValid = false;
    }

    if(areAllValid) {
      $("#user a.next").removeAttr("disabled");
    } else {
      $("#user a.next").attr("disabled", "disabled"); 
    }
  }

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

  $(".checkout-service input[type='checkbox']").each(function() {
    $(this).attr("checked", false);
  });

  $(".service").click(function() {
    var $clicked = $(this);
    var $container = $clicked.closest(".checkout-service");    

    $container.toggleClass("selected");

    if($(".service:checked[data-can-checkout='false']").length > 0) {
      // make payment form disabled
      $("#payment input[type='text']").attr("disabled", "disabled").hide();
      //show message
      $(".alert").show();
    }
    else {
      // enable payment form 
      $("#payment input[type='text']").removeAttr("disabled").show();
      // hide message
      $(".alert").hide();   
    }

    update_cost();
  });

  $(".options select").change(function() {
    update_cost();
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
  var total = 0;
  $("input[type='checkbox']:checked").each(function() {      
    total = total + parseInt($(this).data("base"));
  });
  $(".selected :selected", "#options").each(function() {
    total = total + parseInt($(this).data("additional"));
  });

  $("#total-cost").html(total);
}