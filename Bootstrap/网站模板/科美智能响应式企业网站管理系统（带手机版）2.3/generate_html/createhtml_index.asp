<%
function Run_createhtml_index()
dim rs,sql
dim fso,htmlwrite,replace_code
dim i
dim f,filepath

'读取模板内容
Set fso=Server.CreateObject("Scripting.FileSystemObject")
Set htmlwrite=fso.OpenTextFile(Server.MapPath("../templates/"&SITE_TEMPLATE_FOLDER&"/template_index.html"))
replace_code=htmlwrite.ReadAll()
htmlwrite.close

'首页内容读取替换
set rs=server.createobject("adodb.recordset")
sql="select * from juhaoyong_tb_indexconfig"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
jhy_fd_index_title=rs("jhy_fd_index_title")
jhy_fd_index_keywords=rs("jhy_fd_index_keywords")
jhy_fd_index_description=rs("jhy_fd_index_description")

jhy_fd_index_column1=rs("jhy_fd_index_column1")
jhy_fd_index_url1=rs("jhy_fd_index_url1")
jhy_fd_index_image1=rs("jhy_fd_index_image1")
if trim(jhy_fd_index_image1&"")="" then
jhy_fd_index_image1=""
else
jhy_fd_index_image1="<div class='img'><a href='"&jhy_fd_index_url1&"' title='"&jhy_fd_index_column1&"' target='_blank'><img src='css/"&SITE_STYLE_CSS_FOLDER&"/"&jhy_fd_index_image1&"' alt='"&jhy_fd_index_column1&"'></a></div>"
end if
jhy_fd_index_code1=rs("jhy_fd_index_code1")

jhy_fd_index_column2=rs("jhy_fd_index_column2")
jhy_fd_index_url2=rs("jhy_fd_index_url2")

jhy_fd_index_column3=rs("jhy_fd_index_column3")
jhy_fd_index_url3=rs("jhy_fd_index_url3")
jhy_fd_index_image3=rs("jhy_fd_index_image3")
if trim(jhy_fd_index_image3&"")="" then
jhy_fd_index_image3=""
else
jhy_fd_index_image3="<div class='img'><a href='"&jhy_fd_index_url3&"' title='"&jhy_fd_index_column3&"' target='_blank'><img src='css/"&SITE_STYLE_CSS_FOLDER&"/"&jhy_fd_index_image3&"' alt='"&jhy_fd_index_column3&"'></a></div>"
end if
jhy_fd_index_code3=rs("jhy_fd_index_code3")


jhy_fd_index_column4=rs("jhy_fd_index_column4")
jhy_fd_index_url4=rs("jhy_fd_index_url4")
jhy_fd_index_onoff4=rs("jhy_fd_index_onoff4")

jhy_fd_index_number1=rs("jhy_fd_index_number1")
jhy_fd_index_number2=rs("jhy_fd_index_number2")
end if
rs.close

b_websiteroot=""
replace_code=replace(replace_code,"$Site_GenMuLu$",b_websiteroot)

replace_code=replace(replace_code,"$this_page_title$",jhy_fd_index_title)
replace_code=replace(replace_code,"$this_page_keywords$",jhy_fd_index_keywords)
replace_code=replace(replace_code,"$this_page_description$",jhy_fd_index_description)

replace_code=replace(replace_code,"$jhy_fd_index_column1$",jhy_fd_index_column1)
replace_code=replace(replace_code,"$jhy_fd_index_url1$",jhy_fd_index_url1)
replace_code=replace(replace_code,"$jhy_fd_index_image1$",jhy_fd_index_image1)
replace_code=replace(replace_code,"$jhy_fd_index_code1$",jhy_fd_index_code1)

replace_code=replace(replace_code,"$jhy_fd_index_column2$",jhy_fd_index_column2)
replace_code=replace(replace_code,"$jhy_fd_index_url2$",jhy_fd_index_url2)

