<%
'=================================================
'作  用：生成文章和产品全部内容，以及单个产品（单个文章生成，是另外单独的程序，因为文章涉及到了上一页和下一页，和产品不同）
'参  数：contentId 数值型（内容id，0时表示全部）
'参  数：mpsitefoldername 字符型（手机网站文件夹名称）
'=================================================
function MP_Run_createhtml_article_content(contentId,mpsitefoldername)
if trim(contentId&"")="" then
	Exit Function
end if

dim conRs,rs,sql,sqlWhere
dim fso,f
dim replace_code
dim folderPath,fPath
dim templateName
dim list_block
dim category_position
dim this_page_title,this_page_channel_name,this_page_keywords,this_page_description
dim this_page_banner
dim downloadFiles,df_all,df_ii,articleDownloads
dim htmlFileUrl
dim counterNumber,total
dim htmlwrite

total=0
counterNumber=0

Set fso=Server.CreateObject("Scripting.FileSystemObject")
set conRs=server.createobject("adodb.recordset")

if contentId=0 then
	sqlWhere="WHERE a.ArticleType=1 ORDER BY a.edit_time DESC,a.id DESC"
else
	sqlWhere="WHERE a.ArticleType=1 and a.id="&contentId&" ORDER BY a.edit_time DESC,a.id DESC"
end if

sql="SELECT a.id, a.jhy_fd_levelone_id, a.jhy_fd_leveltwo_id, a.title, a.html_file_name, a.keywords, a.description, a.content,a.jhy_fd_fujian, a.edit_time,"
sql=sql&" b.name, b.folder, b.jhy_fd_image, b.jhy_fd_image_url, b.jhy_fd_image_alt,"
sql=sql&" c.name, c.folder, c.jhy_fd_image, c.jhy_fd_image_url, c.jhy_fd_image_alt"
sql=sql&" FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id "&sqlWhere

