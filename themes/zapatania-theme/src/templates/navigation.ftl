<#include init />
<nav class="navbar navbar-expand-lg bg-body-tertiary">
	<div class="container-fluid">
		<a class="navbar-brand" href="/">
			<img alt="${logo_description}" class="mr-2" height="56" src="${site_logo}" />
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<#list nav_items as nav_item>
					<#assign hasChildren="" />
					<#assign isActive="" />
					<#if nav_item.hasChildren()>
						<#assign hasChildren="dropdown" />
					</#if>
					<#if nav_item.isSelected()>
						<#assign isActive="active" />
					</#if>
					<#if nav_item.isChildSelected()>
						<#assign isActive="active" />
					</#if>
					
					<li class="nav-item ${hasChildren} ${isActive}">
						<#if nav_item.hasChildren()>
							<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown${nav_item?index}" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								${nav_item.getName()}
							</a>
						</#if>
						<#if !nav_item.hasChildren()>
							<a href="${nav_item.getURL()}" class="nav-link">
								${nav_item.getName()}
							</a>
						</#if>
						<#if nav_item.hasChildren()>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown${nav_item?index}">
								<#list nav_item.getChildren() as nav_child>
									<#assign isActive="" />
									<#if nav_item.isSelected()>
										<#assign isActive="active" />
									</#if>
									<li> <a class="dropdown-item ${isActive}" href="${nav_child.getURL()}"> ${nav_child.getName()} </a> </li>
								</#list>
							</ul>
						</#if>
					</li>
				</#list>

			</ul>
			<#if show_header_search>
				<#assign preferences = freeMarkerPortletPreferences.getPreferences({"portletSetupPortletDecoratorId": "barebone", "destination": "/search"}) />
				<div class="dropdown">
					<button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
						<svg class="lexicon-icon lexicon-icon-search" role="presentation">
							<use href="http://localhost:9080/o/zapatania-theme/images/clay/icons.svg#search"></use>
						</svg>
					</button>
					<ul class="dropdown-menu">
						<li>
							<div class="justify-content-md-end mr-4 navbar-form" role="search">
								<@liferay.search_bar default_preferences="${preferences}" />
							</div>
						</li>
					</ul>
				</div>

			</#if>
			<@liferay.user_personal_bar />
		</div>
	</div>
</nav>

