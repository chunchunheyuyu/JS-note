<%
'=================================================
'��  �ã��������ºͲ�Ʒ�б�ȫ���򵥸���
'��  ����classTypeNumber����Ŀ���ͣ�1��ʾ���£�2��ʾ��Ʒ��
'��  ����dirId �ַ��ͣ���Ŀid��"0"ʱ��ʾȫ����
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
'ѭ�����ɲ�ѯ������������Ŀҳ��ʼ
do while not categoryRs.eof
	if categoryRs("title")&""<>"" then
		this_page_title=categoryRs("title")
	else
		this_page_title=categoryRs("a.name")
	end if
	this_page_keywords=categoryRs("keywords")
	this_page_description=categoryRs("description")

	'��ȡ�ļ��к��ļ�λ�á��������ڵ�λ�á����������ж��ļ����Ƿ���ڣ����򴴽���
	if categoryRs("jhy_fd_dir_parentid")=0 then
		oneClassId=categoryRs("id")
		'�����ļ��м��ʹ��������������ļ��У������ص�ǰ��Ŀ�������ļ���·�������ļ���ֻΪ���ɾ�̬html�ļ��ã�ǰ̨��ʾ·�����������
		folderPath=CreateContentFolder(fso,categoryRs("a.folder"),"")
		category_position="<a href='../"&categoryRs("a.folder")&"'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name=""'���ñ�ҳtitleƵ������
		ClassSQL="jhy_fd_levelone_id"
		b_websiteroot="../"
		juhaoyong_mp_folder_file_name=categoryRs("a.folder")&"/"
	else
		oneClassId=categoryRs("jhy_fd_dir_parentid")
		'�����ļ��м��ʹ��������������ļ��У������ص�ǰ��Ŀ�������ļ���·�������ļ���ֻΪ���ɾ�̬html�ļ��ã�ǰ̨��ʾ·�����������
		folderPath=CreateContentFolder(fso,categoryRs("b.folder"),categoryRs("a.folder"))
		category_position="<a href='../../"&categoryRs("b.folder")&"'>"&categoryRs("b.name")&"</a> > <a href='../"&categoryRs("a.folder")&"'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name="_"&categoryRs("b.name")'���ñ�ҳtitleƵ������
		ClassSQL="jhy_fd_leveltwo_id"
		b_websiteroot="../../"
		juhaoyong_mp_folder_file_name=categoryRs("b.folder")&"/"&categoryRs("a.folder")&"/"
	end if
	
	'��װ���»��Ʒ�б�
	set rs=server.createObject("ADODB.Recordset")
	select case classTypeNumber
		case 1
			sql="SELECT a.id, a.title, a.jhy_fd_leveltwo_id, a.html_file_name, a.edit_time, b.folder from juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_leveltwo_id where "&ClassSQL&"='"&categoryRs("id")&"' And a.ArticleType=1 ORDER BY a.index_push DESC,a.edit_time DESC,a.id DESC"
		case 2
			sql="SELECT a.id, a.title, a.jhy_fd_leveltwo_id, a.html_file_name, a.image, a.con_youhuijia, b.folder from juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_leveltwo_id where "&ClassSQL&"='"&categoryRs("id")&"' And a.ArticleType=2 ORDER BY a.edit_time DESC,a.id DESC"
	end select
	rs.open sql,cn,1,1
	
	'��ҳ�������ã�һ��Ҫ�ŵ���ҳ���Ի�ȡǰ�棩
	select case classTypeNumber
		case 1
			rs.pagesize=30'����ÿҳ����
		case 2
			rs.pagesize=18'����ÿҳ����
	end select
		
	'��ҳ���Ի�ȡ
	rscount=rs.recordcount'������
	totalpage=rs.pagecount'��ҳ��
	if rs.bof and rs.eof then totalpage=0
	'ѭ���������з�ҳ��ʼ
	pageNumber=0
	Do
		pageNumber=pageNumber+1
		if pageNumber>totalpage then pageNumber=totalpage
		if not rs.eof then rs.AbsolutePage=pageNumber '���õ�ǰҳҳ��
		
		list_block=""
		if rs.bof and rs.eof then 
			list_block=list_block&"��������"
		else
			select case classTypeNumber
				case 1
					list_block=list_block&InsideArticleList(categoryRs,rs)'���������б���
				case 2
					list_block=list_block&InsideProductList(categoryRs,rs,b_websiteroot)'���ò�Ʒ�б���
			end select
			list_block=list_block&"<div class='clearfix'></div>"
			list_block=list_block&PageListHtmlCommon(rscount,pageNumber,totalpage,counter)'����ͨ�÷�ҳ����
			'һҳ�����б�ѭ����ȡ�����������
		end if
		
		'��װ��ҳbanner
		if trim(categoryRs("a.jhy_fd_image"))<>"" then
		this_page_banner="<div class='insidebanner'><a href='"&trim(categoryRs("a.jhy_fd_image_url"))&"'><img src='"&b_websiteroot&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("a.jhy_fd_image"))&"' alt='"&trim(categoryRs("a.jhy_fd_image_alt"))&"'></a></div>"
		elseif trim(categoryRs("b.jhy_fd_image"))<>"" then
		this_page_banner="<div class='insidebanner'><a href='"&trim(categoryRs("b.jhy_fd_image_url"))&"'><img src='"&b_websiteroot&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("b.jhy_fd_image"))&"' alt='"&trim(categoryRs("b.jhy_fd_image_alt"))&"'></a></div>"
		else
		this_page_banner=""
		end if
		
		'��ȡģ������
		select case classTypeNumber
			case 1
				templateName="../templates/"&SITE_TEMPLATE_FOLDER&"/template_article"&oneClassId&".html"
			case 2
				templateName="../templates/"&SITE_TEMPLATE_FOLDER&"/template_product"&oneClassId&".html"
		end select
		Set htmlwrite=fso.OpenTextFile(Server.MapPath(templateName))
		replace_code=htmlwrite.ReadAll() 
		htmlwrite.close
		
		'ѭ�����б������滻
		replace_code=replace(replace_code,"$juhaoyong_common_inside_content$",list_block)
		
		'ѭ���������ط����滻
		replace_code=replace(replace_code,"$Site_GenMuLu$",b_websiteroot)
		if pageNumber>1 then juhaoyong_mp_folder_file_name=juhaoyong_mp_folder_file_name&"page_"&pageNumber&".html"
		replace_code=replace(replace_code,"$juhaoyong_mp_folder_file_name$",juhaoyong_mp_folder_file_name)
		replace_code=replace(replace_code,"$this_page_title$",this_page_title)
		replace_code=replace(replace_code,"$this_page_channel_name$",this_page_channel_name)
		replace_code=replace(replace_code,"$this_page_keywords$",this_page_keywords)
		replace_code=replace(replace_code,"$this_page_description$",this_page_description)
		replace_code=replace(replace_code,"$category_position$",category_position)
		
		'�滻�����Ŀ����"��ǰ��Ŀ"����
		if categoryRs("jhy_fd_dir_parentid")=0 then
		replace_code=replace(replace_code,"tclassID"&categoryRs("id"),"topicCurrent")
		else
		'replace_code=replace(replace_code,"tclassID"&categoryRs("jhy_fd_dir_parentid"),"topicCurrent")
		replace_code=replace(replace_code,"id=directoryID"&categoryRs("id"),"class='current'")
		end if
		
		'�滻��ҳbanner
		replace_code=replace(replace_code,"$this_page_banner$",this_page_banner)
		
		'�滻��Ʒչʾҳ����Ҫ�����ͼƬչʾbox�Լ������ύ���ڵ�css��js��ǩ����Ϊ��
		if classTypeNumber=2 then replace_code=replace(replace_code,"$product_imagebox_orderwin_cssjs$","")
		
		'ȷ������ļ���
		if pageNumber>1 then
		fPath=folderPath&"/page_"&pageNumber&".html"
		else
		fPath=folderPath&"/index.html"
		end if
		
		'�������д�������ļ�
		Set f=fso.CreateTextFile(Server.MapPath(fPath),true)
		f.WriteLine replace_code
		f.close
		Set f=nothing

	Loop Until pageNumber=totalpage
	'ѭ���������з�ҳ����
	rs.close
	set rs=nothing
categoryRs.movenext
loop
'ѭ�����ɲ�ѯ������������Ŀҳ����
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
'һҳ�����б�ѭ����ȡ���������ʼ
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