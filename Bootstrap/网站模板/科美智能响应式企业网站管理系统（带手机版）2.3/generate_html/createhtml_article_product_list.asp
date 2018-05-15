<%
'=================================================
'作  用：生成文章和产品列表（全部或单个）
'参  数：classTypeNumber（栏目类型，1表示文章，2表示产品）
'参  数：dirId 字符型（栏目id，"0"时表示全部）
'=================================================
function Run_createhtml_article_product_list(classTypeNumber,dirId)
if trim(dirId&"")="" then
	Exit Function
end if

dim categoryRs,rs,sql
dim fso,f
dim replace_code
dim folderPath,fPath
dim templateName
dim list_block
dim category_position
dim this_page_title,this_page_channel_name,this_page_keywords,this_page_description
dim this_page_banner
dim htmlwrite

Set fso=Server.CreateObject("Scripting.FileSystemObject")
set categoryRs=server.createobject("adodb.recordset")
if dirId=0 then
	sql="SELECT a.id, a.folder, a.name, a.title, a.keywords, a.description, a.jhy_fd_image, a.jhy_fd_image_url, a.jhy_fd_image_alt, a.jhy_fd_dir_parentid, b.folder, b.name, b.jhy_fd_image, b.jhy_fd_image_url, b.jhy_fd_image_alt from juhaoyong_tb_directory AS a LEFT JOIN juhaoyong_tb_directory AS b ON b.id=a.jhy_fd_dir_parentid WHERE a.ClassType="&classTypeNumber&" ORDER BY a.id"
else
	sql="SELECT a.id, a.folder, a.name, a.title, a.keywords, a.description, a.jhy_fd_image, a.jhy_fd_image_url, a.jhy_fd_image_alt, a.jhy_fd_dir_parentid, b.folder, b.name, b.jhy_fd_image, b.jhy_fd_image_url, b.jhy_fd_image_alt from juhaoyong_tb_directory AS a LEFT JOIN juhaoyong_tb_directory AS b ON b.id=a.jhy_fd_dir_parentid WHERE a.ClassType="&classTypeNumber&" and a.id="&dirId&" ORDER BY a.id"
