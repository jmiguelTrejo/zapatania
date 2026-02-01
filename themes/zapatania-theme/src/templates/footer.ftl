<#if show_footer>
    <footer id="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div class="col-12">
                        <h3>${footer_text}</h3>
                    </div>
                    <div class="col-12 mb-3">
                    </div>
                    <div class="col-12 mb-3">
                        <a href="${facebook_url}" target="_blank">
                            <i class="fa-brands fa-facebook-f"></i>
                        </a>
                        <a href="${x_url}" target="_blank">
                            <i class="fa-brands fa-x-twitter"></i>
                        </a>
                        <a href="${youtube_url}" target="_blank">
                            <i class="fa-brands fa-youtube"></i>
                        </a>
                    </div>
                    <div class="col-12">
                        @2025 Todos los derechos reservados
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="col-12">
                        <h3>Contacto</h3>
                    </div>
                    <div class="col-12 mb-3">
                        <p>
                            <i class="fa-solid fa-envelope"></i>
                            ${email}
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="col-12">
                        <h3>Suscribete</h3>
                    </div>
                    <div class="col-12 mb-3">
                        <form action="${subscribe_url}" method="post">
                            <input type="email" name="email" placeholder="Email" />
                            <button type="submit">Suscribirse</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="row mt-5" >
                <@liferay.user_personal_bar />
            </div>
        </div>
        <div class="w-100 greca-bkg">
        </div>

    </footer>
</#if>
