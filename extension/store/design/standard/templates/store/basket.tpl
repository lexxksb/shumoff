{set scope=global persistent_variable=hash(
    'meta_description', "",
    'site_title', "Корзина"
)}

<ul class="breadcrumb">
    <li><a href={"/"|ezurl}>Шумофф</a></li>
    <li class="active">Корзина</li>
</ul>

<h1 class="long">Корзина</h1>

{if $basket.items|count}

    {def $itemObject     = array()
        $shippingType   = ezini( 'Shipping', 'type', 'store.ini' )
        $ship           = cond(ezhttp( "shipping", "cookie" ), ezhttp( "shipping", "cookie" ), ezini( 'Shipping', 'default', 'store.ini' ))
        $paydef         = cond($payment, $payment, ezini( 'Payment', 'default', 'store.ini' ))
        $paymentType    = ezini( 'Payment', 'type', 'store.ini' )
    }

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

    <form method="post" action={"/store/basket/"|ezurl}>
        <table class="table basket" id="basket">
        <tbody><tr>
            <th>Наименование</th>
            <th>Цена, руб</th>
            <th>Количество</th>
            <th>Сумма, руб</th>
            <th>&nbsp;</th>
        </tr>
        {foreach $basket.items as $item}
            <tr>
                <td>
                    {set $itemObject = fetch( 'content', 'node', hash( 'node_id', $item.node_id ) )}
                    <input type="hidden" name="ProductItemIDList[]" value="{$item.id}" />
                    <div><a {if $itemObject.object.class_identifier|eq('material')}href={$itemObject.parent.url_alias|ezurl}{else}href={$itemObject.url_alias|ezurl}{/if}>{$itemObject.data_map.name.content|wash}</a></div>
                    {foreach $item.item_object.option_list as $option}
                        {$option.value}{delimiter}&nbsp;|&nbsp;{/delimiter}
                    {/foreach}
                </td>
                <td class="price">
                    {$item.price_inc_vat|l10n( 'currency' )}
                </td>
                <td class="quantity">
                    <div class="input-group">
                        <span data-type="dec" data-id="{$item.id}" class="input-group-addon">-</span>
                        <input type="text" id="count{$item.id}" class="form-control" name="ProductItemCountList[]" value="{$item.item_count}" aria-label="" />
                        <span data-type="inc" data-id="{$item.id}" class="input-group-addon">+</span>
                    </div>
                </td>
                <td class="cost">
                    {$item.total_price_inc_vat|l10n( 'currency' )}
                </td>
                <td>
                    <button class="remove" type="submit" name="RemoveProductItemButton" value="Удалить"><div class="icon-remove"></div></button>
                    <input type="hidden" disabled="disabled" name="RemoveProductItemDeleteList[]" value="{$item.id}" />
                </td>
            </tr>
        {/foreach}
        <tr>
            <td class="weight" colspan="2">
                {*Вес: 1,6кг*}
                Доставка: {$shipping_info.cost|l10n( 'currency' )}&nbsp;<span class="icon-ruble"></span>
            </td>
            <td class="count">Итого:</td>
            <td class="itemCost" colspan="2">
                <div class="cost">{$total_inc_shipping_inc_vat|l10n( 'currency' )}&nbsp;</div><div class="icon-ruble"></div>
                <div class="clearfix"></div>
                <button type="submit" name="StoreChangesButton">Пересчитать</button>
            </td>
        </tr>
        </tbody></table>
    </form>

    <div class="order">
        <div class="title">Оформить заказ</div>
        <div class="row">
            <form method="post" id="shipPaymentForm" action={"/store/basket/"|ezurl}>
                <div class="col-md-4" id="delivery">
                    <div class="rowTitle">Доставка</div>
                    {def $ident = "" $desc = ""}
                    {foreach $shippingType as $type}
                        {set $ident  = concat($type, 'Info')
                             $desc   = ezini($ident, 'description', 'store.ini' )}
                        <div class="radio">
                            <label for="{$type}">
                                <input type="radio" {if $ship|eq($type)} checked="checked" {/if} name="_shipping" value="{$type}" id="{$type}" >
                                <div class="name">{ezini( $ident, 'name', 'store.ini' )}</div>
                                {if $desc}
                                    <div class="icon-cHelp icon" data-toggle="tooltip" data-placement="right" title="" data-original-title="{$desc}"></div>
                                {/if}
                            </label>
                        </div>
                    {/foreach}
                    {undef $ident $desc}
                </div>
                <div class="col-md-4" id="pay">
                    <div class="rowTitle">Оплата</div>
                    {def $ident = "" $desc = ""}
                    {foreach $paymentType as $type}
                        {set $ident = concat($type,'Info')
                             $desc = ezini($ident, 'description', 'store.ini' )}
                        <div class="radio">
                            <label for="{$type}">
                                <input type="radio" {if $paydef|eq($type)} checked="checked" {/if} name="_payment" id="{$type}" value="{$type}">
                                <div class="name">{ezini( $ident, 'name', 'store.ini' )}</div>
                                {if $desc}
                                    <div class="icon-cHelp icon" data-toggle="tooltip" data-placement="right" title="" data-original-title="{$desc}"></div>
                                {/if}
                            </label>
                        </div>
                    {/foreach}
                    {undef $ident $desc}
                </div>
                <div class="col-md-4"></div>
            </form>
        </div>

        <form method="post" action={"/store/basket/"|ezurl}>

            <input type="hidden" value="{$ship}" name="shipping" />
            <input type="hidden" value="{$paydef}" name="payment" />

            <div class="rowTitle">Контактные данные</div>
            {if $input_error}
                <div class="alert alert-warning" role="alert">
                    Поля заполнены неверно. Все поля, отмеченные *, обязательны для заполнения.
                </div>
            {/if}
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label>Ваше имя *:</label>
                        <input type="text" name="FirstName" class="form-control" placeholder="Иванов Иван Иванович" value="{$first_name|wash}" required="required" >
                    </div>
                    <div class="form-group">
                        <label>Телефон *:</label>
                        <input type="tel" name="phone" class="form-control" placeholder="" value="{$phone|wash}" required="required" >
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="EMail" class="form-control" placeholder="Email" value="{$email|wash}">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Город *:</label>
                        <input type="text" name="Place" class="form-control" placeholder="г. Екатеринбург" value="{$place|wash}" required="required" >
                    </div>
                    <div class="form-group">
                        <label>Адрес доставки *:</label>
                        <input type="text" name="Street1" class="form-control" placeholder="ул. Первомайская 5-300" value="{$street1|wash}" required="required" >
                    </div>
                    <div class="form-group">
                        <label>Комментарий к заказу:</label>
                        <textarea class="form-control" name="Comment" rows="5">{$comment|wash}</textarea>
                    </div>
                </div>
                <div class="col-md-2"></div>
            </div>

            <button type="submit" class="btn btn-shumoff" name="CheckoutButton" id="CheckoutButton">Купить</button>
        </form>
    </div>
    {undef $itemObject $shippingType $ship $paydef $paymentType}
{else}
    <p>Корзина пуста</p>
{/if}