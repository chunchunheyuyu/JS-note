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

// �����������ļ�
var outlookbar=new outlook();
var t;
t=outlookbar.addtitle('������Ϣ','��̨��ҳ',1)
outlookbar.additem('������Ϣ',t,'version.asp')




t=outlookbar.addtitle('��վ����','ϵͳ����',1)
outlookbar.additem('��վ��������',t,'jhy_site_config.asp')
outlookbar.additem('��ҳ����',t,'jhy_index_config.asp')
outlookbar.additem('�ֻ���վ����',t,'mp_jhy_index_config.asp')

t=outlookbar.addtitle('��ҳ�ֲ�ͼƬ','ϵͳ����',1)
outlookbar.additem('��ҳ�ֲ�ͼƬ����',t,'index_lunbo_list.asp')

t=outlookbar.addtitle('���߿ͷ��Ͷ�ά��','ϵͳ����',1)
outlookbar.additem('���߿ͷ��Ͷ�ά�����',t,'onlinekefu_list.asp')

t=outlookbar.addtitle('��������','ϵͳ����',1)
outlookbar.additem('�������ӹ���',t,'link_list.asp')

t=outlookbar.addtitle('��װ����������','ϵͳ����',1)
outlookbar.additem('ͳ��|����|���ŵȴ��밲װ',t,'third_code.asp')

t=outlookbar.addtitle('��̨ϵͳ����Ա','ϵͳ����',1)
outlookbar.additem('��̨ϵͳ����Ա����',t,'admin_list.asp')

t=outlookbar.addtitle('���ݹ���','ϵͳ����',1)
outlookbar.additem('��վ����',t,'jhy_site_backup.asp?baktype=1')
outlookbar.additem('���ݿ�-���ر���',t,'jhy_site_backup.asp?baktype=2')
outlookbar.additem('���ݿ�-���߱���',t,'db_backup_list.asp')
outlookbar.additem('���ݿ�����ѹ��',t,'db_compact_alert.asp')




t=outlookbar.addtitle('��������','��������',1)
outlookbar.additem('����һ������',t,'front_nav_first_list.asp')
outlookbar.additem('������������',t,'front_nav_second_list.asp')
outlookbar.additem('����Top���ߵ���',t,'front_nav_top_list.asp')
outlookbar.additem('�ײ�����',t,'front_nav_bottom_list.asp')




t=outlookbar.addtitle('��Ŀ������','���ݹ���',1)
outlookbar.additem('��Ŀ�����ݹ���',t,'back_category_list.asp')


t=outlookbar.addtitle('����ͼƬ���ļ�����','���ݹ���',1)
outlookbar.additem('����ͼƬ���ļ�����',t,'no_use_file_alert.asp')

t=outlookbar.addtitle('��������','���ݹ���',1)
outlookbar.additem('��������',t,'order_list.asp')

t=outlookbar.addtitle('���Թ���','���ݹ���',1)
outlookbar.additem('���Թ���',t,'message_list.asp')






t=outlookbar.addtitle('��������','��̬����',1)
outlookbar.additem('��������',t,'html_generate_alert.asp?htmltype=all')

t=outlookbar.addtitle('����������ҳ','��̬����',1)
outlookbar.additem('������ҳ',t,'html_generate_alert.asp?htmltype=index')

t=outlookbar.addtitle('����������Ŀ','��̬����',1)
outlookbar.additem('����������Ŀ�б�ҳ',t,'html_generate_alert.asp?htmltype=list')

t=outlookbar.addtitle('������������','��̬����',1)
outlookbar.additem('����������������ҳ',t,'html_generate_alert.asp?htmltype=article')
outlookbar.additem('�������в�Ʒ����ҳ',t,'html_generate_alert.asp?htmltype=product')
outlookbar.additem('�������е�ҳ',t,'html_generate_alert.asp?htmltype=singlepage')

t=outlookbar.addtitle('������������','��̬����',1)
outlookbar.additem('��������ҳ',t,'html_generate_alert.asp?htmltype=search')
outlookbar.additem('��������ҳ',t,'html_generate_alert.asp?htmltype=guestmessage')
outlookbar.additem('������վ��ͼҳ',t,'html_generate_alert.asp?htmltype=sitemap')

t=outlookbar.addtitle('�����ֻ���վ','��̬����',1)
outlookbar.additem('�����ֻ���վ',t,'html_generate_alert.asp?htmltype=mp')
