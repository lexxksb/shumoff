{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash
)}

<h1>{$node.data_map.name.content|wash}</h1>

{attribute_view_gui attribute=$node.object.data_map.short_description}

<ul class="flexBlock itemMaterials">
    <li>
        <div class="block">
            <div class="title">Шумофф М1.2</div>
            <img class="img-responsive" src="http://placehold.it/232x165" alt="...">
            <div class="price">
                <div class="text">Цена:</div>
                <div class="priceBlock">50 <span class="icon-ruble"></span><span class="from">/лист</span></div>
            </div>
            <div class="count">
                <div class="text">Количество:</div>
                <div class="input-group">
                    <span class="input-group-addon">-</span>
                    <input type="text" class="form-control" value="259" aria-label="Amount (to the nearest dollar)">
                    <span class="input-group-addon">+</span>
                </div>
            </div>
            <div class="add">
                <div class="notAvailable">Нет в наличии</div>
            </div>
        </div>
    </li>
    <li>
        <div class="block">
            <div class="title">Шумофф М2</div>
            <img class="img-responsive" src="http://placehold.it/232x165" alt="...">
            <div class="price">
                <div class="text">Цена:</div>
                <div class="priceBlock">50 <span class="icon-ruble"></span><span class="from">/лист</span></div>
            </div>
            <div class="count">
                <div class="text">Количество:</div>
                <div class="input-group">
                    <span class="input-group-addon">-</span>
                    <input type="text" class="form-control" value="259" aria-label="Amount (to the nearest dollar)">
                    <span class="input-group-addon">+</span>
                </div>
            </div>
            <div class="add">
                <button class="btn btn-shumoff toBasket cboxElement"><div class="icon-basket"></div>Добавить в корзину</button>
            </div>
        </div>
    </li>
    <li>
        <div class="block">
            <div class="title">Шумофф М1.2</div>
            <img class="img-responsive" src="http://placehold.it/232x165" alt="...">
            <div class="price">
                <div class="text">Цена:</div>
                <div class="priceBlock">50 <span class="icon-ruble"></span><span class="from">/лист</span></div>
            </div>
            <div class="count">
                <div class="text">Количество:</div>
                <div class="input-group">
                    <span class="input-group-addon">-</span>
                    <input type="text" class="form-control" value="259" aria-label="Amount (to the nearest dollar)">
                    <span class="input-group-addon">+</span>
                </div>
            </div>
            <div class="add">
                <button class="btn btn-shumoff toBasket cboxElement"><div class="icon-basket"></div>Добавить в корзину</button>
            </div>
        </div>
    </li>
    <li>
        <div class="block">
            <div class="title">Шумофф М1.2.</div>
            <img class="img-responsive" src="http://placehold.it/232x165" alt="...">
            <div class="price">
                <div class="text">Цена:</div>
                <div class="priceBlock">50 <span class="icon-ruble"></span><span class="from">/лист</span></div>
            </div>
            <div class="count">
                <div class="text">Количество:</div>
                <div class="input-group">
                    <span class="input-group-addon">-</span>
                    <input type="text" class="form-control" value="259" aria-label="Amount (to the nearest dollar)">
                    <span class="input-group-addon">+</span>
                </div>
            </div>
            <div class="add">
                <button class="btn btn-shumoff toBasket cboxElement"><div class="icon-basket"></div>Добавить в корзину</button>
            </div>
        </div>
    </li>
    <li>
        <div class="block">
            <div class="title">Шумофф М1.2. 36</div>
            <img class="img-responsive" src="http://placehold.it/232x165" alt="...">
            <div class="price">
                <div class="text">Цена:</div>
                <div class="priceBlock">50 <span class="icon-ruble"></span><span class="from">/лист</span></div>
            </div>
            <div class="count">
                <div class="text">Количество:</div>
                <div class="input-group">
                    <span class="input-group-addon">-</span>
                    <input type="text" class="form-control" value="259" aria-label="Amount (to the nearest dollar)">
                    <span class="input-group-addon">+</span>
                </div>
            </div>
            <div class="add">
                <button class="btn btn-shumoff toBasket cboxElement"><div class="icon-basket"></div>Добавить в корзину</button>
            </div>
        </div>
    </li>
</ul>

{if $node.object.data_map.ttx.has_content}
    <div class="ttxTitle">Технические характеристики</div>
    <table class="table ttx">
        <tbody><tr>
            <th>Характеристики</th>
            <th>М1.2</th>
            <th>М1.2</th>
            <th>М1.2</th>
            <th>М1.2</th>
        </tr>
        <tr>
            <td>Толщина материала</td>
            <td>М1.2</td>
            <td>М1.2</td>
            <td>М1.2</td>
            <td>М1.2</td>
        </tr>
        <tr>
            <td>Масса упаковки</td>
            <td>М1.2</td>
            <td>М1.2</td>
            <td>М1.2</td>
            <td>М1.2</td>
        </tr>
        </tbody></table>
    {attribute_view_gui attribute=$node.object.data_map.ttx}
{/if}


<div class="materialSoputka">
    <div class="title">Другие вибропоглощающие материалы</div>

    <ul class="flexBlock materials">
        <li>
            <div class="block">
                <div class="media">
                    <div class="media-left">
                        <a href="#"><img class="media-object" src="http://placehold.it/110x110" alt="..."></a>
                    </div>
                    <div class="media-body">
                        <a href="" class="media-heading">Комплект по шумоизоляции дверей</a>
                        <p>Материал на основе неотверждаемой мастики с лицевым покрытием в виде фольги.</p>
                        <div class="priceBlock"><span class="from">от</span>&nbsp;1 360&nbsp;<span class="icon-ruble"></span><span class="from">/лист</span></div>
                    </div>
                </div>
            </div>
        </li>
        <li>
            <div class="block">
                <a href="">Комплект по шумоизоляции дверей</a>
                <p>Вибродемпфирующий, снижающий шум металлических и пластиковых панелей от вибрации.</p>
                <div class="priceBlock"><span class="from">от</span>&nbsp;1 360&nbsp;<span class="icon-ruble"></span></div>
            </div>
        </li>
    </ul>
</div>