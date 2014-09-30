<div class="block">
{$attribute.content.name}
</div>
{def $defvalue = ""
    $defprice = 0}
{literal}
<script>
	function reCount(elem, key){
		var price = 0;
		$( '#label'+key+'value' ).val($(elem).val());
	    $( "#blockPrice input:checked" ).each(function( index ) {
	    	price += parseInt($(this).attr("data-price"));
	    });
	    $( "#price" ).text(price+" p");
	}
</script>
{/literal}    
{foreach  $attribute.content.multioption_list as $key => $multioptions}
<div class="block" id="blockPrice">
    <p>{$multioptions.name}:</p>
    {foreach $multioptions.optionlist as $index => $option}
    <div>
        <label for="label{$option.id}">{$option.value}-{$option.additional_price|l10n( currency )}</label>
        <input type="radio" onclick="reCount(this, {$key})" data-price="{$option.additional_price}"
            {if eq( sum( $index, 1 ), $multioptions.default_option_id)}checked="checked"{set $defvalue=$option.option_id}
            {set $defprice = $defprice|sum($option.additional_price)}{/if} 
            name="eZOption{$key}" id="label{$option.id}" value="{$option.option_id}" />
    </div>        
    {/foreach}
    <input type="hidden" name="eZOption[{$attribute.id}][]" id="label{$key}value" value="{$defvalue}" />
    {*<select name="eZOption[{$attribute.id}][]">
    {foreach $multioptions.optionlist as $index => $option}
            {if ne( $option.additional_price, '' )}
                {if eq( sum( $index, 1 ), $multioptions.default_option_id )}
                    <option value="{$option.option_id}" selected="selected">{$option.value}-{$option.additional_price|l10n( currency )}</option>
                {else}
                    <option value="{$option.option_id}">{$option.value}-{$option.additional_price|l10n( currency )}</option>
                {/if}
            {else}
                {if eq( sum( $index, 1 ), $multioptions.default_option_id)}
                    <option value="{$option.option_id}" selected="selected">{$option.value}</option>
                {else}
                    <option value="{$option.option_id}">{$option.value}</option>
                {/if}
            {/if}
        {/foreach}
    </select>*}
</div>
{/foreach}
<p>Цена <span id="price">{$defprice|l10n( currency )}</span></p>
