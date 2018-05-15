<%
'=================================================
'作  用：生成文章和产品全部内容，以及单个产品（单个文章生成，是另外单独的程序，因为文章涉及到了上一页和下一页，和产品不同）
'参  数：contentId 数值型（内容id，0时表示全部）
'参  数：mpsitefoldername 字符型（手机网站文件夹名称）
'=================================================
function MP_Run_createhtml_product_content(contentId,mpsitefoldername)
if trim(contentId&"")="" then
	Exit Function
end if

dim conRs,rs,sql,sqlWhere
dim fso,f
dim replace_code
dim folderPath,fPath
dim templateName
dim category_position
dim this_page_title,this_page_channel_name,this_page_keywords,this_page_description
dim this_page_banner
dim htmlFileUrl
dim htmlwrite

Set fso=Server.CreateObject("Scripting.FileSystemObject")
set conRs=server.createobject("adodb.recordset")

if contentId=0 then
	sqlWhere="WHERE a.ArticleType=2 ORDER BY a.edit_time DESC,a.id DESC"
else
	sqlWhere="WHERE a.ArticleType=2 and a.id="&contentId&" ORDER BY a.edit_time DESC,a.id DESC"
end if

sql="SELECT a.id, a.jhy_fd_levelone_id, a.jhy_fd_leveltwo_id, a.title, a.html_file_name, a.keywords, a.description, a.content,a.jhy_fd_fujian,a.con_jianjie,a.con_shichangjia,a.con_youhuijia,a.product_order_show,a.product_tbbuy_url,a.image, a.edit_time,"
sql=sql&" b.name, b.folder, b.jhy_fd_image, b.jhy_fd_image_url, b.jhy_fd_image_alt,"
sql=sql&" c.name, c.folder, c.jhy_fd_image, c.jhy_fd_image_url, c.jhy_fd_image_alt"
sql=sql&" FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id "&sqlWhere

