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
mp_site_foldername=MP_Get_mp_site_foldername()'��ȡ�ֻ���վĿ¼����
'����ļ����Ƿ���ڣ���������������´�����
call JuhaoyongFolderCreate("../"&mp_site_foldername)
%>

<%
dim htmltype,type_name
htmltype=request.querystring("htmltype")

select case htmltype
	case "mp"
		type_name="�ֻ���վ����ҳ��"
end select
%>
<%
select case htmltype
	case "mp"
		'����ģ�濪ʼ
		call MP_RewriteTemplateFile(0,0)'������ҳģ��
		call MP_OneLevelClassList(0)'������ҳģ��--����һ����Ŀ�����¡���Ʒ����ҳ��ģ��
		call MP_RewriteTemplateFile(4,0)'������ҳģ��--other
		'����ģ�����
		
		'����ҳ�濪ʼ
		call MP_Run_createhtml_index(mp_site_foldername)'������ҳ
		
		call MP_Run_createhtml_article_product_list(1,0,mp_site_foldername)'�������������б�ҳ
		call MP_Run_createhtml_article_product_list(2,0,mp_site_foldername)'�������в�Ʒ�б�ҳ
		
		call MP_Run_createhtml_article_content(0,mp_site_foldername)'����������������ҳ
		call MP_Run_createhtml_product_content(0,mp_site_foldername)'�������в�Ʒ����ҳ
		call MP_Run_createhtml_singlepage_content(0,mp_site_foldername)'�������е�ҳ
		
		call MP_Run_createhtml_other("search","����",mp_site_foldername)'��������ҳ
		call MP_Run_createhtml_other("order","�ύ����",mp_site_foldername)'��������ҳ
		call MP_Run_createhtml_other("guestmessage","���Է���",mp_site_foldername)'��������ҳ
		call MP_Run_createhtml_other("sitemap","��վ��ͼ",mp_site_foldername)'������վ��ͼҳ
		'����ҳ�����
end select

response.Write "<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
response.Write "<tr><th class='tableHeaderText'>����"&type_name&"�����ɺ��뵽ǰ̨&nbsp;ˢ��&nbsp;�鿴Ч����</th></tr>"
response.Write "<tr><td height=90 valign=top  class='jhyabTabletdBgcolor02'><br>"
response.Write "	<table width=90% border=0 align=center cellpadding=0 cellspacing=0>"
response.Write "		<tr><td height=100><div align=center><font color=red><b>"&type_name&"���ɳɹ���&nbsp;��������ֻ���������棬Ȼ��ˢ�²鿴��</b></font></div></td></tr>"
response.Write "	</table>"
response.Write "</td></tr>"
response.Write "</table>"

%>

<%
'=================================================
'����������һ����Ŀģ��
'=================================================
Function MP_OneLevelClassList(classTypeNumber)
dim rs,sql

select case classTypeNumber
	case 0 '��������һ����Ŀ
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
		call MP_RewriteTemplateFile(rs("ClassType"),rs("id"))'������ҳģ��--ClassType��1���¡�2��Ʒ��3��ҳ
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