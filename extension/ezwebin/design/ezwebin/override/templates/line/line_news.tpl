<div class="media lineBlock news">
    {if $node.object.data_map.image.has_content}
        <div class="media-left">
            {attribute_view_gui href=$node.url_alias|ezurl attribute=$node.data_map.image css_class="media-object" image_class=news}
        </div>
    {/if}
    <div class="media-body">
        {if $node.data_map.date.has_content}
            <div class="date">{$node.data_map.date.content.timestamp|l10n( 'date' )}</div>
        {/if}
        <div class="media-heading"><a href={$node.url_alias|ezurl}>{$node.data_map.name.content|wash}</a></div>
        {attribute_view_gui attribute=$node.data_map.short_description}
    </div>
</div>