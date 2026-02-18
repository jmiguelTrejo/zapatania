<#assign dlAppService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLAppService") />

<#assign counter = 0 />

<div class="selection-container">
    <div class="selection-row">
    <#if entries?has_content>
        <#list entries as curEntry>
            <#assign assetRenderer = curEntry.getAssetRenderer() />
            <#assign customObj = assetRenderer.getAssetObject(curEntry.classPK) />
            <#assign blogUrl = assetRenderer.getUrlTitle() />
            <#assign fileEntry = "" />
            <#assign url = "" />
            <#if customObj.coverImageFileEntryId?has_content && customObj.coverImageFileEntryId gt 0>
                <#assign fileEntry = dlAppService.getFileEntry(customObj.coverImageFileEntryId?number) />
            </#if>
            <#if fileEntry?has_content>
                <#assign url = "/documents/${fileEntry.groupId}/${fileEntry.folderId}/${fileEntry.fileName}/${fileEntry.uuid}" />
            </#if>

            <#if counter % 3 == 0 && counter != 0>
                </div>
                <div class="selection-row">
            </#if>

            <#if url?has_content>
                <div class="selection-item" onclick="window.location.href='/b/${blogUrl}?redirect=/es/home'">
                    <img src="${url}" alt="${curEntry.getTitle(locale)?html}" class="selection-image"/>
                </div>
                <#assign counter = counter + 1 />
            </#if>
            
        </#list>
    </#if>
    </div>
</div>