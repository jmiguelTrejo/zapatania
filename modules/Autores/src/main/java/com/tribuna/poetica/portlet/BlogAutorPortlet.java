package com.tribuna.poetica.portlet;

import com.liferay.blogs.model.BlogsEntry;
import com.liferay.expando.kernel.model.ExpandoColumn;
import com.liferay.expando.kernel.model.ExpandoTable;
import com.liferay.expando.kernel.model.ExpandoValue;
import com.liferay.expando.kernel.service.ExpandoColumnLocalService;
import com.liferay.expando.kernel.service.ExpandoTableLocalService;
import com.liferay.expando.kernel.service.ExpandoValueLocalService;
import com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil;
import com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.WebKeys;
import com.tribuna.poetica.constants.BlogAutorPortletKeys;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import java.io.IOException;
import java.util.*;

@Component(
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=BlogAutor",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + BlogAutorPortletKeys.BLOGAUTOR,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class BlogAutorPortlet extends MVCPortlet {

	@Override
	public void doView(
			RenderRequest renderRequest, RenderResponse renderResponse)
		throws IOException, PortletException {

		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long companyId = themeDisplay.getCompanyId();

		// Retrieve the ExpandoTable for BlogsEntry and get the column "autor"
		ExpandoTable expandoTable = null;
		ExpandoColumn autorColumn = null;
		try {
			expandoTable = expandoTableLocalService.getDefaultTable(
				companyId, BlogsEntry.class.getName() );
			autorColumn = expandoColumnLocalService.getColumn(expandoTable.getTableId(), "autor");
		} catch (PortalException e) {
			// Could not get table or column, exit early
			renderRequest.setAttribute("autores", new ArrayList<String>());
			// Optionally log error
		}

		Set<String> autoresSet = new HashSet<>();
		if (autorColumn != null) {
			// Use dynamic query to fetch all ExpandoValues for the "autor" column (unique, non-repeated)
			try {
				List<ExpandoValue> autorValues = expandoValueLocalService.dynamicQuery(
					DynamicQueryFactoryUtil
						.forClass(ExpandoValue.class, this.getClass().getClassLoader())
						.add( RestrictionsFactoryUtil.eq("columnId", autorColumn.getColumnId()))
				);

				for (ExpandoValue value : autorValues) {
					String autor = value.getString();
					if (autor != null && !autor.trim().isEmpty()) {
						autoresSet.add(autor.trim());
					}
				}
			} catch (Exception ex) {
				// Optionally log error
			}
		}

		List<String> autores = new ArrayList<>(autoresSet);
		Collections.sort(autores, String.CASE_INSENSITIVE_ORDER);

		renderRequest.setAttribute("autores", autores);
		

		super.doView(renderRequest, renderResponse);
	}

	@Reference
	private ExpandoColumnLocalService expandoColumnLocalService;

	@Reference
	private ExpandoTableLocalService expandoTableLocalService;

	@Reference
	private ExpandoValueLocalService expandoValueLocalService;
}