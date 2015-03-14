<div class="media lineBlock">
    {if $node.object.data_map.image.has_content}
        <div class="media-left">
            {attribute_view_gui href=$node.url_alias|ezurl attribute=$node.data_map.image css_class="media-object" image_class=lineBlock}
        </div>
    {/if}
    <div class="media-body">
        <div class="media-heading"><a href={$node.url_alias|ezurl}>{$node.data_map.name.content|wash}</a></div>
        {attribute_view_gui attribute=$node.data_map.short_description}
    </div>
</div>