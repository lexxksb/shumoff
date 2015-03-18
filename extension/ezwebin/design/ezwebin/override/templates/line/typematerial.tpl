<div class="block">
    <div class="media">
        {if $node.object.data_map.image.has_content}
            <div class="media-left">
                {attribute_view_gui href=$node.url_alias|ezurl css_class="media-object" attribute=$node.object.data_map.image image_class=typematerial}
            </div>
        {/if}
        <div class="media-body">
            <a href={$node.url_alias|ezurl} class="media-heading">{$node.data_map.name.content|wash}</a>
            {attribute_view_gui attribute=$node.object.data_map.short_description}
            {def $children = fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                'sort_by', array( 'attribute', true(), 480 ),
                                                'class_filter_type', 'include',
                                                'class_filter_array', array('material'),
                                                'limit', 1) ) }
            <div class="priceBlock">
                <span class="from">от</span>&nbsp;{$children[0].data_map.price.content.price|l10n( 'currency' )}&nbsp;<span class="icon-ruble"></span>{if $children[0].data_map.unit.has_content}<span class="from">/{$children[0].data_map.unit.content}</span>{/if}
            </div>
        </div>
    </div>
</div>