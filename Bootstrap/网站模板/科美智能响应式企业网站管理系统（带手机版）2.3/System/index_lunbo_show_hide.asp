<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->

<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="../inc/rebuild_modify_template.asp" -->

<!-- #include file="inc/head.asp" -->

<%
lunbo_id=request.querystring("id")
set rs=server.createobject("adodb.recordset")
sql="select id,view_yes from juhaoyong_tb_picture where id="&lunbo_id&""
rs.open(sql),cn,1,3
if rs("view_yes")=0 then
rs("view_yes")=1
else
rs("view_yes")=0
end if
rs.update
rs.close
set rs=nothing

'����������ҳģ��
call RewriteTemplateFile(0,0)
'������ҳ
call Run_createhtml_index()
response.Write JuhaoyongResultPage("�ֲ�ͼƬ��ʾ/����","�޸ĳɹ�","index_lunbo_list.asp")
response.end
%>

<%
Call DbconnEnd()
 %>