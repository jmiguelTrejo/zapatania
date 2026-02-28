<#assign dlAppService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLAppService") />

<div class="section-container">
    <#if entries?has_content>
        <#list entries as curEntry>
            <#assign assetRenderer = curEntry.getAssetRenderer() />
            <#assign customObj = assetRenderer.getAssetObject(curEntry.classPK) />
            <#assign blogUrl = assetRenderer.getUrlTitle() />
            <#assign url = "" />
					
            <#assign fileEntry = "" />
            <#if customObj.coverImageFileEntryId?has_content && customObj.coverImageFileEntryId gt 0>
                <#assign fileEntry = dlAppService.getFileEntry(customObj.coverImageFileEntryId?number) />
            </#if>
            <#if fileEntry?has_content>
                <#assign url = "/documents/${fileEntry.groupId}/${fileEntry.folderId}/${fileEntry.fileName}/${fileEntry.uuid}" />
            </#if>
            
							
            <div class="col-12 col-md-6 col-lg-4 purple-bkg">
                <a href="/b/${blogUrl}?redirect=/es/home">
                    <div class="autor-card" >
                        <div class="autor-card-content">
                            <img src="${url}" alt="${curEntry.title}" class="autor-card-image">
                            <h2 class="autor-card-title">${curEntry.title}</h2>
                            <p class="autor-card-subtitle">
                                ${curEntry.summary?replace('<[^>]+>', '', 'r')}
                            </p>
                        </div>
                    </div>
                </a>
            </div>
							
        </#list>
    </#if>
</div>