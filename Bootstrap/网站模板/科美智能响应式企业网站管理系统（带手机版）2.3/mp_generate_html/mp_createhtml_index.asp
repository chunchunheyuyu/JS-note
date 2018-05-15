<%
function MP_Run_createhtml_index(mpsitefoldername)
dim rs,sql
dim fso,htmlwrite,replace_code
dim i
dim f,filepath

'读取模板内容
Set fso=Server.CreateObject("Scripting.FileSystemObject")
Set htmlwrite=fso.OpenTextFile(Server.MapPath("../templates/"&MP_SITE_TEMPLATE_FOLDER&"/mp_template_index.html"))
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
jhy_fd_index_image1="<div class='columntitleimage'><a href='"&jhy_fd_index_url1&"' title='"&jhy_fd_index_column1&"' target='_blank'><img src='../css/"&SITE_STYLE_CSS_FOLDER&"/"&jhy_fd_index_image1&"' alt='"&jhy_fd_index_column1&"' border='0'></a></div>"
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
jhy_fd_index_image3="<div class='columntitleimage'><a href='"&jhy_fd_index_url3&"' title='"&jhy_fd_index_column3&"' target='_blank'><img src='../css/"&SITE_STYLE_CSS_FOLDER&"/"&jhy_fd_index_image3&"' alt='"&jhy_fd_index_column3&"' border='0'></a></div>"
end if
jhy_fd_index_code3=rs("jhy_fd_index_code3")


jhy_fd_index_column4=rs("jhy_fd_index_column4")
jhy_fd_index_url4=rs("jhy_fd_index_url4")

jhy_fd_index_number1=rs("jhy_fd_index_number1")
jhy_fd_index_number2=rs("jhy_fd_index_number2")
end if
rs.close

'获取手机网站设置开始
mp_fd_index_number1=0
mp_fd_index_number2=0
sql="select mp_fd_site_logo,mp_fd_index_onoff4,mp_fd_index_number1,mp_fd_index_number2 from mp_juhaoyong_tb_siteconfig"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
	mp_fd_site_logo=rs("mp_fd_site_logo")
	mp_fd_index_onoff4=rs("mp_fd_index_onoff4")
	mp_fd_index_number1=rs("mp_fd_index_number1")
	mp_fd_index_number2=rs("mp_fd_index_number2")
end if
rs.close
'获取手机网站设置结束

b_websiteroot=""
mpparent_b_root="../"
replace_code=replace(replace_code,"$Site_GenMuLu$",b_websiteroot)
replace_code=replace(replace_code,"$MPparent_GenMuLu$",mpparent_b_root)

replace_code=replace(replace_code,"$mp_site_logo$",mp_fd_site_logo)

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

'产品推荐开始
dim strjuhaoyongtjprolt
dim howmanyrecs
strjuhaoyongtjprolt=""
sql="SELECT a.jhy_fd_leveltwo_id,a.title, a.html_file_name, a.con_youhuijia, a.image, b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id WHERE a.ArticleType=2 and a.index_push=1 ORDER BY a.edit_time DESC,a.id DESC"
rs.open(sql),cn,1,1
if not rs.eof then
strjuhaoyongtjprolt=strjuhaoyongtjprolt&"<div class='clearblockboth'></div>"
strjuhaoyongtjprolt=strjuhaoyongtjprolt&"<div class='column_title3'><a href='"&jhy_fd_index_url4&"' target='_blank'>"&jhy_fd_index_column4&"</a></div>"
strjuhaoyongtjprolt=strjuhaoyongtjprolt&"<div class='clearblockboth'></div>"
howmanyrecs=0
strjuhaoyongtjprolt=strjuhaoyongtjprolt&"<ul class='product'>"
	do while not rs.eof
		rs_url=""
		if rs("jhy_fd_leveltwo_id")&""<>"" then
			rs_url=rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
		else
			rs_url=rs("b.folder")&"/"&rs("html_file_name")
		end if
		
		if (howmanyrecs mod 2 =0) and howmanyrecs>0 then 
		strjuhaoyongtjprolt=strjuhaoyongtjprolt&"</ul><ul class='product clearfix'>"
		end if
		strjuhaoyongtjprolt=strjuhaoyongtjprolt&"<li><a class='picbox' href='"&rs_url&"' title='"&rs("title")&"' target='_blank'><img src='"&mpparent_b_root&"images/up_images/"&rs("image")&"' alt='"&rs("title")&"' /></a>"
		strjuhaoyongtjprolt=strjuhaoyongtjprolt&"<a class='pictitle' href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&trim(left(rs("title"),17))&"</a>"
		if rs("con_youhuijia")&""<>"" then
		strjuhaoyongtjprolt=strjuhaoyongtjprolt&"<span class='boxPrice clearfix'>&#165;"&rs("con_youhuijia")&"</span>"
		end if
		strjuhaoyongtjprolt=strjuhaoyongtjprolt&"</li>"
	rs.movenext
	howmanyrecs=howmanyrecs+1
	loop
