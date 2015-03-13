{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash
)}

<h1>{$node.name|wash}</h1>

{if $node.object.data_map.description.has_content}
    {attribute_view_gui attribute=$node.data_map.description}
{/if}


{*{def $page_limit = 10*}
{*$classes = ezini( 'MenuContentSettings', 'ExtraIdentifierList', 'menu.ini' )*}
{*$children = array()*}
{*$children_count = ''}*}

{*{if le( $node.depth, '3')}*}
    {*{set $classes = $classes|merge( ezini( 'ChildrenNodeList', 'ExcludedClasses', 'content.ini' ) )}*}
{*{/if}*}

{*{set $children_count=fetch_alias( 'children_count', hash( 'parent_node_id', $node.node_id,*}
{*'class_filter_type', 'exclude',*}
{*'class_filter_array', $classes ) )}*}

{*<div class="content-view-children">*}
    {*{if $children_count}*}
        {*{foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,*}
        {*'offset', $view_parameters.offset,*}
        {*'sort_by', $node.sort_array,*}
        {*'class_filter_type', 'exclude',*}
        {*'class_filter_array', $classes,*}
        {*'limit', $page_limit ) ) as $child }*}
            {*{node_view_gui view='line' content_node=$child}*}
        {*{/foreach}*}
    {*{/if}*}
{*</div>*}

{*{include name=navigator*}
{*uri='design:navigator/google.tpl'*}
{*page_uri=$node.url_alias*}
{*item_count=$children_count*}
{*view_parameters=$view_parameters*}
{*item_limit=$page_limit}*}