replace_code=replace(replace_code,"$jhy_fd_index_column3$",jhy_fd_index_column3)
replace_code=replace(replace_code,"$jhy_fd_index_url3$",jhy_fd_index_url3)
replace_code=replace(replace_code,"$jhy_fd_index_image3$",jhy_fd_index_image3)
replace_code=replace(replace_code,"$jhy_fd_index_code3$",jhy_fd_index_code3)

replace_code=replace(replace_code,"$jhy_fd_index_column4$",jhy_fd_index_column4)
replace_code=replace(replace_code,"$jhy_fd_index_url4$",jhy_fd_index_url4)

'首页顶部轮播图片读取替换
sql="select top 9 name,url,image from juhaoyong_tb_picture where view_yes=1 order by [order],id"
rs.open(sql),cn,1,1
if not rs.eof then
	
	for i=1 to rs.recordcount
	jhyindexlunbo_1_temp=jhyindexlunbo_1_temp&"<li id='juhaoyongLunboImgLi"&i&"' style="&chr(34)&"background:url('css/"&SITE_STYLE_CSS_FOLDER&"/"&rs("image")&"'); background-repeat:no-repeat; background-position:top center; width:100%; height:100%;"&chr(34)&"><a href="&rs("url")&" title='"&rs("name")&"' target='_blank'><p></p></a></li>"
	jhyindexlunbo_2_temp_1=jhyindexlunbo_2_temp_1&"<a href='javascript:;'>●</a>"
	jhyindexlunbo_2_temp_2=jhyindexlunbo_2_temp_2&"var juhaoyongLunboImgLiId"&i&" = document.getElementById('juhaoyongLunboImgLi"&i&"');juhaoyongLunboImgLiId"&i&".style.width = juhaoyongLunboImgLiWidth+'px';"
	rs.movenext
	next
	
	jhyindexlunbo_1=jhyindexlunbo_1&"<div class='Focus'>"
	if rs.recordcount>1 then
	jhyindexlunbo_1=jhyindexlunbo_1&"<a href='javascript:;' class='index_focus_pre' title='上一张'>上一张</a>"
	jhyindexlunbo_1=jhyindexlunbo_1&"<a href='javascript:;' class='index_focus_next' title='下一张'>下一张</a>"
	end if
	jhyindexlunbo_1=jhyindexlunbo_1&"<div class='bd'>"
	jhyindexlunbo_1=jhyindexlunbo_1&"<ul>"
	jhyindexlunbo_1=jhyindexlunbo_1&jhyindexlunbo_1_temp
	jhyindexlunbo_1=jhyindexlunbo_1&"</ul>"
	jhyindexlunbo_1=jhyindexlunbo_1&"</div>"
	
	if rs.recordcount>1 then
	jhyindexlunbo_2=jhyindexlunbo_2&"<div class='slide_nav'>"
	jhyindexlunbo_2=jhyindexlunbo_2&jhyindexlunbo_2_temp_1
	jhyindexlunbo_2=jhyindexlunbo_2&"</div>"
	end if
	jhyindexlunbo_2=jhyindexlunbo_2&"</div>"
	jhyindexlunbo_2=jhyindexlunbo_2&"<script type='text/javascript' src='js/juhaoyongLunbo001.js'></script>"
	
	jhyindexlunbo_2=jhyindexlunbo_2&"<script type='text/javascript'>"
	jhyindexlunbo_2=jhyindexlunbo_2&"window.onresize = function() {"
	jhyindexlunbo_2=jhyindexlunbo_2&"var juhaoyongLunboImgLiWidth=document.documentElement.clientWidth;"
	jhyindexlunbo_2=jhyindexlunbo_2&jhyindexlunbo_2_temp_2
	jhyindexlunbo_2=jhyindexlunbo_2&"};"
	jhyindexlunbo_2=jhyindexlunbo_2&"</script>"
else
	jhyindexlunbo_1=""
	jhyindexlunbo_2=""
end if
rs.close

replace_code=replace(replace_code,"$web_TopIMGAD$",jhyindexlunbo_1&jhyindexlunbo_2)

