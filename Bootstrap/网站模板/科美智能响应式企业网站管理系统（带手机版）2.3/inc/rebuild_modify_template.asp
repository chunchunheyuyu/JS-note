<%
'=================================================
'函数：网站基本信息和头部
'=================================================
Function SiteSetInfo(templateString)
dim rs,sql
dim jhy_fd_site_name,jhy_fd_site_logo,jhy_fd_phonetitle,jhy_fd_phonenumber,site_top_html,jhy_fd_site_bottomhtml,jhy_fd_topsearchdisplay
set rs=server.createobject("adodb.recordset")
sql="select * from juhaoyong_tb_siteconfig"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
	jhy_fd_site_name=rs("jhy_fd_site_name")
	if jhy_fd_site_name&""<>"" then jhy_fd_site_name="_"&jhy_fd_site_name
	jhy_fd_site_logo=rs("jhy_fd_site_logo")
	jhy_fd_phonenumber=rs("jhy_fd_phonenumber")
	jhy_fd_phonetitle=rs("jhy_fd_phonetitle")
	jhy_fd_site_bottomhtml=rs("jhy_fd_site_bottomhtml")
	jhy_fd_title_channelnameonoff=rs("jhy_fd_title_channelnameonoff")
	jhy_fd_title_sitenameonoff=rs("jhy_fd_title_sitenameonoff")
	jhy_fd_topsearchdisplay=rs("jhy_fd_topsearchdisplay")
end if
rs.close

'获取手机网站目录名称开始
dim mp_fd_site_folder
sql="select mp_fd_site_folder from mp_juhaoyong_tb_siteconfig"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
	mp_fd_site_folder=rs("mp_fd_site_folder")
end if
rs.close
'获取手机网站目录名称结束
set rs=nothing

'web_top---start
site_top_html=site_top_html&"<div class='TopLogo'>"
site_top_html=site_top_html&"		<div class='logo'><a href='$Site_GenMuLu$' title='"&jhy_fd_site_name&"'><img src='$Site_GenMuLu$css/"&SITE_STYLE_CSS_FOLDER&"/"&jhy_fd_site_logo&"' alt='"&jhy_fd_site_name&"'></a></div>"
site_top_html=site_top_html&"</div>"

site_top_html=site_top_html&"<div class='TopInfo'>"
site_top_html=site_top_html&"		<div class='toptopnav'>"&MostTopNavigation()&"</div>"
if trim(jhy_fd_phonetitle&"")<>"" or trim(jhy_fd_phonenumber&"")<>"" then
site_top_html=site_top_html&"		<div class='telephone'><div class='telephone_num'>"&jhy_fd_phonenumber&"</div><div class='telephone_title'>"&jhy_fd_phonetitle&"</div></div>"
end if
if jhy_fd_topsearchdisplay=1 then
site_top_html=site_top_html&"		<div class='juhaoyongTopSearchClass'>"
site_top_html=site_top_html&"			<form method='get' action='$Site_GenMuLu$Search/index.asp'>"
site_top_html=site_top_html&"			<span class='SearchBar'>"
site_top_html=site_top_html&"			<input type='text' name='q' id='search-text' size='15' onBlur="&chr(34)&"if(this.value=='') this.value='请输入关键词';"&chr(34)&" onfocus="&chr(34)&"if(this.value=='请输入关键词') this.value='';"&chr(34)&" value='请输入关键词' /><input type='submit' id='search-submit' value='搜索' />"
site_top_html=site_top_html&"			</span>"
site_top_html=site_top_html&"			</form>"
site_top_html=site_top_html&"		</div>"
end if
site_top_html=site_top_html&"</div>"
'web_top---end

SiteSetInfo=templateString
SiteSetInfo=replace(SiteSetInfo,"###juhaoyong_css_folder###",SITE_STYLE_CSS_FOLDER)

if jhy_fd_title_channelnameonoff=1 then
SiteSetInfo=replace(SiteSetInfo,"###this_page_channel_name###","$this_page_channel_name$")
else
SiteSetInfo=replace(SiteSetInfo,"###this_page_channel_name###","")
end if

if jhy_fd_title_sitenameonoff=1 then
SiteSetInfo=replace(SiteSetInfo,"###template_site_name###",jhy_fd_site_name)
else
SiteSetInfo=replace(SiteSetInfo,"###template_site_name###","")
end if

