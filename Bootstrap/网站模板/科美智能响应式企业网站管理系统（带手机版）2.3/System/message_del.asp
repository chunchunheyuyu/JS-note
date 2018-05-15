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

dim delconfirm		
if request("action")="AllDel" then
	delconfirm=request.form("delconfirm")
	Num=request.form("Selectitem").count
	if Num=0 then 
		response.Write JuhaoyongResultPage("ÁôÑÔÉ¾³ý","ÇëÑ¡ÔñÒªÉ¾³ýµÄÊý¾Ý","message_list.asp?page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	end if
	
	if delconfirm<>"1" then
		response.Write"<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
		response.Write"	<tr><th class='tableHeaderText'>ÁôÑÔÉ¾³ý</th></tr>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />É¾³ýºó²»¿É»Ö¸´£¬È·¶¨É¾³ýÂð£¿</font><br /><br /></td></tr>"
		response.Write"<form name='form2' method='post' action='message_del.asp?action=AllDel&page="&page&"&act="&act&"&keywords="&keywords&"'>"
		response.Write"<input name='Selectitem' type=hidden value='"&request.Form("Selectitem")&"'>"
		response.Write"<input name='delconfirm' type=hidden value='1'>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><input type='submit' name='Submit' value=' È· ¶¨ ' style='height:25px;width:80px;'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=# onclick='history.go(-1)'><font size='+1'>·µ »Ø</font></a><br /><br /></td></tr>"
		response.Write"</table>"
		response.Write"</form>"
		response.end
	else
		Selectitem=request.Form("Selectitem") 
		messageId=split(Selectitem,",")
		c=ubound(messageId)
		for i=0 to c		
			cn.Execute "delete from juhaoyong_tb_guestbook where id="&cint(messageId(i))
		next
	end if
else
	delconfirm=request.querystring("delconfirm")
	messageId=cint(request.querystring("id"))
	if delconfirm<>"1" then
		response.Write JuhaoyongConfirmPage("ÁôÑÔÉ¾³ý","É¾³ýºó²»¿É»Ö¸´£¬È·¶¨É¾³ýÂð£¿","message_del.asp?delconfirm=1&id="&messageId&"&page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	else
		cn.Execute "delete from juhaoyong_tb_guestbook where id="&messageId
	end if
end if

call Run_createhtml_other("guestmessage","ÁôÑÔ·´À¡")'Éú³ÉÁôÑÔÒ³

response.Write JuhaoyongResultPage("ÁôÑÔÉ¾³ý","É¾³ý³É¹¦","message_list.asp?page="&page&"&act="&act&"&keywords="&keywords)
response.end
%>

<%
Call DbconnEnd()
 %>