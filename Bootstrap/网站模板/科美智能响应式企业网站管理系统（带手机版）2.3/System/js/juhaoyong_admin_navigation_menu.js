var preClassName = ""; 
function list_sub_detail(Id, item) 
{ 
if(preClassName != "") 
{ 
getObject(preClassName).className = "left_back" 
} 
if(getObject(Id).className == "left_back") 
{ 
getObject(Id).className = "left_back_onclick"; 
outlookbar.getbyitem(item); 
preClassName = Id 
} 
} 
function getObject(objectId) 
{ 
if(document.getElementById && document.getElementById(objectId)) 
{ 
return document.getElementById(objectId) 
} 
else if(document.all && document.all(objectId)) 
{ 
return document.all(objectId) 
} 
else if(document.layers && document.layers[objectId]) 
{ 
return document.layers[objectId] 
} 
else 
{ 
return false 
} 
} 
function outlook() 
{ 
this.titlelist = new Array(); 
this.itemlist = new Array(); 
this.addtitle = addtitle; 
this.additem = additem; 
this.getbytitle = getbytitle; 
this.getbyitem = getbyitem; 
this.getdefaultnav = getdefaultnav 
} 
function theitem(intitle, insort, inkey, inisdefault) 
{ 
this.sortname = insort; 
this.key = inkey; 
this.title = intitle; 
this.isdefault = inisdefault 
} 
function addtitle(intitle, sortname, inisdefault) 
{ 
outlookbar.itemlist[outlookbar.titlelist.length] = new Array(); 
outlookbar.titlelist[outlookbar.titlelist.length] = new theitem(intitle, sortname, 0, inisdefault); 
return(outlookbar.titlelist.length - 1) 
} 
function additem(intitle, parentid, inkey) 
{ 
if(parentid >= 0 && parentid <= outlookbar.titlelist.length) 
{ 
insort = "item_" + parentid; 
outlookbar.itemlist[parentid][outlookbar.itemlist[parentid].length] = new theitem(intitle, insort, inkey, 0); 
return(outlookbar.itemlist[parentid].length - 1) 
} 
else additem = - 1 
} 
function getdefaultnav(sortname) 
{ 
var output = ""; 
for(i = 0; i < outlookbar.titlelist.length; i ++ ) 
{ 
if(outlookbar.titlelist[i].isdefault == 1 && outlookbar.titlelist[i].sortname == sortname) 
{ 
output += "<div class=list_tilte id=sub_sort_" + i + " >"; 
output += "<span>" + outlookbar.titlelist[i].title + "</span>"; 
output += "</div>"; 
output += "<div class=list_detail id=sub_detail_" + i + "><ul>"; 
for(j = 0; j < outlookbar.itemlist[i].length; j ++ ) 
{ 
output += "<li id=" + outlookbar.itemlist[i][j].sortname + j + " onclick=\"changeframe('"+outlookbar.itemlist[i][j].title+"', '"+outlookbar.titlelist[i].title+"', '"+outlookbar.itemlist[i][j].key+"')\"><a href=#>" + outlookbar.itemlist[i][j].title + "</a></li>" 
} 
output += "</ul></div>" 
} 
} 
getObject('right_main_nav').innerHTML = output 
} 
function getbytitle(sortname) 
{ 
var output = "<ul>"; 
for(i = 0; i < outlookbar.titlelist.length; i ++ ) 
{ 
if(outlookbar.titlelist[i].sortname == sortname) 
{ 
output += "<li id=left_nav_" + i + " onclick=\"list_sub_detail(id, '"+outlookbar.titlelist[i].title+"')\" class=left_back>" + outlookbar.titlelist[i].title + "</li>" 
} 
} 
output += "</ul>"; 
getObject('left_main_nav').innerHTML = output 
} 
function getbyitem(item) 
{ 
var output = ""; 
for(i = 0; i < outlookbar.titlelist.length; i ++ ) 
{ 
if(outlookbar.titlelist[i].title == item) 
{ 
output = "<div class=list_tilte id=sub_sort_" + i + " onclick=\"hideorshow('sub_detail_"+i+"')\">"; 
output += "<span>" + outlookbar.titlelist[i].title + "</span>"; 
output += "</div>"; 
output += "<div class=list_detail id=sub_detail_" + i + " style='display:block;'><ul>"; 
for(j = 0; j < outlookbar.itemlist[i].length; j ++ ) 
{ 
output += "<li id=" + outlookbar.itemlist[i][j].sortname + "_" + j + " onclick=\"changeframe('"+outlookbar.itemlist[i][j].title+"', '"+outlookbar.titlelist[i].title+"', '"+outlookbar.itemlist[i][j].key+"')\"><a href=#>" + outlookbar.itemlist[i][j].title + "</a></li>" 
} 
output += "</ul></div>" 
} 
} 
getObject('right_main_nav').innerHTML = output 
} 
function changeframe(item, sortname, src) 
{ 
if(item != "" && sortname != "") 
{ 
window.top.frames['mainFrame'].getObject('show_text').innerHTML = sortname + "  <img src=images/slide.gif broder=0 />  " + item 
} 
if(src != "") 
{ 
window.top.frames['manFrame'].location = src 
} 
} 
function hideorshow(divid) 
{ 
subsortid = "sub_sort_" + divid.substring(11); 
if(getObject(divid).style.display == "none") 
{ 
getObject(divid).style.display = "block"; 
getObject(subsortid).className = "list_tilte" 
} 
else 
{ 
getObject(divid).style.display = "none"; 
getObject(subsortid).className = "list_tilte_onclick" 
} 
} 
function initinav(sortname) 
{ 
outlookbar.getdefaultnav(sortname); 
outlookbar.getbytitle(sortname); 
//window.top.frames['manFrame'].location = "manFrame.html" 
}

