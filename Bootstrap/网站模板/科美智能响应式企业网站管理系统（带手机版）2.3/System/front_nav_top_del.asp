<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<%
nav_id=cint(request.querystring("id"))
delconfirm=request.querystring("delconfirm")
if delconfirm<>"1" then
	response.Write JuhaoyongConfirmPage("����Top���ߵ���ɾ��","ɾ���󲻿ɻָ���ȷ��ɾ����","front_nav_top_del.asp?delconfirm=1&id="&nav_id)
	response.end
else
	cn.Execute "delete from juhaoyong_tb_navfirst where id="&nav_id

	response.Write JuhaoyongResultPage("����Top���ߵ���ɾ��","ɾ���ɹ�","front_nav_top_list.asp")
	response.end
end if
%>

<%
Call DbconnEnd()
 %>