<%@ include file="/init.jsp" %>

<div class="contacto-container">
    <div class="row">
        <div class="col-12">
            <h1>Contactanos</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 white-box">
            <div class="white-box-content">
                <div class="purple-box">
                    <img src="./images/mail.png" alt="Email">
                </div>
                <div class="form-container">
                    <form id="contacto-form" >
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="name">Nombre</label>
                                    <input type="text" name="name" id="name" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="name">Correo electrónico</label>
                                    <input type="email" name="email" id="email" class="form-control" required>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="comentario">Comentario</label>
                                    <textarea class="form-control" id="comentario" name="comentario" rows="4" placeholder="Escriba su comentario" required></textarea>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
