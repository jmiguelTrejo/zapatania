<#assign 
    title = (Fieldset97846499.Titulo.getData())?? ? Fieldset97846499.Titulo.getData() : ""
    subtitle = (Fieldset72027713.SubTitulo.getData())?? ? Fieldset72027713.SubTitulo.getData() : ""
    titlealign = (Fieldset97846499.titleAlign.getData())?? ? Fieldset97846499.titleAlign.getData() : ""
    subtitlealign = (Fieldset72027713.AlignSubTitle.getData())?? ? Fieldset72027713.AlignSubTitle.getData() : ""
    width = (width.getData())?? ? width.getData() : "100"
>

<div class="d-flex w-${width}">
    <#if title?has_content>
        <div class="d-flex flex-column justify-content-${titlealign}">
            <h2 class="text-title">${title}</h2>
        </div>
    </#if>
    <#if subtitle?has_content>
        <div class="d-flex flex-column justify-content-${titlealign}">
            <h3 class="text-subtitle">${subtitle}</h3>
        </div>
    </#if>
</div>

