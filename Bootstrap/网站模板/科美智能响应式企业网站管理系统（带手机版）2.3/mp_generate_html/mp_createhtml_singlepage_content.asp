<%
'=================================================
'��  �ã��������ºͲ�Ʒ�б�ȫ���򵥸���
'��  ����dirId �ַ��ͣ���Ŀid��"0"ʱ��ʾȫ����
'��  ����mpsitefoldername �ַ��ͣ��ֻ���վ�ļ������ƣ�
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
'ѭ�����ɲ�ѯ������������Ŀҳ��ʼ
do while not categoryRs.eof
	this_category_name=categoryRs("a.name")
	if categoryRs("title")<>"" then
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
		ClassSQL="oneid"
		b_websiteroot="../"
		mpparent_b_root="../../"
	else
		oneClassId=categoryRs("jhy_fd_dir_parentid")
		folderPath="../"&mpsitefoldername&"/"&categoryRs("b.folder")&"/"&categoryRs("a.folder")
		
		category_position="<a href='../"&categoryRs("b.folder")&"'>"&categoryRs("b.name")&"</a> > <a href='../"&categoryRs("a.folder")&"'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name="_"&categoryRs("b.name")'���ñ�ҳtitleƵ������
		ClassSQL="twoid"
		b_websiteroot="../"
		mpparent_b_root="../../"
	end if
	
	'���ݶ�ȡ
	list_block=""
	list_block=list_block&"<div class='content'>"
	list_block=list_block&replace(categoryRs("content"),"../images/","../../images/")
	list_block=list_block&"</div>"
	
	'��װ��ҳbanner
	if trim(categoryRs("a.jhy_fd_image"))<>"" then
	this_page_banner="<div><a href='"&trim(categoryRs("a.jhy_fd_image_url"))&"'><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("a.jhy_fd_image"))&"' alt='"&trim(categoryRs("a.jhy_fd_image_alt"))&"'></a></div>"
	elseif trim(categoryRs("b.jhy_fd_image"))<>"" then
	this_page_banner="<div><a href='"&trim(categoryRs("b.jhy_fd_image_url"))&"'><img src='"&mpparent_b_root&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("b.jhy_fd_image"))&"' alt='"&trim(categoryRs("b.jhy_fd_image_alt"))&"'></a></div>"
	else
	this_page_banner=""
	end if

	'��ȡģ������
	if categoryRs("ClassType")=1 then
		templateName="../templates/"&MP_SITE_TEMPLATE_FOLDER&"/mp_template_article"&oneClassId&".html"
	else
		templateName="../templates/"&MP_SITE_TEMPLATE_FOLDER&"/mp_template_singlepage"&oneClassId&".html"
	end if
	
	Set htmlwrite=fso.OpenTextFile(Server.MapPath(templateName)) 
	replace_code=htmlwrite.ReadAll() 
	htmlwrite.close
	
	'ѭ���б��滻����
	replace_code=replace(replace_code,"$juhaoyong_common_inside_content$",list_block)
	
	'ѭ�������滻����
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
	
	'�滻��ҳbanner
	replace_code=replace(replace_code,"$this_page_banner$",this_page_banner)
	
	'ȷ������ļ���
	if categoryRs("jhy_fd_dir_parentid")=0 then
	fPath=folderPath&"/index.html"
	else
	fPath=folderPath&".html"
	end if
	
	'�������д�������ļ�
	Set f=fso.CreateTextFile(Server.MapPath(fPath),true)
	f.WriteLine replace_code
	f.close
	Set f=nothing

categoryRs.movenext
loop
'ѭ�����ɲ�ѯ������������Ŀҳ����
end if

categoryRs.close
set categoryRs=nothing

set fso=nothing
end function
%>

