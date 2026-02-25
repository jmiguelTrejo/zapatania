
Liferay.on('allPortletsReady', function() {
    initPrincipalOwlCarousel();
    initSectionOwlCarousel();
    initSubscribeForm();
});

function initPrincipalOwlCarousel() {
    if ($('.owl-principal-carrusel').length > 0) {
        console.log('initPrincipalOwlCarousel');
        $('.owl-principal-carrusel').owlCarousel({
            loop:true,
            margin:10,
            nav:true,
            navText: ['<span class="owl-principal-left"> </span>', '<span class="owl-principal-right"> </span>' ],
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
    if ($('.owl-related-carrusel').length > 0) {
        $('.owl-related-carrusel').owlCarousel({
            loop:true,
            margin:10,
            nav:true,
            navText: ['<span class="owl-principal-left"> </span>', '<span class="owl-principal-right"> </span>' ],
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

function initSubscribeForm() {
    console.log('initSubscribeForm');
    $('#subscribe-form').on('submit', function(e) {
        e.preventDefault();
        
        var email = $(this).find('input[name="email"]').val();
        var form = $(this);
        var submitButton = form.find('button[type="submit"]');
        
        // Validar que el email no esté vacío
        if (!email || email.trim() === '') {
            alert('Por favor, ingresa un email válido');
            return;
        }
        
        // Deshabilitar el botón mientras se procesa la petición
        submitButton.prop('disabled', true).text('Enviando...');
        
        // Realizar petición POST
        $.ajax({
            url: '/o/c/suscripcions/',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                email: email
            }),
            success: function(response) {
                // Mostrar mensaje de éxito
                alert('¡Suscripción exitosa! Gracias por suscribirte.');
                // Limpiar el formulario
                form[0].reset();
                submitButton.prop('disabled', false).text('Enviar');
            },
            error: function(xhr, status, error) {
                // Mostrar mensaje de error
                alert('Error al procesar la suscripción. Por favor, intenta nuevamente.');
                submitButton.prop('disabled', false).text('Enviar');
            }
        });
    });
    return false;
}
