<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<% '������ݵ����ݱ�
act=Request("act")
If act="save" Then 
	l_name=trim(request.form("name"))
	l_url=trim(request.form("url"))
	l_order=trim(request.form("order"))
	l_time=now()
	
	'������Ʋ���Ϊ��
	if l_name&""="" then
		response.Write JuhaoyongReturnHistoryPage("����Top���ߵ������","���Ʋ���Ϊ��")
		response.end
	'����������������
	elseif isnumeric(l_order)=false then
		response.Write JuhaoyongReturnHistoryPage("����Top���ߵ������","����ֵֻ��Ϊ����")
		response.end
	else
		set rs=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_navfirst"
		rs.open(sql),cn,1,3
		rs.addnew
		rs("name")=l_name
		rs("url")=l_url
		if l_order<>"" then
		rs("order")=l_order
		end if
		rs("fd_navfirst_type")=3
		rs("time")=l_time
		
		rs.update
		rs.close
		set rs=nothing
		
		response.Write JuhaoyongResultPage("����Top���ߵ������","��ӳɹ�","front_nav_top_list.asp")
		response.end
	end if
else
%>
	<form id="form1" name="form1" method="post" action="?act=save">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">��Ӷ���Top���ߵ���</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">�������ƣ����</td>
	<td width="85%" class="jhyabTabletdBgcolor01"><input name='name' type='text' id='name' size='70' maxlength="30">
	  &nbsp;</td>
	</tr>

	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>�������ӵ�ַ�����</td>
	    <td class="jhyabTabletdBgcolor01"><input name='url' type='text' id='url' size='70'>
        <br />
        <font color="#FF0000">���Ӹ�ʽ��</font><br />
		<font color="#FF0000">1.��Ӧ����Ŀ��һ����Ŀ��ʽΪ��abc��������Ŀ��ʽΪ��abc/def����ҳ��ʽΪ��abc/def.html</font><br />
		<font color="#FF0000">2.����������������������ӵ�������վ������д��ʽ�磺http://www.baidu.com/</font>
		</td>
      </tr>
	  
	  <tr>
	  <td class="jhyabTabletdBgcolor01" height=11>����</td>
	  <td class="jhyabTabletdBgcolor01"><input name='order' type='text' value="10" size="3" maxlength="3">ֻ�������֣�����ԽС����Խ��ǰ</td>
	  </tr>

	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02">
	<div align="center">
	  <INPUT type=submit value='�ύ' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form>
<%end if%>
<%
Call DbconnEnd()
 %>