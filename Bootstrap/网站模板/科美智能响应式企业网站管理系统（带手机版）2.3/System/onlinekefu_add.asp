<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<% '������ݵ����ݱ�
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
		response.Write JuhaoyongResultPage("��Ӷ�ά��ͼƬ","��ӳɹ�","onlinekefu_list.asp")
	else
		response.Write JuhaoyongResultPage("������߿ͷ�","��ӳɹ�","onlinekefu_list.asp")
	end if
	response.end
else
%>
	<form id="form1" name="form1" method="post" action="?act=save">
	<script language='javascript'>
	function checksignup1() {
	if ( document.form1.name.value == '' ) {
	window.alert('���������߿ͷ�����^_^');
	document.form1.name.focus();
	return false;}
	return true;}
	</script>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText"><%if kftype="2wm" then%>��Ӷ�ά��ͼƬ<%else%>������߿ͷ�<%end if%></th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1"> 
	<tr>
	<td class="jhyabTabletdBgcolor01" width="15%" height=23><%if kftype="2wm" then%>��ά��ͼƬ���� (����)<%else%>���߿ͷ����� (����)<%end if%></td>
	<td class="jhyabTabletdBgcolor01" width="85%"><input name='name' type='text' size='70' maxlength="30">&nbsp;</td>
	</tr>
    
    <%if kftype="2wm" then%>
    <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>�ϴ�ͼƬ </td>
	    <td width="85%" class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%"><input name="web_image" type="text" size="30" readonly></td>
           <td width="78%"><iframe width=750 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=1&juhaoyongForm1InputName=web_image"></iframe></td>
         </tr>
       </table>
	   ͼƬ���ͣ�<font color="red">.jpg</font> &nbsp;&nbsp;ͼƬ�ߴ磺<font color="red">�Ҽ�ģ��ͼƬ��"ͼƬ���Ϊ..."��"�������Ϊ..."����ͼƬ�浽���أ����ŵ�ͼƬ�ļ��ϣ����ɿ����ߴ�</font>
       <input name='kftype' type='hidden' value="2wm">
       </td>
    </tr>
    <%else%>
    <tr>
	  <td class="jhyabTabletdBgcolor01" height=11>���߿ͷ�����</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='memo'  cols="100" rows="6" id="memo" ></textarea></td>
	</tr>
    <%end if%>
    
    <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>����</td>
	    <td class="jhyabTabletdBgcolor01"><input name='kfshunxu' type='text' size='3' maxlength="3">&nbsp;���������֣�����ԽС����Խ��ǰ</span></td>
    </tr>
    
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='�ύ' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table>
	
	</td></tr></table>
</form>
<%end if%>
<%
Call DbconnEnd()
 %>