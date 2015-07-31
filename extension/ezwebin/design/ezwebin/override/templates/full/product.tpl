{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash,
    'contextBlock1', true(),
    'contextBlock2', false()
)}

{def $top_menu_items = fetch( 'content', 'list', hash(
        'parent_node_id', $node.parent.node_id,
        'class_filter_type', 'include',
        'class_filter_array', array("product"),
        'sort_by', array("priority", true())
    ))
    $top_menu_items_count = $top_menu_items|count()
    $item_class = array()
    $current_node_in_path = first_set($pagedata.path_array[1].node_id, 0 )}
{if $top_menu_items_count}
    <nav class="navbar navbar-default navbar-kit">
        <div class="navbar-header">
            <div class="navbar-brand">Все комплекты шумоизоляции:</div>
        </div>
        <ul class="nav navbar-nav">
        {foreach $top_menu_items as $key => $item}
            {set $item_class = cond($current_node_in_path|eq($item.node_id), array("active"), array())}
            {if $item.node_id|eq( $node.node_id )}
                {set $item_class = $item_class|append("active")}
            {/if}
            <li {if $item_class} class="{$item_class|implode(" ")}"{/if}><a href={$item.url_alias|ezurl}>{$item.name|wash}</a></li>
        {/foreach}
        </ul>
    </nav>
{/if}
{undef $top_menu_items $item_class $top_menu_items_count $current_node_in_path}

<h1>{$node.data_map.name.content|wash}</h1>

{def $first = array()
    $second = array()
    $tmp = array()
    $tmp2 = ""
    $recommend = $node.object.data_map.recommend.content|explode('-')}
{foreach $node.object.data_map.options.content.option_list as $v}
    {set $tmp = $v.value|explode('-')}
    {set $first = $first|append($tmp[0])}
    {set $second = $second|append($tmp[1])}
{/foreach}
{set $tmp = array()}
{set $first = $first|unique()}
{set $second = $second|unique()}

<script type="text/javascript">
    kitOptions = [];
    var option = [];
    {foreach $first as $key => $f}
        {foreach $node.object.data_map.options.content.option_list as $v}
            {if $v.value|contains($f)}
            {set $tmp2 = $v.value|explode('-')}
                option["{$tmp2[1]}"] = [{$v.id}, {$v.additional_price}];
            {/if}
        {/foreach}
        kitOptions["{$f}"] = option;
        var option = [];
        {set $tmp = array()}
    {/foreach}
</script>

<div class="row kitItem">
    <div class="col-md-4">
        {attribute_view_gui css_class="img-responsive kitItemImg" image_class=kit attribute=$node.data_map.image}
    </div>
    <div class="col-md-8">
        <div class="row">
            <div class="col-md-6">
                <div class="title">Что будем клеить?</div>
                {foreach $first as $key => $f}
                    <div class="radio"><label><input {if $recommend[0]|eq($f)} checked="checked" {/if} type="radio" name="first" id="f{$key}" value="{$f|wash}">{$f|wash}</label></div>
                {/foreach}
            </div>
            <div class="col-md-6">
                <div class="title">Как будем клеить?</div>
                {foreach $second as $key => $s}
                    <div class="radio"><label><input {if $recommend[1]|eq($s)} checked="checked" {/if} type="radio" name="second" id="s{$key}" value="{$s|wash}">{$s|wash}</label></div>
                {/foreach}
            </div>
        </div>

        {*<div class="weight">Вес комплекта: 0,69 кг</div>*}

        <div class="row">
            <div class="col-md-6">
                <div class="priceBlock">
                    <span id="price" data-price="{$node.object.data_map.price.content.price}">{$node.object.data_map.price.content.price|l10n( 'number' )}</span>&nbsp;<span class="icon-ruble"></span>
                </div>
            </div>
            <div class="col-md-6">
                <button data-nodeid="{$node.node_id}" data-objectid="{$node.object.id}" data-optionid="{$node.object.data_map.options.id}" class="btn btn-shumoff toBasket cboxElement" name="ActionAddToBasket"><div class="icon-basket"></div>Добавить в корзину</button>
            </div>
        </div>
        <div class="ttxKit">
            {attribute_view_gui attribute=$node.object.data_map.description}
        </div>
    </div>
</div>

{def $othermaterials = $node.object.data_map.notforgetbuy.content.relation_list
     $omitems = array()}
{if $othermaterials|count()}
<div class="materialSoputka {*soputka*}">
    <div class="title">Не забудьте купить</div>
    <ul class="flexBlock materials">
        {foreach $othermaterials as $mat}
            {set $omitems = fetch( 'content', 'node', hash( 'node_id', $mat.node_id ) )}
            <li>{node_view_gui view='line' content_node=$omitems}</li>
        {/foreach}
    </ul>
    {*<div class="row">*}
        {*<div class="col-md-6">*}
            {*<div class="media">*}
                {*<div class="media-left">*}
                    {*<a href="#">*}
                        {*<a href=""><img class="media-object" src="http://placehold.it/110x110" alt="..."></a>*}
                    {*</a>*}
                {*</div>*}
                {*<div class="media-body">*}
                    {*<div class="media-heading"><a href="">Инструменты</a></div>*}
                    {*<p>Съемники в наборах и отдельно. Прикаточные валики и другие полезные штуки для монтажа шумоизоляции.</p>*}
                    {*<div class="priceBlock"><span class="from">от</span>&nbsp;95 <span class="icon-ruble"></span><span class="from">/лист</span></div>*}
                {*</div>*}
            {*</div>*}
        {*</div>*}
        {*<div class="col-md-6">*}
            {*<div class="media">*}
                {*<div class="media-left">*}
                    {*<a href="#">*}
                        {*<a href=""><img class="media-object" src="http://placehold.it/110x110" alt="..."></a>*}
                    {*</a>*}
                {*</div>*}
                {*<div class="media-body">*}
                    {*<div class="media-heading"><a href="">Инструменты</a></div>*}
                    {*<p>Съемники в наборах и отдельно. Прикаточные валики и другие полезные штуки для монтажа шумоизоляции.</p>*}
                    {*<div class="priceBlock"><span class="from">от</span>&nbsp;95 <span class="icon-ruble"></span><span class="from">/лист</span></div>*}
                {*</div>*}
            {*</div>*}
        {*</div>*}
    {*</div>*}
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