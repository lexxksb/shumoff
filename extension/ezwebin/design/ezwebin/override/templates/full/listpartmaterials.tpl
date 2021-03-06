{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash,
    'contextBlock1', false(),
    'contextBlock2', true()
)}
<h1>{$node.data_map.name.content|wash}</h1>

{attribute_view_gui attribute=$node.object.data_map.description}

{def $children = fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                'sort_by', array("priority", true()),
                                                'class_filter_type', 'include',
                                                'class_filter_array', array('partmaterials') ) ) }
{foreach $children as $child}
    {node_view_gui view='line' content_node=$child}
{/foreach}