<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/md5.asp" -->
<!-- #include file="inc/head.asp" -->

<% '������ݵ����ݱ�
act=Request("act")
If act="save" Then 
	l_username=trim(request.form("username"))
	l_password=trim(request.form("password"))
	l_repassword=trim(request.form("repassword"))
	l_class=request.form("class")
	l_time=now()
	
	if l_username="" or l_password="" or l_repassword="" then
		response.Write JuhaoyongReturnHistoryPage("�޸Ĺ���Ա����","�û��������벻��Ϊ��")
		response.end
	elseif  l_password<>l_repassword then
		response.Write JuhaoyongReturnHistoryPage("�޸Ĺ���Ա����","������������벻һ��")
		response.end
	else
		set rs1=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_user where username='"&l_username&"'"
		rs1.open(sql),cn,1,1
		if not rs1.eof and not rs1.bof then
			response.Write JuhaoyongReturnHistoryPage("�޸Ĺ���Ա����","���û����Ѿ����ڣ�����������")
			response.end
		else
			'�������Ա��
			set rs=server.createobject("adodb.recordset")
			sql="select * from juhaoyong_tb_user"
			rs.open(sql),cn,1,3
			rs.addnew
			rs("username")=l_username
			rs("password")=md5(l_password,16)
			if l_class<>"" then
			rs("class")=cint(l_class)
			end if
			rs("time")=l_time
			rs.update
			rs.close
			set rs=nothing
			response.Write JuhaoyongResultPage("��Ӻ�̨����Ա","��ӳɹ�","admin_list.asp")
			response.end
		end if
		rs1.close
		set rs1=nothing
	end if
else
 %>
	<form id="form1" name="form1" method="post" action="?act=save">
	<script language='javascript'>
	function checksignup1() {
	if ( document.form1.username.value == '' ) {
	window.alert('�������û���^_^');
	document.form1.username.focus();
	return false;}
	
	if ( document.form1.password.value == '' ) {
	window.alert('����������^_^');
	document.form1.password.focus();
	return false;}
	
	if ( document.form1.repassword.value == '' ) {
	window.alert('���ظ���������^_^');
	document.form1.repassword.focus();
	return false;}
	return true;}
	</script>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">��Ӻ�̨����Ա</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td class="jhyabTabletdBgcolor01" width="15%" height=23>����Ա�û��� (����) </td>
	<td class="jhyabTabletdBgcolor01" width="85%"><input name='username' type='text' id='username' size='30' maxlength="20">��Ӣ�Ļ����֣��<font color="#FF0000" size="+1">&nbsp;20&nbsp;</font>λ��
	  &nbsp;</td>
	</tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>���� (����) </td>
	    <td class="jhyabTabletdBgcolor01"><input name='password' type='password' id='password' size='30' maxlength="20">��Ӣ�Ļ����֣��<font color="#FF0000" size="+1">&nbsp;20&nbsp;</font>λ��</td>
      </tr>
	  
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>�ظ����� <span class="jhyabTabletdBgcolor01">(����) </span></td>
	    <td class="jhyabTabletdBgcolor01"><input name='repassword' type='password' id='repassword' size='30' maxlength="20"></td>
      </tr>
	  <% if logr() then%>
	    <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>�û�Ȩ��<span class="jhyabTabletdBgcolor01"> </span></td>
	    <td class="jhyabTabletdBgcolor01">
	      <input type="radio" name="class" value="1">
	      ��������Ա&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	      <input name="class" type="radio" value="2" checked>
	      ��ͨ����Ա</td>
	    </tr>
		<%end if%>
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='�ύ' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form>
<%end if%>
<%
Call DbconnEnd()
%>