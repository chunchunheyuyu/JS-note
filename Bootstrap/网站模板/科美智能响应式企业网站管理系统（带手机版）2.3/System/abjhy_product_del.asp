<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/mp_functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../inc/function_common_html_create.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="../generate_html/createhtml_article_product_list.asp" -->
<!-- #include file="inc/head.asp" -->

<%
dim mp_site_foldername
mp_site_foldername=MP_Get_mp_site_foldername()'��ȡ�ֻ���վĿ¼����
%>

<%
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")

'��ȡ��Ŀid
oneid=request.QueryString("oneid")
twoid=request.QueryString("twoid")

dim id,intNum,strFolder
dim delconfirm
if request("action")="AllDel" then
	delconfirm=request.form("delconfirm")
	intNum=request.form("Selectitem").count
	if intNum=0 then
		response.Write JuhaoyongResultPage("��Ʒ��������ɾ��","��ѡ��Ҫɾ��������","abjhy_product_list.asp?oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	end if
	
	if delconfirm<>"1" then
		response.Write"<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
		response.Write"	<tr><th class='tableHeaderText'>��Ʒ��������ɾ��</th></tr>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />ɾ���󲻿ɻָ���ȷ��ɾ����</font><br /><br /></td></tr>"
		response.Write"<form name='form2' method='post' action='abjhy_product_del.asp?action=AllDel&oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords&"'>"
		response.Write"<input name='Selectitem' type=hidden value='"&request.Form("Selectitem")&"'>"
		response.Write"<input name='delconfirm' type=hidden value='1'>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><input type='submit' name='Submit' value=' ȷ �� ' style='height:25px;width:80px;'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=# onclick='history.go(-1)'><font size='+1'>�� ��</font></a><br /><br /></td></tr>"
		response.Write"</table>"
		response.Write"</form>"
		response.end
	else
		id=split(request.Form("Selectitem"),",")
		c=ubound(id)
		for i=0 to c
			call DeleteProductByID(id(i),mp_site_foldername)
		next
	end if
else
	id=request.querystring("id")
	delconfirm=request.querystring("delconfirm")
	if delconfirm<>"1" then
		response.Write JuhaoyongConfirmPage("��Ʒ��������ɾ��","ɾ���󲻿ɻָ���ȷ��ɾ����","abjhy_product_del.asp?delconfirm=1&id="&id&"&oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	else
		call DeleteProductByID(id,mp_site_foldername)
	end if
end if

'����������ҳ
call Run_createhtml_index()
'����������Ŀ�б�ҳ
call Run_createhtml_article_product_list(2,oneid)'��������һ����Ʒ�б�
call Run_createhtml_article_product_list(2,twoid)'�������ɶ�����Ʒ�б�

response.Write JuhaoyongResultPage("��Ʒ��������ɾ��","ɾ���ɹ�","abjhy_product_list.asp?oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
response.end
%>

<%
Call DbconnEnd()
%>
 
<%
'=================================================
'���ã�ɾ����Ʒ
'������id��Ҫɾ���ļ�¼id��
'������mp_foldername���ֻ���վĿ¼���ƣ�
'=================================================
Function DeleteProductByID(id,mp_foldername)
	dim rs,sql
	dim filePath,fileName,imageName
	set rs=server.createobject("adodb.recordset")
	'��ѯ��ȡ��Ӧ���ļ���
	sql="select a.id, a.jhy_fd_leveltwo_id, a.html_file_name, a.image ,b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id where a.id="&id
	rs.open(sql),cn,1,1
	fileName=rs("html_file_name")
	imageName=rs("image")
	if rs("jhy_fd_leveltwo_id")&""="" then
		strFolder="../"&rs("b.folder")
		mp_strFolder="../"&mp_foldername&"/"&rs("b.folder")
	else
		strFolder="../"&rs("b.folder")&"/"&rs("c.folder")
		mp_strFolder="../"&mp_foldername&"/"&rs("b.folder")&"/"&rs("c.folder")
	end if
	rs.close
	set rs=nothing
	
	'ɾ����¼
	cn.Execute "delete from juhaoyong_tb_content where id="&id
	
	'ɾ����Ʒhtml��̬ҳ���ļ�
	filePath=strFolder&"/"&fileName
	mp_filePath=mp_strFolder&"/"&fileName '�ֻ����ļ�·��
	
	JuhaoyongDeleteFile(filePath)
	JuhaoyongDeleteFile(mp_filePath) 'ɾ���ֻ����ļ�
	
	'ɾ����ƷͼƬ
	filePath="../images/up_images/"&imageName
	JuhaoyongDeleteFile(filePath)
End Function
%>