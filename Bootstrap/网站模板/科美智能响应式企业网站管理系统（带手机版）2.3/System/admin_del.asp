<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->

<%
admin_id=request.querystring("id")
delconfirm=request.querystring("delconfirm")
if delconfirm<>"1" then
	response.Write JuhaoyongConfirmPage("删除后台系统管理员","删除后不可恢复，确定删除吗？","admin_del.asp?delconfirm=1&id="&admin_id)
	response.end
else
	set rs=server.createobject("adodb.recordset")
	sql="select id from juhaoyong_tb_user where id="&admin_id&""
	rs.open(sql),cn,1,3
	if rs("id")<>1 then
		rs.delete
	else
		response.Write JuhaoyongResultPage("删除后台系统管理员","用户admin不能删除","admin_list.asp")
		response.end
	end if
	rs.close
	set rs=nothing
	
	response.Write JuhaoyongResultPage("删除后台系统管理员","删除成功","admin_list.asp")
	response.end
end if
%>


<%
Call DbconnEnd()
 %>