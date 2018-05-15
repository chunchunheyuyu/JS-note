<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/md5.asp" -->
<!-- #include file="inc/head.asp" -->

<% '添加数据到数据表
act=Request("act")
If act="save" Then 
	l_username=trim(request.form("username"))
	l_password=trim(request.form("password"))
	l_repassword=trim(request.form("repassword"))
	l_class=request.form("class")
	l_time=now()
	
	if l_username="" or l_password="" or l_repassword="" then
		response.Write JuhaoyongReturnHistoryPage("修改管理员密码","用户名或密码不能为空")
		response.end
	elseif  l_password<>l_repassword then
		response.Write JuhaoyongReturnHistoryPage("修改管理员密码","两次输入的密码不一致")
		response.end
	else
		set rs1=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_user where username='"&l_username&"'"
		rs1.open(sql),cn,1,1
		if not rs1.eof and not rs1.bof then
			response.Write JuhaoyongReturnHistoryPage("修改管理员密码","此用户名已经存在，请重新命名")
			response.end
		else
			'加入管理员表
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
			response.Write JuhaoyongResultPage("添加后台管理员","添加成功","admin_list.asp")
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
	window.alert('请输入用户名^_^');
	document.form1.username.focus();
	return false;}
	
	if ( document.form1.password.value == '' ) {
	window.alert('请输入密码^_^');
	document.form1.password.focus();
	return false;}
	
	if ( document.form1.repassword.value == '' ) {
	window.alert('请重复输入密码^_^');
	document.form1.repassword.focus();
	return false;}
	return true;}
	</script>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">添加后台管理员</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td class="jhyabTabletdBgcolor01" width="15%" height=23>管理员用户名 (必填) </td>
	<td class="jhyabTabletdBgcolor01" width="85%"><input name='username' type='text' id='username' size='30' maxlength="20">（英文或数字，最长<font color="#FF0000" size="+1">&nbsp;20&nbsp;</font>位）
	  &nbsp;</td>
	</tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>密码 (必填) </td>
	    <td class="jhyabTabletdBgcolor01"><input name='password' type='password' id='password' size='30' maxlength="20">（英文或数字，最长<font color="#FF0000" size="+1">&nbsp;20&nbsp;</font>位）</td>
      </tr>
	  
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>重复密码 <span class="jhyabTabletdBgcolor01">(必填) </span></td>
	    <td class="jhyabTabletdBgcolor01"><input name='repassword' type='password' id='repassword' size='30' maxlength="20"></td>
      </tr>
	  <% if logr() then%>
	    <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>用户权限<span class="jhyabTabletdBgcolor01"> </span></td>
	    <td class="jhyabTabletdBgcolor01">
	      <input type="radio" name="class" value="1">
	      超级管理员&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	      <input name="class" type="radio" value="2" checked>
	      普通管理员</td>
	    </tr>
		<%end if%>
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='提交' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form>
<%end if%>
<%
Call DbconnEnd()
%>