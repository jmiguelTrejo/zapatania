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
				<div class="blogs-list">
					<c:forEach var="blog" items="${blogs}">
						<a href="/b/${blog.urlTitle}?redirect=/es/home">
							<div class="blog-entry mb-4">
								<img src="${blog.urlImage}" alt="${blog.title}" class="blog-image">
								<h2>${blog.title}</h2>
								<p>${blog.subtitle}</p>
							</div>
						</a>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>
    </c:otherwise>
</c:choose>



