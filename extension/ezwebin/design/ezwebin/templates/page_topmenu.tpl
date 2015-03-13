<div class="navbar navbar-inverse" role="navigation">
    <div class="navbar-header">
        {def $root_node=fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node) )
        $top_menu_items=fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                                        'sort_by', $root_node.sort_array,
                                                        'class_filter_type', 'include',
                                                        'class_filter_array', ezini( 'MenuContentSettings', 'TopIdentifierList', 'menu.ini' )
                                                        ))
        $top_menu_items_count = $top_menu_items|count()
        $item_class = array()
        $current_node_in_path = first_set($pagedata.path_array[1].node_id, 0 )
        $basket = fetch( shop, basket )}
        {if $top_menu_items_count}
            {foreach $top_menu_items as $key => $item}
                {set $item_class = cond($current_node_in_path|eq($item.node_id), array("navbar-brand navbar-active"), array("navbar-brand"))}
                {if $key|eq(0)}
                    {set $item_class = $item_class|append("firstli")}
                {/if}
                {if $top_menu_items_count|eq( $key|inc )}
                    {set $item_class = $item_class|append("lastli")}
                {/if}
                {if $item.node_id|eq( $current_node_id )}
                    {set $item_class = $item_class|append("navbar-active")}
                {/if}
                <a {if $item_class} class="{$item_class|implode(" ")}"{/if} href={$item.url_alias|ezurl}>{$item.name|wash()}</a>
            {/foreach}
        {/if}
        <a class="navbar-brand navbar-right basket" href={"/store/basket/"|ezurl}><div class="icon-basket"></div>{if $basket.is_empty}Корзина пуста{else}{$basket.items|count()}{/if}</a>
        {undef $root_node $top_menu_items $item_class $top_menu_items_count $current_node_in_path $basket}
    </div>
</div>