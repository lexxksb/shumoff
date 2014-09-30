{def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) )
         $locale = false()
         $symbol = false()
         $order_info = $order.order_info}

{if $currency}
    {set locale = $currency.locale
         symbol = $currency.symbol}
{/if}

<div class="grid_8">
  <div class="shop">
		<div class="attribute-header">
			<h1 class="long">{"Payment"|i18n("web/default")}</h1>
		</div>

    {include uri='design:shop/navigator.tpl' stage=4}

		<form id="payment-form" action={"shop/checkout"|ezurl} method="POST" class="form">

			{if ezini('PaymillSettings','IsTestOrLive','ezpaymill.ini')|eq('TEST')}

				{* Creditcard numbers valid for testing as stated here: https://www.paymill.com/en-gb/documentation-3/reference/testing/ *}
				Visa:     4111111111111111
				<br/>
				Mastercard:   5500000000000004
				<br/>
				Mit 3-D Secure:
				<br/>
				Visa:    4012888888881881
				<br/>
				<br/>

			{/if}

			{def $payment=''}
		
			<div class="payment-errors"></div>

			<div class="form-row">

				{* the $order_total_inc_vat is EUR 1,00 so we have to multiply it with 100 to send Euro-Cents to paymill -> 1 EUR = 100 Cents *}
				<input class="card-amount-int" name="amount" type="hidden" size="20" value="{$order_total_inc_vat|mul(100)}"/>
				<input class="card-currency" type="hidden" size="20" value="EUR"/>
			
			</div>
			
			<input name="order_id" class="order_id" type="hidden" size="20" value="{$order_id}"/>
			
			<fieldset>
				<legend>{"Total"|i18n("extension/paymill")}</legend>

				{def $shipping=0}
				{if is_set( $order.order_info.additional_info )}
					{foreach $order.order_info.additional_info as $item}
						{set $shipping=$shipping|sum($item.total.total_price_inc_vat)}
					{/foreach}
				{/if}

				{* Here a node with some description text is fetched and displayed *}
				{def $text_node=fetch('content','node',hash('node_id', cond( $shipping|gt(0), 1576, 1577 ) ) )}
				{attribute_view_gui attribute=$text_node.data_map.inputtext}<br/>
				<div class="txtcenter font24"><strong>{$order_total_inc_vat|l10n( 'currency', $locale, $symbol )}</strong></div>
			</fieldset>
			
			<fieldset>
		    <legend>{"Card information"|i18n("extension/paymill")}</legend>       
		  
		    <div class="pb1em">
		        <label>{"Card number"|i18n("extension/paymill")}: <span class="required">*</span></label>
		      <div class="input"><input class="halfbox card-number" type="text" size="20" value="" /></div>
		    </div>

		    <div class="pb1em">
		        <label>{"CVC"|i18n("extension/paymill")}: <span class="required">*</span></label>
		      <div class="input"><input class="halfbox card-cvc" type="text" size="4" value="" /></div>
		    </div>

		    <div class="pb1em">
		        <label>{"Name"|i18n("extension/paymill")}: <span class="required">*</span></label>
		      <div class="input"><input class="halfbox card-holdername" type="text" value="" /></div>
		    </div>

		    <div class="pb1em">
		        <label>{"Expiry date (MM/YYYY)"|i18n("extension/paymill")}: <span class="required">*</span></label>
		      <div class="input">
						<input class="card-expiry-month" type="text" size="2" value="" style="width:50px"  />
				    /
				    <input class="card-expiry-year" type="text" size="4" value="" style="width:100px" />
		      </div>
		    </div>

		  </fieldset>
			<div class="right">
				<button class="submit-button btn " type="submit">{"Pay now"|i18n('extension/paymill')}</button>
			</div>
			<div class="font12">
				<p>{"This info is encrypted and sent directly to Paymill's servers to bill your card. I do not store it or even read it on my own server."|i18n('extension/paymill')}
			</div>
		</form>
	</div>
</div>
