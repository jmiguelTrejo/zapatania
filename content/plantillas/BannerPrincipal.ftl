<div class="banner-principal">
    <#if (Fondo.getData())?? && Fondo.getData() != "">
        <img alt="${Fondo.getAttribute("alt")}" data-fileentryid="${Fondo.getAttribute("fileEntryId")}" src="${Fondo.getData()}" class="banner-principal__background"/>
    </#if>
    <div class="banner-principal__overlay"></div>
	<div class="banner-principal__content">
        <#if (Titulo.getData())?has_content>
            <h1 class="banner-principal__title"> ${Titulo.getData()} </h1>
        </#if>
        <#if (Subtitulo.getData())?has_content>
            <h1 class="banner-principal__description">${Subtitulo.getData()}</h1>
        </#if>
		<#if (boton.Link.getData())?has_content>
  			<#if (boton.Texto.getData())?has_content>
                <a href="${boton.Link.getData()}" class="banner-principal__button"> ${boton.Texto.getData()} </a>
            </#if>
        </#if>
	</div>
</div>