'新闻动态
sql="SELECT TOP 9 a.jhy_fd_leveltwo_id, a.title, a.html_file_name, a.edit_time, b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id WHERE a.ArticleType=1 ORDER BY a.index_push DESC,a.edit_time DESC,a.id DESC"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then

i=0
do while not rs.eof
	rs_url=""
	if rs("jhy_fd_leveltwo_id")&""<>"" then
		rs_url=rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
	else
		rs_url=rs("b.folder")&"/"&rs("html_file_name")
	end if
	WebNewNewsList=WebNewNewsList&"<tr><td width='80%' class='ListTitle'><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&left(rs("title"),25)&"</a></td>"
	WebNewNewsList=WebNewNewsList&"<td width='20%'><span>"&GetFormatDate(rs("edit_time"))&"</span></td></tr>"
	rs.movenext
i=i+1
if i=9 then exit do
loop
else
WebNewNewsList=WebNewNewsList&"暂无信息。"
end if
rs.close

replace_code=replace(replace_code,"$WebNewNewsList$",WebNewNewsList)

'产品推荐标题
dim strJuHaoYongProLb
strJuHaoYongProLb=""
strJuHaoYongProLb=strJuHaoYongProLb&"<div class='productIndexTuijian'>"
strJuHaoYongProLb=strJuHaoYongProLb&"<div class='topic'>"
strJuHaoYongProLb=strJuHaoYongProLb&"<div class='TopicTitle'><a href='"&jhy_fd_index_url4&"' target='_blank'>"&jhy_fd_index_column4&"</a></div>"
strJuHaoYongProLb=strJuHaoYongProLb&"<div class='TopicMore'> <a href='"&jhy_fd_index_url4&"' target='_blank'><img src='images/more.png'></a></div>"
strJuHaoYongProLb=strJuHaoYongProLb&"</div>"
strJuHaoYongProLb=strJuHaoYongProLb&"</div>"
strJuHaoYongProLb=strJuHaoYongProLb&"<div class='clearfix'></div>"
'产品推荐标题结束
'产品推荐图片轮播开始
strJuHaoYongProLb=strJuHaoYongProLb&"<div class='juhaoyong_product_lunbo'>"
strJuHaoYongProLb=strJuHaoYongProLb&"	<div class='jhy_index_lb_box'>"
strJuHaoYongProLb=strJuHaoYongProLb&"		<img class='jhy_ilb_btn_left prev' src='css/"&SITE_STYLE_CSS_FOLDER&"/juhaoyong_plb_button_l.gif' width='28' height='46' />"
strJuHaoYongProLb=strJuHaoYongProLb&"		<div class='jhy_ilb_ul_outside'>"
strJuHaoYongProLb=strJuHaoYongProLb&"			<ul>"
sql="SELECT a.jhy_fd_leveltwo_id,a.title, a.html_file_name, a.image, a.con_youhuijia, b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id WHERE a.ArticleType=2 and a.index_push=1 ORDER BY a.edit_time DESC,a.id DESC"
rs.open(sql),cn,1,1
if not rs.eof then
	do while not rs.eof
		rs_url=""
		if rs("jhy_fd_leveltwo_id")&""<>"" then
			rs_url=rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
		else
			rs_url=rs("b.folder")&"/"&rs("html_file_name")
		end if
		
		tuijianjiage=""
		if rs("con_youhuijia")&""<>"" then
		tuijianjiage="<div class='tuijianjiage'>&#165;"&rs("con_youhuijia")&"</div>"
		end if
		
		strJuHaoYongProLb=strJuHaoYongProLb&"<li><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'><img src='images/up_images/"&rs("image")&"' alt='"&rs("title")&"' /></a>"
		strJuHaoYongProLb=strJuHaoYongProLb&"<span><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&trim(left(rs("title"),10))&"</a></span>"&tuijianjiage&"</li>"
	rs.movenext
	loop
else
	strJuHaoYongProLb_kaiguan="0"
