{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash,
    'contextBlock1', false(),
    'contextBlock2', false()
)}

<h1>{$node.data_map.name.content|wash}</h1>

{if $node.object.data_map.mapaddress.has_content}
<p class="text-center">
    <script src="http://api-maps.yandex.ru/2.1/?lang=ru_RU" type="text/javascript"></script>
    <div class="map" id="map" style="width: 650px;height: 250px;" data-address="{$node.data_map.mapaddress.content|wash}" data-zoom="15"></div>
</p>
{/if}
{attribute_view_gui attribute=$node.data_map.description}