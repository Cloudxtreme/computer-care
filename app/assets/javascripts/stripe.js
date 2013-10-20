$(function() {
  $("form.payment").submit(function() {
    $("#summary-next").attr("disabled", true);

    Stripe.card.createToken({
      number: $('#card_number').val(),
      cvc: $('#card_code').val(),
      exp_month: $('#card_month').val(),
      exp_year: $('#card_year').val()
    }, function(status, response) {
      if(status == 200) {
        $("#stripe-token").val(response.id);
        $("form.payment")[0].submit();
      }
      else {
        $("#stripe-error").text(response.error.message).show();
        $("#summary-next").attr("disabled", false);
      }
    });

    return false;
  });

});