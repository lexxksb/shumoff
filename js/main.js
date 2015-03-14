$(document).ready(function(){

    $(".toBasket").colorbox({inline:true, href:"#inline_content", width:"40%", opacity: "0.5"});

    $(".colorboxClose").on("click", function(e){
        e.preventDefault();
        $.colorbox.close();
    })

    var _h = 0;
    $(".promoBlock2 .infoBlock").each(function(i,v){
        if($(v).innerHeight() > _h){
            _h = $(v).innerHeight();
        }
    });
    if(_h > 0) {
        $(".promoBlock2 .infoBlock").each(function (i, v) {
            $(v).height(_h);
        });
    }

    $('[data-toggle="tooltip"]').tooltip();

    $('.review .fullLink').on("click", function(e){
        e.preventDefault();
        var _this = $(this);
        _this.next(".full").show();
        _this.hide();
    });

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

});
