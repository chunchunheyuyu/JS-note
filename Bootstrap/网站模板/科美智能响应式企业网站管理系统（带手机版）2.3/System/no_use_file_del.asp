<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->

<%
if request("action")="AllDel" then
	dim delconfirm
	delconfirm=request.form("delconfirm")
	Num=request.form("Selectitem").count
	if Num=0 then
		response.Write JuhaoyongReturnHistoryPage("废弃图片和文件删除清理","请选择要删除的文件")
		response.end
	end if
	
	if delconfirm<>"1" then
		response.Write"<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
		response.Write"	<tr><th class='tableHeaderText'>废弃图片和文件删除清理</th></tr>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />删除后不可恢复，确定删除吗？</font><br /><br /></td></tr>"
		response.Write"<form name='form2' method='post' action='no_use_file_del.asp?action=AllDel'>"
		response.Write"<input name='Selectitem' type=hidden value='"&request.Form("Selectitem")&"'>"
		response.Write"<input name='delconfirm' type=hidden value='1'>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><input type='submit' name='Submit' value=' 确 定 ' style='height:25px;width:80px;'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=# onclick='history.go(-1)'><font size='+1'>返 回</font></a><br /><br /></td></tr>"
		response.Write"</table>"
		response.Write"</form>"
		response.end
	else
		dim fileNameArray,Selectitem
		dim file_i,file_count
		Selectitem=request.Form("Selectitem") 
		fileNameArray=split(Selectitem,",")
		file_count=ubound(fileNameArray)
		for file_i=0 to file_count
			'删除文件
			if trim(fileNameArray(file_i)&"")<>"" then JuhaoyongDeleteFile("../images/"&trim(fileNameArray(file_i)))
			'response.Write"<br>文件名："&trim(fileNameArray(file_i))
		next
	end if

else
	delconfirm=request.querystring("delconfirm")
	file_path_name=request.querystring("file_path_name")
	if delconfirm<>"1" then
		response.Write JuhaoyongConfirmPage("废弃图片和文件删除清理","删除后不可恢复，确定删除吗？","no_use_file_del.asp?delconfirm=1&file_path_name="&file_path_name)
		response.end
	else
		if trim(file_path_name&"")<>"" then JuhaoyongDeleteFile("../images/"&trim(file_path_name))
	end if
end if

response.Write JuhaoyongResultPage("废弃图片和文件删除清理","删除成功","no_use_file_list.asp")
response.end
%>

<%
Call DbconnEnd()
 %>