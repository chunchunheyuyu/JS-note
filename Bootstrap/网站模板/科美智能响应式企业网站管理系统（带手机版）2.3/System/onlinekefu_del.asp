<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="inc/head.asp" -->

<%
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")
kefu_id=cint(request.querystring("id"))
delconfirm=request.querystring("delconfirm")
if delconfirm<>"1" then
	response.Write JuhaoyongConfirmPage("在线客服删除","删除后不可恢复，确定删除吗？","onlinekefu_del.asp?delconfirm=1&id="&kefu_id)
	response.end
else
	set rs=server.createobject("adodb.recordset")
	sql="select image from juhaoyong_tb_kefu where id="&kefu_id
	rs.open(sql),cn,1,3
	imageName=rs("image")
	rs.delete
	rs.close
	set rs=nothing
	
	'先判断图片是否存在，否则删除
	FilePath=Server.MapPath("../css/"&SITE_STYLE_CSS_FOLDER&"/"&imageName)
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	If fso.FileExists(FilePath) then fso.DeleteFile(FilePath)
	set fso=nothing
	
	response.Write JuhaoyongResultPage("在线客服删除","删除成功","onlinekefu_list.asp")
	response.end
end if
%>

<%
Call DbconnEnd()
 %>