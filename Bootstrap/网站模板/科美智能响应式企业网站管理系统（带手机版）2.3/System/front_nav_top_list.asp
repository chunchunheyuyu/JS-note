<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<% '�޸�˳��ģ��
action1=request.querystring("action")
id1=request.querystring("id")
order1=trim(request.form("order"))
if action1="edit" then
	if isnumeric(order1)=false then
		response.Write JuhaoyongReturnHistoryPage("����Top���ߵ�������","����ֵ����Ϊ����")
		response.end
	else
		set rs1=server.createobject("adodb.recordset")
		sql="select id,order from juhaoyong_tb_navfirst where id="&id1&""
		rs1.open(sql),cn,1,3
		rs1("order")=order1
		rs1.update
		rs1.close
		set rs1=nothing
		
		response.Write JuhaoyongResultPage("����Top���ߵ�������","�޸ĳɹ�","front_nav_top_list.asp")
		response.end
	end if
end if

%>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr><th class="tableHeaderText">����Top���ߵ���</th></tr>
	
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" class='TipTitle'>����˵����</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords">
<p>1���õ����ǵ��԰桰����Top��������Ҳ���ֻ��桰�ײ�����������ҳ������Top��������</font></p>
<p>2��<font color="#009933" size="+1"><strong>���ӡ��޸ġ�ɾ���������������������о�̬��Ȼ��ǰ̨&nbsp;<font color="#FF0000">��F5ˢ��</font>&nbsp;�鿴Ч����</strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=all"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>������ȥ�������о�̬</span></a></p>
            </td>
          </tr>
          <tr>
            <td height="10" ></td>
          </tr>
        </table>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30"> <a href="front_nav_top_add.asp">����µĶ���Top���ߵ���</a></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
      </table>
	   
	  
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="7%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">���</div></td>
            <td width="17%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">��������</div></td>
            <td width="21%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">��������</div></td>
            <td width="16%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">��ʾ����</div></td>
            <td width="13%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">���ʱ��</div></td>
            <td width="17%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">����</div></td>
          </tr>
<% '�����б�ģ��
dim rs,trStyleNum
trStyleNum=1
set rs = server.CreateObject("adodb.recordset")
s_sql="select * from juhaoyong_tb_navfirst where fd_navfirst_type=3 order by  [order],id"
rs.Open (s_sql),cn,1,1
rscount=rs.recordcount
if not rs.eof then
do while not rs.eof
%>
<% if trStyleNum mod 2 =0 then
class_style="jhyabTabletdBgcolor02"
else
class_style="jhyabTabletdBgcolor01"
end if%>
            <form name="form1" method="post" action="?action=edit&id=<%=rs("id")%>">
          <tr >
            <td   height="40" class='<%=class_style%>'><div align="center"><%=rs("id")%></div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("name")%></div></td>          
            <td class='<%=class_style%>' ><div align="left"><%=rs("url")%></div></td>
            <td class='<%=class_style%>' ><div align="center">
              <input name="order" type="text" value="<%=rs("order")%>" size="3" maxlength="3">
              <input type="submit" name="Submit" value="�޸�����">
            </div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("time")%></div></td>
            <td class='<%=class_style%>' >
            <div align="center"><a href="front_nav_top_edit.asp?id=<%=rs("id")%>">�޸�</a> | <a href="front_nav_top_del.asp?id=<%=rs("id")%>">ɾ��</a></div></td>
          </tr></form>
		  		  <%
		  rs.movenext
		  trStyleNum=trStyleNum+1
		  loop
		  else
response.write "<div align='center'><span style='color: #FF0000'>�������ݣ�</span></div>"
		  end if 
		  rs.close
		  set rs=nothing
		  %>
      </table>
        ����Top���ߵ���������<%=rscount%>
        </td>
	</tr>
	</table><br /><br /><br /><br />

<%
Call DbconnEnd()
 %>