SiteSetInfo=replace(SiteSetInfo,"###template_site_top_html###",site_top_html)
SiteSetInfo=replace(SiteSetInfo,"###template_site_bottom_html###",jhy_fd_site_bottomhtml)
SiteSetInfo=replace(SiteSetInfo,"###juhaoyong_mp_site_jump_url###",mp_fd_site_folder)
End Function
%>

<%
'=================================================
'函数：产品内容页面，为在head区域插入css和js设置标签
'=================================================
Function ProductImageboxOrderwinCssjs(templateString,classTypeNumber)
dim replaceString
replaceString=""
if classTypeNumber=2 then
	replaceString=replaceString&"$product_imagebox_orderwin_cssjs$"
else
	replaceString=""
end if
ProductImageboxOrderwinCssjs=replace(templateString,"###product_imagebox_orderwin_cssjs###",replaceString)
End Function
%>

<%
'=================================================
'函数：顶部导航
'=================================================
Function TopNavigation(templateString)
dim rs,sql,replaceString
dim juhaoyongMenuLink1,juhaoyongMenuLink2,juhaoyongMenuOutLinkBlank1,juhaoyongMenuOutLinkBlank2
replaceString="<div class='NavBG'>"
set rs=server.createobject("adodb.recordset")
sql="select * from juhaoyong_tb_navfirst where fd_navfirst_type=1 order by [order],id"
rs.open(sql),cn,1,1
if not rs.eof then
	replaceString=replaceString&"<ul id='sddm'>"
	for i=1 to rs.recordcount
	
		if instr(rs("url"),"://")>0 then
		juhaoyongMenuLink1=rs("url")
		juhaoyongMenuOutLinkBlank1=" target=_blank"
		else
		juhaoyongMenuLink1="$Site_GenMuLu$"&rs("url")
		juhaoyongMenuOutLinkBlank1=""
		end if
		
		set rss=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_navsecond where [position]="&rs("id")&" order by [order],id"
		rss.open(sql),cn,1,1
		if not rss.eof then
			replaceString=replaceString&"<li id='aaabbb"&i&"' onmouseover=juhaoyongNavBgaColor('aaabbb"&i&"') onmouseout=style.background=''><a href='"&juhaoyongMenuLink1&"' onmouseover=mopen('m"&i&"') onmouseout='mclosetime()'"&juhaoyongMenuOutLinkBlank1&">"&rs("name")&"</a> "
			replaceString=replaceString&"<div id='m"&i&"' onmouseover='mcancelclosetime()' onmouseout='mclosetime()'>"
			jhyski=1
			do while not rss.eof
				if instr(rss("url"),"://")>0 then
					juhaoyongMenuLink2=rss("url")
					juhaoyongMenuOutLinkBlank2=" target=_blank"
				else
					juhaoyongMenuLink2="$Site_GenMuLu$"&rss("url")
					juhaoyongMenuOutLinkBlank2=""
				end if
				if jhyski=1 then
					juhaoyong_second_menu_class="class='juhaoyong_second_menu_class'"
				else
					juhaoyong_second_menu_class=""
				end if
				replaceString=replaceString&"<a "&juhaoyong_second_menu_class&" href='"&juhaoyongMenuLink2&"'"&juhaoyongMenuOutLinkBlank2&">"&rss("name")&"</a> "
			rss.movenext
			jhyski=jhyski+1
			loop
			replaceString=replaceString&"</div></li> "
		else
			replaceString=replaceString&"<li><a href='"&juhaoyongMenuLink1&"'"&juhaoyongMenuOutLinkBlank1&">"&rs("name")&"</a></li> "
		end if
		rss.close
		set rss=nothing
		
	rs.movenext
	next
	replaceString=replaceString&"</ul>"
end if
rs.close
set rs=nothing
replaceString=replaceString&"</div>"
TopNavigation=replace(templateString,"###web_top_menu###",replaceString)
End Function
%>

