<%
'=================================================
'��  �ã��������ºͲ�Ʒ�б�ȫ���򵥸���
'��  ����className����Ŀ���ƣ��磺"����"��
'��  ����folderName����Ŀ�ļ������ƣ��磺"search"��
'��  ����mpsitefoldername �ַ��ͣ��ֻ���վ�ļ������ƣ�
'=================================================
function MP_Run_createhtml_other(folderName,className,mpsitefoldername)
if trim(folderName&"")="" then
	Exit Function
end if

dim fso,f
dim replace_code
dim folderPath,fPath
dim templateName
dim list_block
dim category_position
dim this_page_title,this_page_keywords,this_page_description
dim this_page_banner
dim htmlwrite

Set fso=Server.CreateObject("Scripting.FileSystemObject")
this_page_title=className
this_page_keywords=className
this_page_description=className

'��ȡ�ļ��к��ļ�λ�á��������ڵ�λ�á����������ж��ļ����Ƿ���ڣ����򴴽���
'�����ļ��м��ʹ��������������ļ��У������ص�ǰ��Ŀ�������ļ���·�������ļ���ֻΪ���ɾ�̬html�ļ��ã�ǰ̨��ʾ·�����������

if folderName="search" or folderName="order" then
	folderPath="../"&mpsitefoldername
else
	folderPath=CreateContentFolder(fso,mpsitefoldername&"/"&folderName,"")
end if

category_position="<a href='../"&folderName&"'>"&className&"</a>"

if folderName="search" or folderName="order" then
	b_websiteroot=""
	mpparent_b_root="../"
else
	b_websiteroot="../"
	mpparent_b_root="../../"
end if

'���ݶ�ȡ
select case folderName
	case "search"
		list_block="<!-- #"&"include file="&chr(34)&"../inc/search_list.asp"&chr(34)&" -->"
	case "order"
		list_block="<!-- #"&"include file="&chr(34)&"../inc/mp_inc_order.asp"&chr(34)&" -->"
	case "sitemap"
		list_block=list_block&GetSiteMapContent(b_websiteroot)'������վ��ͼ����
	case "guestmessage"
		list_block=list_block&GetGuestmessageList()'�������԰庯��
end select

'��ȡģ������
templateName="../templates/"&MP_SITE_TEMPLATE_FOLDER&"/mp_template_other.html"
Set htmlwrite=fso.OpenTextFile(Server.MapPath(templateName)) 
replace_code=htmlwrite.ReadAll() 
htmlwrite.close

'�滻������
replace_code=replace(replace_code,"$juhaoyong_common_inside_content$",list_block)

'�滻��������
replace_code=replace(replace_code,"$Site_GenMuLu$",b_websiteroot)
replace_code=replace(replace_code,"$MPparent_GenMuLu$",mpparent_b_root)
replace_code=replace(replace_code,"$this_page_title$",this_page_title)
replace_code=replace(replace_code,"$this_page_channel_name$","")
replace_code=replace(replace_code,"$this_page_keywords$",this_page_keywords)
replace_code=replace(replace_code,"$this_page_description$",this_page_description)
replace_code=replace(replace_code,"$category_position$",category_position)
replace_code=replace(replace_code,"$inside_content_title$",className)

select case folderName
	case "search"
		replace_code=replace(replace_code,"searchClassID","topicCurrent")
	case "sitemap"
		replace_code=replace(replace_code,"siteMapClassID","topicCurrent")
	case "guestmessage"
		replace_code=replace(replace_code,"guestmessageClassID","topicCurrent")
end select

this_page_banner=""
replace_code=replace(replace_code,"$this_page_banner$",this_page_banner)

if folderName="search" then
	fPath=folderPath&"/search.asp"
elseif folderName="order" then
	fPath=folderPath&"/order.asp"
else
	fPath=folderPath&"/index.html"
end if

Set f=fso.CreateTextFile(Server.MapPath(fPath),true)
f.WriteLine replace_code
f.close
Set f=nothing

set fso=nothing
end function
%>

<%
'��վ��ͼ����
function GetSiteMapContent(site_genmulu)
dim sitemap_content
dim rsOutside,rs,sql,tempUrl
sitemap_content=""
sitemap_content=sitemap_content&"<!--SiteMap start-->"
sitemap_content=sitemap_content&"<div class='content'>"
sitemap_content=sitemap_content&"<div class='SiteMap'>"
sitemap_content=sitemap_content&"<ul>"
sitemap_content=sitemap_content&"<li><a href='"&site_genmulu&"index.html'>��վ��ҳ</a></li>"
set rsOutside=server.createobject("adodb.recordset")
sql="select [id],[name],[folder] from [juhaoyong_tb_directory] where jhy_fd_dir_parentid=0 order by [order],id"
rsOutside.open(sql),cn,1,1
if not rsOutside.eof then
	do while not rsOutside.eof
		
		sitemap_content=sitemap_content&"<li><A href='"&site_genmulu&rsOutside("Folder")&"'>"&rsOutside("name")&"</A> "
		
		set rs=server.createobject("adodb.recordset")
		sql="select [id],[name],[folder],ClassType from [juhaoyong_tb_directory] where jhy_fd_dir_parentid="&rsOutside("id")&" order by [order],id"
		rs.open(sql),cn,1,1
		if not rs.eof then
		sitemap_content=sitemap_content&"<ul>"
		do while not rs.eof 
			if rs("ClassType")=3 then
				tempUrl=rs("folder")&".html"
			else
				tempUrl=rs("folder")
			end if
			sitemap_content=sitemap_content&"<li><a href='"&site_genmulu&rsOutside("Folder")&"/"&tempUrl&"' >"&rs("name")&"</a>"
			sitemap_content=sitemap_content&"</li> "
		rs.movenext
		loop
		sitemap_content=sitemap_content&"</ul>"
		end if
		rs.close
		set rs=nothing
		
		sitemap_content=sitemap_content&"</li> "
	rsOutside.movenext
	loop
