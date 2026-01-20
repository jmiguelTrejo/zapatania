
Liferay.on('allPortletsReady', function() {
    initPrincipalOwlCarousel();
    initSectionOwlCarousel();
});

function initPrincipalOwlCarousel() {
    if ($('.owl-principal-carrusel').length > 0) {
        $('.owl-principal-carrusel').owlCarousel({
            loop:true,
            margin:10,
            nav:true,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:2
                },
                1000:{
                    items:3
                }
            }
        })
    }
}

function initSectionOwlCarousel() {
    if ($('.owl-section-carrusel').length > 0) {
        $('.owl-section-carrusel').owlCarousel({
            loop:true,
            margin:10,
            nav:true,
            responsive:{
                0:{
                    items:1
                },
                600:{
                    items:2
                },
                1000:{
                    items:3
                }
            }
        })
    }
}