<%
'=================================================
'函数：顶部Top顶边导航
'=================================================
Function MostTopNavigation()
dim rs,sql,replaceString
dim juhaoyongMenuLink1,juhaoyongMenuOutLinkBlank1
replaceString=""
set rs=server.createobject("adodb.recordset")
sql="select * from juhaoyong_tb_navfirst where fd_navfirst_type=3 order by [order],id"
rs.open(sql),cn,1,1
if not rs.eof then
	for i=1 to rs.recordcount
		
		if instr(rs("url"),"://")>0 then
			juhaoyongMenuLink1=rs("url")
			juhaoyongMenuOutLinkBlank1=" target=_blank"
		else
			juhaoyongMenuLink1="$Site_GenMuLu$"&rs("url")
			juhaoyongMenuOutLinkBlank1=""
		end if
		
		if i>1 then
		replaceString=replaceString&" | "
		end if
		replaceString=replaceString&"<a href='"&juhaoyongMenuLink1&"'"&juhaoyongMenuOutLinkBlank1&">"&rs("name")&"</a>"
		
		rs.movenext
	next
end if
rs.close
set rs=nothing
MostTopNavigation=replaceString
End Function
%>

<%
'=================================================
'函数：底部导航
'=================================================
Function BottomNavigation(templateString)
dim rs,sql,replaceString
dim juhaoyongMenuLink1,juhaoyongMenuOutLinkBlank1
replaceString=""
set rs=server.createobject("adodb.recordset")
sql="select * from juhaoyong_tb_navfirst where fd_navfirst_type=2 order by [order],id"
rs.open(sql),cn,1,1
if not rs.eof then
	replaceString=replaceString&"<div class='BottomNav'>"
	for i=1 to rs.recordcount
		
		if instr(rs("url"),"://")>0 then
			juhaoyongMenuLink1=rs("url")
			juhaoyongMenuOutLinkBlank1=" target=_blank"
		else
			juhaoyongMenuLink1="$Site_GenMuLu$"&rs("url")
			juhaoyongMenuOutLinkBlank1=""
		end if
		
		if i>1 then
		replaceString=replaceString&" | "
		end if
		replaceString=replaceString&"<a href='"&juhaoyongMenuLink1&"'"&juhaoyongMenuOutLinkBlank1&">"&rs("name")&"</a>"
		
		rs.movenext
	next
	replaceString=replaceString&"</div>"
	replaceString=replaceString&"<div class='HeightTab'></div>"
end if
rs.close
set rs=nothing
BottomNavigation=replace(templateString,"###juhaoyong_web_BottomNav###",replaceString)
End Function
%>

<%
'=================================================
'函数：侧边栏分类列表（生成文章、文章列表、单页、产品、产品列表时调用，列出所有同类型的一级分类及其下的二级分类）
'=================================================
Function SideArticleClassList(templateString,classTypeNumber,oneClassId)
dim rsOne,sqlOne
dim rs,sql
dim iFolderName,currentLi
dim replaceString

if classTypeNumber=4 then
SideArticleClassList=replace(templateString,"###side_common_class_list###","")
Exit Function
end if

sqlOne="select [id],[name],[folder],ClassType from [juhaoyong_tb_directory] where id="&oneClassId

set rsOne=server.createobject("adodb.recordset")
rsOne.open(sqlOne),cn,1,1
if not rsOne.eof and not rsOne.bof then
	
	replaceString=replaceString&"<div class='Sbox'>"
	replaceString=replaceString&"<div class='topic tclassID"&rsOne("id")&"'><a href='$Site_GenMuLu$"&rsOne("Folder")&"'>"&rsOne("name")&"</a></div>"
	
	set rs=server.createobject("adodb.recordset")
	sql="select [id],[name],[folder],ClassType from [juhaoyong_tb_directory] where jhy_fd_dir_parentid="&rsOne("id")&" order by [order]"
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
		replaceString=replaceString&"<div class='articleDirTree'>"
		replaceString=replaceString&"<ul>"
		do while not rs.eof
		iFolderName=rs("Folder")
		if rs("ClassType")=3 then iFolderName=rs("Folder")&".html"
		replaceString=replaceString&"<li id=directoryID"&rs("id")&"><A href='$Site_GenMuLu$"&rsOne("Folder")&"/"&iFolderName&"'>"&rs("name")&"</A></li> "
		rs.movenext
		loop
		replaceString=replaceString&"</ul>"
		replaceString=replaceString&"</div>"
	end if
	rs.close
	set rs=nothing
	
	replaceString=replaceString&"</div>"
	replaceString=replaceString&"<div class='HeightTab clearfix'></div>"
