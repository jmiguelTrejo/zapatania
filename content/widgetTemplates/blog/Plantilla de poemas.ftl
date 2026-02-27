<#assign dlAppService = serviceLocator.findService("com.liferay.document.library.kernel.service.DLAppService") />
<#assign blogsLocalService = serviceLocator.findService("com.liferay.blogs.service.BlogsEntryLocalService") />

<div class="autor-card-container">

<#if entries?has_content>
	<#list entries as entry>
		<#if entry?has_content>
            <#assign blog = blogsLocalService.getBlogsEntry( entry.getClassPK() ) />
            <#assign fileEntry = dlAppService.getFileEntry( blog.coverImageFileEntryId ) />
            <#assign url = "" />
            <#assign blogUrl = blog.urlTitle />
            <#if fileEntry?has_content>
                <#assign url = "/documents/${fileEntry.groupId}/${fileEntry.folderId}/${fileEntry.fileName}/${fileEntry.uuid}" />
            </#if>
            <div class="col-12 col-md-6 col-lg-4">
                <a href="/b/${blog.urlTitle}?redirect=/es/home">
                    <div class="autor-card" >
                        <div class="autor-card-content">
                            <img src="${url}" alt="${blog.title}" class="autor-card-image">
                            <h2 class="autor-card-title">${blog.title}</h2>
                            <p class="autor-card-subtitle">
                                ${blog.content?replace('<[^>]+>', '', 'r')}
                            </p>
                        </div>
                    </div>
                </a>
            </div>
        </#if>
    </#list>
</#if>
</div>