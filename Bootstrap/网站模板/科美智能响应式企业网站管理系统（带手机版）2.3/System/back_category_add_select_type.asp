<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->

<% '��ȡ����
pClassName=request.querystring("pClassName")
dirparentid=cint(request.querystring("dirparentid"))

juhaoyongClassType=request.querystring("juhaoyongClassType")

%>
   	<script charset="utf-8" src="hao8editor/kindeditor.js"></script>
	<script charset="utf-8" src="hao8editor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="hao8editor/editor.js"></script>
 
<!-- #include file="inc/head.asp" -->
<form id="form1" name="form1" method="post" action="back_category_add.asp?dirparentid=<%=dirparentid%>&pClassName=<%=pClassName%>">

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">�����Ŀ</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" class='TipTitle'>����˵����</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords">
		  	<p>1��һ������£�������Ҫ��д��Ŀ���Ƽ���,��Ŀ�ļ������Ʋ�����Զ���ƴ��������</p>
            <p>2����Ŀ�ļ������ƣ�������ϵͳ�ļ�������������</p>
            </td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	  <td class="jhyabTabletdBgcolor01" width="20%">�ϼ���Ŀ</td>
	  <td class="jhyabTabletdBgcolor01" width="80%">
		<%
		if dirparentid>0 then
		response.write pClassName&"&nbsp;>"
		else
		response.write "��ǰΪһ����Ŀ"
		end if
		%>
	  </td>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>ѡ���½���Ŀ���</td>
	  <td class="jhyabTabletdBgcolor01">
	<%Select Case juhaoyongClassType%>
		<%Case "0"%>
			<input name="juhaoyongClassType" type="radio" value="1" checked="checked">����&nbsp;&nbsp;
			<input name="juhaoyongClassType" type="radio" value="2">��Ʒ&nbsp;&nbsp;
			<input name="juhaoyongClassType" type="radio" value="3">��ҳ
		<%Case "1"%>
			<input name="juhaoyongClassType" type="radio" value="1" checked="checked">����&nbsp;&nbsp;
			<input name="juhaoyongClassType" type="radio" value="3">��ҳ
	<%End Select%>
		</td>
	 </tr>


	<tr>
		<td height="50" colspan=2  class="jhyabTabletdBgcolor02">
			<div align="center">
				<INPUT type=submit value='ȷ��' name=Submit>
			</div>
		</td>
	</tr>
	</table></td></tr></table>
</form><br /><br /><br />

<%
Call DbconnEnd()
 %>