<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<%
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")
article_id=cint(request.querystring("id"))
set rs=server.createobject("adodb.recordset")
sql="select id,view_yes from juhaoyong_tb_link where id="&article_id&""
rs.open(sql),cn,1,3
if rs("view_yes")=0 then
rs("view_yes")=1
else
rs("view_yes")=0
end if
rs.update
rs.close
set rs=nothing

response.Write JuhaoyongResultPage("友情链接显示/隐藏","修改成功","link_list.asp?keywords="&keywords)
response.end
%>

<%
Call DbconnEnd()
%>