end if
categoryRs.open(sql),cn,1,1
if not categoryRs.eof then
'循环生成查询出来的所有栏目页开始
do while not categoryRs.eof
	if categoryRs("title")&""<>"" then
		this_page_title=categoryRs("title")
	else
		this_page_title=categoryRs("a.name")
	end if
	this_page_keywords=categoryRs("keywords")
	this_page_description=categoryRs("description")

	'获取文件夹和文件位置、“您现在的位置”导航，并判断文件夹是否存在（否，则创建）
	if categoryRs("jhy_fd_dir_parentid")=0 then
		oneClassId=categoryRs("id")
		'调用文件夹检测和创建函数，创建文件夹，并返回当前栏目的物理文件夹路径（此文件夹只为生成静态html文件用，前台显示路径不用这个）
		folderPath=CreateContentFolder(fso,categoryRs("a.folder"),"")
		category_position="<a href='../"&categoryRs("a.folder")&"'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name=""'设置本页title频道名称
		ClassSQL="jhy_fd_levelone_id"
		b_websiteroot="../"
		juhaoyong_mp_folder_file_name=categoryRs("a.folder")&"/"
	else
		oneClassId=categoryRs("jhy_fd_dir_parentid")
		'调用文件夹检测和创建函数，创建文件夹，并返回当前栏目的物理文件夹路径（此文件夹只为生成静态html文件用，前台显示路径不用这个）
		folderPath=CreateContentFolder(fso,categoryRs("b.folder"),categoryRs("a.folder"))
		category_position="<a href='../../"&categoryRs("b.folder")&"'>"&categoryRs("b.name")&"</a> > <a href='../"&categoryRs("a.folder")&"'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name="_"&categoryRs("b.name")'设置本页title频道名称
		ClassSQL="jhy_fd_leveltwo_id"
		b_websiteroot="../../"
		juhaoyong_mp_folder_file_name=categoryRs("b.folder")&"/"&categoryRs("a.folder")&"/"
	end if
	
	'组装文章或产品列表
	set rs=server.createObject("ADODB.Recordset")
	select case classTypeNumber
		case 1
			sql="SELECT a.id, a.title, a.jhy_fd_leveltwo_id, a.html_file_name, a.edit_time, b.folder from juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_leveltwo_id where "&ClassSQL&"='"&categoryRs("id")&"' And a.ArticleType=1 ORDER BY a.index_push DESC,a.edit_time DESC,a.id DESC"
		case 2
			sql="SELECT a.id, a.title, a.jhy_fd_leveltwo_id, a.html_file_name, a.image, a.con_youhuijia, b.folder from juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_leveltwo_id where "&ClassSQL&"='"&categoryRs("id")&"' And a.ArticleType=2 ORDER BY a.edit_time DESC,a.id DESC"
	end select
	rs.open sql,cn,1,1
	
	'分页属性设置（一定要放到分页属性获取前面）
	select case classTypeNumber
		case 1
			rs.pagesize=30'设置每页条数
		case 2
			rs.pagesize=18'设置每页条数
	end select
		
	'分页属性获取
	rscount=rs.recordcount'总条数
	totalpage=rs.pagecount'总页数
	if rs.bof and rs.eof then totalpage=0
	'循环生成所有分页开始
	pageNumber=0
	Do
		pageNumber=pageNumber+1
		if pageNumber>totalpage then pageNumber=totalpage
		if not rs.eof then rs.AbsolutePage=pageNumber '设置当前页页码
		
		list_block=""
		if rs.bof and rs.eof then 
			list_block=list_block&"暂无内容"
		else
			select case classTypeNumber
				case 1
					list_block=list_block&InsideArticleList(categoryRs,rs)'调用文章列表函数
				case 2
					list_block=list_block&InsideProductList(categoryRs,rs,b_websiteroot)'调用产品列表函数
			end select
			list_block=list_block&"<div class='clearfix'></div>"
			list_block=list_block&PageListHtmlCommon(rscount,pageNumber,totalpage,counter)'调用通用分页函数
			'一页标题列表循环读取生成输出结束
		end if
		
		'组装内页banner
		if trim(categoryRs("a.jhy_fd_image"))<>"" then
		this_page_banner="<div class='insidebanner'><a href='"&trim(categoryRs("a.jhy_fd_image_url"))&"'><img src='"&b_websiteroot&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("a.jhy_fd_image"))&"' alt='"&trim(categoryRs("a.jhy_fd_image_alt"))&"'></a></div>"
		elseif trim(categoryRs("b.jhy_fd_image"))<>"" then
		this_page_banner="<div class='insidebanner'><a href='"&trim(categoryRs("b.jhy_fd_image_url"))&"'><img src='"&b_websiteroot&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("b.jhy_fd_image"))&"' alt='"&trim(categoryRs("b.jhy_fd_image_alt"))&"'></a></div>"
		else
		this_page_banner=""
		end if
		
		'读取模板内容
		select case classTypeNumber
			case 1
				templateName="../templates/"&SITE_TEMPLATE_FOLDER&"/template_article"&oneClassId&".html"
			case 2
				templateName="../templates/"&SITE_TEMPLATE_FOLDER&"/template_product"&oneClassId&".html"
		end select
		Set htmlwrite=fso.OpenTextFile(Server.MapPath(templateName))
		replace_code=htmlwrite.ReadAll() 
		htmlwrite.close
		
		'循环，列表区域，替换
		replace_code=replace(replace_code,"$juhaoyong_common_inside_content$",list_block)
		
		'循环，其它地方，替换
		replace_code=replace(replace_code,"$Site_GenMuLu$",b_websiteroot)
		if pageNumber>1 then juhaoyong_mp_folder_file_name=juhaoyong_mp_folder_file_name&"page_"&pageNumber&".html"
		replace_code=replace(replace_code,"$juhaoyong_mp_folder_file_name$",juhaoyong_mp_folder_file_name)
		replace_code=replace(replace_code,"$this_page_title$",this_page_title)
		replace_code=replace(replace_code,"$this_page_channel_name$",this_page_channel_name)
		replace_code=replace(replace_code,"$this_page_keywords$",this_page_keywords)
		replace_code=replace(replace_code,"$this_page_description$",this_page_description)
		replace_code=replace(replace_code,"$category_position$",category_position)
		
		'替换左侧栏目栏的"当前栏目"设置
		if categoryRs("jhy_fd_dir_parentid")=0 then
		replace_code=replace(replace_code,"tclassID"&categoryRs("id"),"topicCurrent")
		else
		'replace_code=replace(replace_code,"tclassID"&categoryRs("jhy_fd_dir_parentid"),"topicCurrent")
		replace_code=replace(replace_code,"id=directoryID"&categoryRs("id"),"class='current'")
		end if
		
		'替换内页banner
		replace_code=replace(replace_code,"$this_page_banner$",this_page_banner)
		
		'替换产品展示页面需要插入的图片展示box以及订单提交窗口的css和js标签，置为空
		if classTypeNumber=2 then replace_code=replace(replace_code,"$product_imagebox_orderwin_cssjs$","")
		
		'确定输出文件名
		if pageNumber>1 then
		fPath=folderPath&"/page_"&pageNumber&".html"
		else
		fPath=folderPath&"/index.html"
		end if
		
		'最终输出写入生成文件
		Set f=fso.CreateTextFile(Server.MapPath(fPath),true)
		f.WriteLine replace_code
		f.close
		Set f=nothing

	Loop Until pageNumber=totalpage
	'循环生成所有分页结束
	rs.close
	set rs=nothing
