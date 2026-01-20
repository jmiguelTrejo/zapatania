package testContributor;

import com.liferay.portal.kernel.editor.configuration.BaseEditorConfigContributor;
import com.liferay.portal.kernel.editor.configuration.EditorConfigContributor;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.json.JSONUtil;
import com.liferay.portal.kernel.portlet.RequestBackedPortletURLFactory;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.GetterUtil;
import com.liferay.portal.kernel.util.StringUtil;
import com.liferay.portal.kernel.util.Validator;
import org.osgi.service.component.annotations.Component;

import java.util.Map;

@Component(immediate = true, property = {
        "editor.name=ckeditor",
        "editor.name=ckeditor_classic",
        "javax.portlet.name=com_liferay_blogs_web_portlet_BlogsAdminPortlet",
        "service.ranking:Integer=100"
}, service = EditorConfigContributor.class)
public class CKEditorCustomPluginConfigContributor extends BaseEditorConfigContributor {

    @Override
    public void populateConfigJSONObject(JSONObject jsonObject, Map<String, Object> inputEditorTaglibAttributes,
                                         ThemeDisplay themeDisplay, RequestBackedPortletURLFactory requestBackedPortletURLFactory) {

        jsonObject.put("toolbar_liferay", getToolbarLiferayJSONArray(inputEditorTaglibAttributes));
        String removePlugins = jsonObject.getString("removePlugins");

        jsonObject.put("allowedContent", true);
        jsonObject.put("removePlugins", "");
        System.out.println(" removePlugins ");
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
            extraPlugins = extraPlugins + ",cursivebutton,colorbutton,customcolorbutton";
            jsonObject.put("extraPlugins", extraPlugins);
        }

        setInsertSnippetButtonForToolbar(jsonObject, "toolbar_liferay");
        setInsertSnippetButtonForToolbar(jsonObject, "toolbar_text_advanced");
        setInsertSnippetButtonForToolbar(jsonObject, "toolbar_simple");
        setInsertSnippetButtonForToolbar(jsonObject, "toolbar_text_simple");
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
            imageSelectorSection.put("CursiveButton");
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

    protected JSONArray getToolbarLiferayJSONArray(Map<String, Object> inputEditorTaglibAttributes) {
        String buttons = "['Table', '-', 'ImageSelector',";
        buttons = buttons.concat(" 'AudioSelector', 'VideoSelector',");
        buttons = buttons.concat(" 'Flash', '-', 'Smiley', 'SpecialChar']");
        JSONArray jsonArray = JSONUtil.putAll(new Object[] { toJSONArray("['Bold', 'Italic', 'Underline', 'Strike', '-', 'Subscript', 'Superscript', '-', 'RemoveFormat']"),

        toJSONArray("['FontColor', 'BGColor', 'LineHeight', 'CursiveButton', 'TextColor', 'textColor', 'FontColor', 'BGColor']"),
        toJSONArray("['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', 'colorbutton']"),
        toJSONArray("['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent']"), "/",
        toJSONArray("['fontSize']"),
        toJSONArray("['Link', 'Unlink', 'Anchor']"), toJSONArray(buttons), "/" });
        boolean inlineEdit = GetterUtil.getBoolean((String)inputEditorTaglibAttributes
                .get("liferay-ui:input-editor:inlineEdit"));
        boolean showSource = GetterUtil.getBoolean(inputEditorTaglibAttributes
                .get("liferay-ui:input-editor:showSource"), true);
        if (inlineEdit)
            jsonArray.put(toJSONArray("['AjaxSave', '-', 'Restore']"));
        jsonArray.put(
                        toJSONArray("['Cut', 'Copy', 'Paste', '-', 'PasteText', 'PasteFromWord', '-', 'SelectAll' , '-', 'Undo', 'Redo']"))

                .put(
                        toJSONArray("['Find', 'Replace', '-', 'SpellChecker', 'Scayt']"));
        if (!inlineEdit && showSource)
            jsonArray.put(toJSONArray("['Source']"));
        jsonArray.put(toJSONArray("['A11YBtn']"));
        return jsonArray;
    }
}