package testContributor;

import com.liferay.portal.kernel.editor.configuration.BaseEditorConfigContributor;
import com.liferay.portal.kernel.editor.configuration.EditorConfigContributor;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.portlet.RequestBackedPortletURLFactory;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.Validator;
import org.osgi.service.component.annotations.Component;

import java.util.Map;

@Component(immediate = true, property = { "editor.name=ckeditor",
        "service.ranking:Integer=1000" }, service = EditorConfigContributor.class)
public class CKEditorCustomPluginConfigContributor extends BaseEditorConfigContributor {

    @Override
    public void populateConfigJSONObject(JSONObject jsonObject, Map<String, Object> inputEditorTaglibAttributes,
                                         ThemeDisplay themeDisplay, RequestBackedPortletURLFactory requestBackedPortletURLFactory) {

        addPluginToCkEditor(jsonObject);
    }

    /**
     * This method adds the insert snippet plugin to ckeditor toolbar
     *
     * @param jsonObject
     */
    private void addPluginToCkEditor(JSONObject jsonObject) {

        String extraPlugins = jsonObject.getString("extraPlugins");

        if (Validator.isNotNull(extraPlugins)) {
            extraPlugins = extraPlugins + ",insertsnippet";
            jsonObject.put("extraPlugins", extraPlugins);
        }

        setInsertSnippetButtonForToolbar(jsonObject, "toolbar_liferay");
        //setInsertSnippetButtonForToolbar(jsonObject, "toolbar_liferayArticle");
    }

    /**
     * This method adds insert snippet button into the section where we have image selector button
     *
     * @param jsonObject
     * @param toolbarName
     */
    private void setInsertSnippetButtonForToolbar(JSONObject jsonObject, String toolbarName) {

        JSONArray toolbar = jsonObject.getJSONArray(toolbarName);
        JSONArray imageSelectorSection = getImageSelectorSection(toolbar);

        if (imageSelectorSection != null) {
            imageSelectorSection.put("InsertSnippet");
        }

        jsonObject.put(toolbarName, toolbar);
    }

    /**
     * This method returns the json array containing the image selector button
     *
     *
     * @param toolbar
     * @return
     */
    private JSONArray getImageSelectorSection(JSONArray toolbar) {
        JSONArray imageSelectorSection = null;
        for (int i = 0; i < toolbar.length(); i++) {
            JSONArray array = toolbar.getJSONArray(i);
            if (array != null && hasImageSelector(array)) {
                imageSelectorSection = array;
                break;
            }
        }

        return imageSelectorSection;
    }

    /**
     * This method returns true if image selector button is available in given array
     *
     * @param array
     * @return
     */
    private boolean hasImageSelector(JSONArray array) {
        boolean hasImageSelector = Boolean.FALSE;
        for(int i=0; i< array.length(); i++) {
            if(StringUtil.equals(array.getString(i), "ImageSelector")) {
                hasImageSelector = Boolean.TRUE;
                break;
            }
        }
        return hasImageSelector;
    }
}