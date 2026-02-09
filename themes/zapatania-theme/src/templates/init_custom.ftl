<#assign
	show_footer = getterUtil.getBoolean(themeDisplay.getThemeSetting("show-footer"))
	show_header = getterUtil.getBoolean(themeDisplay.getThemeSetting("show-header"))
	show_header_search = getterUtil.getBoolean(themeDisplay.getThemeSetting("show-header-search"))
	wrap_widget_page_content = getterUtil.getBoolean(themeDisplay.getThemeSetting("wrap-widget-page-content"))

	footer_text = getterUtil.getString(themeDisplay.getThemeSetting("footer-text"))
	facebook_url = getterUtil.getString(themeDisplay.getThemeSetting("facebook-url"))
	x_url = getterUtil.getString(themeDisplay.getThemeSetting("x-url"))
	youtube_url = getterUtil.getString(themeDisplay.getThemeSetting("youtube-url"))
	email = getterUtil.getString(themeDisplay.getThemeSetting("email"))
	subscribe_url = getterUtil.getString(themeDisplay.getThemeSetting("subscribe-url"))
/>

<#if wrap_widget_page_content && ((layout.isTypeContent() && themeDisplay.isStateMaximized()) || (layout.getType() == "portlet"))>
	<#assign portal_content_css_class = "container" />
<#else>
	<#assign portal_content_css_class = "" />
</#if>