conRs.open(sql),cn,1,1
if not conRs.eof then
total=conRs.RecordCount
'循环生成查询出来的所有内容页开始
do while not conRs.eof
	counterNumber=counterNumber+1
	if counterNumber=1 then
		a1_title=""
		a1_edit_time=""
		a1_b_folder=""
		a1_c_folder=""
		a1_html_file_name=""

		a2_id=""
		a2_levelone_id=""
		a2_leveltwo_id=""
		a2_title=""
		a2_html_file_name=""
		a2_keywords=""
		a2_description=""
		a2_content=""
		a2_Files=""
		a2_edit_time=""
		a2_b_name=""
		a2_b_folder=""
		a2_b_jhy_fd_image=""
		a2_b_jhy_fd_image_url=""
		a2_b_jhy_fd_image_alt=""
		a2_c_name=""
		a2_c_folder=""
		a2_c_jhy_fd_image=""
		a2_c_jhy_fd_image_url=""
		a2_c_jhy_fd_image_alt=""
		
		a3_id=conRs("id")
		a3_levelone_id=conRs("jhy_fd_levelone_id")
		a3_leveltwo_id=conRs("jhy_fd_leveltwo_id")
		a3_title=conRs("title")
		a3_html_file_name=conRs("html_file_name")
		a3_keywords=conRs("keywords")
		a3_description=conRs("description")
		a3_content=conRs("content")
		a3_Files=conRs("jhy_fd_fujian")
		a3_edit_time=conRs("edit_time")
		a3_b_name=conRs("b.name")
		a3_b_folder=conRs("b.folder")
		a3_b_jhy_fd_image=conRs("b.jhy_fd_image")
		a3_b_jhy_fd_image_url=conRs("b.jhy_fd_image_url")
		a3_b_jhy_fd_image_alt=conRs("b.jhy_fd_image_alt")
		a3_c_name=conRs("c.name")
		a3_c_folder=conRs("c.folder")
		a3_c_jhy_fd_image=conRs("c.jhy_fd_image")
		a3_c_jhy_fd_image_url=conRs("c.jhy_fd_image_url")
		a3_c_jhy_fd_image_alt=conRs("c.jhy_fd_image_alt")
		
		oneClassId=conRs("jhy_fd_levelone_id")
	else
		a1_title=a2_title
		a1_edit_time=a2_edit_time
		a1_b_folder=a2_b_folder
		a1_c_folder=a2_c_folder
		a1_html_file_name=a2_html_file_name
	
		a2_id=a3_id
		a2_levelone_id=a3_levelone_id
		a2_leveltwo_id=a3_leveltwo_id
		a2_title=a3_title
		a2_html_file_name=a3_html_file_name
		a2_keywords=a3_keywords
		a2_description=a3_description
		a2_content=a3_content
		a2_Files=a3_Files
		a2_edit_time=a3_edit_time
		a2_b_name=a3_b_name
		a2_b_folder=a3_b_folder
		a2_b_jhy_fd_image=a3_b_jhy_fd_image
		a2_b_jhy_fd_image_url=a3_b_jhy_fd_image_url
		a2_b_jhy_fd_image_alt=a3_b_jhy_fd_image_alt
		a2_c_name=a3_c_name
		a2_c_folder=a3_c_folder
		a2_c_jhy_fd_image=a3_c_jhy_fd_image
		a2_c_jhy_fd_image_url=a3_c_jhy_fd_image_url
		a2_c_jhy_fd_image_alt=a3_c_jhy_fd_image_alt
	
		a3_id=conRs("id")
		a3_levelone_id=conRs("jhy_fd_levelone_id")
		a3_leveltwo_id=conRs("jhy_fd_leveltwo_id")
		a3_title=conRs("title")
		a3_html_file_name=conRs("html_file_name")
		a3_keywords=conRs("keywords")
		a3_description=conRs("description")
		a3_content=conRs("content")
		a3_Files=conRs("jhy_fd_fujian")
		a3_edit_time=conRs("edit_time")
		a3_b_name=conRs("b.name")
		a3_b_folder=conRs("b.folder")
		a3_b_jhy_fd_image=conRs("b.jhy_fd_image")
		a3_b_jhy_fd_image_url=conRs("b.jhy_fd_image_url")
		a3_b_jhy_fd_image_alt=conRs("b.jhy_fd_image_alt")
		a3_c_name=conRs("c.name")
		a3_c_folder=conRs("c.folder")
		a3_c_jhy_fd_image=conRs("c.jhy_fd_image")
		a3_c_jhy_fd_image_url=conRs("c.jhy_fd_image_url")
		a3_c_jhy_fd_image_alt=conRs("c.jhy_fd_image_alt")
		
		oneClassId=a2_levelone_id
	end if
	if counterNumber=total+1 then a3_title=""'控制最后一条生成时候，下一页为“没有啦”
	'获取标题、关键字、描述
	this_page_title=a2_title
	this_page_keywords=a2_keywords
	this_page_description=a2_description

	'获取文件夹和文件位置、“您现在的位置”导航，并判断文件夹是否存在（否，则创建）
	if trim(a2_c_folder)&""="" then
		'调用文件夹检测和创建函数，创建文件夹，并返回当前栏目的物理文件夹路径（此文件夹只为生成静态html文件用，前台显示路径不用这个）
		folderPath=CreateContentFolder(fso,mpsitefoldername&"/"&a2_b_folder,"")
		category_position="<a href='../"&a2_b_folder&"'>"&a2_b_name&"</a>"
		this_page_channel_name="_"&a2_b_name'设置本页title频道名称
		b_websiteroot="../"
		mpparent_b_root="../../"
	else
		'调用文件夹检测和创建函数，创建文件夹，并返回当前栏目的物理文件夹路径（此文件夹只为生成静态html文件用，前台显示路径不用这个）
		folderPath=CreateContentFolder(fso,mpsitefoldername&"/"&a2_b_folder,a2_c_folder)
		category_position="<a href='../../"&a2_b_folder&"'>"&a2_b_name&"</a> > <a href='../"&a2_c_folder&"'>"&a2_c_name&"</a>"
		this_page_channel_name="_"&a2_c_name&"_"&a2_b_name'设置本页title频道名称
		b_websiteroot="../../"
		mpparent_b_root="../../../"
	end if
	
	'组装内容区内容
	'组装下载内容
	articleDownloads=""
	if a2_Files&""<>"" then
		downloadFiles=split(a2_Files,",")
		df_all=ubound(downloadFiles)
		for df_ii=0 to df_all
			articleDownloads=articleDownloads&"<div class='download ColorLink'><b>文件下载：</b>"
			articleDownloads=articleDownloads&"<a href='"&mpparent_b_root&"upAttachFile/"&downloadFiles(df_ii)&"' target='_blank'>"&downloadFiles(df_ii)&"</a> <span class='ListDate'>(点击右键可另存)</span></div> "
		next
	end if
	
	'组装上一篇、下一篇
	article_next=""
	if contentId=0 then
		'上一篇
		article_next=article_next&"<ul><li>上一篇："
		if trim(a1_title)&""="" then
			article_next=article_next&"没有啦"
		else
			if trim(a1_c_folder)&""="" then
				htmlFileUrl=b_websiteroot&a1_b_folder&"/"&a1_html_file_name
			else
				htmlFileUrl=b_websiteroot&a1_b_folder&"/"&a1_c_folder&"/"&a1_html_file_name
			end if
			article_next=article_next&"<a href='"&htmlFileUrl&"' title='"&a1_title&"'>"&a1_title&"</a> <span class='ListDate'>&nbsp;["&GetFormatDate(a1_edit_time)&"]</span>"
		end if
		article_next=article_next&"</li>"
		
		'下一篇
		article_next=article_next&"<li>下一篇："
		if trim(a3_title)&""="" then
			article_next=article_next&"没有啦"
		else
			if trim(a3_c_folder)&""="" then
				htmlFileUrl=b_websiteroot&a3_b_folder&"/"&a3_html_file_name
			else
				htmlFileUrl=b_websiteroot&a3_b_folder&"/"&a3_c_folder&"/"&a3_html_file_name
			end if
			article_next=article_next&"<a href='"&htmlFileUrl&"' title='"&a3_title&"'>"&a3_title&"</a> <span class='ListDate'>&nbsp;["&GetFormatDate(a3_edit_time)&"]</span>"
		end if
		article_next=article_next&"</li></ul>"
	else
		article_next=JuHaoYongArticleNextCodeHtml(a2_edit_time,b_websiteroot)
	end if
	
	'组合文章内容开始
	articleContent="<div class='content'>"
	articleContent=articleContent&"<div class='infos'>"&GetFormatTime(a2_edit_time)&"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;点击：<script language='javascript' src='"&mpparent_b_root&"inc/click_number.asp?id="&a2_id&"'></script></div>"
	
	articleContent=articleContent&"<div class='maincontent clearfix'>"
	articleContent=articleContent&replace(a2_content,"../images/","../../images/")
	articleContent=articleContent&"</div>"
	
	articleContent=articleContent&articleDownloads
	
	articleContent=articleContent&"<div class='prenext'>"
	articleContent=articleContent&article_next
	articleContent=articleContent&"</div>"
	articleContent=articleContent&"</div>"
	'组合文章内容结束
	
	'组装内页banner
	if trim(a2_c_jhy_fd_image)&""<>"" then
	this_page_banner="<div><a href='"&trim(a2_c_jhy_fd_image_url)&"'><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(a2_c_jhy_fd_image)&"' alt='"&trim(a2_c_jhy_fd_image_alt)&"'></a></div>"
	elseif trim(a2_b_jhy_fd_image)&""<>"" then
	this_page_banner="<div><a href='"&trim(a2_b_jhy_fd_image_url)&"'><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(a2_b_jhy_fd_image)&"' alt='"&trim(a2_b_jhy_fd_image_alt)&"'></a></div>"
	else
	this_page_banner=""
	end if
	
	'读取模板内容
	templateName="../templates/"&MP_SITE_TEMPLATE_FOLDER&"/mp_template_article"&oneClassId&".html"
	Set htmlwrite=fso.OpenTextFile(Server.MapPath(templateName)) 
	replace_code=htmlwrite.ReadAll() 
	htmlwrite.close
	
	'替换内容区内容
	replace_code=replace(replace_code,"$juhaoyong_common_inside_content$",articleContent)
	
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
	replace_code=replace(replace_code,"$inside_content_title$",a2_title)
	
	
	'替换左侧栏目栏的“当前栏目”
	if trim(a2_leveltwo_id)&""="" then
	replace_code=replace(replace_code,"tclassID"&a2_levelone_id,"current")
	else
	'replace_code=replace(replace_code,"tclassID"&a2_levelone_id,"topicCurrent")
	replace_code=replace(replace_code,"id=directoryID"&a2_leveltwo_id,"class='current'")
	end if
	
	'确定输出文件名
	fPath=folderPath&"/"&a2_html_file_name
	
	'最终输出写入生成文件
	if trim(a2_html_file_name)&""<>"" then
		Set f=fso.CreateTextFile(Server.MapPath(fPath),true)
		f.WriteLine replace_code
		f.close
		Set f=nothing
	end if

	if counterNumber=total then
		conRs.moveprevious'加一次循环，输出最后一条数据
	end if
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
'作  用：生成文章的"上一篇"和"下一篇"链接
'参  数：jhyArticleEditTime（当前文章编辑时间）
'=================================================
function JuHaoYongArticleNextCodeHtml(jhyArticleEditTime,b_websiteroot)
if trim(jhyArticleEditTime)&""="" then
	Exit Function
