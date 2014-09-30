{* Product - Full view *}

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<form method="post" action={"store/action"|ezurl}>
<div class="content-view-full">
    <div class="class-product">

        <div class="attribute-header">
        <h1>{$node.name|wash()}</h1>
        </div>
        
        {if $node.data_map.image.has_content}
        <div class="attribute-image">
            {attribute_view_gui image_class=medium attribute=$node.data_map.image}
            {if $node.data_map.caption.has_content}
            <div class="caption">
                {attribute_view_gui attribute=$node.data_map.caption}
            </div>
            {/if}
        </div>
        {/if}

        <div class="attribute-product-number">
           {attribute_view_gui attribute=$node.object.data_map.product_number}
        </div>

        <div class="attribute-short">
           {attribute_view_gui attribute=$node.object.data_map.short_description}
        </div>

        <div class="attribute-long">
           {attribute_view_gui attribute=$node.object.data_map.description}
        </div>

        <div class="attribute-price">
          {*<p>
           {attribute_view_gui attribute=$node.object.data_map.price}
          </p>*}
          <p id="price">{$node.object.data_map.price.content.price}</p>
          <noscript>У Вас не включен JavaScript.</noscript>
        </div>

        {*<div class="attribute-multi-options">
           {attribute_view_gui attribute=$node.object.data_map.additional_options}
        </div>*}
        
        {def $first = array()
        	$second = array()
        	$tmp = array()
        	$tmp2 = ""}
        {foreach $node.object.data_map.options.content.option_list as $v}
        	{set $tmp = $v.value|explode('-')}
        	{set $first = $first|append($tmp[0])}
        	{set $second = $second|append($tmp[1])}
        {/foreach}
        {set $tmp = array()}
        {set $first = $first|unique()}
        {set $second = $second|unique()}
        
        <script type="text/javascript">
            var options = [];
            var option = [];
            var price = {$node.object.data_map.price.content.price} || 0;
            {foreach $first as $key => $f}
                {foreach $node.object.data_map.options.content.option_list as $v}
                    {if $v.value|contains($f)}
                        {set $tmp2 = $v.value|explode('-')}
                        {*set $tmp = $tmp|merge(hash($tmp2[1], $v.additional_price))*}
                        option["{$tmp2[1]}"] = [{$v.id}, {$v.additional_price}];
                    {/if}
                {/foreach} 
                {* {set $firstMod = $firstMod|merge(hash($f, $tmp))} *}
                options["{$f}"] = option;
                var option = [];
                {set $tmp = array()}
            {/foreach}
        
            $(function() {ldelim}
                change();
                $('input[name="first"]').click(function(){ldelim}
                    change();
                {rdelim});
                $('input[name="second"]').click(function(){ldelim}
                    change();
                {rdelim});
            {rdelim});
        
            function change(){ldelim}
                var first   = $('input[name="first"]:checked').val();
                var second  = $('input[name="second"]:checked').val();
                $("#ezoption").val(options[first][second][0]);
                $("#price").html( (price+options[first][second][1]) + " руб");
            {rdelim}
        </script>
        
        <p>Как будем клеить?</p>
        {foreach $first as $key => $f}
            <div><label for="f{$key}">{$f}</label><input {if $key|not} checked="checked" {/if} type="radio" name="first" value="{$f}" id="f{$key}" /></div>
        {/foreach}
        
        <p>Что будем клеить?</p>
        {foreach $second as $key => $s}
            <div><label for="s{$key}">{$s}</label><input {if $key|not} checked="checked" {/if} type="radio" name="second" value="{$s}" id="s{$key}" /></div>
        {/foreach}
        
        <input type="hidden" id="ezoption" name="eZOption[{$node.object.data_map.options.id}]" value="" />
        
        {*attribute_view_gui attribute=$node.object.data_map.options*}

        {* Category. *}
        {*def $product_category_attribute=ezini( 'VATSettings', 'ProductCategoryAttribute', 'shop.ini' )}
        {if and( $product_category_attribute, is_set( $node.data_map.$product_category_attribute ) )}
        <div class="attribute-long">
          <p>Category:&nbsp;{attribute_view_gui attribute=$node.data_map.$product_category_attribute}</p>
        </div>
        {/if}
        {undef $product_category_attribute*}

        <div class="content-action">
            <input type="submit" class="defaultbutton" name="ActionAddToBasket" value="{"Add to basket"|i18n("design/ezwebin/full/product")}" />
            <input class="button" type="submit" name="ActionAddToWishList" value="{"Add to wish list"|i18n("design/ezwebin/full/product")}" />
            <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
            <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
            <input type="hidden" name="ViewMode" value="full" />
        </div>

       {* Related products. *}
       {def $related_purchase=fetch( 'shop', 'related_purchase', hash( 'contentobject_id', $node.object.id, 'limit', 10 ) )}
       {if $related_purchase}
        <div class="relatedorders">
            <h2>{'People who bought this also bought'|i18n( 'design/ezwebin/full/product' )}</h2>

            <ul>
            {foreach $related_purchase as $product}
                <li>{content_view_gui view=text_linked content_object=$product}</li>
            {/foreach}
            </ul>
        </div>
       {/if}
       {undef $related_purchase}
   </div>
</div>
</form>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>