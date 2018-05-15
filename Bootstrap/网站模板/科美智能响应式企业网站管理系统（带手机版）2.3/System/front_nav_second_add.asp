<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<% '添加数据到数据表
act=Request("act")
If act="save" Then 
	l_name=trim(request.form("name"))
	l_url=trim(request.form("url"))
	l_position=trim(request.form("position"))
	l_order=trim(request.form("order"))
	l_time=now()
	
	'检测名称不能为空
	if l_name&""="" then
		response.Write JuhaoyongReturnHistoryPage("顶部二级导航添加","名称不能为空")
		response.end
	'分类选择检测
	elseif l_position&""="" then
		response.Write JuhaoyongReturnHistoryPage("顶部二级导航添加","请选择所属一级分类")
		response.end
	'检测排序必须是数字
	elseif isnumeric(l_order)=false then
		response.Write JuhaoyongReturnHistoryPage("顶部二级导航添加","排序值只能为数字")
		response.end
	else
		set rs=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_navsecond"
		rs.open(sql),cn,1,3
		rs.addnew
		rs("name")=l_name
		rs("url")=l_url
		rs("position")=l_position
		if l_order<>"" then
		rs("order")=cint(l_order)
		end if
		rs("time")=l_time
		
		rs.update
		rs.close
		set rs=nothing
		
		response.Write JuhaoyongResultPage("顶部二级导航添加","添加成功","front_nav_second_list.asp")
		response.end
	end if
else
%>
	<form id="form1" name="form1" method="post" action="?act=save">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">添加顶部二级导航</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	    <td class="jhyabTabletdBgcolor01" height=23>所属一级导航(必选)</td>
	    <td class="jhyabTabletdBgcolor01">
	      <select name="position" id="position">
	       <% set rsp=server.createobject("adodb.recordset")
		   sql="select id,name from juhaoyong_tb_navfirst where fd_navfirst_type=1 order by [order]"
		   rsp.open(sql),cn,1,1
		   if not rsp.eof and not rsp.bof then
		   do while not rsp.eof 
		   %> <option value="<%=rsp("id")%>"><%=rsp("name")%></option>
            <%
			rsp.movenext
			loop
			end if
			rsp.close
			set rsp=nothing%></select>
	    </td>
    </tr>
	<tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">导航名称（必填）</td>
	<td class="jhyabTabletdBgcolor01"><input name='name' type='text' id='name' size='70'>
	  &nbsp;</td>
	</tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>导航链接地址（必填）</td>
	    <td class="jhyabTabletdBgcolor01"><input name='url' type='text' id='url' size='70'>
		<br />
        <font color="#FF0000">链接格式：</font><br />
		<font color="#FF0000">1.对应的栏目是一级栏目格式为：abc；二级栏目格式为：abc/def；单页格式为：abc/def.html</font><br />
		<font color="#FF0000">2.如果是外链（即：导航链接到其他网站），填写格式如：http://www.baidu.com/</font>
		</td>
      </tr>
	  
	  
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>排序</td>
	    <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor02">
	      <input name='order' type='text' value="10" size="3" maxlength="3">
	    &nbsp;只能是数字，数字越小排名越靠前</span></td>
      </tr>
	  
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='提交' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form>
<%end if%>
<%
Call DbconnEnd()
 %>