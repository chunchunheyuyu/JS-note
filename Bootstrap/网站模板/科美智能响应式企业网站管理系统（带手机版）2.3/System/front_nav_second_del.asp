<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->

<%
oneid=request.querystring("oneid")
act=request.querystring("act")
keywords=request.querystring("keywords")
nav_id=cint(request.querystring("id"))
delconfirm=request.querystring("delconfirm")
if delconfirm<>"1" then
	response.Write JuhaoyongConfirmPage("������������ɾ��","ɾ���󲻿ɻָ���ȷ��ɾ����","front_nav_second_del.asp?delconfirm=1&id="&nav_id&"&oneid="&oneid&"&act="&act&"&keywords="&keywords)
	response.end
else
	cn.Execute "delete from juhaoyong_tb_navsecond where id="&nav_id
	
	response.Write JuhaoyongResultPage("������������ɾ��","ɾ���ɹ�","front_nav_second_list.asp?oneid="&oneid&"&act="&act&"&keywords="&keywords)
	response.end
end if
%>

<%
Call DbconnEnd()
 %>