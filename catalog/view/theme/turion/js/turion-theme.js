
var initQVP = function(argument) {
        $('.product-thumb').each(function(i,val){
        var _href = $(this).find('a').attr('href');
        var prod_id = _href.match(/product_id=[0-9]+/g);
        prod_id = prod_id[0].match(/[0-9]+/);
        $(this).find('.caption').append('<span class="fa-stack fa-lg quick-view-btn" data-product-id="'+prod_id[0]+'">\
            <i class="fa fa-circle fa-stack-2x"></i>\
            <i class="fa fa-search fa-stack-1x"></i>\
          </span>');

        });
        
    };
$(document).ready(function () {
    // owl-carousel
    var owl = $('.owl-carousel');
    $('.owl-carousel').owlCarousel({
        loop:true,
        autoPlay: 5000,
        stopOnHover: true,
        navigation: true,
        pagination: false,
        singleItem: true,
        navigationText: ["<i class='icon fa fa-angle-right'></i>","<i class='icon fa fa-angle-left'></i>"],
        items:5
    })
    owl.on('mousewheel', '.owl-stage', function (e) {
        if (e.deltaY>0) {
            owl.trigger('next.owl');
        } else {
            owl.trigger('prev.owl');
        }
        e.preventDefault();
    });    
    // init

    initQVP();
    $('.owl-prev i').attr('class','fa fa-angle-left fa-x1');
    // $('.owl-prev i').attr('class','fa fa-angle-left fa-x5');
    $('.owl-next i').attr('class','fa fa-angle-right fa-x1');
	$("#search input.form-control").attr('class','form-control input-md');
	$("#search button.btn").attr('class','form-control btn-md');
	$(".col-sm-4 div.pull-left").attr('class','');

    //  category hover
    
	$("#column-left ul > li ").mouseenter(function(e){

        if(!$('.sub-menu').hasClass('subActive')){
            
            $(this).find('.sub-menu').fadeIn();
            $(this).find('i.fa-angle-double-right').css({'position':'relative','left':'10px'});
            $('.sub-menu').addClass('subActive');
        
        }
    });
    $("#column-left ul > li").mouseleave(function(e){

		$(this).find('.sub-menu').fadeOut();
        $(this).find('i.fa-angle-double-right').css({'position':'relative','left':'0'});
        $('.sub-menu').removeClass('subActive');
    });
    // filter 

   $(document).on('click','.list-group span .fa-plus-square',function(){

        $(this).parents('.list-group').find('div.list-group-item').slideDown(200);
        $(this).parent('.list-group-item').css('background-color','#fff');

        var arrow = $(this).parent('.list-group-item').find('.fa-angle-right');
        $(arrow).removeClass('fa-angle-right');
        $(arrow).addClass('fa-angle-down');

        $(this).removeClass('fa-plus-square');
        $(this).addClass('fa-minus-square');
    
    });

    $(document).on('click','.list-group span .fa-minus-square',function(){

        $(this).parents('.list-group').find('div.list-group-item').slideUp(200);
        $(this).parent('.list-group-item').css('background-color','#F4F4F4');
        var arrow = $(this).parent('.list-group-item').find('.fa-angle-down');
        $(arrow).removeClass('fa-angle-down');
        $(arrow).addClass('fa-angle-right');

        $(this).removeClass('fa-minus-square');
        $(this).addClass('fa-plus-square');
    
    });

    // Quick View Product 

    $(document).on('mouseenter','.product-thumb',function(e){
        e.preventDefault();
        $(this).find('.quick-view-btn').css({'opacity':'1','top':'40%'});
        $(this).find('.price').animate({
            top: '40%',
            opacity: 0,
            complete: $(this).find('.button-group').addClass('active'),
        });
    });
    $(document).on('mouseleave','.product-thumb',function(e){
        e.preventDefault();
        $(this).find('.quick-view-btn').css({'opacity':'0','top':'0'});
        $(this).find('.price').animate({
            top: '0',
            opacity: 1,
            complete: $(this).find('.button-group').removeClass('active'),
        });
    });

    $(document).on('click','.quick-view-btn',function () {
        var offsetTop = $(window).scrollTop();
        var btn_group = $(this).parents('.product-thumb ').find('.button-group').clone();
        btn_group = btn_group[0].outerHTML;
        var prod_id = $(this).attr('data-product-id');
        $.ajax({
            url: 'index.php?route=product/product&type=true&product_id='+prod_id,
            type: 'get',
            dataType: 'json',
            beforeSend: function() {
                $('body').append('<img class="preloader" height="120" width="120" src="catalog/view/theme/turion/image/preloader.png">');
            },
            success: function(json) {
                $('.preloader').remove();
                $('#QVP').css('top',offsetTop+$(window).innerHeight()/2);
                $('#QVP').fadeIn();
                $('.bg_body').fadeIn();
                var findAttr = '';
                var container_li_img = '';
                var container_li_atributes = '';
                $.map(json.images,function(value,index) {
                    container_li_img += '<li><img class="thumb-img" src="'+value.popup+'"</li>';
                });
                $.map(json.attribute_groups,function (value,index) {
                    container_li_atributes += '<li><strong>'+value.name+'</strong> : '+findAttributs(value.attribute)+'</li>'
                });
                
                var innerQV = '<div class="container-fluid ">\
                                <div class="row">\
                                    <div class="col-md-6 col-lg-6 img-column">\
                                        <div class="thumbnail main"> <img src="'+json.popup+'"</div>\
                                        <ul >'+container_li_img+'</ul>\
                                    </div>\
                                </div>\
                                <div class="col-md-6 col-lg-6 descript_column">\
                                        <h2>'+json.heading_title+'</h2>\
                                         <span>'+json.price+'</span>\
                                        <ul>'+container_li_atributes+'</ul>\
                                        <p>\
                                          <button class="btn " type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">\
                                            Описание <i class="fa fa-caret-down"></i>\
                                          </button>\
                                        </p>\
                                        <div class="collapse" id="collapseExample">\
                                          <div class="card card-body">\
                                            '+json.description+'\
                                          </div>\
                                        </div>\
                                        '+btn_group+'\
                                    </div>\
                            </div>';

                $('#QVP').append(innerQV);
                

                $('.thumb-img').click(function(){
                    var currentThumb = $('.img-column .main > img').attr('src');
                    var clicedImg = $(this).attr('src');
                    $('.img-column').find('.main > img').attr('src',clicedImg);
                     $(this).attr('src',currentThumb);
                     currentThumb = 0;
                     clicedImg =0;
                });
                            
            },
            error: function (xhr, ajaxOptions, thrownError) {
                $('.preloader').remove();
            }
        });
    });
    $('.CloseQVP,.bg_body').click(function () {
       $('#QVP').fadeOut(function (argument) {
           $('#QVP .container-fluid').remove();
       });
        $('.bg_body').fadeOut();
             
    });

    
});
function findAttributs(arg) {
    var attrText = '';
    for(var i = 0 ;i<arg.length;i++){
        attrText += arg[i].name + arg[i].text;
    }
    return attrText;
}