end if
dim rs,sql
dim article_next,htmlFileUrl
set rs=server.createobject("adodb.recordset")
article_next=""
htmlFileUrl=""

'生成上一篇链接
sql="select top 1 a.title,a.html_file_name,a.edit_time,b.folder,c.folder from (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id where a.edit_time>#"&GetFormatTime(jhyArticleEditTime)&"# and a.ArticleType=1 order by [a.edit_time] asc,a.id asc"
rs.open(sql),cn,1,1
article_next=article_next&"<ul><li>上一篇："
if not rs.eof and not rs.bof then
	if trim(rs("c.folder"))&""="" then
		htmlFileUrl=b_websiteroot&rs("b.folder")&"/"&rs("html_file_name")
	else
		htmlFileUrl=b_websiteroot&rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
	end if
	article_next=article_next&"<a href='"&htmlFileUrl&"' title='"&rs("title")&"'>"&rs("title")&"</a> <span class='ListDate'>&nbsp;["&GetFormatDate(rs("edit_time"))&"]</span>"
else
	article_next=article_next&"没有啦"
end if
article_next=article_next&"</li>"
rs.close

'生成下一篇链接
sql="select top 1 a.title,a.html_file_name,a.edit_time,b.folder,c.folder from (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id where a.edit_time<#"&GetFormatTime(jhyArticleEditTime)&"# and a.ArticleType=1 order by [a.edit_time] desc,a.id desc"
rs.open(sql),cn,1,1
article_next=article_next&"<li>下一篇："
if not rs.eof and not rs.bof then
	if trim(rs("c.folder"))&""="" then
		htmlFileUrl=b_websiteroot&rs("b.folder")&"/"&rs("html_file_name")
	else
		htmlFileUrl=b_websiteroot&rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
	end if
	article_next=article_next&"<a href='"&htmlFileUrl&"' title='"&rs("title")&"'>"&rs("title")&"</a> <span class='ListDate'>&nbsp;["&GetFormatDate(rs("edit_time"))&"]</span>"
else
	article_next=article_next&"没有啦"
end if
article_next=article_next&"</li></ul>"
rs.close
set rs=nothing
JuHaoYongArticleNextCodeHtml=article_next
end function
%>