<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="inc/md5.asp" -->
<!-- #include file="inc/head.asp" -->
<% 
article_id=cint(request.querystring("id"))

act=Request("act")
If act="save" Then 
	l_username=trim(request.form("username"))
	l_password=trim(request.form("password"))
	l_new_password=trim(request.form("new_password"))
	l_renew_password=trim(request.form("renew_password"))
	l_time=now()
	l_password_md5=md5(l_password,16)
	if l_password="" or l_new_password="" or l_renew_password="" then
		response.Write JuhaoyongReturnHistoryPage("�޸Ĺ���Ա����","���벻��Ϊ��")
		response.end
	elseif  l_new_password<>l_renew_password then
		response.Write JuhaoyongReturnHistoryPage("�޸Ĺ���Ա����","��������������벻һ��")
		response.end
	else
		set rs1=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_user where password='"&l_password_md5&"' and username='"&l_username&"'"
		rs1.open(sql),cn,1,1
		if  rs1.eof  then
			response.Write JuhaoyongReturnHistoryPage("�޸Ĺ���Ա����","ԭ���벻��ȷ")
			response.end
		else
			set rs=server.createobject("adodb.recordset")
			sql="select * from juhaoyong_tb_user where username='"&l_username&"'"
			rs.open(sql),cn,1,3
			rs("password")=md5(l_new_password,16)
			rs.update
			rs.close
			set rs=nothing
			response.Write JuhaoyongResultPage("�޸Ĺ���Ա����","�޸ĳɹ�","admin_list.asp")
			response.end
		end if
		rs1.close
		set rs1=nothing
	end if
else
%>

<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_user where id="&article_id&""
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
%>

	<form id="form1" name="form1" method="post" action="?act=save&id=<%=rs("id")%>">
	<script language='javascript'>
	function checksignup1() {
	if ( document.form1.password.value == '' ) {
	window.alert('������ԭ����^_^');
	document.form1.password.focus();
	return false;}
	
	if ( document.form1.new_password.value == '' ) {
	window.alert('������������^_^');
	document.form1.new_password.focus();
	return false;}
	
	if ( document.form1.renew_password.value == '' ) {
	window.alert('���ظ�����������^_^');
	document.form1.renew_password.focus();
	return false;}
	
	return true;}
	</script>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">�޸Ĺ���Ա����</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>����Ա�û���</td>
	  <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor01">
	    <input name='username' type='text' id='username' size='30' maxlength="20"  value="<%=rs("username")%>" readonly>
	  </span></td>
	  </tr>
	<tr>
	<td class="jhyabTabletdBgcolor01" width="15%" height=23>ԭ���� (����) </td>
	<td class="jhyabTabletdBgcolor01" width="85%"><input name='password' type='password' id='password' size='30'   maxlength="20">
	  &nbsp;</td>
	</tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>������ (����) </td>
	    <td class="jhyabTabletdBgcolor01"><input name='new_password' type='password' id='new_password' size='30'   maxlength="20">��Ӣ�Ļ����֣��<font color="#FF0000" size="+1">&nbsp;20&nbsp;</font>λ��</td>
      </tr>
	  
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>�ظ������� <span class="jhyabTabletdBgcolor01">(����) </span></td>
	    <td class="jhyabTabletdBgcolor01"><input name='renew_password' type='password' id='renew_password' size='30'   maxlength="20"></td>
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