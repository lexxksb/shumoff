{set scope=global persistent_variable=hash(
    'meta_description', "",
    'site_title', $node.name|wash,
    'contextBlock1', false(),
    'contextBlock2', false()
)}
<h1>{$node.name|wash()}</h1>
<p>{attribute_view_gui attribute=$node.data_map.image image_class=imagelarge}</p>