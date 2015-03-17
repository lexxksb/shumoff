
<h1>Заказ № {$order.order_nr} оформлен</h1>

<p>Спасибо за Ваш выбор</p>

<table class="table orderviewTable">
    <tr>
        <td>
            Товаров на сумму:
        </td>
        <td>
            <div class="priceBlock">{$order.product_total_inc_vat|l10n( 'currency' )}&nbsp;<span class="icon-ruble"></span></div>
        </td>
    </tr>
    {if $order.order_items|count()}
        {foreach $order.order_items as $order_item sequence}
            <tr>
                <td>
                    Доставка: {$order_item.description}
                </td>
                <td>
                    <div class="priceBlock">{$order_item.price_inc_vat|l10n( 'currency' )}&nbsp;<span class="icon-ruble"></span></div>
                </td>
            </tr>
        {/foreach}
    {/if}
    <tr>
        <td>
            Итого:
        </td>
        <td>
            <div class="priceBlock">{$order.total_inc_vat|l10n( 'currency' )}&nbsp;<span class="icon-ruble"></span></div>
        </td>
    </tr>
</table>