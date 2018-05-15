<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../generate_html/createhtml_article_content.asp" -->
<!-- #include file="inc/head.asp" -->

<%
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")
order_product_id=cint(request.querystring("id"))
set rs=server.createobject("adodb.recordset")
sql="select id,view_yes,order_product_id from juhaoyong_tb_order where id="&order_product_id&""
rs.open(sql),cn,1,3
if rs("view_yes")=0 then
	rs("view_yes")=1
else
	rs("view_yes")=0
end if
rs.update
rs.close
set rs=nothing
response.Write JuhaoyongResultPage("订单处理","处理成功","order_list.asp?page="&page&"&act="&act&"&keywords="&keywords)
response.end

%>

<%
Call DbconnEnd()
 %>