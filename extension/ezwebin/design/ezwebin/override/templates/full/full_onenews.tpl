{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash,
    'contextBlock1', false(),
    'contextBlock2', false()
)}
<h1>{$node.data_map.name.content|wash()}</h1>

<div class="date">{$node.data_map.date.content.timestamp|l10n( 'date' )}</div>

<div class="row">
    {if $node.data_map.image.has_content}
    <div class="col-md-4">
        {attribute_view_gui css_class="img-responsive" attribute=$node.data_map.image image_class=onenews}
    </div>
    {/if}
    <div class="{if $node.data_map.image.has_content}col-md-8{else}col-md-12{/if}">
        {attribute_view_gui attribute=$node.data_map.description}
    </div>
</div>

<p><a href={$node.parent.url_alias|ezurl}>Вернуться ко всем новостям</a></p>

{def $related = array()}
{if $node.data_map.other.has_content}
<div class="otherNews">
    <div class="title">Другие новости и акции</div>
    {foreach $node.data_map.other.content.relation_list as $child}
        {set $related = fetch( 'content', 'node', hash( 'node_id', $child.node_id ) )}
        {node_view_gui view='line' content_node=$related}
    {/foreach}
</div>
{/if}
{undef $related}