end if
rs.close
strJuHaoYongProLb=strJuHaoYongProLb&"			</ul>"
strJuHaoYongProLb=strJuHaoYongProLb&"		</div>"
strJuHaoYongProLb=strJuHaoYongProLb&"		<img class='jhy_ilb_btn_right next' src='css/"&SITE_STYLE_CSS_FOLDER&"/juhaoyong_plb_button_r.gif' width='28' height='46' />"
strJuHaoYongProLb=strJuHaoYongProLb&"	</div>"
strJuHaoYongProLb=strJuHaoYongProLb&"</div>"
strJuHaoYongProLb=strJuHaoYongProLb&"<div class='HeightTab2 clearfix'></div>"
strJuHaoYongProLb=strJuHaoYongProLb&"<script language='javascript'>"
strJuHaoYongProLb=strJuHaoYongProLb&"jQuery('.jhy_index_lb_box').slide({titCell:'',mainCell:'.jhy_ilb_ul_outside ul',autoPage:true,effect:'leftLoop',autoPlay:true,vis:4});"
strJuHaoYongProLb=strJuHaoYongProLb&"</script>"
'产品推荐图片轮播结束
if strJuHaoYongProLb_kaiguan="0" or jhy_fd_index_onoff4=0 then
	strJuHaoYongProLb=""
end if
replace_code=replace(replace_code,"$juhaoyong_index_product_lunbo$",strJuHaoYongProLb)

'首页产品栏目推荐列表开始
jhy_index_product_column_list=JhyIndexProductColumnListN(jhy_fd_index_number1)
replace_code=replace(replace_code,"$jhy_index_product_column_list$",jhy_index_product_column_list)
'首页产品栏目推荐列表结束

