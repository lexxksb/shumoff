<div class="media lineBlock partner">
    <div class="media-left">
        {attribute_view_gui attribute=$node.data_map.image css_class="media-object" image_class=partner}
    </div>
    <div class="media-body">
        <div class="media-heading">{$node.data_map.name.content|wash}</div>
        {attribute_view_gui attribute=$node.data_map.description}
        {if $node.data_map.address.has_content}
        <div class="contacts">
            <div class="text"><div class="_text">Адрес:</div></div>
            <div class="_info">{$node.data_map.address.content|wash}</div>
        </div>
        {/if}
        {if $node.data_map.tel.has_content}
            <div class="contacts">
                <div class="text"><div class="_text">Тел.:</div></div>
                <div class="_info">{$node.data_map.tel.content|wash}</div>
            </div>
        {/if}
        {if $node.data_map.time.has_content}
            <div class="contacts">
                <div class="text"><div class="_text">График работы:</div></div>
                <div class="_info">{$node.data_map.time.content|wash}</div>
            </div>
        {/if}
        {if $node.data_map.email.has_content}
            <div class="contacts">
                <div class="text"><div class="_text">E-mail:</div></div>
                <div class="_info">{attribute_view_gui attribute=$node.data_map.email}</div>
            </div>
        {/if}
        {if $node.data_map.site.has_content}
            <div class="contacts">
                <div class="text"><div class="_text">Сайт:</div></div>
                <div class="_info">{attribute_view_gui attribute=$node.data_map.site}</div>
            </div>
        {/if}
    </div>
</div>