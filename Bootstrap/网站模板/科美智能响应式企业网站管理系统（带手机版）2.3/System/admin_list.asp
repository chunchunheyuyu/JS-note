<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">��̨ϵͳ����Ա����</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" class='TipTitle'>����˵����</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords"><p>1����̨����Ա���������𣺳�������Ա����ͨ����Ա����ͨ����Աû�С�ϵͳ���á�Ȩ�ޡ�</p>
                <p>2�����龭���������룬���Ϻ�̨��ȫ��</p>
            </td>
          </tr>
          <tr>
            <td height="10" ></td>
          </tr>
        </table>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30"> <a href="admin_add.asp">����µĹ���Ա</a></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
      </table>
<%set rs=server.createobject("adodb.recordset")
if logr() then
	sql="select * from juhaoyong_tb_user order by class,id"
else
	sql="select * from juhaoyong_tb_user where class<>1 order by class,id"
end if
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
%>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="22%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">�û���</div></td>
            <td width="26%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">�û�Ȩ��</div></td>
            <td width="28%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">���ʱ��</div></td>
            <td width="24%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">����</div></td>
          </tr>
		  <%
		  do while not rs.eof
		  %>
          <tr>
            <td height="35" class="jhyabTabletdBgcolor01">
            <div align="center"><%=rs("username")%></div></td>
            <td class="jhyabTabletdBgcolor01">
              <div align="center">
            <%if rs("class")=1 then
			response.write "<span style='color: #FF0000'>��������Ա</span>"
			else
			response.write "һ���û�"
			end if%>
            </div></td>
            <td class="jhyabTabletdBgcolor01"><div align="center"><%=rs("time")%></div></td>
            <td class="jhyabTabletdBgcolor01">
            <div align="center" id="loginform"><a href="admin_edit.asp?id=<%=rs("id")%>" >�޸�����</a>
              <%If logr() and rs("username")<>"admin" Then%>  | <a href="admin_del.asp?id=<%=rs("id")%>&username=<%=rs("username")%>">ɾ��</a>
              <%end if %></div></td>
          </tr>
		  <%
		  rs.movenext
		  loop
		  else
		  response.write "���޹���Ա��"
		  end if 
		  %>
      </table>
	    <br></td>
	</tr>
	</table><br /><br /><br /><br />

<%
Call DbconnEnd()
 %>