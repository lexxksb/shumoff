{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash
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
    <table class="table ttx">
        <tbody><tr>
            <th>Характеристики</th>
            <th>М1.2</th>
            <th>М1.2</th>
            <th>М1.2</th>
            <th>М1.2</th>
        </tr>
        <tr>
            <td>Толщина материала</td>
            <td>М1.2</td>
            <td>М1.2</td>
            <td>М1.2</td>
            <td>М1.2</td>
        </tr>
        <tr>
            <td>Масса упаковки</td>
            <td>М1.2</td>
            <td>М1.2</td>
            <td>М1.2</td>
            <td>М1.2</td>
        </tr>
        </tbody></table>
    {attribute_view_gui attribute=$node.object.data_map.ttx}
{/if}


<div class="materialSoputka">
    <div class="title">Другие вибропоглощающие материалы</div>

    <ul class="flexBlock materials">
        <li>
            <div class="block">
                <div class="media">
                    <div class="media-left">
                        <a href="#"><img class="media-object" src="http://placehold.it/110x110" alt="..."></a>
                    </div>
                    <div class="media-body">
                        <a href="" class="media-heading">Комплект по шумоизоляции дверей</a>
                        <p>Материал на основе неотверждаемой мастики с лицевым покрытием в виде фольги.</p>
                        <div class="priceBlock"><span class="from">от</span>&nbsp;1 360&nbsp;<span class="icon-ruble"></span><span class="from">/лист</span></div>
                    </div>
                </div>
            </div>
        </li>
        <li>
            <div class="block">
                <a href="">Комплект по шумоизоляции дверей</a>
                <p>Вибродемпфирующий, снижающий шум металлических и пластиковых панелей от вибрации.</p>
                <div class="priceBlock"><span class="from">от</span>&nbsp;1 360&nbsp;<span class="icon-ruble"></span></div>
            </div>
        </li>
    </ul>
</div>