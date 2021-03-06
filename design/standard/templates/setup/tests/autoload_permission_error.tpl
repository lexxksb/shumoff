{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{let file_results=$test_result[2]}

<h3>{$result_number}. {"Insufficient directory permissions"|i18n("design/standard/setup/tests")}</h3>
<p>{"eZ Publish cannot write to the"|i18n("design/standard/setup/tests")} <i>autoload</i> {"directory."|i18n("design/standard/setup/tests")}</p>
<p>{"It's recommended that you fix this by running the commands below."|i18n("design/standard/setup/tests")}</p>

<p><b>{"Shell commands"|i18n("design/standard/setup/tests")}</b></p>
<pre class="example">cd {$file_results.current_path}<br/>
{section name=File loop=$file_results.result_elements}
{section-exclude match=$:item.result}
chmod -R ug+rwx {$:item.file}
chown -R {$file_results.user_info.user_name}:{$file_results.user_info.group_name} {$:item.file}
{/section}
</pre>
{/let}
