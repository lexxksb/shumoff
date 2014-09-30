  <div id="header-position">
  <div id="header" class="float-break">
    <div id="usermenu">
        <ul>
            <li id="shoppingbasket"><a href={"/store/basket/"|ezurl} title="Корзина">Корзина</a></li>
        </ul>
      {*include uri='design:page_header_languages.tpl'}
      {include uri='design:page_header_links.tpl'*}
    </div>

    {include uri='design:page_header_logo.tpl'}
    
    {include uri='design:page_header_searchbox.tpl'}
    
    <p class="hide"><a href="#main">{'Skip to main content'|i18n('design/ezwebin/pagelayout')}</a></p>
  </div>
  </div>