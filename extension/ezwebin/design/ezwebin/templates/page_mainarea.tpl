{if $pagedata.path_array|count|gt(1)}
    <ul class="breadcrumb">
    {foreach $pagedata.path_array as $path}
        <li {if $path.url|not}class="active"{/if}>
            {if $path.url}<a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>{$path.text|wash}</a>{else}{$path.text|wash}{/if}
        </li>
    {/foreach}
    </ul>
{/if}
{$module_result.content}