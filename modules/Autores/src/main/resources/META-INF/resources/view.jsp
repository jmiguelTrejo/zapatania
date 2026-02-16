<%@ include file="/init.jsp" %>

<div class="autores-container">
    <div class="row">
        <div class="col-1">
        </div>
        <div class="col-11">
            <h1 class="mb-4 title">Autores</h1>
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
                    <c:set var="letter" value="" scope="page" />
                    <c:if test="${not empty autores}">
                        <ul>
                            <c:forEach var="autor" items="${autores}">
                                <c:if test="${empty letter or letter ne autor.substring(0,1)}">
                                    <c:set var="letter" value="${autor.substring(0,1)}" scope="page" />
                                    <li class="letter">${letter}</li>
                                </c:if>
                                <li class="autor">${autor}</li>
                            </c:forEach>
                        </ul>
                    </c:if>
                </div>
                <div class="tab-pane fade" id="nacionalidad" role="tabpanel" aria-labelledby="nacionalidad-tab">
                    <!-- Contenido de Nacionalidad -->
                </div>
            </div>
        </div>
    </div>

</div>



