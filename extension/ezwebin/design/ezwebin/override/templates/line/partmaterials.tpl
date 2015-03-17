<h2>{$node.data_map.name.content|wash}</h2>
{def $children = fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                            'sort_by', $node.sort_array,
                                            'class_filter_type', 'include',
                                            'class_filter_array', array('typematerial') ) ) }
<ul class="flexBlock materials">
    {foreach $children as $child}
        <li>{node_view_gui view='line' content_node=$child}</li>
    {/foreach}
</ul>