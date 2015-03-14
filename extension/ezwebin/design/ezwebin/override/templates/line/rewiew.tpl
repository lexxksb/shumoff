<div class="media lineBlock review">
    <div class="media-left">
        {attribute_view_gui attribute=$node.data_map.avatar css_class="media-object" image_class=review}
    </div>
    <div class="media-body">
        <div class="icon"><div class="icon-reviewBg"></div></div>
        <div class="wrap">
            <div class="media-heading">{$node.data_map.name.content|wash}:</div>
            {attribute_view_gui attribute=$node.data_map.review}
            {if $node.data_map.reviewcontinue.has_content}
                <span class="fullLink">Читать полностью</span>
                <div class="full">
                    {attribute_view_gui attribute=$node.data_map.reviewcontinue}
                </div>
            {/if}
        </div>
    </div>
</div>
