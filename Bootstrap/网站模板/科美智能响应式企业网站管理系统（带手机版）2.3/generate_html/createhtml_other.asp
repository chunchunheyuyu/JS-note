<%
'=================================================
'作  用：生成文章和产品列表（全部或单个）
'参  数：className（栏目名称，如："搜索"）
'参  数：folderName（栏目文件夹名称，如："search"）
'=================================================
function Run_createhtml_other(folderName,className)
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

'获取文件夹和文件位置、“您现在的位置”导航，并判断文件夹是否存在（否，则创建）
'调用文件夹检测和创建函数，创建文件夹，并返回当前栏目的物理文件夹路径（此文件夹只为生成静态html文件用，前台显示路径不用这个）
folderPath=CreateContentFolder(fso,folderName,"")
category_position="<a href='../"&folderName&"'>"&className&"</a>"
b_websiteroot="../"
juhaoyong_mp_folder_file_name=folderName&"/"
if folderName="search" then
juhaoyong_mp_folder_file_name=folderName&"/index.asp"
end if
'内容读取
select case folderName
	case "search"
		list_block="<!-- #"&"include file="&chr(34)&"../inc/search_list.asp"&chr(34)&" -->"
	case "sitemap"
		list_block=list_block&GetSiteMapContent(b_websiteroot)'调用网站地图函数
	case "guestmessage"
		list_block=list_block&GetGuestmessageList()'调用留言板函数
end select

'读取模板内容
templateName="../templates/"&SITE_TEMPLATE_FOLDER&"/template_other.html"
Set htmlwrite=fso.OpenTextFile(Server.MapPath(templateName)) 
replace_code=htmlwrite.ReadAll() 
htmlwrite.close

'替换主内容
replace_code=replace(replace_code,"$juhaoyong_common_inside_content$",list_block)

'替换其他内容
replace_code=replace(replace_code,"$Site_GenMuLu$",b_websiteroot)
replace_code=replace(replace_code,"$juhaoyong_mp_folder_file_name$",juhaoyong_mp_folder_file_name)
replace_code=replace(replace_code,"$this_page_title$",this_page_title)
replace_code=replace(replace_code,"$this_page_channel_name$","")
replace_code=replace(replace_code,"$this_page_keywords$",this_page_keywords)
replace_code=replace(replace_code,"$this_page_description$",this_page_description)
replace_code=replace(replace_code,"$category_position$",category_position)

select case folderName
	case "search"
		replace_code=replace(replace_code,"searchClassID","topicCurrent")
end select

this_page_banner=""
replace_code=replace(replace_code,"$this_page_banner$",this_page_banner)

if folderName="search" then
	fPath=folderPath&"/index.asp"
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
'网站地图函数
function GetSiteMapContent(site_genmulu)
dim sitemap_content
dim rsOutside,rs,sql,tempUrl
sitemap_content=""
sitemap_content=sitemap_content&"<!--SiteMap start-->"
sitemap_content=sitemap_content&"<div class='SiteMap'>"
sitemap_content=sitemap_content&"<ul>"
sitemap_content=sitemap_content&"<li><a href='"&site_genmulu&"index.html'>网站首页</a></li>"
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
sitemap_content=sitemap_content&"<!--SiteMap end-->"
GetSiteMapContent=sitemap_content
end function
%>

<%
'留言列表函数
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
		comment_replay="<div class='Freply'><div class='FRtitle'>回复</div><p>"&rs("recontent")&"</p></div>"
		else
		comment_replay=""
		end if
		
		list_block=list_block&"<div class='FeedBlock'>"
		list_block=list_block&"<div class='Fleft'>"
		list_block=list_block&"<div class='Ficon'><img src='../images/PostIcon.gif'></div>"
		list_block=list_block&"<div class='Fname'>"&rs("name")&"</div>"
		list_block=list_block&"</div>"
		list_block=list_block&"<div class='Fright'>"
		list_block=list_block&"<div class='Fcontent'>"
		list_block=list_block&"<div class='Ftime'>"&GetFormatTime(rs("time"))&"</div>"
		list_block=list_block&"<p>"&rs("content")&"</p>"
		list_block=list_block&comment_replay
		list_block=list_block&"</div>"
		list_block=list_block&"<div class='Fline'></div>"
		list_block=list_block&"<div class='clearfix'></div>"
		list_block=list_block&"</div>"
		list_block=list_block&"</div>"
		list_block=list_block&"<div class='clearfix'></div> "
	rs.movenext
	loop
end if
rs.close
set rs=nothing

list_block=list_block&"<div class='IntroTitle clearfix'>留言</div>"
list_block=list_block&"<div class='commentbox'>"
list_block=list_block&"<form id='form1' name='form1' method='post' action='../inc/guest_message.asp'>"

list_block=list_block&"<table id='commentform' width='600' border='0' align='center' cellpadding='0' cellspacing='0'>"
list_block=list_block&"<tr>"
list_block=list_block&"<td>留言内容</td>"
list_block=list_block&"<td><textarea name='content' cols='60' rows='7'  value=''></textarea>&nbsp;<span class='FontRed'>*</span></td>"
list_block=list_block&"</tr>"

list_block=list_block&"<tr>"
list_block=list_block&"<td>姓名</td>"
list_block=list_block&"<td><input name='name' type='text' id='name' size='30' maxlength='30'>&nbsp;<span class='FontRed'>*</span></td>"
list_block=list_block&"</tr>"

list_block=list_block&"<tr>"
list_block=list_block&"<td>电子邮件</td>"
list_block=list_block&"<td><input name='email' type='text' id='email' size='30' maxlength='80'></td>"
list_block=list_block&"</tr>"

list_block=list_block&"<tr>"
list_block=list_block&"<td>QQ</td>"
list_block=list_block&"<td><input name='qq' type='text' id='qq' size='30' maxlength='30'></td>"
list_block=list_block&"</tr>"

list_block=list_block&"<tr>"
list_block=list_block&"<td>验证码</td>"
list_block=list_block&"<td><input name='verycode'  maxLength=5 size=10 >&nbsp;<span class='FontRed'>*</span>&nbsp;<img src='../inc/verification_code_image.asp' width='55'  onclick="&chr(34)&"this.src=this.src+'?'"&chr(34)&" alt='图片看不清？点击重新得到验证码' style='cursor:hand;'></td>"
list_block=list_block&"</tr>"

list_block=list_block&"<tr>"
list_block=list_block&"<td>&nbsp;</td>"
list_block=list_block&"<td><input class='Cbutton' type='submit' value=' 提交留言 ' onClick='javascript:return comment_check()'></td>"
list_block=list_block&"</tr>"
list_block=list_block&"</table>"

list_block=list_block&"</form>"
list_block=list_block&"</div>"
list_block=list_block&"</div>"
list_block=list_block&"<!--FeedBack end-->"
GetGuestmessageList=list_block
end function
%>
