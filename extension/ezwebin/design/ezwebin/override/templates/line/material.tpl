<div class="block">
    <div class="title">{$node.data_map.name.content|wash}</div>
    {if $node.object.data_map.image.has_content}
        {attribute_view_gui css_class="img-responsive" attribute=$node.object.data_map.image image_class=material}
    {/if}
    {if and(
        $node.object.data_map.price.content.price|gt(0),
        $node.object.data_map.notavailable.content|not
    )}
        <div class="price">
            <div class="text">Цена:</div>
            <div class="priceBlock">{$node.object.data_map.price.content.price|l10n( 'currency' )} <span class="icon-ruble"></span>{if $node.object.data_map.unit.has_content}<span class="from">/{$node.object.data_map.unit.content}</span>{/if}</div>
        </div>
        <div class="count">
            <div class="text">Количество:</div>
            <div class="input-group">
                <span class="input-group-addon" data-type="dec" data-id="{$node.node_id}">-</span>
                <input type="text" class="form-control" id="count{$node.node_id}" value="1" aria-label="">
                <span class="input-group-addon" data-type="inc" data-id="{$node.node_id}">+</span>
            </div>
        </div>
        <div class="add">
            <button data-nodeid="{$node.node_id}" data-objectid="{$node.object.id}" class="btn btn-shumoff toBasket cboxElement"><div class="icon-basket"></div>Добавить в корзину</button>
        </div>
    {else}
        <div class="add">
            <div class="notAvailable">Нет в наличии</div>
        </div>
    {/if}
</div>