end if
rsOne.close
set rsOne=nothing
SideArticleClassList=replace(templateString,"###side_common_class_list###",replaceString)
End Function
%>

<%
'=================================================
'函数：侧边栏,最新资讯
'=================================================
Function SideNewestInfo(templateString,classTypeNumber)
dim rs,sql,rs_url,replaceString
replaceString=""
set rs=server.createobject("adodb.recordset")

dim jhy_fd_side_newestnumber
jhy_fd_side_newestnumber=0
sql="select jhy_fd_side_newestnumber from juhaoyong_tb_siteconfig"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
	jhy_fd_side_newestnumber=rs("jhy_fd_side_newestnumber")
end if
rs.close

if jhy_fd_side_newestnumber>0 then
	replaceString=replaceString&"<div class='Sbox'>"
	replaceString=replaceString&"<div class='topic'>"&juhaoyongGetFieldValue("juhaoyong_tb_indexconfig","jhy_fd_index_column2")&"</div>"
	replaceString=replaceString&"<div class='list'>"
	sql="SELECT TOP "&jhy_fd_side_newestnumber&" a.jhy_fd_leveltwo_id, a.title, a.html_file_name, b.folder, c.folder"
	sql=sql&" FROM (juhaoyong_tb_content AS a"
	sql=sql&" LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id)"
	sql=sql&" LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id"
	sql=sql&" WHERE a.ArticleType=1 ORDER BY a.index_push DESC,a.edit_time DESC,a.id DESC"
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
		replaceString=replaceString&"<dl>"
		do while not rs.eof
			rs_url=""
			if rs("jhy_fd_leveltwo_id")<>"" then
				rs_url="$Site_GenMuLu$"&rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
			else
				rs_url="$Site_GenMuLu$"&rs("b.folder")&"/"&rs("html_file_name")
			end if
			replaceString=replaceString&"<dd><div class='phzxtitleicon'></div><a href='"&rs_url&"' target='_blank' title='"&rs("title")&"'>"&left(rs("title"),15)&"</a><div class='clearfix'></div></dd>"
		rs.movenext
		loop
		replaceString=replaceString&"</dl>"
	end if
	rs.close
	replaceString=replaceString&"</div>"
	replaceString=replaceString&"</div>"
	replaceString=replaceString&"<div class='HeightTab clearfix'></div>"
end if

set rs=nothing
if classTypeNumber=2 then
	SideNewestInfo=replace(templateString,"###side_area_position_2###",replaceString)
else
	SideNewestInfo=replace(templateString,"###side_area_position_1###",replaceString)
end if
End Function
%>

<%
'=================================================
'函数：侧边栏,产品点击排行
'=================================================
Function SideHotProduct(templateString,classTypeNumber)
dim rs,sql,rs_url,replaceString
replaceString=""
set rs=server.createobject("adodb.recordset")

dim jhy_fd_side_hotnumber,jhy_fd_hot_product
jhy_fd_side_hotnumber=0
jhy_fd_hot_product=""
sql="select jhy_fd_side_hotnumber,jhy_fd_hot_product from juhaoyong_tb_siteconfig"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
	jhy_fd_side_hotnumber=rs("jhy_fd_side_hotnumber")
	jhy_fd_hot_product=rs("jhy_fd_hot_product")
end if
rs.close

if jhy_fd_side_hotnumber>0 then
	replaceString=replaceString&"<div class='Sbox'>"
	replaceString=replaceString&"<div class='topic'>"&jhy_fd_hot_product&"</div>"
	replaceString=replaceString&"<div class='list'>"
	sql="select top "&jhy_fd_side_hotnumber&" a.jhy_fd_leveltwo_id, a.title, a.html_file_name, a.image, a.con_youhuijia, b.folder, c.folder"
	sql=sql&" from (juhaoyong_tb_content AS a"
	sql=sql&" LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id)"
	sql=sql&" LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id"
	sql=sql&" where ArticleType=2 order by a.hit desc,a.id DESC"
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
		replaceString=replaceString&"<dl>"
		do while not rs.eof
			if rs("jhy_fd_leveltwo_id")&""<>"" then
				rs_url="$Site_GenMuLu$"&rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
			else
				rs_url="$Site_GenMuLu$"&rs("b.folder")&"/"&rs("html_file_name")
			end if
			
			if rs("image")&""<>"" then
				rs_pimg_url="$Site_GenMuLu$images/up_images/"&rs("image")
			else
				rs_pimg_url="$Site_GenMuLu$images/up_images/nophoto.jpg"
			end if
			
			if trim(rs("con_youhuijia")&"")<>"" then
				rs_jiage="<div class='phzxprice'><span>&#165;</span>"&rs("con_youhuijia")&"</div>"
			else
				rs_jiage=""
			end if
			
			replaceString=replaceString&"<dd><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'><img src='"&rs_pimg_url&"' alt='"&rs("title")&"'></a><div class='phzxtitle'><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&left(rs("title"),22)&"</a></div>"&rs_jiage&"<div class='clearfix'></div></dd>"
		rs.movenext
		loop
		replaceString=replaceString&"</dl>"
	end if
	rs.close
	replaceString=replaceString&"</div>"
	replaceString=replaceString&"</div>"
	replaceString=replaceString&"<div class='HeightTab clearfix'></div>"
