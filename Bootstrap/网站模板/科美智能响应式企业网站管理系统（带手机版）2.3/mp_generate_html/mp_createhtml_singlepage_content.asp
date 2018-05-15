<%
'=================================================
'作  用：生成文章和产品列表（全部或单个）
'参  数：dirId 字符型（栏目id，"0"时表示全部）
'参  数：mpsitefoldername 字符型（手机网站文件夹名称）
'=================================================
function MP_Run_createhtml_singlepage_content(dirId,mpsitefoldername)
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
	sql="SELECT a.id, a.folder, a.name, a.title, a.keywords, a.description, a.content, a.jhy_fd_image, a.jhy_fd_image_url, a.jhy_fd_image_alt, a.jhy_fd_dir_parentid, b.folder, b.name, b.ClassType, b.jhy_fd_image, b.jhy_fd_image_url, b.jhy_fd_image_alt from juhaoyong_tb_directory AS a LEFT JOIN juhaoyong_tb_directory AS b ON b.id=a.jhy_fd_dir_parentid WHERE a.ClassType=3 ORDER BY a.id"
else
	sql="SELECT a.id, a.folder, a.name, a.title, a.keywords, a.description, a.content, a.jhy_fd_image, a.jhy_fd_image_url, a.jhy_fd_image_alt, a.jhy_fd_dir_parentid, b.folder, b.name, b.ClassType, b.jhy_fd_image, b.jhy_fd_image_url, b.jhy_fd_image_alt from juhaoyong_tb_directory AS a LEFT JOIN juhaoyong_tb_directory AS b ON b.id=a.jhy_fd_dir_parentid WHERE a.ClassType=3 and a.id="&dirId&" ORDER BY a.id"
end if
categoryRs.open(sql),cn,1,1
if not categoryRs.eof then
'循环生成查询出来的所有栏目页开始
do while not categoryRs.eof
	this_category_name=categoryRs("a.name")
	if categoryRs("title")<>"" then
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
		folderPath=CreateContentFolder(fso,mpsitefoldername&"/"&categoryRs("a.folder"),"")

		category_position="<a href='../"&categoryRs("a.folder")&"'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name=""'设置本页title频道名称
		ClassSQL="oneid"
		b_websiteroot="../"
		mpparent_b_root="../../"
	else
		oneClassId=categoryRs("jhy_fd_dir_parentid")
		folderPath="../"&mpsitefoldername&"/"&categoryRs("b.folder")&"/"&categoryRs("a.folder")
		
		category_position="<a href='../"&categoryRs("b.folder")&"'>"&categoryRs("b.name")&"</a> > <a href='../"&categoryRs("a.folder")&"'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name="_"&categoryRs("b.name")'设置本页title频道名称
		ClassSQL="twoid"
		b_websiteroot="../"
		mpparent_b_root="../../"
	end if
	
	'内容读取
	list_block=""
	list_block=list_block&"<div class='content'>"
	list_block=list_block&replace(categoryRs("content"),"../images/","../../images/")
	list_block=list_block&"</div>"
	
	'组装内页banner
	if trim(categoryRs("a.jhy_fd_image"))<>"" then
	this_page_banner="<div><a href='"&trim(categoryRs("a.jhy_fd_image_url"))&"'><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("a.jhy_fd_image"))&"' alt='"&trim(categoryRs("a.jhy_fd_image_alt"))&"'></a></div>"
	elseif trim(categoryRs("b.jhy_fd_image"))<>"" then
	this_page_banner="<div><a href='"&trim(categoryRs("b.jhy_fd_image_url"))&"'><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("b.jhy_fd_image"))&"' alt='"&trim(categoryRs("b.jhy_fd_image_alt"))&"'></a></div>"
	else
	this_page_banner=""
	end if

	'读取模板内容
	if categoryRs("ClassType")=1 then
		templateName="../templates/"&MP_SITE_TEMPLATE_FOLDER&"/mp_template_article"&oneClassId&".html"
	else
		templateName="../templates/"&MP_SITE_TEMPLATE_FOLDER&"/mp_template_singlepage"&oneClassId&".html"
	end if
	
	Set htmlwrite=fso.OpenTextFile(Server.MapPath(templateName)) 
	replace_code=htmlwrite.ReadAll() 
	htmlwrite.close
	
	'循环列表替换内容
	replace_code=replace(replace_code,"$juhaoyong_common_inside_content$",list_block)
	
	'循环其它替换内容
	replace_code=replace(replace_code,"$Site_GenMuLu$",b_websiteroot)
	replace_code=replace(replace_code,"$MPparent_GenMuLu$",mpparent_b_root)
	replace_code=replace(replace_code,"$this_page_title$",this_page_title)
	replace_code=replace(replace_code,"$this_page_channel_name$",this_page_channel_name)
	replace_code=replace(replace_code,"$this_page_keywords$",this_page_keywords)
	replace_code=replace(replace_code,"$this_page_description$",this_page_description)
	replace_code=replace(replace_code,"$category_position$",category_position)
	replace_code=replace(replace_code,"$inside_content_title$",this_category_name)
	
	if categoryRs("jhy_fd_dir_parentid")=0 then
	replace_code=replace(replace_code,"tclassID"&categoryRs("id"),"current")
	else
	replace_code=replace(replace_code,"id=directoryID"&categoryRs("id"),"class='current'")
	end if
	
	'替换内页banner
	replace_code=replace(replace_code,"$this_page_banner$",this_page_banner)
	
	'确定输出文件名
	if categoryRs("jhy_fd_dir_parentid")=0 then
	fPath=folderPath&"/index.html"
	else
	fPath=folderPath&".html"
	end if
	
	'最终输出写入生成文件
	Set f=fso.CreateTextFile(Server.MapPath(fPath),true)
	f.WriteLine replace_code
	f.close
	Set f=nothing

categoryRs.movenext
loop
'循环生成查询出来的所有栏目页结束
end if

categoryRs.close
set categoryRs=nothing

set fso=nothing
end function
%>

