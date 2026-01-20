<div class="owl-carousel owl-theme owl-principal-carrusel">
    <#if entries?has_content>
        <#list entries as curEntry>
            <div class="item">
            
                <h4>
                    <#if entry?has_content>
                    	${entry.getTitle(locale)}
                    </#if>
                </h4>
            </div>
        </#list>
    </#if>
</div>