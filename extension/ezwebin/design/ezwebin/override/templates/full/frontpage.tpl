{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash,
    'metaheader', $node.object.data_map.meta_header.content|wash,
    'textheader', $node.object.data_map.textheader
)}
{def
    $himselfNodes = fetch( 'content', 'list', hash( 'parent_node_id', 72,
'limit', 3) )
    $reviewNodes = fetch( 'content', 'list', hash(
            'parent_node_id', 70,
            'limit', 1,
            'sort_by', array( 'attribute', false(), 376 )
        ) )
    $newsNodes = fetch( 'content', 'list', hash(
            'parent_node_id', 73,
            'limit', 1,
            'sort_by', array( 'attribute', false(), 444 )
    ) )
    $instCenter = fetch( 'content', 'node', hash( 'node_id', 138 ) )
}
<div class="seo">
    {attribute_view_gui attribute=$node.object.data_map.seotext}
</div>

<ul class="flexBlock info">
    <li>
        {if $himselfNodes|count}
        <div class="articles">
            <div class="legend"><div class="icon-himself"></div>Сделай сам</div>
            {foreach $himselfNodes as $node}
                <div class="list"><div class="icon-liDot"></div><a href={$node.url_alias|ezurl}>{$node.data_map.name.content|wash}</a></div>
            {/foreach}
            <div class="all"><a href={$himselfNodes[0].parent.url_alias|ezurl}>Все инструкции</a></div>
        </div>
        {/if}
    </li>
    <li>
        {if $newsNodes|count()}
        <div class="news">
            <div class="text"><a href={$newsNodes[0].url_alias|ezurl}>{$newsNodes[0].data_map.name.content|wash}</a></div>
            {attribute_view_gui attribute=$newsNodes[0].data_map.short_description}
            <div class="all"><a href={$newsNodes[0].parent.url_alias|ezurl}>Все новости и акции</a></div>
        </div>
        {/if}
    </li>
    <li>
        {if $reviewNodes|count()}
        <div class="rewiew">
            <div class="author">{$reviewNodes[0].data_map.name.content|wash}:</div>
            {attribute_view_gui attribute=$reviewNodes[0].data_map.review}
            <div class="all"><a class="all" href={$reviewNodes[0].parent.url_alias|ezurl}>Все отзывы</a></div>
        </div>
        {/if}
    </li>
</ul>

<div class="instCenter">
    <div class="t1"><a href={$instCenter.url_alias|ezurl}>{$instCenter.data_map.name.content|wash}</a></div>
    <div class="media">
        <div class="media-left media-middle">
            {attribute_view_gui image_class=inctCenterMainPage css_class="media-object" href=$instCenter.url_alias|ezurl attribute=$instCenter.data_map.image}
        </div>
        <div class="media-body">
            {attribute_view_gui attribute=$instCenter.data_map.short_description}
        </div>
    </div>
</div>