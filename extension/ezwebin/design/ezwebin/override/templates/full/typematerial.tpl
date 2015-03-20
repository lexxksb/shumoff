{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash,
    'contextBlock1', true(),
    'contextBlock2', false()
)}

<h1>{$node.data_map.name.content|wash}</h1>

{attribute_view_gui attribute=$node.object.data_map.short_description}

{def $children = fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                        'sort_by', $node.sort_array,
                                        'class_filter_type', 'include',
                                        'class_filter_array', array('material')) ) }

<ul class="flexBlock itemMaterials">
    {foreach $children as $child}
        <li>{node_view_gui view='line' content_node=$child}</li>
    {/foreach}
</ul>

{if $node.object.data_map.ttx.has_content}
    <div class="ttxTitle">Технические характеристики</div>
    <div class="ttx">{attribute_view_gui attribute=$node.object.data_map.ttx}</div>
{/if}

{def $othermaterials = $node.object.data_map.othermaterials.content.relation_list
     $omitems = array()}
{if $othermaterials|count()}
<div class="materialSoputka">
    <div class="title">Другие {$node.parent.name|downcase()}</div>
    <ul class="flexBlock materials">
        {foreach $othermaterials as $mat}
            {set $omitems = fetch( 'content', 'node', hash( 'node_id', $mat.node_id ) )}
            <li>{node_view_gui view='line' content_node=$omitems}</li>
        {/foreach}
    </ul>
</div>
{/if}
{undef $othermaterials $omitems}

<div style="display: none">
    <div id='inline_content' class="basketAddBlock">
        <div class="title">Товар добавлен в корзину</div>
        <div>
            <a href="#" class="colorboxClose">Продолжить покупки</a>
            <a href={"/store/basket/"|ezurl}><button class="btn btn-shumoff" type="submit">Оформить заказ</button></a>
        </div>
    </div>
</div>