categoryRs.movenext
loop
'循环生成查询出来的所有栏目页结束
end if

categoryRs.close
set categoryRs=nothing

set fso=nothing
end function
%>

<%
function InsideArticleList(categoryRs,rs)
dim list_block,howmanyrecs
dim rs_url
list_block=""
list_block=list_block&"<!--ArticleList start-->"
list_block=list_block&"<div class='ArticleList'>"
list_block=list_block&"<table  width='100%' border='0' cellspacing='0' cellpadding='0'>"

howmanyrecs=0
'一页标题列表循环读取生成输出开始
do while not rs.eof and howmanyrecs<rs.pagesize
	rs_url=""
	if categoryRs("jhy_fd_dir_parentid")=0 then
		if rs("jhy_fd_leveltwo_id")&""<>"" then
			rs_url=rs("folder")&"/"&rs("html_file_name")
		else
			rs_url=rs("html_file_name")
		end if
	else
		rs_url=rs("html_file_name")
	end if
	
	list_block=list_block&"<tr>"
	list_block=list_block&"<td width='88%' class='fw_t'><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&left(rs("title"),47)&"</a></td>"
	list_block=list_block&"<td width='12%' class='fw_s' align=right>"&GetFormatDate(rs("edit_time"))&"</td>"
	list_block=list_block&"</tr>"
rs.movenext
howmanyrecs=howmanyrecs+1
loop
list_block=list_block&"</table>"
list_block=list_block&"</div>"
list_block=list_block&"<!--ArticleList end-->"
InsideArticleList=list_block
end function
%>

<%
function InsideProductList(categoryRs,rs,siterootpath)
dim list_block,howmanyrecs
dim rs_url
list_block=""
list_block=list_block&"<!--ProductList start-->"
list_block=list_block&"<div class='content'>"
list_block=list_block&"<div class='MorePro'>"

howmanyrecs=0
do while not rs.eof and howmanyrecs<rs.pagesize
	rs_url=""
	if categoryRs("jhy_fd_dir_parentid")=0 then
		if rs("jhy_fd_leveltwo_id")&""<>"" then
			rs_url=rs("folder")&"/"&rs("html_file_name")
		else
			rs_url=rs("html_file_name")
		end if
	else
		rs_url=rs("html_file_name")
	end if
	
	if (howmanyrecs mod 3 =0) and howmanyrecs>0 then 
	list_block=list_block&"</DIV><div class='clearfix'></div><DIV class=MorePro>"
	end if
	
	list_block=list_block&"<div class='albumblock'>"
	list_block=list_block&"<div class='inner'><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'><img src='"&siterootpath&"images/up_images/"&rs("image")&"' alt='"&rs("title")&"' /></a></div>"
	list_block=list_block&"<div class='albumtitle'><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&rs("title")&"</a></div>"
	if rs("con_youhuijia")&""<>"" then
	list_block=list_block&"<DIV class='boxPrice'>&#165;"&rs("con_youhuijia")&"</DIV>"
	end if
	list_block=list_block&"</div>"
rs.movenext
howmanyrecs=howmanyrecs+1
loop
list_block=list_block&"</div>"
list_block=list_block&"</div>"
list_block=list_block&"<!--ProductList end-->"
InsideProductList=list_block
end function
%>