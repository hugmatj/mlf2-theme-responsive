{if $mode=='index'}
<ul id="subnav-2">
 <li><a class="refresh" href="index.php?refresh=1&amp;category={$category}" title="{#refresh_linktitle#}" rel="nofollow">{#refresh_link#}</a></li>
 <li>{if $thread_order==0}<a class="order-1" href="index.php?mode=index&amp;thread_order=1" title="{#order_link_title_1#}" rel="nofollow">{#order_link#}</a>{else}<a class="order-2" href="index.php?mode=index&amp;thread_order=0" title="{#order_link_title_2#}" rel="nofollow">{#order_link#}</a>{/if}</li>
 <li>{if $usersettings.fold_threads==0}<a class="fold-1" href="index.php?fold_threads=true" title="{#fold_threads_linktitle#}">{#fold_threads#}</a>{else}<a class="fold-2" href="index.php?fold_threads=true" title="{#expand_threads_linktitle#}">{#expand_threads#}</a>{/if}</li>
 <li>{if $usersettings.user_view==0}<a class="tableview" href="index.php?toggle_view=true" title="{#table_view_linktitle#}">{#table_view#}</a>{else}<a class="threadview" href="index.php?toggle_view=true" title="{#thread_view_linktitle#}">{#thread_view#}</a>{/if}</li>
</ul>
{elseif $mode=='entry'}
<ul id="subnav-2">
 <li><a class="openthread" href="index.php?mode=thread&amp;id={$tid}#p{$id}" title="{#open_in_thread_linktitle#}">{#open_in_thread_link#}</a></li>
</ul>
{elseif $mode=='thread'}
<ul id="subnav-2">
 <li>{if $usersettings.thread_display==0}<a class="linear" href="index.php?mode=thread&amp;id={$id}&amp;toggle_thread_display=true" title="{#thread_linear_linktitle#}">{#thread_linear#}</a>{else}<a class="hierarchic" href="index.php?mode=thread&amp;id={$id}&amp;toggle_thread_display=true" title="{#thread_hierarchical_linktitle#}">{#thread_hierarchical#}</a>{/if}</li>
</ul>
{/if}
{if $categories && $mode=='index'}
<!-- subnavigation_2.inc.tpl, $categories && $mode=='index' -->
<form action="index.php" method="get" accept-charset="{#charset#}" id="subnav-2"><div>
<input type="hidden" name="mode" value="{$mode}" />
<select class="small" size="1" name="category" title="{#category_title#}">
 <option value="0"{if $category==0} selected="selected"{/if}>{#all_categories#}</option>
{if $category_selection} <option value="-1"{if $category==-1} selected="selected"{/if}>{#my_category_selection#}</option>
{/if}
{foreach key=key item=val from=$categories}
{if $key!=0} <option value="{$key}"{if $key==$category} selected="selected"{/if}>{$val}</option>
{/if}
{/foreach}
</select>
<noscript><div class="inline"><button class="small" value="&raquo;">{#go#}</button></div></noscript>
</div></form>{/if}
{if $pagination_top}
<!-- subnavigation_2.inc.tpl, $pagination_top -->
<div id="subnav-2">
{if $pagination_top.previous}<a href="index.php?mode={$mode}&amp;page={$pagination_top.previous}{if $category}&amp;category={$category}{/if}"><img class="previous" src="{$THEMES_DIR}/{$theme}/images/plain.png" alt="[&laquo;]" title="{#previous_page_link_title#}" width="6" height="11" /></a>{/if}
<form action="index.php" method="get"><div class="inline">
<input type="hidden" name="mode" value="{$mode}" />
{if $order}<input type="hidden" name="order" value="{$order}" />{/if}
{if $category}<input type="hidden" name="category" value="{$category}" />{/if}
<select class="small" size="1" name="page" title="{#browse_page_title#}">
{foreach from=$pagination_top.items item=item}
{if $item!=0} <option value="{$item}"{if $item==$page} selected="selected"{/if}>{$item}</option>{/if}
{/foreach}
</select>
<noscript><div class="inline"><button class="small" value="&raquo;">{#go#}</button></div></noscript>
</div></form>
</div>
{if $pagination_top.next}
<!-- subnavigation_2.inc.tpl, $pagination_top.next -->
<ul id="subnav-2">
 <li><a href="index.php?mode={$mode}&amp;page={$pagination_top.next}{if $category}&amp;category={$category}{/if}"><img class="next" src="{$THEMES_DIR}/{$theme}/images/plain.png" alt="[&raquo;]" title="{#next_page_link_title#}" width="6" height="11" /></a></li>
</ul>{/if}
{/if}
