<%@ include file="/init.jsp" %>

<c:choose>
    <c:when test="${empty blogs}">
        <div class="alert alert-warning" role="alert">
            No se encontraron blogs para el filtro seleccionado.
        </div>
    </c:when>
    <c:otherwise>
		<c:choose>
			<c:when test="${fn:length(blogs) == 1}">
			<script>
				// Redirige a la página de detalles del blog si solo hay uno
				<c:forEach var="blog" items="${blogs}">
					window.location.href = "/b/${blog.urlTitle}?redirect=/es/home";
				</c:forEach>
			</script>
			</c:when>
			<c:otherwise>

				<div class="container">
					<div class="row">
						<div class="col-12">
							<h1 class="text-center">
								${sectionTitle}
							</h1>
						</div>
					</div>
				</div>
				<div class="autor-card-container">
					<c:forEach var="blog" items="${blogs}">
						<div class="col-12 col-md-6 col-lg-4">
							<a href="/b/${blog.urlTitle}?redirect=/es/home">
								<div class="autor-card" >
									<div class="autor-card-content">
										<img src="${blog.urlImage}" alt="${blog.title}" class="autor-card-image">
										<h2 class="autor-card-title">${blog.title}</h2>
										<p class="autor-card-subtitle">${blog.subtitle}</p>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
				</div>
				
			</c:otherwise>
		</c:choose>
    </c:otherwise>
</c:choose>



