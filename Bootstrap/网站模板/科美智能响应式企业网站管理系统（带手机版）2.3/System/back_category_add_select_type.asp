<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->

<% '读取数据
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
	  <th class="tableHeaderText">添加栏目</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" class='TipTitle'>操作说明：</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords">
		  	<p>1、一般情况下，您可需要填写栏目名称即可,栏目文件夹名称不填将会自动用拼音命名。</p>
            <p>2、栏目文件夹名称，不能与系统文件夹名称重名。</p>
            </td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	  <td class="jhyabTabletdBgcolor01" width="20%">上级栏目</td>
	  <td class="jhyabTabletdBgcolor01" width="80%">
		<%
		if dirparentid>0 then
		response.write pClassName&"&nbsp;>"
		else
		response.write "当前为一级栏目"
		end if
		%>
	  </td>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>选择新建栏目类别</td>
	  <td class="jhyabTabletdBgcolor01">
	<%Select Case juhaoyongClassType%>
		<%Case "0"%>
			<input name="juhaoyongClassType" type="radio" value="1" checked="checked">文章&nbsp;&nbsp;
			<input name="juhaoyongClassType" type="radio" value="2">产品&nbsp;&nbsp;
			<input name="juhaoyongClassType" type="radio" value="3">单页
		<%Case "1"%>
			<input name="juhaoyongClassType" type="radio" value="1" checked="checked">文章&nbsp;&nbsp;
			<input name="juhaoyongClassType" type="radio" value="3">单页
	<%End Select%>
		</td>
	 </tr>


	<tr>
		<td height="50" colspan=2  class="jhyabTabletdBgcolor02">
			<div align="center">
				<INPUT type=submit value='确定' name=Submit>
			</div>
		</td>
	</tr>
	</table></td></tr></table>
</form><br /><br /><br />

<%
Call DbconnEnd()
 %>