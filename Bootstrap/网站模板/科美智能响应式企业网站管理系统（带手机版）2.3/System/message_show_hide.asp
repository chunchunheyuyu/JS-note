<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->

<!-- #include file="../inc/function_common_html_create.asp" -->
<!-- #include file="../generate_html/createhtml_other.asp" -->
<!-- #include file="inc/head.asp" -->

<%
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")
messageId=cint(request.querystring("id"))
set rs=server.createobject("adodb.recordset")
sql="select id,view_yes from juhaoyong_tb_guestbook where id="&messageId&""
rs.open(sql),cn,1,3
if rs("view_yes")=0 then
rs("view_yes")=1
else
rs("view_yes")=0
end if
rs.update
rs.close
set rs=nothing
call Run_createhtml_other("guestmessage","ÁôÑÔ·´À¡")'Éú³ÉÁôÑÔÒ³
response.Write JuhaoyongResultPage("ÁôÑÔÏÔÊ¾/Òþ²Ø","ÐÞ¸Ä³É¹¦","message_list.asp?page="&page&"&act="&act&"&keywords="&keywords)
response.end
%>

<%
Call DbconnEnd()
 %>