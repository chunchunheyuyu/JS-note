<%
'=================================================
'��  �ã��������ºͲ�Ʒ�б�ȫ���򵥸���
'��  ����dirId �ַ��ͣ���Ŀid��"0"ʱ��ʾȫ����
'=================================================
function Run_createhtml_singlepage_content(dirId)
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
		folderPath=CreateContentFolder(fso,categoryRs("a.folder"),"")

		category_position="<a href='../"&categoryRs("a.folder")&"'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name=""'���ñ�ҳtitleƵ������
		ClassSQL="oneid"
		b_websiteroot="../"
		juhaoyong_mp_folder_file_name=categoryRs("a.folder")&"/"
	else
		oneClassId=categoryRs("jhy_fd_dir_parentid")
		folderPath="../"&categoryRs("b.folder")&"/"&categoryRs("a.folder")
		
		category_position="<a href='../"&categoryRs("b.folder")&"'>"&categoryRs("b.name")&"</a> > <a href='"&categoryRs("a.folder")&".html'>"&categoryRs("a.name")&"</a>"
		this_page_channel_name="_"&categoryRs("b.name")'���ñ�ҳtitleƵ������
		ClassSQL="twoid"
		b_websiteroot="../"
		juhaoyong_mp_folder_file_name=categoryRs("b.folder")&"/"&categoryRs("a.folder")&".html"
	end if
	
	'���ݶ�ȡ
	list_block="<div class='content'>"
	list_block=list_block&"<div class='maincontent clearfix'>"
	list_block=list_block&categoryRs("content")
	list_block=list_block&"</div>"
	list_block=list_block&"</div>"
	
	'��װ��ҳbanner
	if trim(categoryRs("a.jhy_fd_image"))<>"" then
	this_page_banner="<div class='insidebanner'><a href='"&trim(categoryRs("a.jhy_fd_image_url"))&"'><img src='"&b_websiteroot&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("a.jhy_fd_image"))&"' alt='"&trim(categoryRs("a.jhy_fd_image_alt"))&"'></a></div>"
	elseif trim(categoryRs("b.jhy_fd_image"))<>"" then
	this_page_banner="<div class='insidebanner'><a href='"&trim(categoryRs("b.jhy_fd_image_url"))&"'><img src='"&b_websiteroot&"css/"&SITE_STYLE_CSS_FOLDER&"/"&trim(categoryRs("b.jhy_fd_image"))&"' alt='"&trim(categoryRs("b.jhy_fd_image_alt"))&"'></a></div>"
	else
	this_page_banner=""
	end if

	'��ȡģ������
	if categoryRs("ClassType")=1 then
		templateName="../templates/"&SITE_TEMPLATE_FOLDER&"/template_article"&oneClassId&".html"
	else
		templateName="../templates/"&SITE_TEMPLATE_FOLDER&"/template_singlepage"&oneClassId&".html"
	end if
	
	Set htmlwrite=fso.OpenTextFile(Server.MapPath(templateName)) 
	replace_code=htmlwrite.ReadAll() 
	htmlwrite.close
	
	'ѭ���б��滻����
	replace_code=replace(replace_code,"$juhaoyong_common_inside_content$",list_block)
	
	'ѭ�������滻����
	replace_code=replace(replace_code,"$Site_GenMuLu$",b_websiteroot)
	replace_code=replace(replace_code,"$juhaoyong_mp_folder_file_name$",juhaoyong_mp_folder_file_name)
	replace_code=replace(replace_code,"$this_page_title$",this_page_title)
	replace_code=replace(replace_code,"$this_page_channel_name$",this_page_channel_name)
	replace_code=replace(replace_code,"$this_page_keywords$",this_page_keywords)
	replace_code=replace(replace_code,"$this_page_description$",this_page_description)
	replace_code=replace(replace_code,"$category_position$",category_position)
	
	if categoryRs("jhy_fd_dir_parentid")=0 then
	replace_code=replace(replace_code,"tclassID"&categoryRs("id"),"topicCurrent")
	else
	'replace_code=replace(replace_code,"tclassID"&categoryRs("jhy_fd_dir_parentid"),"topicCurrent")
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

