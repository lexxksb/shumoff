<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-basket">

<ul>
    <li class="selected">1. {"Shopping basket"|i18n("design/ezwebin/shop/basket")}</li>
    <li>2. {"Account information"|i18n("design/ezwebin/shop/basket")}
</li>
    <li>3. {"Confirm order"|i18n("design/ezwebin/shop/basket")}</li>
</ul>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">

<div class="shop-basket">

<form method="post" action={"/store/basket/"|ezurl}>

<div class="attribute-header">
    <h1 class="long">{"Basket"|i18n("design/ezwebin/shop/basket")}</h1>
</div>
{section show=$removed_items}
<div class="warning">
    <h2>{"The following items were removed from your basket because the products were changed."|i18n("design/ezwebin/shop/basket",,)}</h2>
    <ul>
    {section name=RemovedItem loop=$removed_items}
        <li> <a href={concat("/content/view/full/",$RemovedItem:item.contentobject.main_node_id,"/")|ezurl}>{$RemovedItem:item.contentobject.name|wash}</a></li>
    {/section}
    </ul>
</div>
{/section}

{if not( $vat_is_known )}
<div class="message-warning">
<h2>{'VAT is unknown'|i18n( 'design/ezwebin/shop/basket' )}</h2>
{'VAT percentage is not yet known for some of the items being purchased.'|i18n( 'design/ezwebin/shop/basket' )}<br/>
{'This probably means that some information about you is not yet available and will be obtained during checkout.'|i18n( 'design/ezwebin/shop/basket' )}
</div>
{/if}

{section show=$error}
<div class="error">
{section show=$error|eq(1)}
<h2>{"Attempted to add object without price to basket."|i18n("design/ezwebin/shop/basket",,)}</h2>
{/section}
</div>
{/section}

{section show=$error}
<div class="error">
{section show=eq($error, "aborted")}
<h2>{"Your payment was aborted."|i18n("design/ezwebin/shop/basket",,)}</h2>
{/section}
</div>
{/section}


    {def $currency = fetch( 'shop', 'currency', hash( 'code', $basket.productcollection.currency_code ) )
         $locale = false()
         $symbol = false()}
    {if $currency}
        {set locale = $currency.locale
             symbol = $currency.symbol}
    {/if}

    {section name=Basket show=$basket.items}


<table class="list"  width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
    <th>
    {"Count"|i18n("design/ezwebin/shop/basket")}
    </th>
    <th>
    {"VAT"|i18n("design/ezwebin/shop/basket")}
    </th>
    <th>
    {"Price inc. VAT"|i18n("design/ezwebin/shop/basket")}
    </th>
    <th>
    {"Discount"|i18n("design/ezwebin/shop/basket")}
    </th>
    <th>
    {"Total price ex. VAT"|i18n("design/ezwebin/shop/basket")}
    </th>
    <th>
    {"Total price inc. VAT"|i18n("design/ezwebin/shop/basket")}
    </th>
    <th>&nbsp;
    </th>
</tr>
{section name=ProductItem loop=$basket.items sequence=array(bgdark, bglight)}
<tr class="bglight">
    <td colspan="7"><input type="hidden" name="ProductItemIDList[]" value="{$Basket:ProductItem:item.id}" />
    {*{$Basket:ProductItem:item.id}-*}
    <a href={concat("/content/view/full/",$Basket:ProductItem:item.node_id,"/")|ezurl}>{$Basket:ProductItem:item.object_name}</a></td>