end if
set rs=nothing
if classTypeNumber=2 then
	SideHotProduct=replace(templateString,"###side_area_position_1###",replaceString)
else
	SideHotProduct=replace(templateString,"###side_area_position_2###",replaceString)
end if
End Function
%>

<%
'=================================================
'函数：侧边栏搜索框
'=================================================
Function SideSearchBox(templateString)
dim replaceString
replaceString=""
replaceString=replaceString&"<div class='topic searchClassID'>搜索</div>"
replaceString=replaceString&"<div class='SearchBar'>"
replaceString=replaceString&"<form method='get' action='$Site_GenMuLu$search/index.asp'>"
replaceString=replaceString&"<input type='text' name='q' id='search-text' size='15' onBlur="&chr(34)&"if(this.value=='') this.value='请输入关键词';"&chr(34)&" onfocus="&chr(34)&"if(this.value=='请输入关键词') this.value='';"&chr(34)&" value='请输入关键词' />"
replaceString=replaceString&"<input type='submit' id='search-submit' value='搜索' />"
replaceString=replaceString&"</form>"
replaceString=replaceString&"</div>"
SideSearchBox=replace(templateString,"###side_search_box###",replaceString)
End Function
%>

<%
'=================================================
'函数：友情链接
'=================================================
function JuhaoyongLinksHtmlCode(templateString)
dim rs,sql,replaceString
replaceString=""
set rs = server.CreateObject("adodb.recordset")
sql="select  [name],[url],[image],follow_yes from juhaoyong_tb_link where view_yes=1 order by [order]"
rs.open(sql),cn,1,1
if not rs.eof then
	replaceString=replaceString&"<div id='JuhaoyongLinks'>"
	replaceString=replaceString&"<span>友情链接：</span>"
	do while not rs.eof
		if rs("follow_yes")=1 then
		NoFollow="rel='nofollow'"
		else
		NoFollow=""
		end if 
		replaceString=replaceString&"<a href='"&rs("url")&"' target='_blank' "&NoFollow&">"&rs("name")&"</a>"
		rs.movenext
	loop
	replaceString=replaceString&"</div>"
else
	replaceString=""
end if
rs.close
set rs=nothing

JuhaoyongLinksHtmlCode=replace(templateString,"###juhaoyong_links_html_code_string###",replaceString)
end function
%>

