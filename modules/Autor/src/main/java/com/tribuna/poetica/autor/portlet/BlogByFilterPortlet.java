package com.tribuna.poetica.autor.portlet;

import com.liferay.blogs.model.BlogsEntry;
import com.liferay.blogs.service.BlogsEntryLocalService;
import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.document.library.kernel.service.DLFileEntryLocalService;
import com.liferay.expando.kernel.model.ExpandoColumn;
import com.liferay.expando.kernel.model.ExpandoTable;
import com.liferay.expando.kernel.model.ExpandoValue;
import com.liferay.expando.kernel.service.ExpandoColumnLocalService;
import com.liferay.expando.kernel.service.ExpandoTableLocalService;
import com.liferay.expando.kernel.service.ExpandoValueLocalService;
import com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil;
import com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.tribuna.poetica.autor.constants.BlogByFilterPortletKeys;

import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;

import javax.portlet.Portlet;
import javax.servlet.http.HttpServletRequest;

import com.tribuna.poetica.autor.dto.BlogInfo;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import java.util.ArrayList;
import java.util.List;

@Component(
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=BlogByFilter",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + BlogByFilterPortletKeys.BLOGBYFILTER,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user",
		"com.liferay.portlet.private-request-attributes=false",
		"com.liferay.portlet.render-url-parameter-allowed=true"
	},
	service = Portlet.class
)
public class BlogByFilterPortlet extends MVCPortlet {

	private static final Log log = LogFactoryUtil.getLog(BlogByFilterPortlet.class);

    @Override
    public void doView(javax.portlet.RenderRequest renderRequest, javax.portlet.RenderResponse renderResponse)
            throws java.io.IOException, javax.portlet.PortletException {


		HttpServletRequest httpServletRequest = PortalUtil.getHttpServletRequest(renderRequest);
		HttpServletRequest originalServletRequest = PortalUtil.getOriginalServletRequest(httpServletRequest);
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);

		String autor = ParamUtil.getString(originalServletRequest, "autor");
		String nacionalidad = ParamUtil.getString(originalServletRequest, "nacionalidad");
		long companyId = PortalUtil.getCompanyId(renderRequest);

		List<BlogsEntry> result;
		List<BlogInfo> biList = new ArrayList<>();
		log.info("Autor: " + autor);
		log.info("Nacionalidad: " + nacionalidad);

		if( !autor.isEmpty() ){
			result = getBlogsByFilter( companyId, "autor", autor );
		}else{
			result = getBlogsByFilter( companyId, "nacionalidad", nacionalidad );
		}

		if( !result.isEmpty() ){
			log.info("convierto");
			biList = convertBlogToView( result, themeDisplay );
			log.info("biList" + biList);
		}

		renderRequest.setAttribute("blogs", biList);
        super.doView(renderRequest, renderResponse);

    }

	private List<BlogsEntry> getBlogsByFilter(long companyId, String type, String filter) {
		List<BlogsEntry> blogsEntries = new ArrayList<>();
		
		if (type == null || type.trim().isEmpty() || filter == null || filter.trim().isEmpty()) {
			log.warn("Type or filter is null or empty");
			return blogsEntries;
		}
		
		try {
			// Obtener la ExpandoTable para BlogsEntry
			ExpandoTable expandoTable = expandoTableLocalService.getDefaultTable(
					companyId, BlogsEntry.class.getName());
			
			if (expandoTable == null) {
				log.warn("ExpandoTable not found for BlogsEntry");
				return blogsEntries;
			}
			
			// Obtener la ExpandoColumn usando el parámetro type
			ExpandoColumn expandoColumn = expandoColumnLocalService.getColumn(
				expandoTable.getTableId(), type);
			
			if (expandoColumn == null) {
				log.warn("ExpandoColumn not found: " + type);
				return blogsEntries;
			}
			
			// Buscar todos los ExpandoValues para esta columna
			List<ExpandoValue> allExpandoValues = expandoValueLocalService.dynamicQuery(
				DynamicQueryFactoryUtil
					.forClass(ExpandoValue.class, this.getClass().getClassLoader())
					.add(RestrictionsFactoryUtil.eq("columnId", expandoColumn.getColumnId()))
			);
			
			// Filtrar por el valor específico y obtener los BlogsEntry asociados
			String filterValue = filter.trim();
			for (ExpandoValue expandoValue : allExpandoValues) {
				String value = expandoValue.getString();
				if (value != null && value.trim().equalsIgnoreCase(filterValue)) {
					long entryId = expandoValue.getClassPK();
					try {
						BlogsEntry blogsEntry = blogsEntryLocalService.getBlogsEntry(entryId);
						if (blogsEntry != null) {
							blogsEntries.add(blogsEntry);
						}
					} catch (PortalException e) {
						log.warn("BlogsEntry not found for entryId: " + entryId, e);
					}
				}
			}
			
		} catch (Exception e) {
			log.error("Unexpected error getting blogs by filter", e);
		}
		
		return blogsEntries;
	}

	private List<BlogInfo> convertBlogToView( List<BlogsEntry> blogsEntryList, ThemeDisplay themeDisplay ){
		List<BlogInfo> blogList = new ArrayList<>();
		if( !blogsEntryList.isEmpty() ){
			try {
				for( BlogsEntry be: blogsEntryList ){
					BlogInfo bi = new BlogInfo();
					bi.setUrlTitle( be.getUrlTitle() );
					bi.setUrlImage( getImageUrl( be, themeDisplay ) );
					bi.setTitle( be.getTitle() );
					bi.setSubtitle( getSubtitle( be ) );
					blogList.add( bi );
				}
			} catch (Exception e) {
				log.error(e);
			}
		}
		return blogList;
	}

	private String getImageUrl( BlogsEntry blog, ThemeDisplay themeDisplay ){
		String url = "";
        try {
            url = blog.getCoverImageURL( themeDisplay );
        } catch (PortalException e) {
            log.error(e);
        }
		if( url == null || url.isEmpty() ){
            try {
				DLFileEntry fe = dlFileEntryLocalService.getFileEntry( blog.getCoverImageFileEntryId() );
				url = "/documents/" + fe.getGroupId() + "/" + fe.getFolderId() + "/" + fe.getFileName() + "/" + fe.getUuid();
            } catch (PortalException e) {
                log.error(e);
            }
        }
        return url;
	}

	private String getSubtitle( BlogsEntry blog ){
		String result = "";
		if( blog.getContent() != null && !blog.getContent().isEmpty() ){
			result = blog.getContent().replaceAll("<[^>]*>", "");
		}
		return result;
	}


		@Reference
	private ExpandoColumnLocalService expandoColumnLocalService;
	
	@Reference
	private ExpandoTableLocalService expandoTableLocalService;
	
	@Reference
	private ExpandoValueLocalService expandoValueLocalService;
	
	@Reference
	private BlogsEntryLocalService blogsEntryLocalService;

	@Reference
	private DLFileEntryLocalService dlFileEntryLocalService;

}