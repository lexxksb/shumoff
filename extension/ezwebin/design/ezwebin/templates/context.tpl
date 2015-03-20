{if and(is_set($module_result.node_id), $module_result.node_id|ne(2))}

    <div class="context">
        {if $module_result.content_info.persistent_variable.contextBlock1}
        <div class="row promoBlock2">
            <div class="col-md-4">
                <div class="infoBlock">
                    <div class="title"><div class="icon-help icon"></div>Нужна консультация?</div>
                    <div class="_cont">
                        <div class="media">
                            {if $pagedesign.data_map.directorfoto.has_content}
                                <div class="media-left">
                                    {attribute_view_gui href=$contacts.url_alias|ezurl attribute=$pagedesign.data_map.directorfoto image_class=review}
                                </div>
                            {/if}
                            <div class="media-body">
                                {if $pagedesign.data_map.directorname.has_content}
                                    <div class="text1">{$pagedesign.data_map.directorname.content|wash},<br><span>директор Шумофф - Екатеринбург</span></div>
                                {/if}
                                {if $pagedesign.data_map.tel.has_content}
                                    <div class="telephone">Мы всегда готовы помочь Вам:<br><span>{$pagedesign.data_map.tel.content|wash}</span></div>
                                {/if}
                            </div>
                        </div>
                        <div class="all"><a href={$contacts.url_alias|ezurl}>Все контакты</a></div>
                    </div>
                </div>
            </div>
            {* TODO сделать рандомную смену на блок с уст. центром *}
            <div class="col-md-4">
                <div class="infoBlock">
                    <div class="title"><div class="icon-himself icon"></div>Сделай сам</div>
                    {if $himselfNodes|count()}
                        <div class="_cont">
                            <ul>
                                {foreach $himselfNodes as $node}
                                    <li><a href={$node.url_alias|ezurl}>{$node.name|wash}</a></li>
                                {/foreach}
                            </ul>
                            <div class="all"><a href={$himselfNodes[0].parent.url_alias|ezurl}>Все инструкции</a></div>
                        </div>
                    {/if}
                </div>
            </div>
            <div class="col-md-4">
                <div class="infoBlock">
                    <div class="title"><div class="icon-review icon"></div>Отзывы</div>
                    {if $reviewNodes|count()}
                        <div class="_cont review">
                            <div>{$reviewNodes[0].data_map.name.content|wash}:</div>
                            {attribute_view_gui attribute=$reviewNodes[0].data_map.review}
                            <div class="all"><a href={$reviewNodes[0].parent.url_alias|ezurl}>Все отзывы</a></div>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
        {/if}

        {if $module_result.content_info.persistent_variable.contextBlock2}
            <div class="row promoBlock1">
                <div class="col-md-6 b1">
                    <div class="title">Купите прямо сейчас</div>

                    {def $kit = array()}
                    {if is_set($module_result.content_info.persistent_variable.contextKit)}
                        {set $kit = $module_result.content_info.persistent_variable.contextKit.content.main_node}
                    {else}
                        {set $kit = $pagedesign.data_map.komplekt.content.main_node}
                    {/if}

                    <div class="border">
                        <a class="title" href={$kit.url_alias|ezurl}>{$kit.data_map.name.content|wash}</a>
                        {attribute_view_gui attribute=$kit.data_map.short_description}
                        <div class="priceBlock"><span class="from">от</span>&nbsp;{$kit.data_map.price.content.price|l10n('currency')}&nbsp;<span class="icon-ruble"></span></div>
                    </div>
                    {undef $kit}
                </div>
                <div class="col-md-6 b2">
                    <div class="title">Доверьте профессионалам</div>
                    <div class="border media">
                        <div class="media-left">
                            {if $contacts.object.data_map.address.has_content}
                                <script src="http://api-maps.yandex.ru/2.1/?lang=ru_RU" type="text/javascript"></script>
                                <div class="map" id="map" style="width: 280px;height: 220px;" data-address="{$contacts.data_map.address.content|wash}" data-zoom="14"></div>
                            {/if}
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading"><a href={$contacts.url_alias|ezurl}>{$contacts.data_map.headercenter.content|wash}</a></h4>
                            {attribute_view_gui attribute=$contacts.data_map.textcenter}
                        </div>
                    </div>
                </div>
            </div>
        {/if}

    </div>
{/if}