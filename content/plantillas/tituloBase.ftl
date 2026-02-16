<#assign title = ((Fieldset97846499.Titulo.getData())??)?then( Fieldset97846499.Titulo.getData() , "")>
<#assign subtitle = ((Fieldset72027713.SubTitulo.getData())??)?then( Fieldset72027713.SubTitulo.getData() , "")>
<#assign titlealign = ((Fieldset97846499.titleAlign.getData())??)?then( Fieldset97846499.titleAlign.getData() , "")>
<#assign subtitlealign = ((Fieldset72027713.AlignSubTitle.getData())??)?then( Fieldset72027713.AlignSubTitle.getData() , "")>
<#assign width = ((width.getData())??)?then( width.getData() , "100")>

<div class="d-flex w-100 flex-wrap">
    <#if title?has_content>
        <div class="d-flex w-100 justify-content-${titlealign}">
            <div class="w-${width}">
                <h1 class="text-title text-${titlealign}">${title}</h1>
            </div>
        </div>
    </#if>
    <#if subtitle?has_content>
        <div class="d-flex w-100 justify-content-${subtitlealign}">
            <div class="w-${width}">
                <h5 class="text-subtitle text-${subtitlealign}">${subtitle}</h5>
            </div>
        </div>
    </#if>
		

</div>

