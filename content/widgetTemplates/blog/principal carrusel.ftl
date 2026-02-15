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
                    <#else>
                        <img src="/documents/d/guest/chris_muschard-ink-5067880_1280"  alt="imagen generica blog" class="principal-carrusel-image" />
                </#if>
                <h4 class=" pl-4 mt-3">
                    ${curEntry.title}
                </h4>
                <p class="pl-4  mt-3">
                    <#if curEntry.description?has_content>
                        ${curEntry.description}
                    <#else>
                        ${curEntry.summary?replace('<[^>]+>', '', 'r')}
                    </#if>
                </p>
							
            </div>
        </#list>
    </#if>
</div>