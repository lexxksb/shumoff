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

    <link rel="stylesheet" media="all" href="/css/production.min.css">
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>

<body>
<!--[if lt IE 8]>
<div class="browsehappy">Вы используете устаревший браузер. Пожалуйста, <a href="http://browsehappy.com/">обновите Ваш браузер</a></div>
<![endif]-->
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
            <div class="icon icon-icq"></div><div class="i">{$pagedesign.data_map.icq.content|wash}</div>
        </div>
        <div class="subscribe">
            <div class="title">Присоединяйтесь к нам</div>
            <form action="" method="get">
                <input type="email" name="" value="" placeholder="Ваш Email">
                <div><button class="btn btn-shumoff" type="submit">Подписаться</button></div>
            </form>
        </div>
    </footer>

</div>
<script src="/js/production.min.js"></script>
</body>
</html>
{undef $helpNodes}