</tr>
<tr class="bgdark">
    <td>
    <input type="text" name="ProductItemCountList[]" value="{$Basket:ProductItem:item.item_count}" size="5" />
    </td>
    <td>
    {if ne( $Basket:ProductItem:item.vat_value, -1 )}
        {$Basket:ProductItem:item.vat_value} %
    {else}
        {'Unknown'|i18n( 'design/ezwebin/shop/basket' )}
    {/if}
    </td>
    <td>
    {$Basket:ProductItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
    <td>
    {$Basket:ProductItem:item.discount_percent}%
    </td>
    <td>
    {$Basket:ProductItem:item.total_price_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
    <td>
    {$Basket:ProductItem:item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
    <td>
    <input type="checkbox" name="RemoveProductItemDeleteList[]" value="{$Basket:ProductItem:item.id}" />
    </td>
</tr>
<tr class="bglight">
    <td colspan="6"><input class="button" type="submit" name="StoreChangesButton" value="{'Update'|i18n('design/ezwebin/shop/basket')}" /></td>
    <td colspan="1"><input class="button" type="submit" name="RemoveProductItemButton" value="{'Remove'|i18n('design/ezwebin/shop/basket')}" /> </td>
</tr>
{section show=$Basket:ProductItem:item.item_object.option_list}
<tr>
  <td colspan="7" style="padding: 0;">
     <table cellpadding="0" cellspacing="0">
<tr>
<td colspan="3">
{"Selected options"|i18n("design/ezwebin/shop/basket")}
</td>
</tr>
     {section name=Options loop=$Basket:ProductItem:item.item_object.option_list sequence=array(bglight, bgdark)}
      <tr>
        <td width="33%">{$Basket:ProductItem:Options:item.name}</td>
        <td width="33%">{$Basket:ProductItem:Options:item.value}</td>
        <td width="33%">{$Basket:ProductItem:Options:item.price|l10n( 'currency', $locale, $symbol )}</td>
      </tr>
    {/section}
     </table>
   </td>
</tr>
{/section}
{/section}
<tr>
     <td colspan="7">
     <hr size='2' />
     </td>
</tr>

<tr>
	<td colspan="10">
	
	{def $shippingType = ezini( 'Shipping', 'type', 'store.ini' )}
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script type="text/javascript">
		{literal}
		function setcookie(name, value, expires, path, domain, secure) {	// Send a cookie
			expires instanceof Date ? expires = expires.toGMTString() : typeof(expires) == 'number' && (expires = (new Date(+(new Date) + expires * 1e3)).toGMTString());
			var r = [name + "=" + escape(value)], s, i;
			for(i in s = {expires: expires, path: path, domain: domain}){
				s[i] && r.push(i + "=" + s[i]);
			}
			return secure && r.push("secure"), document.cookie = r.join(";"), true;
		}
		{/literal}
		$(function() {ldelim}
		{foreach $shippingType as $type}
		    $("#{$type}").click(function() {ldelim}
		    	setcookie("shipping", $(this).val(), null, "/");
				$("#CheckoutButton").click();
		    {rdelim});
	    {/foreach}
	    {rdelim});
	</script>
	{if ezhttp( "shipping", "cookie" )}
		{def $ship = ezhttp( "shipping", "cookie" )}
	{else}
		{def $ship = ezini( 'Shipping', 'default', 'store.ini' )}
	{/if}
	{foreach $shippingType as $type}
		{def $ident = concat($type,'info')}
		{def $shipname = ezini( $ident, 'name', 'store.ini' )}
		<label for="{$type}">{$shipname}</label>
		<input type="radio" {if $ship|eq($type)} checked="checked" {/if} name="shipping" id="{$type}" value="{$type}" />
	{/foreach}
	
	</td>
</tr>

<tr>
	<td>
		{if $payment}
			{def $paydef = $payment}
		{else}
			{def $paydef = ezini( 'Payment', 'default', 'store.ini' )}
		{/if}
		{def $paymentType = ezini( 'Payment', 'type', 'store.ini' )}
		{foreach $paymentType as $type}
			{def $ident = concat($type,'info')}
			{def $payname = ezini( $ident, 'name', 'store.ini' )}
			<label for="{$type}">{$payname}</label>
			<input type="radio" {if $paydef|eq($type)} checked="checked" {/if} name="payment" id="{$type}" value="{$type}" />
		{/foreach}
	</td>
</tr>

<tr>
	<td colspan="10">
	
	{section show=$input_error}
	<div class="warning">
		<p>
		{"Input did not validate. All fields marked with * must be filled in."|i18n("design/ezwebin/shop/userregister")}
		</p>
	</div>
	{/section}
	
	<div class="block">
	    <div class="element">
	    <label>
	    {"First name"|i18n("design/ezwebin/shop/userregister")}:*
	    </label><div class="labelbreak"></div>
	    <input class="halfbox" type="text" name="FirstName" size="20" value="{$first_name|wash}" />
	    </div>
	    <div class="element">
	    <label>
	    {"Last name"|i18n("design/ezwebin/shop/userregister")}:*
	    </label><div class="labelbreak"></div>
	    <input class="halfbox" type="text" name="LastName" size="20" value="{$last_name|wash}" />
	    </div>
	    <div class="break"></div>
	</div>
	<br />
	<div class="block">
	<label>
	Email:*
	</label><div class="labelbreak"></div>
	<input class="box" type="text" name="EMail" size="20" value="{$email|wash}" />
	</div>
	
	<div class="block">
	<label>
	Телефон:
	</label><div class="labelbreak"></div>
	<input class="box" type="text" name="phone" size="20" value="{$phone|wash}" />
	</div>
	
	<div class="block">
	<label>
	{"Street"|i18n("design/ezwebin/shop/userregister")}:*
	</label><div class="labelbreak"></div>
	<input class="box" type="text" name="Street1" size="20" value="{$street1|wash}" />
	</div>
	
	<div class="block">
	    <div class="element">
	    <label>
	    Индекс:*
	    </label><div class="labelbreak"></div>
	    <input class="halfbox" type="text" name="Zip" size="20" value="{$zip|wash}" />
	    </div>
	    <div class="element">
	    <label>
	    Город:*
	    </label><div class="labelbreak"></div>
	    <input class="halfbox" type="text" name="Place" size="20" value="{$place|wash}" />
	    </div>
	    <div class="break"></div>
	</div>
	<br/>
	<div class="block">
	<label>
	Область/Край/АО/Республика:
	</label><div class="labelbreak"></div>
	<input class="box" type="text" name="State" size="20" value="{$state|wash}" />
	</div>
	
	<div class="block">
	<label>
	{"Comment"|i18n("design/ezwebin/shop/userregister")}:
	</label><div class="labelbreak"></div>
	<textarea name="Comment" cols="80" rows="5">{$comment|wash}</textarea>
	</div>
	
	</td>
</tr>


<tr>
     <td colspan="5">
     </td>
     <td>
     <strong>{"Subtotal ex. VAT"|i18n("design/ezwebin/shop/basket")}</strong>:
     </td>
     <td>
     <strong>{"Subtotal inc. VAT"|i18n("design/ezwebin/shop/basket")}</strong>:
     </td>
</tr>
<tr>
    <td colspan="5">
    </td>
    <td>
        {$basket.total_ex_vat|l10n( 'currency', $locale, $symbol )}
    </td>
    <td>
    {$basket.total_inc_vat|l10n( 'currency', $locale, $symbol )}
    </td>
</tr>
{if is_set( $shipping_info )}
{* Show shipping type/cost. *}
<tr>
     <td colspan="5">
     <a href={$shipping_info.management_link|ezurl}>{'Shipping'|i18n( 'design/ezwebin/shop/basket' )}{if $shipping_info.description} ({$shipping_info.description}){/if}</a>:
     </td>
     <td>
     {$shipping_info.cost|l10n( 'currency', $locale, $symbol )}:
     </td>
     <td>
     {$shipping_info.cost|l10n( 'currency', $locale, $symbol )}:
     </td>
</tr>
{* Show order total *}
<tr>
     <td colspan="5">
     <strong>{'Order total'|i18n( 'design/ezwebin/shop/basket' )}</strong>:
     </td>
     <td>
     <strong>{$total_inc_shipping_ex_vat|l10n( 'currency', $locale, $symbol )}</strong>
     </td>
     <td>
     <strong>{$total_inc_shipping_inc_vat|l10n( 'currency', $locale, $symbol )}</strong>
     </td>
</tr>
{/if}

</table>

<div class="buttonblock">
<input class="button" type="submit" name="ContinueShoppingButton" value="{'Continue shopping'|i18n('design/ezwebin/shop/basket')}" />
<input class="button" type="submit" name="CheckoutButton" id="CheckoutButton" value="{'Checkout'|i18n('design/ezwebin/shop/basket')}" /> &nbsp;
</div>

{undef $currency $locale $symbol}

{section-else}

<div class="feedback">
<h2>{"You have no products in your basket."|i18n("design/ezwebin/shop/basket")}</h2>
</div>

{/section}

</form>

</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>