<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../inc/rebuild_modify_template.asp" -->

<!-- #include file="../inc/function_common_html_create.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="../generate_html/createhtml_article_product_list.asp" -->
<!-- #include file="../generate_html/createhtml_article_content.asp" -->
<!-- #include file="../generate_html/createhtml_product_content.asp" -->
<!-- #include file="../generate_html/createhtml_singlepage_content.asp" -->
<!-- #include file="../generate_html/createhtml_other.asp" -->

<!-- #include file="inc/head.asp" -->
<%
dim htmltype,type_name
htmltype=request.querystring("htmltype")

select case htmltype
	case "all"
		type_name="����ҳ��"
	case "index"
		type_name="��ҳ"
	case "list"
		type_name="������Ŀ�б�ҳ"
	case "article"
		type_name="������������ҳ"
	case "product"
		type_name="���в�Ʒ����ҳ"
	case "singlepage"
		type_name="���е�ҳ"
	case "search"
		type_name="����ҳ"
	case "guestmessage"
		type_name="����ҳ"
	case "sitemap"
		type_name="��վ��ͼҳ"
end select
%>
<%
select case htmltype
	case "all"
		'����ģ�濪ʼ
		call RewriteTemplateFile(0,0)'������ҳģ��
		call OneLevelClassList(0)'������ҳģ��--����һ����Ŀ�����¡���Ʒ����ҳ��ģ��
		call RewriteTemplateFile(4,0)'������ҳģ��--other
		'����ģ�����
		
		'����ҳ�濪ʼ
		call Run_createhtml_index()'������ҳ
		
		call Run_createhtml_article_product_list(1,0)'�������������б�ҳ
		call Run_createhtml_article_product_list(2,0)'�������в�Ʒ�б�ҳ
		
		call Run_createhtml_article_content(0)'����������������ҳ
		call Run_createhtml_product_content(0)'�������в�Ʒ����ҳ
		call Run_createhtml_singlepage_content(0)'�������е�ҳ
		
		call Run_createhtml_other("search","����")'��������ҳ
		call Run_createhtml_other("guestmessage","���Է���")'��������ҳ
		call Run_createhtml_other("sitemap","��վ��ͼ")'������վ��ͼҳ
		'����ҳ�����
		
	case "index"
		call RewriteTemplateFile(0,0)'������ҳģ��
		call Run_createhtml_index()'������ҳ
		
	case "list"
		call OneLevelClassList(1)'������ҳģ��--����ģ��
		call OneLevelClassList(2)'������ҳģ��--��Ʒģ��
		call Run_createhtml_article_product_list(1,0)'�������������б�
		call Run_createhtml_article_product_list(2,0)'�������в�Ʒ�б�
		
	case "article"
		call OneLevelClassList(1)'������ҳģ��--����ģ��
		call Run_createhtml_article_content(0)'����������������
		
	case "product"
		call OneLevelClassList(2)'������ҳģ��--��Ʒģ��
		call Run_createhtml_product_content(0)'�������в�Ʒ����
		
	case "singlepage"
		call OneLevelClassList(3)'������ҳģ��--��ҳģ��
		call Run_createhtml_singlepage_content(0)'�������е�ҳ
		
	case "search"
		call RewriteTemplateFile(4,0)'������ҳģ��--other
		call Run_createhtml_other("search","����")'��������ҳ
		
	case "guestmessage"
		call RewriteTemplateFile(4,0)'������ҳģ��--other
		call Run_createhtml_other("guestmessage","���Է���")'��������ҳ
		
	case "sitemap"
		call RewriteTemplateFile(4,0)'������ҳģ��--other
		call Run_createhtml_other("sitemap","��վ��ͼ")'������վ��ͼҳ
end select

response.Write "<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
response.Write "<tr><th class='tableHeaderText'>����"&type_name&"�����ɺ��뵽ǰ̨&nbsp;��F5ˢ��&nbsp;�鿴Ч����</th></tr>"
response.Write "<tr><td height=90 valign=top  class='jhyabTabletdBgcolor02'><br>"
response.Write "	<table width=90% border=0 align=center cellpadding=0 cellspacing=0>"
response.Write "		<tr><td height=100><div align=center><font color=red><b>"&type_name&"���ɳɹ���&nbsp;�뵽ǰ̨&nbsp;��F5&nbsp;ˢ�²鿴��</b></font></div></td></tr>"
response.Write "	</table>"
response.Write "</td></tr>"
response.Write "</table>"

%>

<%
'=================================================
'����������һ����Ŀģ��
'=================================================
Function OneLevelClassList(classTypeNumber)
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
		call RewriteTemplateFile(rs("ClassType"),rs("id"))'������ҳģ��--ClassType��1���¡�2��Ʒ��3��ҳ
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