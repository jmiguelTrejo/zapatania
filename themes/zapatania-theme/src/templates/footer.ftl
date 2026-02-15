<#include init />

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
                    <div class="col-12 mb-3 d-flex">
                        <a class="circle-icon" href="${facebook_url}" target="_blank">
                            <i class="fa-brands fa-facebook-f"></i>
                        </a>
                        <a class="circle-icon dark"href="${x_url}" target="_blank">
                            <i class="fa-brands fa-x-twitter"></i>
                        </a>
                        <a class="square-icon" href="${youtube_url}" target="_blank">
                            <i class="fa-brands fa-youtube"></i>
                        </a>
                    </div>
                    <div class="col-12 mt-4">
                        @2026 Todos los derechos reservados
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="col-12">
                        <h3>Contacto</h3>
                    </div>
                    <div class="col-12 mb-3">
                        <p class="mt-5">
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
                        <form id="subscribe-form" method="post">
                            <input id="subscribe-form-email" type="email" name="email" placeholder="Email" />
                            <button class="btn mt-3" type="submit"> Enviar </button>
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
