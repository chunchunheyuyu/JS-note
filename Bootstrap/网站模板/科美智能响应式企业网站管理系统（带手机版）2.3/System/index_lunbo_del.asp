<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->

<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="../inc/rebuild_modify_template.asp" -->

<!-- #include file="inc/head.asp" -->

<%
lunbo_id=cint(request.querystring("id"))
delconfirm=request.querystring("delconfirm")
if delconfirm<>"1" then
	response.Write JuhaoyongConfirmPage("�ֲ�ͼƬɾ��","ɾ���󲻿ɻָ���ȷ��ɾ����","index_lunbo_del.asp?delconfirm=1&id="&lunbo_id)
	response.end
else
	set rs=server.createobject("adodb.recordset")
	sql="select id,image from juhaoyong_tb_picture where id="&lunbo_id&""
	rs.open(sql),cn,1,3
	imageName=rs("image")
	rs.delete
	rs.close
	set rs=nothing
	
	'���ж�ͼƬ�Ƿ���ڣ�����ɾ��
	FilePath=Server.MapPath("../css/"&SITE_STYLE_CSS_FOLDER&"/"&imageName)
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	If fso.FileExists(FilePath) then fso.DeleteFile(FilePath)
	set fso=nothing
	
	'����������ҳģ��
	call RewriteTemplateFile(0,0)
	'������ҳ
	call Run_createhtml_index()
	response.Write JuhaoyongResultPage("�ֲ�ͼƬɾ��","ɾ���ɹ�","index_lunbo_list.asp")
	response.end
end if
%>

<%
Call DbconnEnd()
 %>