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

});
