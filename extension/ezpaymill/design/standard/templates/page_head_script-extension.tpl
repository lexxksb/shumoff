<script type="text/javascript">
var PAYMILL_PUBLIC_KEY = '{cond( ezini('PaymillSettings','IsTestOrLive','ezpaymill.ini')|eq('TEST'), ezini( 'PaymillSettings', 'PAYMILL_PUBLIC_TEST_KEY','ezpaymill.ini' ), ezini( 'PaymillSettings', 'PAYMILL_PUBLIC_LIVE_KEY','ezpaymill.ini' ) )}';
</script>

<script type="text/javascript" src="https://bridge.paymill.de/"></script>
  
    <script type="text/javascript">
{literal}
        $(document).ready(function () {

            function PaymillResponseHandler(error, result) {

                if (error) {

                    // Zeigt den Fehler überhalb des Formulars an
                    $(".payment-errors").text(error.apierror);


                } else {
                    $(".payment-errors").text("");

                    var form = $("#payment-form");
                    // Token
                    var token = result.token;

                    // Token in das Formular einfügen damit es an den Server übergeben wird
                    form.append("<input type='hidden' name='paymillToken' value='" + token + "'/>");

                    form.get(0).submit();
                }

                $(".submit-button").removeAttr("disabled");
            }

            $("#payment-form").submit(function (event) {

                // Absenden Button deaktivieren um weitere Klicks zu vermeiden
                $('.submit-button').attr("disabled", "disabled");

                if (false == paymill.validateCardNumber($('.card-number').val())) {
                    $(".payment-errors").text("Ungueltige Kartennummer");
                    $(".submit-button").removeAttr("disabled");
                    return false;
                }

                if (false == paymill.validateExpiry($('.card-expiry-month').val(), $('.card-expiry-year').val())) {
                    $(".payment-errors").text("Ungueltiges Gueltigkeitsdatum");
                    $(".submit-button").removeAttr("disabled");
                    return false;
                }

                paymill.createToken({
                    number:$('.card-number').val(),
                    exp_month:$('.card-expiry-month').val(),
                    exp_year:$('.card-expiry-year').val(),
                    cvc:$('.card-cvc').val(),
                    cardholdername:$('.card-holdername').val(),
                    amount_int: $('.card-amount-int').val(),    // required, integer, z.B. "15" für 0,15 Euro 
                    currency: $('.card-currency').val()    // required, ISO 4217 z.B. "EUR" od. "GBP"                    

                }, PaymillResponseHandler);

                return false;
            });



        });
{/literal}
</script>
