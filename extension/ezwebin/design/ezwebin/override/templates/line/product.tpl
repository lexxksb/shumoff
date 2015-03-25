<div class="block">
    <a href={$node.url_alias|ezurl}>{$node.data_map.name.content|wash}</a>
    {attribute_view_gui attribute=$node.object.data_map.short_description}
    {if $node.object.data_map.price.content.price}
        <div class="priceBlock"><span class="from">от</span>&nbsp;{$node.object.data_map.price.content.price|l10n( 'number' )}&nbsp;<span class="icon-ruble"></span></div>
    {/if}
</div>