{def
    $doors  = fetch( 'content', 'node', hash( 'node_id', 108 ) )
    $flour  = fetch( 'content', 'node', hash( 'node_id', 113 ) )
    $engine = fetch( 'content', 'node', hash( 'node_id', 136 ) )
    $hood   = fetch( 'content', 'node', hash( 'node_id', 137 ) )
    $roof   = fetch( 'content', 'node', hash( 'node_id', 135 ) )
    $payments = fetch( 'content', 'node', hash( 'node_id', 68 ) )
}

<div class="facade">
    <div class="relative">
        <div class="car">
            <div class="relative">
                <div class="roof">
                    <a href={$roof.url_alias|ezurl}>{$roof.data_map.mainpagetext.content|wash}</a>
                    <div>от <span class="price">{$roof.data_map.price.content.price|l10n("currency")}&nbsp;<span class="icon-ruble"></span></span></div>
                </div>
                <div class="doors">
                    <a href={$doors.url_alias|ezurl}>{$doors.data_map.mainpagetext.content|wash}</a>
                    <div>от <span class="price">{$doors.data_map.price.content.price|l10n("currency")}&nbsp;<span class="icon-ruble"></span></span></div>
                </div>
                <div class="engine">
                    <a href={$engine.url_alias|ezurl}>{$engine.data_map.mainpagetext.content|wash}</a>
                    <div>от <span class="price">{$engine.data_map.price.content.price|l10n("currency")}&nbsp;<span class="icon-ruble"></span></span></div>
                </div>
                <div class="hood">
                    <a href={$hood.url_alias|ezurl}>{$hood.data_map.mainpagetext.content|wash}</a>
                    <div>от <span class="price">{$hood.data_map.price.content.price|l10n("currency")}&nbsp;<span class="icon-ruble"></span></span></div>
                </div>
                <div class="floor">
                    <a href={$flour.url_alias|ezurl}>{$flour.data_map.mainpagetext.content|wash}</a>
                    <div>от <span class="price">{$flour.data_map.price.content.price|l10n("currency")}&nbsp;<span class="icon-ruble"></span></span></div>
                </div>
            </div>
        </div>
    </div>

    <div class="relative">
        <div class="info">
            {def $freeShipSumm = ezini( 'General', 'freeShipSumm', 'store.ini' )}
            {if $freeShipSumm}
                <div class="freeDelivery">
                    <div class="icon-freeDelivery"></div><div class="text">Бесплатная доставка по Екатеринбургу от {$freeShipSumm} руб.</div>
                </div>
            {/if}
            <div class="delivery">
                <div class="icon-delivery"></div>
                <div class="text">Доставка по России</div>
            </div>
            <div class="payment">
                <div class="icon-payment"></div>
                <div class="text">
                    <div>Удобные способы оплаты:</div><div class="icon-payTypes"></div>
                    <div><a href={$payments.url_alias|ezurl}>Подробнее</a></div>
                </div>
            </div>
            <div class="help">
                <div class="icon-help"></div>
                <div class="text">
                    Нужна консультация? Звоните:<div class="tel">{$contacts.data_map.tel.content|wash}</div>
                    <div><a href={$contacts.url_alias|ezurl}>Подробнее</a></div>
                </div>
            </div>
        </div>
    </div>

    <div class="slogan">
        {if $module_result.content_info.persistent_variable.metaheader}
            <h1>{$module_result.content_info.persistent_variable.metaheader|wash}</h1>
        {/if}
        {if $module_result.content_info.persistent_variable.textheader}
            <div class="t2">{attribute_view_gui attribute=$module_result.content_info.persistent_variable.textheader}</div>
        {/if}
    </div>
</div>
{undef $doors $flour $engine $hood $roof $payments}