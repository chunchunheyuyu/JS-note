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
dim delconfirm
if request("action")="AllDel" then
	delconfirm=request.form("delconfirm")
	Num=request.form("Selectitem").count 
	if Num=0 then 
		response.Write JuhaoyongResultPage("订单删除","请选择要删除的数据","order_list.asp?page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	end if
	
	if delconfirm<>"1" then
		response.Write"<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
		response.Write"	<tr><th class='tableHeaderText'>订单删除</th></tr>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />删除后不可恢复，确定删除吗？</font><br /><br /></td></tr>"
		response.Write"<form name='form2' method='post' action='order_del.asp?action=AllDel&page="&page&"&act="&act&"&keywords="&keywords&"'>"
		response.Write"<input name='Selectitem' type=hidden value='"&request.Form("Selectitem")&"'>"
		response.Write"<input name='delconfirm' type=hidden value='1'>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><input type='submit' name='Submit' value=' 确 定 ' style='height:25px;width:80px;'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=# onclick='history.go(-1)'><font size='+1'>返 回</font></a><br /><br /></td></tr>"
		response.Write"</table>"
		response.Write"</form>"
		response.end
	else
		Selectitem=request.Form("Selectitem") 
		order_product_id=split(Selectitem,",")
		c=ubound(order_product_id)
		for i=0 to c		
			cn.Execute "delete from juhaoyong_tb_order where id="&cint(order_product_id(i))
		next
	end if
else
	order_product_id=cint(request.querystring("id"))
	delconfirm=request.querystring("delconfirm")
	if delconfirm<>"1" then
		response.Write JuhaoyongConfirmPage("订单删除","删除后不可恢复，确定删除吗？","order_del.asp?delconfirm=1&id="&order_product_id&"&page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	else
		cn.Execute "delete from juhaoyong_tb_order where id="&order_product_id
	end if
end if

response.Write JuhaoyongResultPage("订单删除","删除成功","order_list.asp?page="&page&"&act="&act&"&keywords="&keywords)
response.end

%>

<%
Call DbconnEnd()
 %>