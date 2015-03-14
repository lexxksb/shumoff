{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash
)}

<h1>{$node.data_map.name.content|wash()}</h1>

{if $node.object.data_map.description.has_content}
    {attribute_view_gui attribute=$node.data_map.description}
{/if}