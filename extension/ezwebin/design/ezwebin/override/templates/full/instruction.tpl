{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash,
    'contextBlock1', false(),
    'contextBlock2', true(),
    'contextKit', cond($node.object.data_map.komplekt.has_content, $node.object.data_map.komplekt, false())
)}
<h1>{$node.object.data_map.name.content|wash()}</h1>
{attribute_view_gui attribute=$node.data_map.description}