// 导航栏配置文件
var outlookbar=new outlook();
var t;
t=outlookbar.addtitle('程序信息','后台首页',1)
outlookbar.additem('程序信息',t,'version.asp')




t=outlookbar.addtitle('网站设置','系统设置',1)
outlookbar.additem('网站基本设置',t,'jhy_site_config.asp')
outlookbar.additem('首页设置',t,'jhy_index_config.asp')
outlookbar.additem('手机网站设置',t,'mp_jhy_index_config.asp')

t=outlookbar.addtitle('首页轮播图片','系统设置',1)
outlookbar.additem('首页轮播图片管理',t,'index_lunbo_list.asp')

t=outlookbar.addtitle('在线客服和二维码','系统设置',1)
outlookbar.additem('在线客服和二维码管理',t,'onlinekefu_list.asp')

t=outlookbar.addtitle('友情链接','系统设置',1)
outlookbar.additem('友情链接管理',t,'link_list.asp')

t=outlookbar.addtitle('安装第三方代码','系统设置',1)
outlookbar.additem('统计|分享|商桥等代码安装',t,'third_code.asp')

t=outlookbar.addtitle('后台系统管理员','系统设置',1)
outlookbar.additem('后台系统管理员管理',t,'admin_list.asp')

t=outlookbar.addtitle('数据管理','系统设置',1)
outlookbar.additem('网站备份',t,'jhy_site_backup.asp?baktype=1')
outlookbar.additem('数据库-下载备份',t,'jhy_site_backup.asp?baktype=2')
outlookbar.additem('数据库-在线备份',t,'db_backup_list.asp')
outlookbar.additem('数据库在线压缩',t,'db_compact_alert.asp')




t=outlookbar.addtitle('导航管理','导航管理',1)
outlookbar.additem('顶部一级导航',t,'front_nav_first_list.asp')
outlookbar.additem('顶部二级导航',t,'front_nav_second_list.asp')
outlookbar.additem('顶部Top顶边导航',t,'front_nav_top_list.asp')
outlookbar.additem('底部导航',t,'front_nav_bottom_list.asp')




t=outlookbar.addtitle('栏目和内容','内容管理',1)
outlookbar.additem('栏目和内容管理',t,'back_category_list.asp')


t=outlookbar.addtitle('废弃图片和文件清理','内容管理',1)
outlookbar.additem('废弃图片和文件清理',t,'no_use_file_alert.asp')

t=outlookbar.addtitle('订单管理','内容管理',1)
outlookbar.additem('订单管理',t,'order_list.asp')

t=outlookbar.addtitle('留言管理','内容管理',1)
outlookbar.additem('留言管理',t,'message_list.asp')






t=outlookbar.addtitle('生成所有','静态管理',1)
outlookbar.additem('生成所有',t,'html_generate_alert.asp?htmltype=all')

t=outlookbar.addtitle('单独生成首页','静态管理',1)
outlookbar.additem('生成首页',t,'html_generate_alert.asp?htmltype=index')

t=outlookbar.addtitle('单独生成栏目','静态管理',1)
outlookbar.additem('生成所有栏目列表页',t,'html_generate_alert.asp?htmltype=list')

t=outlookbar.addtitle('单独生成内容','静态管理',1)
outlookbar.additem('生成所有文章类型页',t,'html_generate_alert.asp?htmltype=article')
outlookbar.additem('生成所有产品类型页',t,'html_generate_alert.asp?htmltype=product')
outlookbar.additem('生成所有单页',t,'html_generate_alert.asp?htmltype=singlepage')

t=outlookbar.addtitle('单独生成其他','静态管理',1)
outlookbar.additem('生成搜索页',t,'html_generate_alert.asp?htmltype=search')
outlookbar.additem('生成留言页',t,'html_generate_alert.asp?htmltype=guestmessage')
outlookbar.additem('生成网站地图页',t,'html_generate_alert.asp?htmltype=sitemap')

t=outlookbar.addtitle('生成手机网站','静态管理',1)
outlookbar.additem('生成手机网站',t,'html_generate_alert.asp?htmltype=mp')
