<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<% '添加数据到数据表
nav_id=cint(request.querystring("id"))
act1=Request("act1")
If act1="save" Then 
	l_id=trim(request.form("l_id"))
	l_name=trim(request.form("name"))
	l_url=trim(request.form("url"))
	l_order=trim(request.form("order"))
	
	'检测名称不能为空
	if l_name&""="" then
		response.Write JuhaoyongReturnHistoryPage("顶部Top顶边导航修改","名称不能为空")
		response.end
	'检测排序必须是数字
	elseif isnumeric(l_order)=false then
		response.Write JuhaoyongReturnHistoryPage("顶部Top顶边导航修改","排序值只能为数字")
		response.end
	else
		set rs=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_navfirst where id="&l_id&""
		rs.open(sql),cn,1,3
		rs("name")=l_name
		rs("url")=l_url
		if l_order<>"" then
		rs("order")=l_order
		end if
		rs.update
		rs.close
		set rs=nothing
		
		response.Write JuhaoyongResultPage("顶部Top顶边导航修改","修改成功","front_nav_top_list.asp")
		response.end
	end if
else
%>
 
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_navfirst where id="&nav_id&""
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then%>
	<form id="form1" name="form1" method="post" action="?act1=save&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">修改顶部Top顶边导航</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">导航名称（必填）</td>
	<td width="85%" class="jhyabTabletdBgcolor01"><input name='name' type='text' id='name'  value="<%=rs("name")%>" size='70'>
	 <input name='l_id' type='hidden' id='l_id' value="<%=rs("id")%>" size='70'>
	  &nbsp;</td>
	</tr>

	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>导航链接地址（必填）</td>
	    <td class="jhyabTabletdBgcolor01"><input name='url' type='text' id='url' value="<%=rs("url")%>" size='70'>
		<br />
        <font color="#FF0000">链接格式：</font><br />
		<font color="#FF0000">1.对应的栏目是一级栏目格式为：abc；二级栏目格式为：abc/def；单页格式为：abc/def.html</font><br />
		<font color="#FF0000">2.如果是外链（即：导航链接到其他网站），填写格式如：http://www.baidu.com/</font>
		</td>
      </tr>

	<tr>
	  <td class="jhyabTabletdBgcolor01" height=11>排序</td>
	  <td class="jhyabTabletdBgcolor01"><input name='order' type='text' size="3" maxlength="3" value="<%=rs("order")%>">只能是数字，数字越小排名越靠前</td>
	</tr>

	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='提交' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form>
<%
	end if
	rs.close
	set rs=nothing
end if
%>
<%
Call DbconnEnd()
 %>