end if
rsOutside.close
set rsOutside=nothing
sitemap_content=sitemap_content&"</ul>"
sitemap_content=sitemap_content&"</div>"
sitemap_content=sitemap_content&"</div>"
sitemap_content=sitemap_content&"<!--SiteMap end-->"
GetSiteMapContent=sitemap_content
end function
%>

<%
'�����б���
function GetGuestmessageList()
dim rs,sql
dim list_block
dim comment_name,comment_replay
set rs=server.createobject("adodb.recordset")
sql="select * from juhaoyong_tb_guestbook where view_yes=1 order by [time]"
rs.open sql,cn,1,1

list_block=""
list_block=list_block&"<!--FeedBack start-->"
list_block=list_block&"<div class='FeedBack'>"
if rs.bof and rs.eof then 
	list_block=list_block&""
else
	do while not rs.eof
		if rs("name")<>"" then
		comment_name=rs("name")
		else
		comment_name=rs("ip")
		end if
		
		if rs("recontent")<>"" then
		comment_replay="<div class='Freply'><div class='FRtitle'>�ظ�</div><p>"&rs("recontent")&"</p></div>"
		else
		comment_replay=""
		end if
		
		list_block=list_block&"<div class='FeedBlock'>"
		list_block=list_block&"<div class='Fleft'>"
		list_block=list_block&"<div class='Ficon'><img src='../../images/PostIcon.gif'></div>"
		list_block=list_block&"<div class='Fname'>"&rs("name")&"</div>"
		list_block=list_block&"</div>"
		list_block=list_block&"<div class='Fright'>"
		list_block=list_block&"<div class='Fcontent'>"
		list_block=list_block&"<div class='Ftime'>"&GetFormatTime(rs("time"))&"</div>"
		list_block=list_block&"<p>"&rs("content")&"</p>"
		list_block=list_block&comment_replay
		list_block=list_block&"</div>"
		list_block=list_block&"<div class='clearfix'></div>"
		list_block=list_block&"</div>"
		list_block=list_block&"</div>"
		list_block=list_block&"<div class='clearfix'></div> "
	rs.movenext
	loop
end if
rs.close
set rs=nothing

list_block=list_block&"<div class='IntroTitle'>��д����</div>"
list_block=list_block&"<div class='commentbox clearfix'>"
list_block=list_block&"<form id='form1' name='form1' method='post' action='../../inc/guest_message.asp'>"

list_block=list_block&"<table id='commentform' border='0' align='center' cellpadding='0' cellspacing='0'>"
list_block=list_block&"<tr>"
list_block=list_block&"<td align='right'>�������ݣ�</td>"
list_block=list_block&"<td><textarea name='content' class='juhaoyongFormTitle' value=''></textarea>&nbsp;<span class='FontRed'>*</span></td>"
list_block=list_block&"</tr>"

list_block=list_block&"<tr>"
list_block=list_block&"<td align='right'>������</td>"
list_block=list_block&"<td><input name='name' type='text' id='name' size='20'>&nbsp;<span class='FontRed'>*</span></td>"
list_block=list_block&"</tr>"

list_block=list_block&"<tr>"
list_block=list_block&"<td align='right'>�����ʼ���</td>"
list_block=list_block&"<td><input name='email' type='text' id='email' size='20'></td>"
list_block=list_block&"</tr>"

list_block=list_block&"<tr>"
list_block=list_block&"<td align='right'>QQ��</td>"
list_block=list_block&"<td><input name='qq' type='text' id='qq' size='20'><input name='comefrom' type='hidden' value='mp'></td>"
list_block=list_block&"</tr>"

list_block=list_block&"<tr>"
list_block=list_block&"<td align='right'>��֤�룺</td>"
list_block=list_block&"<td><input name='verycode'  maxLength=5 size=10 >&nbsp;<span class='FontRed'>*</span>&nbsp;<img src='../../inc/verification_code_image.asp' width='55'  onclick="&chr(34)&"this.src=this.src+'?'"&chr(34)&" alt='ͼƬ�����壿������µõ���֤��' style='cursor:hand;'></td>"
list_block=list_block&"</tr>"

list_block=list_block&"<tr>"
list_block=list_block&"<td>&nbsp;</td>"
list_block=list_block&"<td><input class='Cbutton' type='submit' value=' �ύ���� ' onClick='javascript:return comment_check()'></td>"
list_block=list_block&"</tr>"
list_block=list_block&"</table>"

list_block=list_block&"</form>"
list_block=list_block&"</div>"
list_block=list_block&"<!--FeedBack end-->"
GetGuestmessageList=list_block
end function
%>
