
Liferay.on('allPortletsReady', function() {
    initPrincipalOwlCarousel();
    initSectionOwlCarousel();
    initSubscribeForm();
    checkAndAddTypeParameter();
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

function checkAndAddTypeParameter() {
    // Obtener la URL actual
    var currentUrl = window.location.href;
    
    // Verificar si la URL contiene "/buscar"
    if (currentUrl.indexOf('/buscar') !== -1) {
        // Crear un objeto URL para manejar los parámetros
        var url = new URL(currentUrl);
        var searchParams = url.searchParams;
        
        // Verificar si el parámetro "type" no existe
        if (!searchParams.has('type')) {
            // Agregar el parámetro "type" con el valor especificado
            searchParams.set('type', 'com.liferay.blogs.model.BlogsEntry');
            
            // Actualizar la URL con el nuevo parámetro
            var newUrl = url.toString();
            
            // Redirigir a la nueva URL (usando replace para no agregar entrada al historial)
            window.location.replace(newUrl);
        }
    }
}
