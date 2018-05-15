<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<% '添加数据到数据表
act=Request("act")
kftype=Request("kftype")

if act="save" then
	l_name=trim(request.form("name"))
	
	if kftype="2wm" then
		l_image=trim(request.form("web_image"))
	else
		l_memo=trim(request.form("memo"))
	end if
	
	l_kfshunxu=trim(request.form("kfshunxu"))
	l_time=now()
	
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_kefu"
	rs.open(sql),cn,1,3
	rs.addnew
	rs("name")=l_name
	
	if kftype="2wm" then
		rs("image")=l_image
		rs("kftype")=2
	else
		rs("memo")=l_memo
	end if
	
	if l_kfshunxu<>"" then rs("kfshunxu")=cint(l_kfshunxu)
	rs("time")=l_time
	rs.update
	rs.close
	set rs=nothing
	if kftype="2wm" then
		response.Write JuhaoyongResultPage("添加二维码图片","添加成功","onlinekefu_list.asp")
	else
		response.Write JuhaoyongResultPage("添加在线客服","添加成功","onlinekefu_list.asp")
	end if
	response.end
else
%>
	<form id="form1" name="form1" method="post" action="?act=save">
	<script language='javascript'>
	function checksignup1() {
	if ( document.form1.name.value == '' ) {
	window.alert('请输入在线客服名称^_^');
	document.form1.name.focus();
	return false;}
	return true;}
	</script>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText"><%if kftype="2wm" then%>添加二维码图片<%else%>添加在线客服<%end if%></th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1"> 
	<tr>
	<td class="jhyabTabletdBgcolor01" width="15%" height=23><%if kftype="2wm" then%>二维码图片名称 (必填)<%else%>在线客服名称 (必填)<%end if%></td>
	<td class="jhyabTabletdBgcolor01" width="85%"><input name='name' type='text' size='70' maxlength="30">&nbsp;</td>
	</tr>
    
    <%if kftype="2wm" then%>
    <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>上传图片 </td>
	    <td width="85%" class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%"><input name="web_image" type="text" size="30" readonly></td>
           <td width="78%"><iframe width=750 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=1&juhaoyongForm1InputName=web_image"></iframe></td>
         </tr>
       </table>
	   图片类型：<font color="red">.jpg</font> &nbsp;&nbsp;图片尺寸：<font color="red">右键模版图片，"图片另存为..."或"背景另存为..."，把图片存到本地，鼠标放到图片文件上，即可看到尺寸</font>
       <input name='kftype' type='hidden' value="2wm">
       </td>
    </tr>
    <%else%>
    <tr>
	  <td class="jhyabTabletdBgcolor01" height=11>在线客服代码</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='memo'  cols="100" rows="6" id="memo" ></textarea></td>
	</tr>
    <%end if%>
    
    <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>排序</td>
	    <td class="jhyabTabletdBgcolor01"><input name='kfshunxu' type='text' size='3' maxlength="3">&nbsp;请输入数字，数字越小排序越靠前</span></td>
    </tr>
    
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='提交' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table>
	
	</td></tr></table>
</form>
<%end if%>
<%
Call DbconnEnd()
 %>