conRs.open(sql),cn,1,1
if not conRs.eof then
'循环生成查询出来的所有内容页开始
do while not conRs.eof
	'获取标题、关键字、描述
	this_page_title=conRs("title")
	this_page_keywords=conRs("keywords")
	this_page_description=conRs("description")

	'获取文件夹和文件位置、“您现在的位置”导航，并判断文件夹是否存在（否，则创建）
	if trim(conRs("c.folder"))&""="" then
		'调用文件夹检测和创建函数，创建文件夹，并返回当前栏目的物理文件夹路径（此文件夹只为生成静态html文件用，前台显示路径不用这个）
		folderPath=CreateContentFolder(fso,mpsitefoldername&"/"&conRs("b.folder"),"")
		category_position="<a href='../"&conRs("b.folder")&"'>"&conRs("b.name")&"</a>"
		this_page_channel_name="_"&conRs("b.name")'设置本页title频道名称
		b_websiteroot="../"
		mpparent_b_root="../../"
	else
		'调用文件夹检测和创建函数，创建文件夹，并返回当前栏目的物理文件夹路径（此文件夹只为生成静态html文件用，前台显示路径不用这个）
		folderPath=CreateContentFolder(fso,mpsitefoldername&"/"&conRs("b.folder"),conRs("c.folder"))
		category_position="<a href='../../"&conRs("b.folder")&"'>"&conRs("b.name")&"</a> > <a href='../"&conRs("c.folder")&"'>"&conRs("c.name")&"</a>"
		this_page_channel_name="_"&conRs("c.name")&"_"&conRs("b.name")'设置本页title频道名称
		b_websiteroot="../../"
		mpparent_b_root="../../../"
	end if
	
	'组装内容区内容
	'组合产品内容开始
	'产品参数简介
	prod_con_jianjie=conRs("con_jianjie")
	if trim(prod_con_jianjie)&""="" then
	prod_con_jianjie=""
	else
	prod_con_jianjie="<div class='pro_jianjie'>"&prod_con_jianjie&"</div>"
	end if
	
	'市场价
	prod_con_shichangjia=conRs("con_shichangjia")
	if trim(prod_con_shichangjia)&""="" then
	prod_con_shichangjia=""
	else
	prod_con_shichangjia="<div class='pro_shichangjia'><span>市场价：</span>"&prod_con_shichangjia&" 元</div>"
	end if
	
	'优惠价
	prod_con_youhuijia=conRs("con_youhuijia")
	if trim(prod_con_youhuijia)&""="" then
	prod_con_youhuijia=""
	else
	prod_con_youhuijia="<div class='pro_youhuijia'><span>优惠价：</span>"&prod_con_youhuijia&" 元</div>"
	end if
	
	'购买：提交订单，到淘宝拍
	product_order_show=conRs("product_order_show")
	product_tbbuy_url=conRs("product_tbbuy_url")
	if product_order_show=1 then
	HTML_product_order_show="<div class='pro_tijiaodingdan'><a href="&Chr(34)&b_websiteroot&"order.asp?id="&conRs("id")&"&bfolder="&conRs("b.folder")&"&cfolder="&conRs("c.folder")&"&html_file_name="&conRs("html_file_name")&Chr(34)&" target=_blank><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/order_img.gif' alt='提交订单' border=0></a></div>"
	else
	HTML_product_order_show=""
	end if

	if trim(product_tbbuy_url)&""="" then
	HTML_product_tbbuy_url=""
	else
	HTML_product_tbbuy_url="<div class='pro_qutaobaopai'><a href="&product_tbbuy_url&" target=_blank><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/tb_to_buy.gif' alt='去淘宝拍' border=0></a></div>"
	end if
	
	'产品图片
	if conRs("image")<>"" then
	article_image=conRs("image")
	else
	article_image="nophoto.jpg"
	end if
	
	product_content=""
	product_content=product_content&"<!--content start-->"
	product_content=product_content&"<div class='content'>"
	product_content=product_content&"<!--ProInfo start-->"
	product_content=product_content&"<div class='ProInfo'>"
	product_content=product_content&"<div class='infos'>更新："&GetFormatTime(conRs("edit_time"))&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;点击：<script language='javascript' src='"&mpparent_b_root&"inc/click_number.asp?id="&conRs("id")&"'></script></div>"
	product_content=product_content&"<div class='image'><a href='"&mpparent_b_root&"images/up_images/"&article_image&"' title='"&conRs("title")&"' target='_blank'><img src='"&mpparent_b_root&"images/up_images/"&article_image&"' alt='"&conRs("title")&"'></a></div>"
	product_content=product_content&"<div class='column'>"
	product_content=product_content&""&prod_con_jianjie&""
	product_content=product_content&""&prod_con_shichangjia&""
	product_content=product_content&""&prod_con_youhuijia&""
	product_content=product_content&""&HTML_product_order_show&"  "&HTML_product_tbbuy_url&""
	product_content=product_content&"</div>"
	product_content=product_content&"<div class='clearfix'></div>"
	product_content=product_content&"</div>"
	
	product_content=product_content&"<div class='maincontent clearfix'>"
	product_content=product_content&"<div class='commonContentTitle'>详情</div>"
	product_content=product_content&replace(conRs("content"),"../images/","../../images/")
	product_content=product_content&"</div>"
	product_content=product_content&"<div class='commonContentTitle'>相关</div>"
	
	product_content=product_content&GetMoreProductList(conRs("id"),conRs("jhy_fd_levelone_id"),conRs("jhy_fd_leveltwo_id"),mpparent_b_root)
	product_content=product_content&"</div>"
	product_content=product_content&"<!--ProInfo end-->"
	product_content=product_content&"</div>"
	product_content=product_content&"<!--content end-->"
	'组合产品内容结束
	
	'组装内页banner
	if trim(conRs("c.jhy_fd_image"))&""<>"" then
	this_page_banner="<div><a href='"&trim(conRs("c.jhy_fd_image_url"))&"'><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(conRs("c.jhy_fd_image"))&"' alt='"&trim(conRs("c.jhy_fd_image_alt"))&"'></a></div>"
	elseif trim(conRs("b.jhy_fd_image"))&""<>"" then
	this_page_banner="<div><a href='"&trim(conRs("b.jhy_fd_image_url"))&"'><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(conRs("b.jhy_fd_image"))&"' alt='"&trim(conRs("b.jhy_fd_image_alt"))&"'></a></div>"
	else
	this_page_banner=""
	end if
	
	'组装产品展示页面需要插入的图片展示box以及订单提交窗口的css和js标签
	product_imagebox_orderwin_cssjs=""
	product_imagebox_orderwin_cssjs=product_imagebox_orderwin_cssjs&chr(13)&chr(10)&"<link rel="&Chr(34)&"stylesheet"&Chr(34)&" type="&Chr(34)&"text/css"&Chr(34)&" href="&Chr(34)&b_websiteroot&"css/juhaoyongfgstyle/clearbox.css"&Chr(34)&" />"
	product_imagebox_orderwin_cssjs=product_imagebox_orderwin_cssjs&chr(13)&chr(10)&"<script type="&Chr(34)&"text/javascript"&Chr(34)&">"
	product_imagebox_orderwin_cssjs=product_imagebox_orderwin_cssjs&chr(13)&chr(10)&"var CB_PicDir="&Chr(34)&b_websiteroot&"images"&Chr(34)&";"
	product_imagebox_orderwin_cssjs=product_imagebox_orderwin_cssjs&chr(13)&chr(10)&"</script>"
	product_imagebox_orderwin_cssjs=product_imagebox_orderwin_cssjs&chr(13)&chr(10)&"<script type="&Chr(34)&"text/javascript"&Chr(34)&" src="&Chr(34)&b_websiteroot&"js/clearbox.js"&Chr(34)&"></script>"
	product_imagebox_orderwin_cssjs=product_imagebox_orderwin_cssjs&chr(13)&chr(10)&"<script type="&Chr(34)&"text/javascript"&Chr(34)&" src="&Chr(34)&b_websiteroot&"js/view_original_image.js"&Chr(34)&"></script>"

	'读取模板内容
	templateName="../templates/"&MP_SITE_TEMPLATE_FOLDER&"/mp_template_product"&conRs("jhy_fd_levelone_id")&".html"
	Set htmlwrite=fso.OpenTextFile(Server.MapPath(templateName)) 
	replace_code=htmlwrite.ReadAll() 
	htmlwrite.close
	
	'替换内容区内容
	replace_code=replace(replace_code,"$juhaoyong_common_inside_content$",product_content)
	
	'替换内页banner
	replace_code=replace(replace_code,"$this_page_banner$",this_page_banner)

	'替换其他内容
	replace_code=replace(replace_code,"$Site_GenMuLu$",b_websiteroot)
	replace_code=replace(replace_code,"$MPparent_GenMuLu$",mpparent_b_root)
	replace_code=replace(replace_code,"$this_page_title$",this_page_title)
	replace_code=replace(replace_code,"$this_page_channel_name$",this_page_channel_name)
	replace_code=replace(replace_code,"$this_page_keywords$",this_page_keywords)
	replace_code=replace(replace_code,"$this_page_description$",this_page_description)
	replace_code=replace(replace_code,"$category_position$",category_position)
	replace_code=replace(replace_code,"$inside_content_title$",this_page_title)
	
	'替换左侧栏目栏的“当前栏目”
	if trim(conRs("jhy_fd_leveltwo_id"))&""="" then
	replace_code=replace(replace_code,"tclassID"&conRs("jhy_fd_levelone_id"),"current")
	else
	'replace_code=replace(replace_code,"tclassID"&conRs("jhy_fd_levelone_id"),"topicCurrent")
	replace_code=replace(replace_code,"id=directoryID"&conRs("jhy_fd_leveltwo_id"),"class='current'")
	end if
	
	'替换产品展示页面需要插入的图片展示box以及订单提交窗口的css和js标签
	replace_code=replace(replace_code,"$product_imagebox_orderwin_cssjs$",product_imagebox_orderwin_cssjs)
	
	'确定输出文件名
	fPath=folderPath&"/"&conRs("html_file_name")
	
	'最终输出写入生成文件
	Set f=fso.CreateTextFile(Server.MapPath(fPath),true)
	f.WriteLine replace_code
	f.close
	Set f=nothing

