<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->

<!-- #include file="../inc/function_common_html_create.asp" -->
<!-- #include file="../generate_html/createhtml_other.asp" -->
<!-- #include file="inc/head.asp" -->

<% '�������ݵ����ݱ�
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")
messageId=cint(request.querystring("id"))

act1=Request("act1")
If act1="save" Then 
a_id=cint(request.form("a_id"))
a_recontent=trim(request.form("a_recontent"))
a_view_yes=trim(request.form("a_view_yes"))


set rs=server.createobject("adodb.recordset")
sql="select id,view_yes,recontent,retime from juhaoyong_tb_guestbook where id="&a_id&""
rs.open(sql),cn,1,3
rs("view_yes")=a_view_yes
rs("recontent")=a_recontent
rs("retime")=now()
rs.update
rs.close
set rs=nothing
call Run_createhtml_other("guestmessage","���Է���")'��������ҳ
response.Write JuhaoyongResultPage("���Իظ�","�ظ��ɹ�","message_list.asp?page="&page&"&act="&act&"&keywords="&keywords)
response.end
end if 
 %>

<%
set rs=server.createobject("adodb.recordset")
sql="select id,name,content,recontent,view_yes from [juhaoyong_tb_guestbook] where id="&messageId&""
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
%> <form id="form1" name="form1" method="post" action="?act1=save&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">�ظ�����</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">������ </td>
	<td width="85%" class="jhyabTabletdBgcolor01"><input name='a_id' type='hidden' id='a_id' value="<%=rs("id")%>" size='70'>&nbsp;<%=rs("name")%></td>
	</tr>
	
	<tr>
	    <td height=23 valign="top" class="jhyabTabletdBgcolor01">�������� </td>
	    <td valign="top" class="jhyabTabletdBgcolor01">&nbsp;<%=rs("content")%></td>
    </tr>
	
	<tr>
	  <td  class="jhyabTabletdBgcolor01" height=11>�ظ�����</td>
	  <td  class="jhyabTabletdBgcolor01"><textarea name='a_recontent'  cols="100" rows="6" id="a_recontent" ><%=rs("recontent")%></textarea></td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>�Ƿ���ʾ</td>
	  <td class="jhyabTabletdBgcolor01">
	  <input type="radio" name="a_view_yes" value="1" <%if rs("view_yes")=1 then response.write "checked"%>>��&nbsp;
      <input type="radio" name="a_view_yes" value="0" <%if rs("view_yes")=0 then response.write "checked"%>>��
	  </td>
	</tr>
	
	<tr>
		<td height="50" colspan=2  class="jhyabTabletdBgcolor02">
			<div align="center">
			<INPUT type=submit value='�ύ'  name=Submit>
			</div>
		</td>
	</tr>
	</table></td></tr></table>
</form>
<%end if%>
<%
Call DbconnEnd()
 %>