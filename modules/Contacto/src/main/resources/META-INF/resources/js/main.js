Liferay.on('allPortletsReady', function() {
    initContactoForm();
});

function initContactoForm() {
    $('#contacto-form').on('submit', function(e) {
        e.preventDefault();
        console.log('submit');
        var form = $(this);
        var name = form.find('input[name="name"]').val();
        var email = form.find('input[name="email"]').val();
        var comentario = form.find('textarea[name="comentario"]').val();

        if (!name || !email || !comentario) {
            alert('Por favor, complete todos los campos');
            return;
        }

        $.ajax({
            url: '/o/c/mensajes/',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                name: name,
                email: email,
                comentario: comentario
            }),
            success: function(response) {
                console.log(response);
            },
            error: function(xhr, status, error) {
                console.log(xhr, status, error);
            }
        });
    });
}