conRs.movenext
loop
'循环生成查询出来的所有内容页结束
end if

conRs.close
set conRs=nothing

set fso=nothing
end function
%>

<%
'=================================================
'作  用：更多产品
'参  数：a_id（当前产品id）
'参  数：currentOneId（当前一级类别id）
'参  数：currentTwoId（当前二级类别id）
'=================================================
function GetMoreProductList(a_id,currentOneId,currentTwoId,siterootpath)
dim rs,sql
dim htmlFileUrl
dim list_block
dim howmanyrecs
list_block=""
set rs=server.createobject("adodb.recordset")
if trim(currentTwoId)&""<>"" then
sql="select top 9 a.jhy_fd_leveltwo_id,a.title,a.html_file_name,a.con_youhuijia,a.image,b.folder FROM juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_leveltwo_id where ArticleType=2 and a.jhy_fd_leveltwo_id='"&currentTwoId&"' and a.id<>"&a_id&" order by [a.edit_time] desc,a.id DESC"
else
sql="select top 9 a.jhy_fd_leveltwo_id,a.title,a.html_file_name,a.con_youhuijia,a.image,b.folder FROM juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_leveltwo_id where ArticleType=2 and a.jhy_fd_levelone_id='"&currentOneId&"' and a.id<>"&a_id&" order by [a.edit_time] desc,a.id DESC"
end if
rs.open(sql),cn,1,1
if not rs.eof then
	list_block=list_block&"<!--ProductList start-->"
	list_block=list_block&"<ul class='product'>"
	
	howmanyrecs=0
	do while not rs.eof
		if trim(currentTwoId)&""<>"" then
		htmlFileUrl=rs("html_file_name")
		else
			if trim(rs("jhy_fd_leveltwo_id"))&""<>"" then
			htmlFileUrl=rs("folder")&"/"&rs("html_file_name")
			else
			htmlFileUrl=rs("html_file_name")
			end if
		end if
	
		if (howmanyrecs mod 2 =0) and howmanyrecs>0 then 
		list_block=list_block&"</ul><ul class='product clearfix'>"
		end if
		list_block=list_block&"<li>"
		list_block=list_block&"<a class='picbox' href='"&htmlFileUrl&"' title='"&rs("title")&"' target='_blank'><img src='"&siterootpath&"images/up_images/"&rs("image")&"' alt='"&rs("title")&"' /></a>"
		list_block=list_block&"<a class='pictitle' href='"&htmlFileUrl&"' title='"&rs("title")&"' target='_blank'>"&trim(left(rs("title"),17))&"</a>"
		if rs("con_youhuijia")&""<>"" then
		list_block=list_block&"<span class='boxPrice'>&#165;"&rs("con_youhuijia")&"</span>"
		end if
		list_block=list_block&"</li>"
		
		rs.movenext
		howmanyrecs=howmanyrecs+1
	loop
	list_block=list_block&"</ul>"
	list_block=list_block&"<!--ProductList end-->"
end if 
rs.close
set rs=nothing
GetMoreProductList=list_block
end function
%>