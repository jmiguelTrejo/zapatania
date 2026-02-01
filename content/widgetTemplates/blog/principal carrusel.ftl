<#assign dlAppService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLAppService") />

<div class="owl-carousel owl-theme owl-principal-carrusel">
    <#if entries?has_content>
        <#list entries as curEntry>
            <div class="item">
                <#assign assetRenderer = curEntry.getAssetRenderer() />
                <#assign customObj = assetRenderer.getAssetObject(curEntry.classPK) />
                <#assign fileEntry = "" />
                <#if customObj.coverImageFileEntryId?has_content && customObj.coverImageFileEntryId gt 0>
                    <#assign fileEntry = dlAppService.getFileEntry(customObj.coverImageFileEntryId?number) />
                </#if>

                <#if fileEntry?has_content>
                    <#assign url = "/documents/${fileEntry.groupId}/${fileEntry.folderId}/${fileEntry.fileName}/${fileEntry.uuid}" />
                    <img src="${url}" alt="${curEntry.getTitle(locale)?html}" class="principal-carrusel-image"/>
                </#if>
            </div>
        </#list>
    </#if>
</div>