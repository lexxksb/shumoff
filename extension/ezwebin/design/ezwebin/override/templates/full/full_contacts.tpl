{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash
)}

<h1>{$node.data_map.name.content|wash()}</h1>

{if $node.object.data_map.description.has_content}
    {attribute_view_gui attribute=$node.data_map.description}
{/if}

<div class="row contactBlock">
    <div class="col-md-6">
        {if $node.object.data_map.address.has_content}
            <div class="item">
                <div class="icon-cPlace icon"></div>
                <div class="text">Адрес: {$node.data_map.address.content|wash}</div>
            </div>
        {/if}
        {if $node.object.data_map.tel.has_content}
        <div class="item">
            <div class="icon-cTel icon"></div>
            <div class="text">Телефон: {$node.data_map.tel.content|wash}</div>
        </div>
        {/if}
        {if $node.object.data_map.time.has_content}
            <div class="item"><div class="icon-cTime icon"></div>
                <div class="text"><div class="t">Время работы:</div>{$node.data_map.time.content|wash|nl2br}</div>
            </div>
        {/if}
    </div>
    <div class="col-md-6">
        {if $node.object.data_map.email.has_content}
            <div class="item">
                <div class="icon-cEmail icon"></div>
                <div class="text">Email: {attribute_view_gui attribute=$node.data_map.email}</div>
            </div>
        {/if}
        {if $node.object.data_map.skype.has_content}
            <div class="item">
                <div class="icon-cSkype icon"></div>
                <div class="text">Skype: {$node.data_map.skype.content|wash}</div>
            </div>
        {/if}
        {if $node.object.data_map.icq.has_content}
            <div class="item">
                <div class="icon-cIcq icon"></div>
                <div class="text"><div class="t">ICQ:</div>{$node.data_map.icq.content|wash|nl2br}3</div>
            </div>
        {/if}
    </div>
</div>

{if $node.object.data_map.address.has_content}
    <script src="http://api-maps.yandex.ru/2.1/?lang=ru_RU" type="text/javascript"></script>
    <div class="map" id="map" style="width: 100%;height: 300px;" data-address="{$node.data_map.address.content|wash}"></div>
{/if}

{if $node.object.data_map.about.has_content}
    {attribute_view_gui attribute=$node.data_map.about}
{/if}