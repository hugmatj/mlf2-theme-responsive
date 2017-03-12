{if $threads}
<table>
 <thead>
  <tr>{*
{if $fold_threads==1}   <th>&nbsp;</th>{/if}*}
   <th>{#subject#}</th>
   <th>{#author#}</th>
   <th>{#date#}</th>
{if $settings.count_views}   <th>{#views#}</th>
{/if}
   <th>{#replies#}</th>
{if $categories && $category<=0}   <th>{#category#}</th>
{/if}
  </tr>
 </thead>
 <tbody>
{foreach from=$threads item=thread}
{cycle values="a,b" assign=c}
  <tr class="{$c}">
{*{if $fold_threads==1}   <td class="fold"></td>{/if}*}
   <td class="subject">
<ul id="thread-{$thread}" class="thread {if $fold_threads==1}folded{else}expanded{/if}">
{function name=tree level=0}
<li><a class="{if $data.$element.pid==0}opening-entry{else}following-entry{/if}{if $data.$element.new} new{/if}{if $data.$element.sticky==1} sticky{/if}{if $data.$element.locked==1} locked{/if}{if $data.$element.is_read} read{/if}" href="index.php?mode=thread&amp;id={$data.$element.tid}{if $data.$element.pid!=0}#p{$data.$element.id}{/if}" title="{$data.$element.name}, {$data.$element.formated_time}">{if $data.$element.spam==1}<span class="spam">{$data.$element.subject}</span>{else}{$data.$element.subject}{/if}</a>{if $data.$element.no_text} <img class="no-text" src="{$THEMES_DIR}/{$theme}/images/no_text.png" title="{#no_text_title#}" alt="[ {#no_text_alt#} ]" width="11" height="9" />{/if}<span id="p{$data.$element.id}" class="tail">{if $admin || $mod} <a id="marklink_{$data.$element.id}" href="index.php?mode=posting&amp;mark={$data.$element.id}" title="{#mark_linktitle#}">{if $data.$element.marked==0}<img id="markimg_{$data.$element.id}" src="{$THEMES_DIR}/{$theme}/images/unmarked.png" title="{#mark_linktitle#}" alt="[○]" width="11" height="11" />{else}<img id="markimg_{$data.$element.id}" src="{$THEMES_DIR}/{$theme}/images/marked.png" title="{#unmark_linktitle#}" alt="[●]" width="11" height="11" title="{#unmark_linktitle#}" />{/if}</a> <a href="index.php?mode=posting&amp;delete_posting={$data.$element.id}&amp;back=index" title="{#delete_posting_title#}"><img src="{$THEMES_DIR}/{$theme}/images/delete_posting.png" title="{#delete_posting_title#}" alt="[x]" width="9" height="9" /></a>{/if}</span>
{if is_array($child_array[$element])}
<ul class="{if $level<$settings.deep_reply}reply{elseif $level>=$settings.deep_reply&&$level<$settings.very_deep_reply}deep-reply{else}very-deep-reply{/if}{if $fold_threads==1} js-display-none{/if}">{foreach from=$child_array[$element] item=child}{tree element=$child level=$level+1}{/foreach}</ul>{/if}</li>
{/function}
{tree element=$thread}
</ul>
</td>
   <td data-header="{#author#}"><span class="value nowrap">{if $data.$thread.user_type==2}<span class="admin registered_user" title="{#administrator_title#}">{$data.$thread.name}</span>{elseif $data.$thread.user_type==1}<span class="mod registered_user" title="{#moderator_title#}">{$data.$thread.name}</span>{elseif $data.$thread.user_id>0}<span class="registered_user">{$data.$thread.name}</span>{else}{$data.$thread.name}{/if}</span></td>
   <td data-header="{#date#}"><span class="value nowrap">{$data.$thread.formated_time}</span></td>
{if $settings.count_views}   <td data-header="{#views#}"><span class="value">{$total_views.$thread}</span></td>
{/if}
   <td data-header="{#replies#}"><span class="value">{$replies.$thread}</span></td>
{if $categories && $category<=0}   <td data-header="{#category#}">{if $data.$thread.category_name}<a href="index.php?mode=index&amp;category={$data.$thread.category}" title="{#change_category_link#|replace:"[category]":$data.$thread.category_name|escape:"html"}"><span class="value category nowrap">{$data.$thread.category_name}</span></a>{else}&nbsp;{/if}</td>
{/if}
</tr>
{/foreach}
 </tbody>
</table>
{else}<p>{if $category!=0}{#no_messages_in_category#}{else}{#no_messages#}{/if}</p>{/if}

{if $pagination}
<ul class="pagination pagination-index-table">
{if $pagination.previous}<li><a href="index.php?mode={$mode}&amp;page={$pagination.previous}{if $category}&amp;category={$category}{/if}" title="{#previous_page_link_title#}">{#previous_page_link#}</a></li>{/if}
{foreach from=$pagination.items item=item}
{if $item==0}<li>&hellip;</li>{elseif $item==$pagination.current}<li><span class="current">{$item}</span></li>{else}<li><a href="index.php?mode={$mode}&amp;page={$item}{if $category}&amp;category={$category}{/if}">{$item}</a></li>{/if}
{/foreach}
{if $pagination.next}<li><a href="index.php?mode={$mode}&amp;page={$pagination.next}{if $category}&amp;category={$category}{/if}" title="{#next_page_link_title#}">{#next_page_link#}</a></li>{/if}
</ul>
{/if}

{if $tag_cloud || $latest_postings || $admin || $mod}
<aside id="bottombar"{if $usersettings.sidebar==0} class="js-display-fold"{/if}>
<h2><a href="index.php?toggle_sidebar=true" title="{#toggle_sidebar#}">{#sidebar#}</a></h2>
<div id="sidebarcontent">
{if $latest_postings}
<section id="latest-postings">
<h3>{#latest_postings_hl#}</h3>
<ul id="latest-postings-container">
{foreach from=$latest_postings item=posting} <li><a href="index.php?mode=thread&amp;id={$posting.tid}{if $posting.pid!=0}#p{$posting.id}{/if}" title="{$posting.name}, {$posting.formated_time}{if $posting.category_name} ({$posting.category_name}){/if}"><span class="posting-title{if $posting.is_read} read{/if}">{if $posting.pid==0}<strong>{$posting.subject}</strong>{else}{$posting.subject}{/if}</span>
  <span class="posting-info">{if $posting.ago.days>1}{#posting_several_days_ago#|replace:"[days]":$posting.ago.days_rounded}{else}{if $posting.ago.days==0 && $posting.ago.hours==0}{#posting_minutes_ago#|replace:"[minutes]":$posting.ago.minutes}{elseif $posting.ago.days==0 && $posting.ago.hours!=0}{#posting_hours_ago#|replace:"[hours]":$posting.ago.hours|replace:"[minutes]":$posting.ago.minutes}{else}{#posting_one_day_ago#|replace:"[hours]":$posting.ago.hours|replace:"[minutes]":$posting.ago.minutes}{/if}{/if}</span></a></li>
{/foreach}
</ul>
</section>
{/if}
{if $tag_cloud}
<section id="tagcloud">
<h3>{#tag_cloud_hl#}</h3>
<ul>
{foreach from=$tag_cloud item=tag}
 <li><a href="index.php?mode=search&amp;search={$tag.escaped}&amp;method=tags">{section name=strong_start start=0 loop=$tag.frequency}<strong>{/section}{$tag.tag}{section name=strong_end start=0 loop=$tag.frequency}</strong>{/section}</a></li>
{/foreach}
</ul>
</section>
{/if}
{if $admin || $mod}
<section id="modmenu">
<h3>{#options#}</h3>
<ul id="mod-options">
{if $number_of_non_activated_users}<li><a href="index.php?mode=user" class="non-activated-users">{#non_activated_users_link#|replace:'[counter]':$number_of_non_activated_users}</a></li>{/if}
<li><a href="index.php?mode=posting&amp;delete_marked=true" class="delete-marked">{#delete_marked_link#}</a></li>
<li><a href="index.php?mode=posting&amp;manage_postings=true" class="manage">{#manage_postings_link#}</a></li>
{if $show_spam_link}<li><a href="index.php?show_spam=true" class="report">{$smarty.config.show_spam_link|replace:"[number]":$total_spam}</a></li>{/if}
{if $hide_spam_link}<li><a href="index.php?show_spam=true" class="report">{$smarty.config.hide_spam_link|replace:"[number]":$total_spam}</a></li>{/if}
{if $show_spam_link||$hide_spam_link}<li><a href="index.php?mode=search&amp;list_spam=1" class="report">{#list_spam_link#}</a></li>{/if}
{if $delete_spam_link}<li><a href="index.php?mode=posting&amp;delete_spam=true" class="delete-spam">{#delete_spam_link#}</a></li>{/if}
</ul>
</section>{/if}
</div>
</aside>
{/if}
