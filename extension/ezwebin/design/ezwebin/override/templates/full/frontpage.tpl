{set scope=global persistent_variable=hash(
    'meta_description', $node.object.data_map.meta_description.content|wash,
    'site_title', $node.object.data_map.meta_title.content|wash,
    'metaheader', $node.object.data_map.meta_header.content|wash,
    'textheader', $node.object.data_map.textheader
)}
<div class="seo">
    {attribute_view_gui attribute=$node.object.data_map.seotext}
</div>

<ul class="flexBlock info">
    <li>
        <div class="articles">
            <div class="legend"><div class="icon-himself"></div>Сделай сам</div>
            <div class="list"><div class="icon-liDot"></div><a href="">Как самому сделать шумоизоляцию крыши</a></div>
            <div class="list"><div class="icon-liDot"></div><a href="">Виды шумоизоляций и их применение</a></div>
            <div class="list"><div class="icon-liDot"></div><a href="">Особености шумоизоляции дверей</a></div>
            <div class="all"><a href="">Все инструкции</a></div>
        </div>
    </li>
    <li>
        <div class="news">
            <div class="text"><a href="">25 мая магазин Шумофф работает с 11-00 до 17-00. Приезжайте! Мы вас ждем!</a></div>
            <div class="all"><a href="#">Все новости и акции</a></div>
        </div>
    </li>
    <li>
        <div class="rewiew">
            <div class="author">Василий. Асбест:</div>
            <p>В 2012 г приобрёл в магазине "Шумофф" комплект шумоизоляции дверей. Теперь езжу спокойно, без лишних звуков...</p>
            <div class="all"><a class="all" href="#">Все отзывы</a></div>
        </div>
    </li>
</ul>

<div class="instCenter">
    <div class="t1">Установочный центр на Попова, 6</div>
    <div class="media">
        <div class="media-left media-middle">
            <a href="#"><img class="media-object" src="http://placehold.it/140x140" alt="..."></a>
        </div>
        <div class="media-body">
            <p>Шумоизоляция в последнее время становится все более распространенным явлением. Но в ее установке так много тонкостей, что результат напрямую зависит от качества материала и квалификации мастеров.</p>
            <p>Мы стараемся сделать вашу езду на автомобиле как можно более комфортной. Мы ценим ваше время и деньги, поэтому заказ будет выполнен в короткие сроки за приемлемые цены.</p>
        </div>
    </div>
</div>