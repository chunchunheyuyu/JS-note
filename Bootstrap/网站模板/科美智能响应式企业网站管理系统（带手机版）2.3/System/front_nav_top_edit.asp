<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<% '������ݵ����ݱ�
nav_id=cint(request.querystring("id"))
act1=Request("act1")
If act1="save" Then 
	l_id=trim(request.form("l_id"))
	l_name=trim(request.form("name"))
	l_url=trim(request.form("url"))
	l_order=trim(request.form("order"))
	
	'������Ʋ���Ϊ��
	if l_name&""="" then
		response.Write JuhaoyongReturnHistoryPage("����Top���ߵ����޸�","���Ʋ���Ϊ��")
		response.end
	'����������������
	elseif isnumeric(l_order)=false then
		response.Write JuhaoyongReturnHistoryPage("����Top���ߵ����޸�","����ֵֻ��Ϊ����")
		response.end
	else
		set rs=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_navfirst where id="&l_id&""
		rs.open(sql),cn,1,3
		rs("name")=l_name
		rs("url")=l_url
		if l_order<>"" then
		rs("order")=l_order
		end if
		rs.update
		rs.close
		set rs=nothing
		
		response.Write JuhaoyongResultPage("����Top���ߵ����޸�","�޸ĳɹ�","front_nav_top_list.asp")
		response.end
	end if
else
%>
 
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_navfirst where id="&nav_id&""
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then%>
	<form id="form1" name="form1" method="post" action="?act1=save&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">�޸Ķ���Top���ߵ���</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">�������ƣ����</td>
	<td width="85%" class="jhyabTabletdBgcolor01"><input name='name' type='text' id='name'  value="<%=rs("name")%>" size='70'>
	 <input name='l_id' type='hidden' id='l_id' value="<%=rs("id")%>" size='70'>
	  &nbsp;</td>
	</tr>

	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>�������ӵ�ַ�����</td>
	    <td class="jhyabTabletdBgcolor01"><input name='url' type='text' id='url' value="<%=rs("url")%>" size='70'>
		<br />
        <font color="#FF0000">���Ӹ�ʽ��</font><br />
		<font color="#FF0000">1.��Ӧ����Ŀ��һ����Ŀ��ʽΪ��abc��������Ŀ��ʽΪ��abc/def����ҳ��ʽΪ��abc/def.html</font><br />
		<font color="#FF0000">2.����������������������ӵ�������վ������д��ʽ�磺http://www.baidu.com/</font>
		</td>
      </tr>

	<tr>
	  <td class="jhyabTabletdBgcolor01" height=11>����</td>
	  <td class="jhyabTabletdBgcolor01"><input name='order' type='text' size="3" maxlength="3" value="<%=rs("order")%>">ֻ�������֣�����ԽС����Խ��ǰ</td>
	</tr>

	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='�ύ' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form>
<%
	end if
	rs.close
	set rs=nothing
end if
%>
<%
Call DbconnEnd()
 %>