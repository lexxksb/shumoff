{set-block scope=root variable=subject}{"Order"|i18n("design/standard/shop")}: {$order.order_nr}{/set-block}
<h1>{"Order"|i18n("design/standard/shop")}: {$order.order_nr}</h1>
<h3>{"Customer"|i18n("design/standard/shop")}</h3>
<table width="50%" cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td valign="top">
            <p>
                <b>{"Customer"|i18n("design/standard/shop")}</b>
            </p>
            <p>
                {'Name'|i18n('design/standard/shop')}: {$order.account_information.first_name} {$order.account_information.last_name}<br />
                {'Email'|i18n('design/standard/shop')}: {$order.account_information.email}<br />
            </p>
        </td>
        <td valign="top">
            <p>
                <b>{"Address"|i18n("design/standard/shop")}</b>
            </p>
            <p>
                {'Street'|i18n('design/standard/shop')}: {$order.account_information.street1}<br /> {'Zip'|i18n('design/standard/shop')}:
                {$order.account_information.zip}<br /> {'Place'|i18n('design/standard/shop')}: {$order.account_information.place}<br />
                {'State'|i18n('design/standard/shop')}: {$order.account_information.state}<br />
            </p>
        </td>
    </tr>
</table>
{if $order.account_information.comment}
<p>
    <b>{'Comment'|i18n( 'design/standard/shop' )}</b>
</p>
<p>{$order.account_information.comment|wash|nl2br}</p>
{/if}
<h3>{"Product items"|i18n("design/standard/shop")}</h3>
{def $currency = fetch( 'shop', 'currency', hash( 'code', $order.productcollection.currency_code ) ) 
    $locale = false() 
    $symbol = false()}
{if $currency} {set locale = $currency.locale symbol = $currency.symbol} {/if}
<table cellspacing="2" cellpadding="2" border="1" width="80%">
    <tr>
        <th>Товар</th>
        <th>Количество</th>
        <th>Цена</th>
        <th>Количество</th>
    </tr>
    {section name=ProductItem loop=$order.product_items show=$order.product_items}
    <tr>
        <td>{$ProductItem:item.object_name}</td>
        <td>{$ProductItem:item.item_count}</td>
        <td>{$ProductItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
        <td>{$ProductItem:item.total_price_inc_vat|l10n( 'currency', $locale, $symbol )}</td>
    </tr>
    {/section}
</table>
<p>
    {"Subtotal of items"|i18n("design/standard/shop")}: <b>{$order.product_total_inc_vat|l10n( 'currency', $locale, $symbol )}</b>
</p>
{section name=OrderItem loop=$order.order_items show=$order.order_items}
<p>
    {$OrderItem:item.description}: <b>{$OrderItem:item.price_inc_vat|l10n( 'currency', $locale, $symbol )}</b>
</p>
{/section}
<h3>
    {"Order total"|i18n("design/standard/shop")}: <b>{$order.total_inc_vat|l10n( 'currency', $locale, $symbol )}</b>
</h3>
{undef $currency $locale $symbol}
