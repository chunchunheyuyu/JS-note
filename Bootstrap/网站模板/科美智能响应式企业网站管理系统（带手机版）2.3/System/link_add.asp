<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<%
'������ݵ����ݱ�
act=Request("act")
If act="save" Then
	l_name=trim(request.form("name"))
	l_url=trim(request.form("url"))
	l_image=trim(request.form("web_image"))
	l_order=trim(request.form("order"))
	l_memo=trim(request.form("memo"))
	l_view_yes=trim(request.form("view_yes"))
	l_time=now()
	
	'������Ʋ���Ϊ��
	if l_name&""="" then
		response.Write JuhaoyongReturnHistoryPage("�����������","���Ʋ���Ϊ��")
		response.end
	'�����ַ����Ϊ��
	elseif l_url&""="" then
		response.Write JuhaoyongReturnHistoryPage("�����������","��ַ����Ϊ��")
		response.end
	'����������������
	elseif isnumeric(l_order)=false then
		response.Write JuhaoyongReturnHistoryPage("�����������","����ֵֻ��Ϊ����")
		response.end
	else
		set rs=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_link"
		rs.open(sql),cn,1,3
		rs.addnew
		rs("name")=l_name
		rs("url")=l_url
		rs("image")=l_image
		if l_order<>"" then
		rs("order")=cint(l_order)
		end if
		rs("memo")=l_memo
		rs("follow_yes")=cint(l_view_yes)
		rs("view_yes")=1
		rs("time")=l_time
		
		rs.update
		rs.close
		set rs=nothing
		
		response.Write JuhaoyongResultPage("�����������","��ӳɹ�","link_list.asp")
		response.end
	end if 
else
%>

	<form id="form1" name="form1" method="post" action="?act=save">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">�������</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td class="jhyabTabletdBgcolor01" width="15%" height=23>�������� (����) </td>
	<td class="jhyabTabletdBgcolor01"><input name='name' type='text' id='name' size='70'>
	  &nbsp;</td>
	</tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>������ַ (����) </td>
	    <td class="jhyabTabletdBgcolor01"><input name='url' type='text' id='url' value="http://" size='70'>
        &nbsp;��http://��ͷ</td>
      </tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>����LOGO</td>
	    <td class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%" ><input name="web_image" type="text" id="web_image"  size="30"></td>
           <td width="78%"  ><iframe width=750 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=2"></iframe></td>
         </tr>
       </table></td>
      </tr><tr>
	    <td class="jhyabTabletdBgcolor01" height=23>����</td>
	    <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor02">
	      <input name='order' type='text' id='order' value="100" size='3' maxlength="3">
	    &nbsp;ֻ�������֣�����ԽС����Խ��ǰ��Ĭ��Ϊ100�������������</span></td>
      </tr><tr>
	  <td class="jhyabTabletdBgcolor01" height=11>��ע</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='memo'  cols="100" rows="6" id="memo" ></textarea></td>
	</tr>
	  
	  <tr>
	  <td class="jhyabTabletdBgcolor01" height=23>NoFollow</td>
	  <td class="jhyabTabletdBgcolor01">
	    <input type="radio" name="view_yes" value="1">
      ��
      &nbsp;
      <input name="view_yes" type="radio" value="0" checked="checked" >
      ��</td>
	</tr>
		
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='�ύ' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form>
<%end if%>
<%
Call DbconnEnd()
 %>