'底部文章块列表（嵌套循环）开始
'外部循环开始
sql="select a.name,a.folder,a.id,a.jhy_fd_dir_parentid,b.folder from juhaoyong_tb_directory AS a LEFT JOIN juhaoyong_tb_directory AS b ON b.id=a.jhy_fd_dir_parentid WHERE a.ClassType=1 and a.index_push=1 ORDER BY [a.order],a.id"
rs.open(sql),cn,1,1
if not rs.eof then
	juhaoyongi=0
	jhyArticleListHtml=jhyArticleListHtml&"<!--jhyArticleListMainBlock start-->"
	jhyArticleListHtml=jhyArticleListHtml&"<div class='jhyArticleListMainBlock'>"
	
	do while not rs.eof
	
	aFolderPath=""
	if rs("jhy_fd_dir_parentid")>0 then
		aFolderPath=rs("b.folder")&"/"&rs("a.folder")
	else
		aFolderPath=rs("a.folder")
	end if
	
	if (juhaoyongi mod 3 =0) and juhaoyongi>0 then
	jhyArticleListHtml=jhyArticleListHtml&"</div><div class='juhaoyongHeightTab clearfix'></div><div class='jhyArticleListMainBlock'>"
	end if
	
	if (juhaoyongi+2) mod 3 =0 or (juhaoyongi+1) mod 3 =0 then
	jhyArticleListHtml=jhyArticleListHtml&"<div class='WidthTab2'></div>"
	end if
	
	jhyArticleListHtml=jhyArticleListHtml&"<!--列表单元开始-->"
	if (juhaoyongi+2) mod 3 =0 then
	jhyArticleListHtml=jhyArticleListHtml&"<div class='juhaoyongALCommonUnit1'>"
	else
	jhyArticleListHtml=jhyArticleListHtml&"<div class='juhaoyongALCommonUnit2'>"
	end if
	
	jhyArticleListHtml=jhyArticleListHtml&"<div class='topic'>"
	jhyArticleListHtml=jhyArticleListHtml&"<div class='TopicTitle'><a  href='"&aFolderPath&"' target='_blank'>"&rs("name")&"</a></div>"
	jhyArticleListHtml=jhyArticleListHtml&"<div class='TopicMore'> <a  href='"&aFolderPath&"' target='_blank'><img src='images/more.png'></a></div>"
	jhyArticleListHtml=jhyArticleListHtml&"</div>"
	jhyArticleListHtml=jhyArticleListHtml&"<div class='juhaoyongCommonUnitArticleList'>"
	jhyArticleListHtml=jhyArticleListHtml&"<table class='JHYBlockTable' width='100%' border='0' cellspacing='0' cellpadding='0'>"
		'内部循环（获取文章列表）开始
		set rs01=server.createobject("adodb.recordset")
		sql="select top "&jhy_fd_index_number2&" a.jhy_fd_leveltwo_id,a.title,a.html_file_name,a.edit_time, b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id where (a.jhy_fd_levelone_id='"&rs("id")&"' or a.jhy_fd_leveltwo_id='"&rs("id")&"') and a.ArticleType=1 order by a.index_push DESC,a.edit_time DESC,a.id DESC"
		rs01.open(sql),cn,1,1
		if not rs01.eof then
			do while not rs01.eof
				
				rs_url=""
				if rs01("jhy_fd_leveltwo_id")&""<>"" then
					rs_url=rs01("b.folder")&"/"&rs01("c.folder")&"/"&rs01("html_file_name")
				else
					rs_url=rs01("b.folder")&"/"&rs01("html_file_name")
				end if
				
				if (juhaoyongi+2) mod 3 =0 then
				jhyArticleListHtml=jhyArticleListHtml&"<tr><td width='81%' class='ListTitle'><a href='"&rs_url&"' title='"&rs01("title")&"' target='_blank'>"&left(rs01("title"),25)&"</a></td>"
				jhyArticleListHtml=jhyArticleListHtml&"<td width='19%'><span>"&GetFormatDate(rs01("edit_time"))&"</span></td></tr>"
				else
				jhyArticleListHtml=jhyArticleListHtml&"<tr><td width='75%' class='ListTitle'><a href='"&rs_url&"' title='"&rs01("title")&"' target='_blank'>"&left(rs01("title"),16)&"</a></td>"
				jhyArticleListHtml=jhyArticleListHtml&"<td width='25%'><span>"&GetFormatDate(rs01("edit_time"))&"</span></td></tr>"
				end if
				rs01.movenext
			loop
		else
			jhyArticleListHtml=jhyArticleListHtml&"<tr><td>暂无信息。</td></tr>"
		end if
		rs01.close
		set rs01=nothing
		'内部循环（获取文章列表）结束
	jhyArticleListHtml=jhyArticleListHtml&"</table>"
	jhyArticleListHtml=jhyArticleListHtml&"</div>"
	jhyArticleListHtml=jhyArticleListHtml&"</div>"
	jhyArticleListHtml=jhyArticleListHtml&"<!--列表单元结束-->"
	
	rs.movenext
	juhaoyongi=juhaoyongi+1
	loop
	
	jhyArticleListHtml=jhyArticleListHtml&"</div>"
	jhyArticleListHtml=jhyArticleListHtml&"<div class='HeightTab2 clearfix'></div>"
	jhyArticleListHtml=jhyArticleListHtml&"<!--jhyArticleListMainBlock end-->"
end if
rs.close
set rs=nothing
'外部循环结束

replace_code=replace(replace_code,"$jhyArticleListHtml$",jhyArticleListHtml)
'底部文章块列表（嵌套循环）结束
%>

<%
'声明HTML文件名,指定文件路径
filepath="../index.html"
'生成首页静态文件
Set f = fso.CreateTextFile(Server.MapPath(filepath))
f.WriteLine replace_code
f.close
set f=nothing
set fso=nothing
end function
%>

<%
'=================================================
'函数：产品栏目列表（单个产品栏目的循环）
'=================================================
Function JhyIndexProductColumnListN(productnum)
dim htmlstring
dim rs,sql
htmlstring=""
set rs=server.createobject("adodb.recordset")
sql="select a.name,a.folder,a.id,a.jhy_fd_dir_parentid,b.folder from juhaoyong_tb_directory AS a LEFT JOIN juhaoyong_tb_directory AS b ON b.id=a.jhy_fd_dir_parentid WHERE a.ClassType=2 and a.index_push=1 ORDER BY [a.order],a.id"
rs.open(sql),cn,1,1
if not rs.eof then
	do while not rs.eof
	
	aFolderPath=""
	if rs("jhy_fd_dir_parentid")>0 then
		aFolderPath=rs("b.folder")&"/"&rs("a.folder")
	else
		aFolderPath=rs("a.folder")
	end if
	
	htmlstring=htmlstring&JhyIndexProductColumnList(rs("id"),rs("name"),aFolderPath,productnum)
	rs.movenext
	loop
