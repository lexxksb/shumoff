$(document).ready(function(){

    if(window.kitOptions !== undefined){

        var priceObject     = $("#price");
        var priceObjectParent = $("#price").parent();
        var price           = priceObject.data("price") || 0;
        var ezOptionValue   = 0;
        var basketButton    = $(".toBasket");

        change();

        $('input[name="first"], input[name="second"]').on('click', function(){
            change();
        });

        function change(){
            var first   = $('input[name="first"]:checked').val();
            var second  = $('input[name="second"]:checked').val();
            if(first !== undefined && second !== undefined) {
                ezOptionValue = kitOptions[first][second][0];
                var summPrice = price + kitOptions[first][second][1];
                if (summPrice > 0) {
                    priceObjectParent.show();
                    basketButton.removeAttr("disabled");
                    priceObject.html(accounting.formatMoney(price + kitOptions[first][second][1], "", 0, " ", ""));
                } else {
                    priceObjectParent.hide();
                    basketButton.attr("disabled", "disabled");
                }
            }
        }
    }

    $(".toBasket").on('click', function(e){
        e.preventDefault();

        var toPost = new Object(),
            button = $(this);

        toPost.ContentNodeID = button.data("nodeid");
        toPost.ContentObjectID = button.data("objectid");
        toPost.ViewMode = "full";
        toPost.ActionAddToBasket = "";

        var quantity = $("#count"+button.data("nodeid"));
        if(quantity.length){
            toPost.Quantity = quantity.val();
        }

        if(window.kitOptions !== undefined && ezOptionValue !== undefined && button.data("optionid")) {
            var opt = new Object();
            opt[button.data("optionid")] = ezOptionValue;
            toPost.eZOption = opt;
        }

        $.post( "/store/action", toPost, function() {

        }).done(function(result) {
            $("#basketText").text(result.count);
            $.colorbox({inline:true, href:"#inline_content", width:"40%", opacity: "0.5"});
        });

    });

    $(".colorboxClose").on("click", function(e){
        e.preventDefault();
        $.colorbox.close();
    })

    var infoBlock = $(".promoBlock2 .infoBlock");
    if(infoBlock.length) {
        var _h = 0;
        infoBlock.each(function (i, v) {
            if ($(v).innerHeight() > _h) {
                _h = $(v).innerHeight();
            }
        });
        if (_h > 0) {
            infoBlock.each(function (i, v) {
                $(v).height(_h);
            });
        }
    }

    $('[data-toggle="tooltip"]').tooltip();

    $('.review .fullLink').on("click", function(e){
        e.preventDefault();
        var _this = $(this);
        _this.next(".full").show();
        _this.hide();
    });

    /*Контакты*/
    var address = $("#map");
    if(address.length) {
        ymaps.ready(function () {
            var myGeocoder = ymaps.geocode(address.data("address"));
            myGeocoder.then(
                function (res) {
                    var coords = res.geoObjects.get(0).geometry.getCoordinates();
                    var map = new ymaps.Map("map", {
                        center: coords,
                        zoom: address.data("zoom") || 15
                    });
                    var office = new ymaps.GeoObject({
                        geometry: {
                            type: "Point",
                            coordinates: coords
                        }
                    });
                    map.geoObjects.add(office);
                },
                function (err) {}
            );
        });
    }

    /*Корзина*/
    var basket = $("#basket");
    if(basket.length){
        $("#delivery input").on('click', function() {
            setcookie("shipping", $(this).val(), null, "/");
            $("#shipPaymentForm").submit();
        });
        $("#pay input").on('click', function() {
            $("[name='payment']").val($(this).val());
        });
        $(".remove").on('click', function(e) {
            $(this).next().removeAttr("disabled");
        });
    }

    /* Inc|Dec в поле количества */
    $(".input-group-addon").on('click', function() {
        var elem = $(this),
            input = $("#count" + elem.data("id"));
        if(elem.data("type") == "inc"){
            input.val(function(i, oldval) {
                return ++oldval;
            });
        }else{
            input.val(function(i, oldval) {
                return oldval>0 ? --oldval : 0;
            });
        }
    });

});

function setcookie(name, value, expires, path, domain, secure) {	// Send a cookie
    expires instanceof Date ? expires = expires.toGMTString() : typeof(expires) == 'number' && (expires = (new Date(+(new Date) + expires * 1e3)).toGMTString());
    var r = [name + "=" + escape(value)], s, i;
    for(i in s = {expires: expires, path: path, domain: domain}){
        s[i] && r.push(i + "=" + s[i]);
    }
    return secure && r.push("secure"), document.cookie = r.join(";"), true;
}