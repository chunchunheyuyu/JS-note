<%
'=================================================
'��������վ������Ϣ��ͷ��
'=================================================
Function MP_SiteSetInfo(templateString)
dim rs,sql
dim jhy_fd_site_name,jhy_fd_phonetitle,jhy_fd_phonenumber,jhy_fd_site_bottomhtml
set rs=server.createobject("adodb.recordset")
sql="select jhy_fd_site_name,jhy_fd_phonetitle,jhy_fd_phonenumber,jhy_fd_site_bottomhtml,jhy_fd_title_channelnameonoff,jhy_fd_title_sitenameonoff from juhaoyong_tb_siteconfig"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
	jhy_fd_site_name=rs("jhy_fd_site_name")
	if jhy_fd_site_name&""<>"" then jhy_fd_site_name="_"&jhy_fd_site_name
	jhy_fd_phonenumber=rs("jhy_fd_phonenumber")
	jhy_fd_phonetitle=rs("jhy_fd_phonetitle")
	jhy_fd_site_bottomhtml=rs("jhy_fd_site_bottomhtml")
	jhy_fd_title_channelnameonoff=rs("jhy_fd_title_channelnameonoff")
	jhy_fd_title_sitenameonoff=rs("jhy_fd_title_sitenameonoff")
end if
rs.close
set rs=nothing

if trim(jhy_fd_phonenumber&"")<>"" then
mp_index_phone_string="<div class='clearblockboth'></div>"
mp_index_phone_string=mp_index_phone_string&"<div class='tel'><a href='tel:"&jhy_fd_phonenumber&"'><img alt='��ϵ�绰' src='$MPparent_GenMuLu$css/"&MP_SITE_STYLE_CSS_FOLDER&"/tel.gif' border='0' /> &nbsp;"&jhy_fd_phonetitle&" "&jhy_fd_phonenumber&"</a></div>"
else
mp_index_phone_string=""
end if

MP_SiteSetInfo=templateString
MP_SiteSetInfo=replace(MP_SiteSetInfo,"###juhaoyong_css_folder###",MP_SITE_STYLE_CSS_FOLDER)
MP_SiteSetInfo=replace(MP_SiteSetInfo,"###pc_juhaoyong_css_folder###",SITE_STYLE_CSS_FOLDER)

if jhy_fd_title_channelnameonoff=1 then
MP_SiteSetInfo=replace(MP_SiteSetInfo,"###this_page_channel_name###","$this_page_channel_name$")
else
MP_SiteSetInfo=replace(MP_SiteSetInfo,"###this_page_channel_name###","")
end if

if jhy_fd_title_sitenameonoff=1 then
MP_SiteSetInfo=replace(MP_SiteSetInfo,"###template_site_name###",jhy_fd_site_name)
else
MP_SiteSetInfo=replace(MP_SiteSetInfo,"###template_site_name###","")
end if

MP_SiteSetInfo=replace(MP_SiteSetInfo,"###mp_index_phone_string###",mp_index_phone_string)

MP_SiteSetInfo=replace(MP_SiteSetInfo,"###template_site_bottom_html###",jhy_fd_site_bottomhtml)
End Function
%>

<%
'=================================================
'��������������
'=================================================
Function MP_TopNavigation(templateString)
dim rs,sql,replaceString,rsnumber
dim juhaoyongMenuLink1,juhaoyongMenuOutLinkBlank1
dim indexnavstart
replaceString=""
set rs=server.createobject("adodb.recordset")
sql="select * from juhaoyong_tb_navfirst where fd_navfirst_type=1 order by [order]"
rs.open(sql),cn,1,1
if not rs.eof then
	replaceString=replaceString&"<ul class='mainnav clearfix'>"
	replaceString=replaceString&"<li class='mainnav_line clearfix'>"
	rsnumber=0
	do while not rs.eof
		if instr(rs("url"),"://")>0 then
			juhaoyongMenuLink1=rs("url")
			juhaoyongMenuOutLinkBlank1=" target=_blank"
		else
			juhaoyongMenuLink1="$Site_GenMuLu$"&rs("url")
			juhaoyongMenuOutLinkBlank1=""
		end if
		
		indexnavstart=""
		if rsnumber=0 or (rsnumber mod 4 =0) then indexnavstart=" class='indexnavstart'"
		
		if (rsnumber mod 4 =0) and rsnumber>0 then
		replaceString=replaceString&"</li><li class='mainnav_line clearfix'>"
		end if
		replaceString=replaceString&"<a"&indexnavstart&" href='"&juhaoyongMenuLink1&"'"&juhaoyongMenuOutLinkBlank1&">"&rs("name")&"</a>"
	rs.movenext
	rsnumber=rsnumber+1
	loop
	replaceString=replaceString&"</li>"
	replaceString=replaceString&"</ul>"
end if
rs.close
set rs=nothing
MP_TopNavigation=replace(templateString,"###web_top_menu###",replaceString)
End Function
%>

