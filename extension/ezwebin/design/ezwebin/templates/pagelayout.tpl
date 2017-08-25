<!DOCTYPE html>
<!--[if lt IE 8 ]> <html lang="ru" class="ie7"> <![endif]-->
<!--[if IE 8 ]>	<html lang="ru" class="ie8"> <![endif]-->
<!--[if IE 9 ]>	<html lang="ru" class="ie9"> <![endif]-->
<!--[if IE 10 ]>   <html lang="ru" class="ie10"> <![endif]-->
<!--[if (gt IE 10)|!(IE)]><!--> <html lang="ru"> <!--<![endif]-->
<head>
    {def    $pagedata         = ezpagedata()
            $pagedesign       = $pagedata.template_look
            $current_node_id  = $pagedata.node_id
            $helpNodes        = fetch( 'content', 'list', hash( 'parent_node_id', 59 ) )
            $contacts         = fetch( 'content', 'node', hash( 'node_id', 110 ) )
            $himselfNodes     = fetch( 'content', 'list', hash( 'parent_node_id', 72,
                                                            'limit', 3) )
            $reviewNodes      = fetch( 'content', 'list', hash(
                                                        'parent_node_id', 70,
                                                        'limit', 1,
                                                        'sort_by', array( 'attribute', false(), 376 )
                                                        ) )
            $instCenter       = fetch( 'content', 'node', hash( 'node_id', 138 ) )
    }

    {include uri='design:page_head.tpl'}

    <meta name='yandex-verification' content='4e4679f53e1f99ac' />

    <link rel="stylesheet" media="all" href="/css/production.min.css">
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>

<body>
<!--[if lt IE 8]>
<div class="browsehappy">Вы используете устаревший браузер. Пожалуйста, <a href="http://browsehappy.com/">обновите Ваш браузер</a></div>
<![endif]-->
{literal}
<!-- Google Tag Manager -->
<noscript><iframe src="//www.googletagmanager.com/ns.html?id=GTM-TJ9GPG"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-TJ9GPG');</script>
<!-- End Google Tag Manager -->
{/literal}
<div class="wrapper">

    <header>
        <div class="head">
            <div class="logo"><a href={"/"|ezurl}><div class="icon-logo"></div></a></div>
            <div class="slogan">Технологии акустического комфорта</div>
            <div class="pull-right">
                <div class="tel">{$pagedesign.data_map.tel.content|wash}</div>
                <a href={$contacts.url_alias|ezurl}>{$pagedesign.data_map.addres.content|wash}</a>
            </div>
        </div>
        {include uri='design:page_topmenu.tpl'}
    </header>

    {if and(is_set($module_result.node_id), $module_result.node_id|eq(2))}
        {include uri='design:facade.tpl'}
    {/if}

    <div class="content">
        {if and(is_set($module_result.node_id), $module_result.node_id|eq(2))}
            {include uri='design:page_mainarea.tpl'}
        {else}
            {def $subnodes = fetch( 'content', 'list', hash(
                    'parent_node_id', $pagedata.path_array[1].node_id,
                    'sort_by', array("priority", true()),
                    'class_filter_type', 'include',
                    'class_filter_array', array("folder", "contacts", "instcenter")
                ) )}
            {if $subnodes|count}
                <div class="row">
                    <div class="col-md-9">
                        {include uri='design:page_mainarea.tpl'}
                    </div>
                    <aside class="col-md-3">
                        {include uri='design:page_innermenu.tpl' top_menu_items=$subnodes}
                    </aside>
                </div>
            {else}
                {include uri='design:page_mainarea.tpl'}
            {/if}
            {undef $subnodes}
        {/if}
    </div>

    {include uri='design:context.tpl'}

    <footer>
        <div class="about">
            <div class="title">О нас</div>
            {attribute_view_gui attribute=$pagedesign.data_map.footer_text}
        </div>
        <div class="help">
            <div class="title">Помощь</div>
            {foreach $helpNodes as $node}
                <div><a href={$node.url_alias|ezurl} title="{$node.name|wash}">{$node.name|wash}</a></div>
            {/foreach}
        </div>
        <div class="contacts">
            <div class="title">Контакты</div>
            <div class="icon icon-tel"></div><div class="i">{$pagedesign.data_map.tel.content|wash}</div>
            <div class="icon icon-email"></div><div class="i">
                <a href="mailto:{$pagedesign.data_map.email.content.data|wash}">{$pagedesign.data_map.email.content.data|wash('email')}</a></div>
            <div class="icon icon-skype"></div><div class="i">{$pagedesign.data_map.skype.content|wash}</div>
        </div>
        <div class="subscribe">
            <div class="title">Присоединяйтесь к нам</div>
            <div class="social">
                <a target="_blank" href="https://vk.com/shumoff_ekb"><div class="icon-vk"></div></a>
                <a target="_blank" href="https://www.facebook.com/%D0%A8%D1%83%D0%BC%D0%BE%D1%84%D1%84-%D1%86%D0%B5%D0%BD%D1%82%D1%80-%D0%B0%D0%BA%D1%83%D1%81%D1%82%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%BE%D0%B3%D0%BE-%D1%82%D1%8E%D0%BD%D0%B8%D0%BD%D0%B3%D0%B0-680450362068524/timeline/
"><div class="icon-fb"></div></a>
                <a target="_blank" title="instagram" href="https://www.instagram.com/shumoff_team/"><img src="/img/Insta.jpg" width="38" height="38" alt="instagram"></a>
                <a target="_blank" title="drive2" href="https://www.drive2.ru/o/ShumoffTeam/dashboard/"><img src="/img/D2.jpg" width="38" height="38" alt="drive2"></a>
            </div>

        </div>
    </footer>

</div>
<script src="/js/production.min.js"></script>
</body>
</html>
{undef $helpNodes}