end if
rs.close
set rs=nothing
JhyIndexProductColumnListN=htmlstring
end Function
'=================================================
'函数：单个产品栏目列表
'=================================================
Function JhyIndexProductColumnList(adirid,dirname,dirfolder,productnum)
'一个产品栏目开始
dim htmlstring
dim rs,sql
htmlstring=""
set rs=server.createobject("adodb.recordset")
sql="select top "&productnum&" a.jhy_fd_leveltwo_id,a.title,a.html_file_name,a.con_youhuijia,a.image, b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id where a.ArticleType=2 and (a.jhy_fd_levelone_id='"&adirid&"' or a.jhy_fd_leveltwo_id='"&adirid&"') order by a.edit_time desc,a.id DESC"
rs.open(sql),cn,1,1
if not rs.eof then
	dim juhaoyongi,rs_url
	juhaoyongi=0
	htmlstring=htmlstring&"<div class=productIndexTuijian>"
	htmlstring=htmlstring&"<div class=topic>"
	htmlstring=htmlstring&"<div class=TopicTitle><a href='"&dirfolder&"' target='_blank'>"&dirname&"</a></div>"
	htmlstring=htmlstring&"<div class=TopicMore> <a href='"&dirfolder&"' target='_blank'><img src=images/more.png></a></div>"
	htmlstring=htmlstring&"</div>"
	htmlstring=htmlstring&"</div>"
	
	htmlstring=htmlstring&"<!--JuhaoyongProductColList start-->"
	htmlstring=htmlstring&"<div class=JuhaoyongProductColList>"
	htmlstring=htmlstring&"<div class=TabBlock>"
	htmlstring=htmlstring&"<DIV class=juhaoyong4hangList>"
	
	do while not rs.eof 
		rs_url=""
		if rs("jhy_fd_leveltwo_id")&""<>"" then
			rs_url=rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
		else
			rs_url=rs("b.folder")&"/"&rs("html_file_name")
		end if
	
		if (juhaoyongi mod 4 =0) and juhaoyongi>0 then
		htmlstring=htmlstring&"</DIV><div class='clearfix'></div><DIV class=juhaoyong4hangList>"
		end if
		
		htmlstring=htmlstring&"<DIV class='box'>"
		htmlstring=htmlstring&"<DIV class='boxImage'><A class='imgBorder' href='"&rs_url&"' title='"&rs("title")&"' target='_blank'><IMG src='images/up_images/"&rs("image")&"' alt='"&rs("title")&"'></A></DIV>"
		htmlstring=htmlstring&"<DIV class='boxTittle'><A class='imgBorder' href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&rs("title")&"</A></DIV>"
		if rs("con_youhuijia")<>"" then
		htmlstring=htmlstring&"<DIV class='boxPrice'>&#165;"&rs("con_youhuijia")&"</DIV>"
		end if
		htmlstring=htmlstring&"</DIV>"
	rs.movenext
	juhaoyongi=juhaoyongi+1
	loop
	
	htmlstring=htmlstring&"<div class='clearfix'></div></DIV>"
	htmlstring=htmlstring&"</div>"
	htmlstring=htmlstring&"<div class=clearfix></div>"
	htmlstring=htmlstring&"</div>"
	htmlstring=htmlstring&"<div class='HeightTab2 clearfix'></div>"
	htmlstring=htmlstring&"<!--JuhaoyongProductColList end-->"
end if
rs.close
set rs=nothing
'一个产品栏目结束
JhyIndexProductColumnList=htmlstring
end Function
%>
