<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" --> 
<% '������ݵ����ݱ�
act=Request("act")
keywords=request.querystring("keywords")
article_id=cint(request.querystring("id"))

act1=Request("act1")
If act1="save" Then 
	l_id=trim(request.form("l_id"))
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
		sql="select * from juhaoyong_tb_link where id="&l_id&""
		rs.open(sql),cn,1,3
		rs("name")=l_name
		rs("url")=l_url
		rs("image")=l_image
		if l_order<>"" then
		rs("order")=cint(l_order)
		end if
		rs("memo")=l_memo
		rs("follow_yes")=cint(l_view_yes)
		rs.update
		rs.close
		set rs=nothing
		response.Write JuhaoyongResultPage("���������޸�","�޸ĳɹ�","link_list.asp?act="&act&"&keywords="&keywords)
		response.end
	end if
else
%>

<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_link where id="&article_id&""
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then%>
	<form id="form1" name="form1" method="post" action="?act1=save&act=<%=act%>&keywords=<%=keywords%>">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">�޸�����</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td class="jhyabTabletdBgcolor01" width="15%" height=23>�������� (����) </td>
	<td class="jhyabTabletdBgcolor01"><input name='name' type='text' id='name'  value="<%=rs("name")%>"size='70'>
	 <input name='l_id' type='hidden' id='l_id' value="<%=rs("id")%>" size='70'>
	  &nbsp;</td>
	</tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>������ַ (����) </td>
	    <td class="jhyabTabletdBgcolor01"><input name='url' type='text' id='url' value="<%=rs("url")%>" size='70'>
        &nbsp;��http://��ͷ</td>
      </tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>����LOGO</td>
	    <td width="85%" class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%" ><input name="web_image" type="text" id="web_image"  value="<%=rs("image")%>" size="30"></td>
           <td width="78%"  ><iframe width=750 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=2&uploadFileOldName=<%=rs("image")%>"></iframe></td>
         </tr>
       </table></td>
      </tr><tr>
	    <td class="jhyabTabletdBgcolor01" height=23>����</td>
	    <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor02">
	      <input name='order' type='text' id='order' value="<%=rs("order")%>" size='3' maxlength="3">
	    &nbsp;ֻ�������֣�����ԽС����Խ��ǰ��Ĭ��Ϊ100�������������</span></td>
      </tr><tr>
	  <td class="jhyabTabletdBgcolor01" height=11>��ע</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='memo'  cols="100" rows="6" id="memo" ><%=rs("memo")%></textarea></td>
	</tr>
	  
	  <tr>
	  <td class="jhyabTabletdBgcolor01" height=23>NoFollow</td>
	  <td class="jhyabTabletdBgcolor01">
	       <input type="radio" name="view_yes" value="1"<%
		if rs("follow_yes")=1 then
		response.write "checked"
		end if%>>
      ��
      &nbsp;
      <input name="view_yes" type="radio" value="0" <%if rs("follow_yes")=0 then
		response.write "checked"
		end if%>>
      ��</td>
	</tr>	
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='�ύ' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
</form>
<%
	end if
	rs.close
	set rs=nothing
end if%>
<%
Call DbconnEnd()
 %>