<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->

<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="../inc/rebuild_modify_template.asp" -->

<!-- #include file="inc/head.asp" -->
<%
'�޸�����
action1=request.querystring("action")
id1=request.querystring("id")
order1=trim(request.form("order"))
if action1="edit" then
	if isnumeric(order1)=false then
		response.Write JuhaoyongReturnHistoryPage("�ֲ�ͼƬ����","����ֵ����Ϊ����")
		response.end
	else
		set rs1=server.createobject("adodb.recordset")
		sql="select id,order from juhaoyong_tb_picture where id="&id1&""
		rs1.open(sql),cn,1,3
		rs1("order")=cint(order1)
		rs1.update
		rs1.close
		set rs1=nothing
		
		'����������ҳģ��
		call RewriteTemplateFile(0,0)
		'������ҳ
		call Run_createhtml_index()
		response.Write JuhaoyongResultPage("�ֲ�ͼƬ����","�޸ĳɹ�","index_lunbo_list.asp")
		response.end
	end if
end if

%>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">�ֲ�ͼƬ�б�</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" class='TipTitle'>����˵����</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords">

		  	  <p>1��ͼƬ���ͣ�.jpg &nbsp;&nbsp;ͼƬ�ߴ磺�Ҽ�ģ��ͼƬ����ͼƬ���Ϊ...���򡰱������Ϊ...������ͼƬ�浽���أ����ŵ�ͼƬ�ļ��ϣ����ɿ����ߴ�</p>
              <p>2���ϴ���ͼƬ�����������С�㣬����������100K���ڣ�ͼƬ̫���Ӱ����ҳ���ٶȣ�</p>
			  <p>3��ȫ�����ػ�ȫ��ɾ��ͼƬ������ҳ����ʾ��ģ�顣</p>
				
			</td>
          </tr>
          <tr>
            <td height="10" ></td>
          </tr>
        </table>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30"><a href="index_lunbo_add.asp">����µ�ͼƬ</a></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
      </table>
	   
	  
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="4%" height="30" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">���</div></td>
            <td width="24%" height="30" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">����</div></td>
            <td width="14%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">����</div></td>
            <td width="13%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">��ʾ����</div></td>
            <td width="7%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">���</div></td>
            <td width="15%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">���ʱ��</div></td>
            <td width="9%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">����</div></td>
          </tr>
<% '�����б�ģ��
dim imagesNum
imagesNum=1
s_sql="select * from juhaoyong_tb_picture order by [order],id"
set rs = server.CreateObject("adodb.recordset")
rs.Open (s_sql),cn,1,1
rscount=rs.recordcount
if not rs.eof then
do while not rs.eof
%>
<% if imagesNum mod 2 =0 then
class_style="jhyabTabletdBgcolor02"
else
class_style="jhyabTabletdBgcolor01"
end if%>
            <form name="form1" method="post" action="?action=edit&id=<%=rs("id")%>">
          <tr >
            <td   height="40" class='<%=class_style%>'><div align="center"><%=rs("id")%></div></td>
           <td class='<%=class_style%>' ><%=rs("name")%></td>
            <td class='<%=class_style%>' ><div align="center">ͼƬ</div></td>
            <td class='<%=class_style%>' > <div align="center">
            <input name="order" type="text" value="<%=rs("order")%>" size="3" maxlength="3">
            <input type="submit" name="submit" value="�޸�����"  >
           </div></td>
            <td class='<%=class_style%>' ><div align="center"><a href="index_lunbo_show_hide.asp?id=<%=rs("id")%>"><%if rs("view_yes")=1 then%>����ʾ<%else%><span style="color: #FF0000">δ��ʾ</span><% end if%></a></div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("time")%></div></td>
            <td class='<%=class_style%>' >
            <div align="center"><a href="index_lunbo_edit.asp?id=<%=rs("id")%>">�޸�</a> | <a href="index_lunbo_del.asp?id=<%=rs("id")%>">ɾ��</a>            </div></td>
          </tr></form>
<%
rs.movenext
imagesNum=imagesNum+1
loop
else
response.write "<div align='center'><span style='color: #FF0000'>�������ӣ�</span></div>"
end if 
rs.close
set rs=nothing
%>
      </table>
	    
	   </td>
	</tr>
	</table><br /><br /><br />

<%
Call DbconnEnd()
 %>