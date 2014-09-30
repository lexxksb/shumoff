<h1>{$node.data_map.name.content|wash()}</h1>

{def $page_limit = 10
     $classes = array('instruction')
     $filter_type = 'include'
     $children = array()
     $children_count = ''}

{set $children_count=fetch_alias( 'children_count', hash( 'parent_node_id', $node.node_id,
                                                          'class_filter_type', $filter_type,
                                                          'class_filter_array', $classes ) )}
{if $children_count}                                                          
    {set $children = fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
                                                'offset', $view_parameters.offset,
                                                'sort_by', $node.sort_array,
                                                'class_filter_type', $filter_type,
                                                'class_filter_array', $classes,
                                                'limit', $page_limit ) ) }

    <div class="content-view-children">
        {foreach $children as $child }
            {node_view_gui view='line' content_node=$child}
        {/foreach}
    </div>
    
    {include name=navigator
         uri='design:navigator/google.tpl'
         page_uri=$node.url_alias
         item_count=$children_count
         view_parameters=$view_parameters
         item_limit=$page_limit}
{else}         
    <p>Ничего нет</p>
{/if}
