<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<%
act=request.querystring("act")
keywords=request.querystring("keywords")
link_id=cint(request.querystring("id"))
delconfirm=request.querystring("delconfirm")
if delconfirm<>"1" then
	response.Write JuhaoyongConfirmPage("���߿ͷ�ɾ��","ɾ���󲻿ɻָ���ȷ��ɾ����","link_del.asp?delconfirm=1&id="&link_id&"&act="&act&"&keywords="&keywords)
	response.end
else
	set rs=server.createobject("adodb.recordset")
	sql="select id,image from juhaoyong_tb_link where id="&link_id&""
	rs.open(sql),cn,1,3
	imageName=rs("image")
	rs.delete
	rs.close
	set rs=nothing
	
	'���ж�ͼƬ�Ƿ���ڣ�����ɾ��
	FilePath=Server.MapPath("../images/up_images/"&imageName)
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	If fso.FileExists(FilePath) then fso.DeleteFile(FilePath)
	set fso=nothing
	
	response.Write JuhaoyongResultPage("��������ɾ��","ɾ���ɹ�","link_list.asp?act="&act&"&keywords="&keywords)
	response.end
end if
%>

<%
Call DbconnEnd()
%>