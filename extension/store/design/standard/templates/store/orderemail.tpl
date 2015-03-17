{set-block scope=root variable=subject}{"Order"|i18n("design/standard/shop")}: {$order.order_nr}{/set-block}
<h1>{"Order"|i18n("design/standard/shop")}: {$order.order_nr}</h1>

<table width="50%" cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td valign="top">
            <p><b>{"Customer"|i18n("design/standard/shop")}</b></p>
            <p>{'Name'|i18n('design/standard/shop')}: {$order.account_information.first_name|wash} {$order.account_information.last_name|wash}</p>
            <p>Телефон: {$order.account_information.phone|wash}</p>
            {if $order.account_information.email}
                <p>{'Email'|i18n('design/standard/shop')}: {$order.account_information.email|wash}</p>
            {/if}
        </td>
        <td valign="top">
            <p><b>{"Address"|i18n("design/standard/shop")}</b></p>
            <p>{'Place'|i18n('design/standard/shop')}: {$order.account_information.place|wash}</p>
            <p>{'Street'|i18n('design/standard/shop')}: {$order.account_information.street1|wash}</p>
        </td>
    </tr>
</table>
<p><b>Оплата:</b>&nbsp;{def $ident = concat($order.account_information.payment,'Info')}{ezini( $ident, 'name', 'store.ini' )}</p>
{if $order.account_information.comment}
    <p><b>{'Comment'|i18n( 'design/standard/shop' )}</b></p>
    <p>{$order.account_information.comment|wash|nl2br}</p>
{/if}

<h3>Товары</h3>

{def $itemObject = array()}
<table cellspacing="2" cellpadding="2" border="1" width="80%">
    <tr>
        <th>Товар</th>
        <th>Количество</th>
        <th>Цена</th>
        <th>Количество</th>
    </tr>

    {foreach $order.product_items as $item}
        <tr>
            <td>
                {set $itemObject = fetch( 'content', 'node', hash( 'node_id', $item.node_id ) )}
                {$itemObject.data_map.name.content|wash}
                {foreach $item.item_object.option_list as $option}
                    {$option.value}{delimiter}&nbsp;|&nbsp;{/delimiter}
                {/foreach}
            </td>
            <td>{$item.item_count|wash}</td>
            <td>{$item.price_inc_vat|l10n( 'currency' )} руб</td>
            <td>{$item.total_price_inc_vat|l10n( 'currency' )} руб</td>
        </tr>
    {/foreach}
</table>
<p>
    {"Subtotal of items"|i18n("design/standard/shop")}: <b>{$order.product_total_inc_vat|l10n( 'currency' )} руб</b>
</p>
    {section name=OrderItem loop=$order.order_items show=$order.order_items}
    <p>
        {$OrderItem:item.description}: <b>{$OrderItem:item.price_inc_vat|l10n( 'currency' )} руб</b>
    </p>
    {/section}
<h3>
    {"Order total"|i18n("design/standard/shop")}: <b>{$order.total_inc_vat|l10n( 'currency' )} руб</b>
</h3>
{undef $itemObject}