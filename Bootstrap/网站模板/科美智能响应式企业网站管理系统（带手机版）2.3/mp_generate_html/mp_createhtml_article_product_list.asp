<%
'=================================================
'��  �ã��������ºͲ�Ʒ�б�ȫ���򵥸���
'��  ����classTypeNumber����Ŀ���ͣ�1��ʾ���£�2��ʾ��Ʒ��
'��  ����dirId �ַ��ͣ���Ŀid��"0"ʱ��ʾȫ����
'��  ����mpsitefoldername �ַ��ͣ��ֻ���վ�ļ������ƣ�
'=================================================
function MP_Run_createhtml_article_product_list(classTypeNumber,dirId,mpsitefoldername)
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
	this_category_name=categoryRs("a.name")
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
		folderPath=CreateContentFolder(fso,mpsitefoldername&"/"&categoryRs("a.folder"),"")
		category_position="<a href='../"&categoryRs("a.folder")&"'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name=""'���ñ�ҳtitleƵ������
		ClassSQL="jhy_fd_levelone_id"
		b_websiteroot="../"
		mpparent_b_root="../../"
	else
		oneClassId=categoryRs("jhy_fd_dir_parentid")
		'�����ļ��м��ʹ��������������ļ��У������ص�ǰ��Ŀ�������ļ���·�������ļ���ֻΪ���ɾ�̬html�ļ��ã�ǰ̨��ʾ·�����������
		folderPath=CreateContentFolder(fso,mpsitefoldername&"/"&categoryRs("b.folder"),categoryRs("a.folder"))
		category_position="<a href='../../"&categoryRs("b.folder")&"'>"&categoryRs("b.name")&"</a> > <a href='../"&categoryRs("a.folder")&"'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name="_"&categoryRs("b.name")'���ñ�ҳtitleƵ������
		ClassSQL="jhy_fd_leveltwo_id"
		b_websiteroot="../../"
		mpparent_b_root="../../../"
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
					list_block=list_block&InsideProductList(categoryRs,rs,mpparent_b_root)'���ò�Ʒ�б���
			end select
			list_block=list_block&"<div class='clearblockboth'></div>"
			list_block=list_block&PageListHtmlCommon(rscount,pageNumber,totalpage,counter)'����ͨ�÷�ҳ����
			'һҳ�����б�ѭ����ȡ�����������
		end if
		
		'��װ��ҳbanner
		if trim(categoryRs("a.jhy_fd_image"))<>"" then
		this_page_banner="<div><a href='"&trim(categoryRs("a.jhy_fd_image_url"))&"'><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("a.jhy_fd_image"))&"' alt='"&trim(categoryRs("a.jhy_fd_image_alt"))&"'></a></div>"
		elseif trim(categoryRs("b.jhy_fd_image"))<>"" then
		this_page_banner="<div><a href='"&trim(categoryRs("b.jhy_fd_image_url"))&"'><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("b.jhy_fd_image"))&"' alt='"&trim(categoryRs("b.jhy_fd_image_alt"))&"'></a></div>"
		else
		this_page_banner=""
		end if
		
		'��ȡģ������
		select case classTypeNumber
			case 1
				templateName="../templates/"&MP_SITE_TEMPLATE_FOLDER&"/mp_template_article"&oneClassId&".html"
			case 2
				templateName="../templates/"&MP_SITE_TEMPLATE_FOLDER&"/mp_template_product"&oneClassId&".html"
		end select
		Set htmlwrite=fso.OpenTextFile(Server.MapPath(templateName))
		replace_code=htmlwrite.ReadAll() 
		htmlwrite.close
		
		'ѭ�����б������滻
		replace_code=replace(replace_code,"$juhaoyong_common_inside_content$",list_block)
		
		'ѭ���������ط����滻
		replace_code=replace(replace_code,"$Site_GenMuLu$",b_websiteroot)
		replace_code=replace(replace_code,"$MPparent_GenMuLu$",mpparent_b_root)
		replace_code=replace(replace_code,"$inside_content_title$",this_category_name)
		replace_code=replace(replace_code,"$this_page_title$",this_page_title)
		replace_code=replace(replace_code,"$this_page_channel_name$",this_page_channel_name)
		replace_code=replace(replace_code,"$this_page_keywords$",this_page_keywords)
		replace_code=replace(replace_code,"$this_page_description$",this_page_description)
		replace_code=replace(replace_code,"$category_position$",category_position)
		
		'�滻�����Ŀ����"��ǰ��Ŀ"����
		if categoryRs("jhy_fd_dir_parentid")=0 then
		replace_code=replace(replace_code,"tclassID"&categoryRs("id"),"current")
		else
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
list_block=list_block&"<ul class='articlelist'>"
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
	
	list_block=list_block&"<li class='articleli'><div class='phzxtitle'><a href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&left(rs("title"),17)&"</a></div><div class='phzxtime'>"&GetFormatDate(rs("edit_time"))&"</div><div class='clearblockboth'></div></li>"
rs.movenext
howmanyrecs=howmanyrecs+1
loop
list_block=list_block&"</ul>"
list_block=list_block&"<!--ArticleList end-->"
InsideArticleList=list_block
end function
%>

<%
function InsideProductList(categoryRs,rs,mpparent_b_root)
dim list_block,howmanyrecs
dim rs_url
list_block=""
list_block=list_block&"<!--ProductList start-->"
list_block=list_block&"<ul class='product'>"

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
	
	if (howmanyrecs mod 2 =0) and howmanyrecs>0 then 
	list_block=list_block&"</ul><ul class='product clearfix'>"
	end if
	list_block=list_block&"<li>"
	list_block=list_block&"<a class='picbox clearfix' href='"&rs_url&"' title='"&rs("title")&"' target='_blank'><img src='"&mpparent_b_root&"images/up_images/"&rs("image")&"' alt='"&rs("title")&"' /></a>"
	list_block=list_block&"<a class='pictitle clearfix' href='"&rs_url&"' title='"&rs("title")&"' target='_blank'>"&trim(left(rs("title"),17))&"</a>"
	if rs("con_youhuijia")&""<>"" then
	list_block=list_block&"<span class='boxPrice clearfix'>&#165;"&rs("con_youhuijia")&"</span>"
	end if
	list_block=list_block&"</li>"
	
rs.movenext
howmanyrecs=howmanyrecs+1
loop
list_block=list_block&"</ul>"
list_block=list_block&"<!--ProductList end-->"
InsideProductList=list_block
end function
%>