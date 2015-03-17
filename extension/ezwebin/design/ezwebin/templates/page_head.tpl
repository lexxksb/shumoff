{default enable_help=true() enable_link=false() canonical_link=true()}

{if and( is_set($module_result.content_info), $module_result.content_info.persistent_variable.site_title)}
    {def $site_title=$module_result.content_info.persistent_variable.site_title|wash}
{else}
    {let name=Path
         path=$module_result.path
         reverse_path=array()}
        {if is_set($pagedata.path_array)}
            {set path=$pagedata.path_array}
        {elseif is_set($module_result.title_path)}
            {set path=$module_result.title_path}
        {/if}
        {section loop=$:path}
            {set reverse_path=$:reverse_path|array_prepend($:item)}
        {/section}

        {set-block scope=root variable=site_title}
            {section loop=$Path:reverse_path}{$:item.text|wash}{delimiter} / {/delimiter}{/section} - {$site.title|wash}
        {/set-block}
    {/let}
{/if}
    <title>{$site_title|trim}</title>
    {if and(is_set($#Header:extra_data),is_array($#Header:extra_data))}
        {section name=ExtraData loop=$#Header:extra_data}
            {$:item}
        {/section}
    {/if}
    {* check if we need a http-equiv refresh *}
    {if $site.redirect}
        <meta http-equiv="Refresh" content="{$site.redirect.timer}; URL={$site.redirect.location}" />
    {/if}
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    {if and( is_set($module_result.content_info), $module_result.content_info.persistent_variable.meta_description)}
        <meta name="description" content="{$module_result.content_info.persistent_variable.meta_description|wash}">
    {/if}
    {*foreach $site.http_equiv as $key => $item}
        <meta name="{$key|wash}" content="{$item|wash}" />
    {/foreach}
    {foreach $site.meta as $key => $item}
        {if is_set( $module_result.content_info.persistent_variable[$key] )}
            <meta name="{$key|wash}" content="{$module_result.content_info.persistent_variable[$key]|wash}" />
        {else}
            <meta name="{$key|wash}" content="{$item|wash}" />
        {/if}
    {/foreach*}
{if $canonical_link}
    {include uri="design:canonical_link.tpl"}
{/if}
{if $enable_link}
    {include uri="design:link.tpl" enable_help=$enable_help enable_link=$enable_link}
{/if}

{/default}