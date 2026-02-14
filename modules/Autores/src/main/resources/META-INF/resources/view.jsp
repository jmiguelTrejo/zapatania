<%@ include file="/init.jsp" %>

<div class="autores-container">
    <h1 class="text-center mb-4 title">Autores</h1>
    <ul class="nav nav-pills mb-3" id="autorTab" role="tablist">
        <li class="nav-item" role="presentation">
            <a class="nav-link active" id="nombre-tab" data-toggle="pill" href="#nombre" role="tab"
                aria-controls="nombre" aria-selected="true">
                Nombre
            </a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link" id="nacionalidad-tab" data-toggle="pill" href="#nacionalidad" role="tab"
                aria-controls="nacionalidad" aria-selected="false">
                Nacionalidad
            </a>
        </li>
    </ul>
    <div class="tab-content" id="autorTabContent">
        <div class="tab-pane fade show active" id="nombre" role="tabpanel" aria-labelledby="nombre-tab">
            <c:if test="${not empty autores}">
                <ul>
                    <c:forEach var="autor" items="${autores}">
                        <li>${autor}</li>
                    </c:forEach>
                </ul>
            </c:if>
        </div>
        <div class="tab-pane fade" id="nacionalidad" role="tabpanel" aria-labelledby="nacionalidad-tab">
            <!-- Contenido de Nacionalidad -->
        </div>
    </div>

</div>



