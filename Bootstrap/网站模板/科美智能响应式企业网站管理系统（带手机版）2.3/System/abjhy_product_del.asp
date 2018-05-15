<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/mp_functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../inc/function_common_html_create.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="../generate_html/createhtml_article_product_list.asp" -->
<!-- #include file="inc/head.asp" -->

<%
dim mp_site_foldername
mp_site_foldername=MP_Get_mp_site_foldername()'获取手机网站目录名称
%>

<%
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")

'获取栏目id
oneid=request.QueryString("oneid")
twoid=request.QueryString("twoid")

dim id,intNum,strFolder
dim delconfirm
if request("action")="AllDel" then
	delconfirm=request.form("delconfirm")
	intNum=request.form("Selectitem").count
	if intNum=0 then
		response.Write JuhaoyongResultPage("产品类型内容删除","请选择要删除的数据","abjhy_product_list.asp?oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	end if
	
	if delconfirm<>"1" then
		response.Write"<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
		response.Write"	<tr><th class='tableHeaderText'>产品类型内容删除</th></tr>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />删除后不可恢复，确定删除吗？</font><br /><br /></td></tr>"
		response.Write"<form name='form2' method='post' action='abjhy_product_del.asp?action=AllDel&oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords&"'>"
		response.Write"<input name='Selectitem' type=hidden value='"&request.Form("Selectitem")&"'>"
		response.Write"<input name='delconfirm' type=hidden value='1'>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><input type='submit' name='Submit' value=' 确 定 ' style='height:25px;width:80px;'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=# onclick='history.go(-1)'><font size='+1'>返 回</font></a><br /><br /></td></tr>"
		response.Write"</table>"
		response.Write"</form>"
		response.end
	else
		id=split(request.Form("Selectitem"),",")
		c=ubound(id)
		for i=0 to c
			call DeleteProductByID(id(i),mp_site_foldername)
		next
	end if
else
	id=request.querystring("id")
	delconfirm=request.querystring("delconfirm")
	if delconfirm<>"1" then
		response.Write JuhaoyongConfirmPage("产品类型内容删除","删除后不可恢复，确定删除吗？","abjhy_product_del.asp?delconfirm=1&id="&id&"&oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	else
		call DeleteProductByID(id,mp_site_foldername)
	end if
end if

'重新生成首页
call Run_createhtml_index()
'重新生成栏目列表页
call Run_createhtml_article_product_list(2,oneid)'重新生成一级产品列表
call Run_createhtml_article_product_list(2,twoid)'重新生成二级产品列表

response.Write JuhaoyongResultPage("产品类型内容删除","删除成功","abjhy_product_list.asp?oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
response.end
%>

<%
Call DbconnEnd()
%>
 
<%
'=================================================
'作用：删除产品
'参数：id（要删除的记录id）
'参数：mp_foldername（手机网站目录名称）
'=================================================
Function DeleteProductByID(id,mp_foldername)
	dim rs,sql
	dim filePath,fileName,imageName
	set rs=server.createobject("adodb.recordset")
	'查询获取对应的文件夹
	sql="select a.id, a.jhy_fd_leveltwo_id, a.html_file_name, a.image ,b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id where a.id="&id
	rs.open(sql),cn,1,1
	fileName=rs("html_file_name")
	imageName=rs("image")
	if rs("jhy_fd_leveltwo_id")&""="" then
		strFolder="../"&rs("b.folder")
		mp_strFolder="../"&mp_foldername&"/"&rs("b.folder")
	else
		strFolder="../"&rs("b.folder")&"/"&rs("c.folder")
		mp_strFolder="../"&mp_foldername&"/"&rs("b.folder")&"/"&rs("c.folder")
	end if
	rs.close
	set rs=nothing
	
	'删除记录
	cn.Execute "delete from juhaoyong_tb_content where id="&id
	
	'删除产品html静态页面文件
	filePath=strFolder&"/"&fileName
	mp_filePath=mp_strFolder&"/"&fileName '手机版文件路径
	
	JuhaoyongDeleteFile(filePath)
	JuhaoyongDeleteFile(mp_filePath) '删除手机版文件
	
	'删除产品图片
	filePath="../images/up_images/"&imageName
	JuhaoyongDeleteFile(filePath)
End Function
%>