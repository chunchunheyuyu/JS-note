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
	response.Write JuhaoyongConfirmPage("顶部一级导航删除","删除后不可恢复，确定删除吗？","front_nav_first_del.asp?delconfirm=1&id="&nav_id)
	response.end
else
	cn.Execute "delete from juhaoyong_tb_navfirst where id="&nav_id

	response.Write JuhaoyongResultPage("顶部一级导航删除","删除成功","front_nav_first_list.asp")
	response.end
end if
%>

<%
Call DbconnEnd()
 %>