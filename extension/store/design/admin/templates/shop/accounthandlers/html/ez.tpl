{* Name. *}
<div class="block">
<label>{'Name'|i18n( 'design/admin/shop/accounthandlers/html/ez' )}:</label>
{let customer_user=fetch( content, object, hash( object_id, $order.user_id ) )}
<a href={$customer_user.main_node.url_alias|ezurl}>{$order.account_information.first_name}&nbsp;{$order.account_information.last_name}</a>
{/let}
</div>

{* Email. *}
<div class="block">
<label>E-mail:</label>
<a href="mailto:{$order.account_information.email}">{$order.account_information.email}</a>
</div>

{* Address. *}
<div class="block">

<fieldset>
<legend>Платежная информация</legend>
<table class="list" cellspacing="0">
<tr>
    <td>Фио</td>
    <td>{$order.account_information.first_name}</td>
</tr>
<tr>
    <td>Телефон</td>
    <td>{$order.account_information.phone}</td>
</tr>
<tr>
    <td>Город</td>
    <td>{$order.account_information.place}</td>
</tr>
<tr>
    <td>{"Street"|i18n("design/ezwebin/shop/userregister")}</td>
    <td>{$order.account_information.street1}</td>
</tr>
<tr>
    <td>Доставка</td>
    <td>
        {ezini( concat($order.account_information.shipping,'Info'), 'name', 'store.ini' )}
    </td>
</tr>
<tr>
    <td>Оплата</td>
    <td>
        {ezini( concat($order.account_information.payment,'Info'), 'name', 'store.ini' )}
    </td>
</tr>
<tr>
    <td>Комментарий</td>
    <td>{$order.account_information.comment}</td>
</tr>
</table>
</fieldset>

</div>
