<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="inc/head.asp" -->
<%
'�޸�����
action=request.querystring("action")
id=request.querystring("id")
kfshunxu=trim(request.form("kfshunxu"))
if action="edit" then
	if isnumeric(kfshunxu)=false then
		response.Write JuhaoyongReturnHistoryPage("���߿ͷ�����","����ֵ����Ϊ����")
		response.end
	else
		set rs=server.createobject("adodb.recordset")
		sql="select kfshunxu from juhaoyong_tb_kefu where id="&id&""
		rs.open(sql),cn,1,3
		rs("kfshunxu")=cint(kfshunxu)
		rs.update
		rs.close
		set rs=nothing
		response.Write JuhaoyongResultPage("���߿ͷ�����","�޸ĳɹ�","onlinekefu_list.asp")
		response.end
	end if
end if
%>

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">���߿ͷ��б�</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	
		 <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" class='TipTitle'>����˵����</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords">
		    <p>1������޸ģ������߿ͷ������滻Ϊ�Լ��ģ����ɡ�</p>
			<p>2��<font color="#ff0000" size="+1"><b>���߿ͷ������ȡ������</b></font></p>
			<p><font color="#0066ff">��1��QQ���ߴ���������ַ��<a href="http://shang.qq.com/" target="_blank">http://shang.qq.com/</a>���򿪺󣬵�����ƹ㹤�ߡ����롣</font>���⣬��¼QQ������>>Ȩ������>>��ʱ����������ġ��������κ���ʱ�ػ���Ϣ��ǰ��Ĺ�ȥ����</p>
			<p><font color="#ff0000">��2���������ߴ���������ַ��<a href="https://www.taobao.com/market/seller/aliclient/ww/wangbiantianxia.php" target="_blank">https://www.taobao.com/market/seller/aliclient/ww/wangbiantianxia.php</a>�����������Ұ������������ϵͳ����>>��ȫ����>>��֤���ã�ѡ�񡰲�������֤���ܼ���Ϊ���ѡ���</font></p>
			<p>��3���������ߴ��룬�磺MSN��Skype�ȣ��뵽�ٷ����ɴ��롣</p>
            <p>3��<font color="#009933" size="+1"><strong>���ӡ��޸ġ�ɾ�����߿ͷ����������������о�̬��Ȼ��ǰ̨&nbsp;<font color="#FF0000">��F5ˢ��</font>&nbsp;�鿴Ч����</strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=all"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>������ȥ�������о�̬</span></a></p>
			<p>4���������Ҫ���߿ͷ�����ɾ�����У�Ȼ�������������о�̬���Ͳ�����ʾ���߿ͷ��������ˡ�</p>
			</td>
          </tr>
          <tr>
            <td height="10" ></td>
          </tr>
        </table>
		
	
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="120"> <a href="onlinekefu_add.asp">������߿ͷ�</a></td>
            <td height="30"> <a href="onlinekefu_add.asp?kftype=2wm">��Ӷ�ά��ͼƬ</a></td>
          </tr>
		  <tr>
            <td height="10" ></td><td height="10" ></td>
          </tr>
      </table>
	   
	  
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="5%" height="30" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">���</div></td>
            <td width="10%" height="30" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">���</div></td>
            <td width="15%" height="30" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">����</div></td>
            <td width="30%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">��ʾЧ��</div></td>
            <td width="20%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">��ʾ����</div></td>
            <td width="20%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">����</div></td>
          </tr>
<%
'���߿ͷ��б�ģ��
dim kefuNum
kefuNum=1
set rs = server.CreateObject("adodb.recordset")
s_sql="select * from juhaoyong_tb_kefu order by kfshunxu,id"
rs.Open (s_sql),cn,1,1
if not rs.eof and not rs.bof then
do while not rs.eof
if kefuNum mod 2 =0 then
class_style="jhyabTabletdBgcolor02"
else
class_style="jhyabTabletdBgcolor01"
end if%>
            <form name="form1" method="post" action="?action=edit&id=<%=rs("id")%>">
          <tr >
            <td height="40" class='<%=class_style%>'><div align="center"><%=rs("id")%></div></td>
            <td height="40" class='<%=class_style%>'><%if rs("kftype")=2 then%>��ά��ͼƬ<%else%>���߿ͷ�<%end if%></td>
           <td class='<%=class_style%>' ><div align="center"><%=rs("name")%></div></td>
            <td class='<%=class_style%>' >
            <div align="center">
            <%if rs("kftype")=2 then%>
			<img src="../css/<%=SITE_STYLE_CSS_FOLDER%>/<%=rs("image")%>" width="115" boder="0">
            <%else%>
            <%=rs("memo")%>
            <%end if%>
            </div>
            </td>
            <td class='<%=class_style%>' > <div align="center">
            <input name="kfshunxu" type="text" value="<%=rs("kfshunxu")%>" size="3" maxlength="3">
            <input type="submit" name="submit" value="�޸�����">
           </div></td>
            <td class='<%=class_style%>' >
            <div align="center"><a href="onlinekefu_edit.asp?id=<%=rs("id")%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">�޸�</a> | <a href="onlinekefu_del.asp?id=<%=rs("id")%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">ɾ��</a>            </div></td>
          </tr></form>
<%
rs.movenext
kefuNum=kefuNum+1
loop
else
	response.write "<div align='center'><span style='color: #FF0000'>�������ݣ�</span></div>"
end if 
rs.close
set rs=nothing
%>
      </table>
	    <br></td>
	</tr>
	</table><br /><br /><br /><br />

<%
Call DbconnEnd()
 %>