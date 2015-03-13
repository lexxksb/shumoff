{if $module_result.node_id|eq(2)}
<div class="facade">
    <div class="relative">
        <div class="car">
            <div class="relative">
                <div class="roof">
                    <a href="">Комплект для крыши</a>
                    <div>от <span class="price">1 400 <span class="icon-ruble"></span></span></div>
                </div>
                <div class="doors">
                    <a href="">Комплект для дверей</a>
                    <div>от <span class="price">1 400 <span class="icon-ruble"></span></span></div>
                </div>
                <div class="engine">
                    <a href="">Комплект для моторного отсека</a>
                    <div>от <span class="price">1 400 <span class="icon-ruble"></span></span></div>
                </div>
                <div class="hood">
                    <a href="">Комплект для капота</a>
                    <div>от <span class="price">1 400 <span class="icon-ruble"></span></span></div>
                </div>
                <div class="floor">
                    <a href="">Комплект для пола</a>
                    <div>от <span class="price">1 400 <span class="icon-ruble"></span></span></div>
                </div>
            </div>
        </div>
    </div>

    <div class="relative">
        <div class="info">
            <div class="freeDelivery">
                <div class="icon-freeDelivery"></div>
                <div class="text">Бесплатная доставка по Екатеринбургу от 1000 руб.</div>
            </div>
            <div class="delivery">
                <div class="icon-delivery"></div>
                <div class="text">Доставка по России</div>
            </div>
            <div class="payment">
                <div class="icon-payment"></div>
                <div class="text">
                    Удобные способы оплаты:<br><div class="icon-payTypes"></div>
                    <div><a href="">Подробнее</a></div>
                </div>
            </div>
            <div class="help">
                <div class="icon-help"></div>
                <div class="text">
                    Нужна консультация? Звоните:<div class="tel">+7 (343) 201-16-56</div>
                    <div><a href="">Подробнее</a></div>
                </div>
            </div>
        </div>
    </div>

    <div class="slogan">
        {if $module_result.content_info.persistent_variable.metaheader}
            <h1>{$module_result.content_info.persistent_variable.metaheader|wash}</h1>
        {/if}
        {if $module_result.content_info.persistent_variable.textheader}
            <div class="t2">
                {attribute_view_gui attribute=$module_result.content_info.persistent_variable.textheader}
            </div>
        {/if}
    </div>
</div>
{/if}