<%
'=================================================
'����������Top���ߵ�����Ҳ�ǵײ�������
'=================================================
Function MP_MostTopNavigation(templateString)
dim rs,sql,replaceString
dim juhaoyongMenuLink1,juhaoyongMenuOutLinkBlank1
replaceString=""
set rs=server.createobject("adodb.recordset")
sql="select * from juhaoyong_tb_navfirst where fd_navfirst_type=3 order by [order],id"
rs.open(sql),cn,1,1
if not rs.eof then
	for i=1 to rs.recordcount
		
		if instr(rs("url"),"://")>0 then
			juhaoyongMenuLink1=rs("url")
			juhaoyongMenuOutLinkBlank1=" target=_blank"
		else
			juhaoyongMenuLink1="$Site_GenMuLu$"&rs("url")
			juhaoyongMenuOutLinkBlank1=""
		end if
		
		if i>1 then
		replaceString=replaceString&" | "
		end if
		replaceString=replaceString&"<a href='"&juhaoyongMenuLink1&"'"&juhaoyongMenuOutLinkBlank1&">"&rs("name")&"</a>"
		
		rs.movenext
	next
end if
rs.close
set rs=nothing
MP_MostTopNavigation=replace(templateString,"###mp_web_top_menu###",replaceString)
End Function
%>

<%
'=================================================
'����������������б��������¡������б���ҳ����Ʒ����Ʒ�б�ʱ���ã��г�����ͬ���͵�һ�����༰���µĶ������ࣩ
'=================================================
Function MP_SideArticleClassList(templateString,classTypeNumber,oneClassId)
dim rsOne,sqlOne
dim rs,sql
dim iFolderName,currentLi
dim replaceString

if classTypeNumber=4 then
MP_SideArticleClassList=replace(templateString,"###side_common_class_list###","")
Exit Function
end if

replaceString=""

sqlOne="select [id],[name],[folder],ClassType from [juhaoyong_tb_directory] where id="&oneClassId

set rsOne=server.createobject("adodb.recordset")
rsOne.open(sqlOne),cn,1,1
if not rsOne.eof and not rsOne.bof then
replaceString=replaceString&"<ul class='mainnav clearfix'>"
	
	replaceString=replaceString&"<li class='mainnav_line clearfix'>"
	replaceString=replaceString&"<a class='firstmenu tclassID"&rsOne("id")&"' href='$Site_GenMuLu$"&rsOne("Folder")&"'>"&rsOne("name")&"</a>"

	set rs=server.createobject("adodb.recordset")
	sql="select [id],[name],[folder],ClassType from [juhaoyong_tb_directory] where jhy_fd_dir_parentid="&rsOne("id")&" order by [order]"
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
		do while not rs.eof
		iFolderName=rs("Folder")
		if rs("ClassType")=3 then iFolderName=rs("Folder")&".html"
		replaceString=replaceString&"<a id=directoryID"&rs("id")&" href='$Site_GenMuLu$"&rsOne("Folder")&"/"&iFolderName&"'>"&rs("name")&"</a>"
		rs.movenext
		loop
	end if
	rs.close
	set rs=nothing
	replaceString=replaceString&"</li>"
	replaceString=replaceString&"</ul>"
end if
rsOne.close
set rsOne=nothing
MP_SideArticleClassList=replace(templateString,"###side_common_class_list###",replaceString)
End Function
%>

<%
'=================================================
'��������Դģ���ļ�������ģ���ļ�
'=================================================
Function MP_RewriteTemplateFile(classTypeNumber,oneClassId)
dim templateFileNameSource,templateFileName,rewriteTemplateString
dim fso,f

templateFileNameSource="mp_template_inside.html"
select case classTypeNumber
	case 0
		templateFileNameSource="mp_template_index.html"
		templateFileName=templateFileNameSource
	case 1
		templateFileName="mp_template_article"&oneClassId&".html"
	case 2
		templateFileName="mp_template_product"&oneClassId&".html"
	case 3
		templateFileName="mp_template_singlepage"&oneClassId&".html"
	case 4
		templateFileName="mp_template_other.html"
end select

Set fso=Server.CreateObject("Scripting.FileSystemObject")

'��Դģ���ļ�
Set f=fso.OpenTextFile(Server.MapPath("../templates/"&MP_SITE_TEMPLATE_SOURCE_FOLDER&"/"&templateFileNameSource), 1)
	rewriteTemplateString=f.ReadAll
f.Close

'�滻ģ���ļ����ݿ�ʼ
rewriteTemplateString=MP_SiteSetInfo(rewriteTemplateString)'�滻--��վ������Ϣ
rewriteTemplateString=MP_MostTopNavigation(rewriteTemplateString)'�滻--����Top���ߵ�����Ҳ�ǵײ�������

if classTypeNumber=0 then
	rewriteTemplateString=MP_TopNavigation(rewriteTemplateString)'�滻--��ҳ��������
else
	rewriteTemplateString=MP_SideArticleClassList(rewriteTemplateString,classTypeNumber,oneClassId)'�滻--����������б�classTypeNumber=1���¡�2��Ʒ��3��ҳ��
end if
'�滻ģ���ļ����ݽ���

'��������ģ���ļ�
Set f=fso.CreateTextFile(Server.MapPath("../templates/"&MP_SITE_TEMPLATE_FOLDER&"/"&templateFileName))
	f.Write rewriteTemplateString
f.Close

Set f=Nothing
Set fso=nothing
End Function
%>