<%
'=================================================
'函数：在线悬浮客服
'=================================================
function JuhaoyongKefuHtmlCode(templateString)
dim rs,sql,replaceString
replaceString=""
'<!----------------------在线悬浮客服代码开始---------------------->
replaceString=replaceString&"<DIV id=juhaoyong_xuanfukefu>"
replaceString=replaceString&"<DIV id=juhaoyong_xuanfukefuBut><table class=juhaoyong_xuanfukefuBut_table border=0 cellspacing=0 cellpadding=0><tr><td> </td></tr></table></DIV>"
replaceString=replaceString&"<DIV id=juhaoyong_xuanfukefuContent>"
replaceString=replaceString&"<table width=143 border=0 cellspacing=0 cellpadding=0>"
replaceString=replaceString&"<tr><td class=juhaoyong_xuanfukefuContent01 valign=top> </td></tr>"
replaceString=replaceString&"<tr><td class=juhaoyong_xuanfukefuContent02 align=center>"
replaceString=replaceString&"	<table border=0 cellspacing=0 cellpadding=0 align=center>"
set rs = server.CreateObject("adodb.recordset")
sql="select * from juhaoyong_tb_kefu order by kfshunxu,id"
rs.Open (sql),cn,1,1
if not rs.eof then
	do while not rs.eof
		replaceString=replaceString&"    <tr><td class=jhykefu_box1>"&rs("name")&"</td></tr>"
		if rs("kftype")=2 then
		replaceString=replaceString&"    <tr><td class=jhykefu_box2><img src='$Site_GenMuLu$css/"&SITE_STYLE_CSS_FOLDER&"/"&rs("image")&"' width='115' boder='0'></td></tr>"
		else
		replaceString=replaceString&"    <tr><td class=jhykefu_box2>"&rs("memo")&"</td></tr>"
		end if
	rs.movenext
	loop
	replaceString=replaceString&"	</table>"
	replaceString=replaceString&"</td></tr>	"
	replaceString=replaceString&"<tr><td class=juhaoyong_xuanfukefuContent03></td></tr>"
	replaceString=replaceString&"</table>"
	replaceString=replaceString&"</DIV>"
	replaceString=replaceString&"</DIV>"
'<!----------------------在线悬浮客服代码结束---------------------->
else
	replaceString=""
end if 
rs.close
set rs=nothing
JuhaoyongKefuHtmlCode=replace(templateString,"###juhaoyong_kefu_html_code_string###",replaceString)
end function
%>

<%
'=================================================
'函数：读源模板文件，生成模板文件
'classTypeNumber=0首页、1文章、2产品、3单页
'=================================================
Function RewriteTemplateFile(classTypeNumber,oneClassId)
dim templateFileNameSource,templateFileName,rewriteTemplateString
dim fso,f

templateFileNameSource="template_inside.html"
select case classTypeNumber
	case 0
		templateFileNameSource="template_index.html"
		templateFileName=templateFileNameSource
	case 1
		templateFileName="template_article"&oneClassId&".html"
	case 2
		templateFileName="template_product"&oneClassId&".html"
	case 3
		templateFileName="template_singlepage"&oneClassId&".html"
	case 4
		templateFileName="template_other.html"
end select

Set fso=Server.CreateObject("Scripting.FileSystemObject")

'读源模板文件
Set f=fso.OpenTextFile(Server.MapPath("../templates/"&SITE_TEMPLATE_SOURCE_FOLDER&"/"&templateFileNameSource), 1)
	rewriteTemplateString=f.ReadAll
f.Close

'替换模板文件内容开始
rewriteTemplateString=SiteSetInfo(rewriteTemplateString)'替换--网站基本信息
rewriteTemplateString=TopNavigation(rewriteTemplateString)'替换--顶部导航

if classTypeNumber>0 then

	rewriteTemplateString=SideArticleClassList(rewriteTemplateString,classTypeNumber,oneClassId)'替换--侧边栏分类列表（classTypeNumber=1文章、2产品、3单页）
	
	rewriteTemplateString=SideNewestInfo(rewriteTemplateString,classTypeNumber)'替换--侧边栏最新资讯
	rewriteTemplateString=SideHotProduct(rewriteTemplateString,classTypeNumber)'替换--侧边栏产品点击排行
	
	rewriteTemplateString=SideSearchBox(rewriteTemplateString)'替换--侧边栏搜索框
	
	rewriteTemplateString=ProductImageboxOrderwinCssjs(rewriteTemplateString,classTypeNumber)'替换--产品模版中插入图片展示box和order弹出页面的css和js替换标签
end if

if classTypeNumber=0 then
rewriteTemplateString=JuhaoyongLinksHtmlCode(rewriteTemplateString)'替换--友情链接
end if

rewriteTemplateString=BottomNavigation(rewriteTemplateString)'替换--底部导航

rewriteTemplateString=JuhaoyongKefuHtmlCode(rewriteTemplateString)'替换--在线悬浮客服
'替换模板文件内容结束
'重新生成模板文件
Set f=fso.CreateTextFile(Server.MapPath("../templates/"&SITE_TEMPLATE_FOLDER&"/"&templateFileName))
	f.Write rewriteTemplateString
f.Close

Set f=Nothing
Set fso=nothing
End Function
%>