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
<!-- #include file="../generate_html/createhtml_article_content.asp" -->
<!-- #include file="inc/head.asp" -->

<%
dim mp_site_foldername
mp_site_foldername=MP_Get_mp_site_foldername()'��ȡ�ֻ���վĿ¼����
%>

<%
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")

'��ȡ��Ŀid
oneid=request.QueryString("oneid")
twoid=request.QueryString("twoid")

dim idArray,delArticleId,firstArticleId,lastArticleId
dim currentEditTime,currentEditTime1,currentEditTime2
dim preArticleEditTime,nextArticleEditTime
dim intNum
dim delconfirm
Set rs=server.createobject("adodb.recordset")

if request("action")="AllDel" then
	delconfirm=request.form("delconfirm")
	intNum=request.form("Selectitem").count
	if intNum=0 then
		response.Write JuhaoyongResultPage("������������ɾ��","��ѡ��Ҫɾ��������","abjhy_article_list.asp?oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	end if
	
	if delconfirm<>"1" then
		response.Write"<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
		response.Write"	<tr><th class='tableHeaderText'>������������ɾ��</th></tr>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />ɾ���󲻿ɻָ���ȷ��ɾ����</font><br /><br /></td></tr>"
		response.Write"<form name='form2' method='post' action='abjhy_article_del.asp?action=AllDel&oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords&"'>"
		response.Write"<input name='Selectitem' type=hidden value='"&request.Form("Selectitem")&"'>"
		response.Write"<input name='delconfirm' type=hidden value='1'>"
		response.Write"	<tr><td class='jhyabTabletdBgcolor02' align=center><input type='submit' name='Submit' value=' ȷ �� ' style='height:25px;width:80px;'> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=# onclick='history.go(-1)'><font size='+1'>�� ��</font></a><br /><br /></td></tr>"
		response.Write"</table>"
		response.Write"</form>"
		response.end
	else
		idArray=split(request.Form("Selectitem"),",")
		c=ubound(idArray)
		for i=0 to c
			if i=0 then
				firstArticleId=idArray(i)
				currentEditTime1=JuhaoyongGetArticleEditTime(firstArticleId)
			end if
			if i=c then
				lastArticleId=idArray(i)
				currentEditTime2=JuhaoyongGetArticleEditTime(lastArticleId)
			end if
			call DeleteArticleByID(idArray(i),mp_site_foldername)
		next
	end if
else
	delArticleId=request.querystring("id")
	delconfirm=request.querystring("delconfirm")
	if delconfirm<>"1" then
		response.Write JuhaoyongConfirmPage("������������ɾ��","ɾ���󲻿ɻָ���ȷ��ɾ����","abjhy_article_del.asp?delconfirm=1&id="&delArticleId&"&oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	else
		currentEditTime=JuhaoyongGetArticleEditTime(delArticleId)
		call DeleteArticleByID(delArticleId,mp_site_foldername)
	end if
end if

set rs=nothing

'����������ҳ
call Run_createhtml_index()
'����������Ŀ�б�ҳ
call Run_createhtml_article_product_list(1,oneid)'��������һ�������б�
call Run_createhtml_article_product_list(1,twoid)'�������ɶ��������б�

'��ȡǰһƪ�ͺ�һƪ���µı༭ʱ��
if request("action")="AllDel" then
	preArticleEditTime=GetNextOrPreEditTime(currentEditTime1,"pre")
	nextArticleEditTime=GetNextOrPreEditTime(currentEditTime2,"next")
else
	preArticleEditTime=GetNextOrPreEditTime(currentEditTime,"pre")
	nextArticleEditTime=GetNextOrPreEditTime(currentEditTime,"next")
end if
'��������ǰһƪ����һƪ���Լ��ڶ�ѡɾ��������м�û��ѡ��ɾ��������
call CreatehtmlBetweenArticleEditTime(preArticleEditTime,nextArticleEditTime)

response.Write JuhaoyongResultPage("������������ɾ��","ɾ���ɹ�","abjhy_article_list.asp?oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
response.end
%>

<%
Call DbconnEnd()
%>

<%
'=================================================
'���ã�����id��ȡ���±༭ʱ��
'������id
'=================================================
function JuhaoyongGetArticleEditTime(id)
if trim(id&"")="" then
	JuhaoyongGetArticleEditTime=""
	Exit Function
end if
dim rs,sql
set rs=server.createobject("adodb.recordset")
sql="select edit_time from juhaoyong_tb_content where id="&id
rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
	JuhaoyongGetArticleEditTime=rs("edit_time")
	end if
rs.close
set rs=nothing
end function
%>

<%
'=================================================
'���ã�ɾ������
'������id��Ҫɾ���ļ�¼id��
'������mp_foldername���ֻ���վĿ¼���ƣ�
'=================================================
Function DeleteArticleByID(id,mp_foldername)
	dim rs,sql
	dim filePath,fileName,imageName
	set rs=server.createobject("adodb.recordset")
	'��ѯ��ȡ��Ӧ���ļ���
	sql="select a.id, a.jhy_fd_leveltwo_id, a.html_file_name, a.jhy_fd_fujian ,b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id where a.id="&id
	rs.open(sql),cn,1,1
	fileName=rs("html_file_name")
	fujianName=rs("jhy_fd_fujian")
	if rs("jhy_fd_leveltwo_id")&""="" then
		strFolder="../"&rs("b.folder")
		mp_strFolder="../"&mp_foldername&"/"&rs("b.folder")
	else
		strFolder="../"&rs("b.folder")&"/"&rs("c.folder")
		mp_strFolder="../"&mp_foldername&"/"&rs("b.folder")&"/"&rs("c.folder")
	end if
	rs.close
	set rs=nothing
	
	'ɾ����¼
	cn.Execute "delete from juhaoyong_tb_content where id="&id
	
	'ɾ����Ʒhtml��̬ҳ���ļ�
	filePath=strFolder&"/"&fileName
	mp_filePath=mp_strFolder&"/"&fileName '�ֻ����ļ�·��
	
	JuhaoyongDeleteFile(filePath)
	JuhaoyongDeleteFile(mp_filePath) 'ɾ���ֻ����ļ�
	
	'ɾ�����¸���
	filePath="../upAttachFile/"&fujianName
	JuhaoyongDeleteFile(filePath)
End Function
%>