$(document).ready(function(){

    if(window.kitOptions !== undefined){

        var priceObject     = $("#price");
        var price           = priceObject.data("price") || 0;
        var ezOptionValue   = 0;

        change();

        $('input[name="first"], input[name="second"]').on('click', function(){
            change();
        });

        function change(){
            var first   = $('input[name="first"]:checked').val();
            var second  = $('input[name="second"]:checked').val();
            ezOptionValue = kitOptions[first][second][0];
            priceObject.html( accounting.formatMoney(price + kitOptions[first][second][1], "", 0, " ", "") );
        }
    }

    $(".toBasket").on('click', function(e){
        e.preventDefault();

        var cb = $("#basketText").data("count"),
            toPost = new Object();

        toPost.ContentNodeID = priceObject.data("nodeid");
        toPost.ContentObjectID = priceObject.data("objectid");
        toPost.ViewMode = "full";
        toPost.ActionAddToBasket = "";

        if(window.kitOptions !== undefined) {
            var opt = new Object();
            opt[priceObject.data("optionid")] = ezOptionValue;
            toPost.eZOption = opt;
        }

        $.post( "/store/action", toPost, function() {
        })
        .done(function(result) {
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
                        zoom: 15
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

        $(".remove").on('click', function(e) {
            $(this).next().removeAttr("disabled");
        });
    }

});

function setcookie(name, value, expires, path, domain, secure) {	// Send a cookie
    expires instanceof Date ? expires = expires.toGMTString() : typeof(expires) == 'number' && (expires = (new Date(+(new Date) + expires * 1e3)).toGMTString());
    var r = [name + "=" + escape(value)], s, i;
    for(i in s = {expires: expires, path: path, domain: domain}){
        s[i] && r.push(i + "=" + s[i]);
    }
    return secure && r.push("secure"), document.cookie = r.join(";"), true;
}