strjuhaoyongtjprolt=strjuhaoyongtjprolt&"</ul>"
end if
rs.close
if mp_fd_index_onoff4=1 then
	replace_code=replace(replace_code,"$juhaoyong_index_product_tuijian$",strjuhaoyongtjprolt)
else
	replace_code=replace(replace_code,"$juhaoyong_index_product_tuijian$","")
end if
'产品推荐结束

'点击排行开始
strIndexProductHot=""
if mp_fd_index_number1>0 then
	sql="SELECT TOP "&mp_fd_index_number1&" a.jhy_fd_leveltwo_id, a.title, a.html_file_name, a.edit_time, a.image, a.con_youhuijia, b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id WHERE ArticleType=2 order by a.hit desc,a.id DESC"
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
	strIndexProductHot=strIndexProductHot&"<div class='clearblockboth'></div>"
	strIndexProductHot=strIndexProductHot&"<div class='column_title3'><a href='"&jhy_fd_index_url4&"' target='_blank'>"&juhaoyongGetFieldValue("juhaoyong_tb_siteconfig","jhy_fd_hot_product")&"</a></div>"
	strIndexProductHot=strIndexProductHot&"<div class='clearblockboth'></div>"
	strIndexProductHot=strIndexProductHot&"<ul class='articlelist'>"
		do while not rs.eof
			rs_url=""
			if rs("jhy_fd_leveltwo_id")&""<>"" then
				rs_url=rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
			else
				rs_url=rs("b.folder")&"/"&rs("html_file_name")
			end if
			
			if rs("image")&""<>"" then
				rs_pimg_url=mpparent_b_root&"images/up_images/"&rs("image")
			else
				rs_pimg_url=mpparent_b_root&"images/up_images/nophoto.jpg"
			end if
			
			if trim(rs("con_youhuijia")&"")<>"" then
				rs_jiage="<div class='phzxprice'><span>&#165;</span>"&rs("con_youhuijia")&"</div>"
			else
				rs_jiage=""
			end if
			
			strIndexProductHot=strIndexProductHot&"<li class='productli'><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'><img src='"&rs_pimg_url&"' alt='"&rs("title")&"'></a><div class='phzxtitle'><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&left(rs("title"),20)&"</a></div>"&rs_jiage&"<div class='clearblockboth'></div></li>"
		rs.movenext
		loop
	strIndexProductHot=strIndexProductHot&"</ul>"
	end if
	rs.close
end if
replace_code=replace(replace_code,"$index_product_hot$",strIndexProductHot)
'点击排行结束

'最新资讯开始
WebNewNewsList=""
if mp_fd_index_number2>0 then
	sql="SELECT TOP "&mp_fd_index_number2&" a.jhy_fd_leveltwo_id, a.title, a.html_file_name, a.edit_time, b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id WHERE a.ArticleType=1 ORDER BY a.index_push DESC,a.edit_time DESC,a.id DESC"
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
	WebNewNewsList=WebNewNewsList&"<div class='clearblockboth'></div>"
	WebNewNewsList=WebNewNewsList&"<div class='column_title3'><a href='"&jhy_fd_index_url2&"' target='_blank'>"&jhy_fd_index_column2&"</a></div>"
	WebNewNewsList=WebNewNewsList&"<div class='clearblockboth'></div>"
	WebNewNewsList=WebNewNewsList&"<ul class='articlelist'>"
		do while not rs.eof
			rs_url=""
			if rs("jhy_fd_leveltwo_id")&""<>"" then
				rs_url=rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
			else
				rs_url=rs("b.folder")&"/"&rs("html_file_name")
			end if
			WebNewNewsList=WebNewNewsList&"<li class='articleli'><div class='phzxtitle'><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&left(rs("title"),17)&"</a></div><div class='phzxtime'>"&GetFormatDate(rs("edit_time"))&"</div><div class='clearblockboth'></div></li>"
		rs.movenext
		loop
	WebNewNewsList=WebNewNewsList&"</ul>"
	else
		WebNewNewsList=WebNewNewsList&"暂无信息"
	end if
	rs.close
end if
set rs=nothing
replace_code=replace(replace_code,"$WebNewNewsList$",WebNewNewsList)
'最新资讯结束
%>

<%
'声明HTML文件名,指定文件路径
filepath="../"&mpsitefoldername&"/index.html"
'生成首页静态文件
Set f = fso.CreateTextFile(Server.MapPath(filepath))
f.WriteLine replace_code
f.close
set f=nothing
set fso=nothing
end function
%>