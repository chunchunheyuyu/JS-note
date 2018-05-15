<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/mp_functions.asp" -->

<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../inc/mp_rebuild_modify_template.asp" -->

<!-- #include file="../inc/function_common_html_create.asp" -->
<!-- #include file="../mp_generate_html/mp_createhtml_index.asp" -->
<!-- #include file="../mp_generate_html/mp_createhtml_article_product_list.asp" -->
<!-- #include file="../mp_generate_html/mp_createhtml_article_content.asp" -->
<!-- #include file="../mp_generate_html/mp_createhtml_product_content.asp" -->
<!-- #include file="../mp_generate_html/mp_createhtml_singlepage_content.asp" -->
<!-- #include file="../mp_generate_html/mp_createhtml_other.asp" -->

<!-- #include file="inc/head.asp" -->
<%
dim mp_site_foldername
mp_site_foldername=MP_Get_mp_site_foldername()'获取手机网站目录名称
'检测文件夹是否存在，如果不存在则重新创建。
call JuhaoyongFolderCreate("../"&mp_site_foldername)
%>

<%
dim htmltype,type_name
htmltype=request.querystring("htmltype")

select case htmltype
	case "mp"
		type_name="手机网站所有页面"
end select
%>
<%
select case htmltype
	case "mp"
		'生成模版开始
		call MP_RewriteTemplateFile(0,0)'生成首页模板
		call MP_OneLevelClassList(0)'生成内页模板--所有一级栏目（文章、产品、单页）模版
		call MP_RewriteTemplateFile(4,0)'生成内页模板--other
		'生成模版结束
		
		'生成页面开始
		call MP_Run_createhtml_index(mp_site_foldername)'生成首页
		
		call MP_Run_createhtml_article_product_list(1,0,mp_site_foldername)'生成所有文章列表页
		call MP_Run_createhtml_article_product_list(2,0,mp_site_foldername)'生成所有产品列表页
		
		call MP_Run_createhtml_article_content(0,mp_site_foldername)'生成所有文章内容页
		call MP_Run_createhtml_product_content(0,mp_site_foldername)'生成所有产品内容页
		call MP_Run_createhtml_singlepage_content(0,mp_site_foldername)'生成所有单页
		
		call MP_Run_createhtml_other("search","搜索",mp_site_foldername)'生成搜索页
		call MP_Run_createhtml_other("order","提交订单",mp_site_foldername)'生成搜索页
		call MP_Run_createhtml_other("guestmessage","留言反馈",mp_site_foldername)'生成留言页
		call MP_Run_createhtml_other("sitemap","网站地图",mp_site_foldername)'生成网站地图页
		'生成页面结束
end select

response.Write "<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
response.Write "<tr><th class='tableHeaderText'>生成"&type_name&"（生成后，请到前台&nbsp;刷新&nbsp;查看效果）</th></tr>"
response.Write "<tr><td height=90 valign=top  class='jhyabTabletdBgcolor02'><br>"
response.Write "	<table width=90% border=0 align=center cellpadding=0 cellspacing=0>"
response.Write "		<tr><td height=100><div align=center><font color=red><b>"&type_name&"生成成功！&nbsp;请先清空手机浏览器缓存，然后刷新查看。</b></font></div></td></tr>"
response.Write "	</table>"
response.Write "</td></tr>"
response.Write "</table>"

%>

<%
'=================================================
'函数：生成一级栏目模版
'=================================================
Function MP_OneLevelClassList(classTypeNumber)
dim rs,sql

select case classTypeNumber
	case 0 '所有类别的一级栏目
	sql="select [id],[name],[folder],ClassType from [juhaoyong_tb_directory] where jhy_fd_dir_parentid=0 order by [id]"
	case 1 'article
	sql="select [id],[name],[folder],ClassType from [juhaoyong_tb_directory] where ClassType=1 and jhy_fd_dir_parentid=0 order by [id]"
	case 2 'product
	sql="select [id],[name],[folder],ClassType from [juhaoyong_tb_directory] where ClassType=2 and jhy_fd_dir_parentid=0 order by [id]"
	case 3 'singlepage
	sql="select [id],[name],[folder],ClassType from [juhaoyong_tb_directory] where ClassType=3 and jhy_fd_dir_parentid=0 order by [id]"
end select

set rs=server.createobject("adodb.recordset")
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
	do while not rs.eof
		call MP_RewriteTemplateFile(rs("ClassType"),rs("id"))'生成内页模板--ClassType：1文章、2产品、3单页
	rs.movenext
	loop
end if
rs.close
set rs=nothing
End Function
%>

<%
Call DbconnEnd()
 %>