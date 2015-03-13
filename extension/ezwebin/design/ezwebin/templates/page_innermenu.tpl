{default top_menu_items=array()}
<div class="innerMenu">
    <ul>
        {def
            $top_menu_items_count = $top_menu_items|count()
            $item_class = array()
            $current_node_in_path = first_set($pagedata.path_array[1].node_id, 0 )}
        {if $top_menu_items_count}
            {foreach $top_menu_items as $key => $item}
                {set $item_class = cond($current_node_in_path|eq($item.node_id), array("active"), array())}
                {if $key|eq(0)}
                    {set $item_class = $item_class|append("firstli")}
                {/if}
                {if $top_menu_items_count|eq( $key|inc )}
                    {set $item_class = $item_class|append("lastli")}
                {/if}
                {if $item.node_id|eq( $current_node_id )}
                    {set $item_class = $item_class|append("active")}
                {/if}
                <li {if $item_class} class="{$item_class|implode(" ")}"{/if} ><a href={$item.url_alias|ezurl}>{$item.name|wash()}</a></li>
            {/foreach}
        {/if}
        {undef $item_class $top_menu_items_count $current_node_in_path}
    </ul>
</div>
{/default}