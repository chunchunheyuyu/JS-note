<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" --> 
<% '添加数据到数据表
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
	
	'检测名称不能为空
	if l_name&""="" then
		response.Write JuhaoyongReturnHistoryPage("友情链接添加","名称不能为空")
		response.end
	'检测网址不能为空
	elseif l_url&""="" then
		response.Write JuhaoyongReturnHistoryPage("友情链接添加","网址不能为空")
		response.end
	'检测排序必须是数字
	elseif isnumeric(l_order)=false then
		response.Write JuhaoyongReturnHistoryPage("友情链接添加","排序值只能为数字")
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
		response.Write JuhaoyongResultPage("友情链接修改","修改成功","link_list.asp?act="&act&"&keywords="&keywords)
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
	  <th class="tableHeaderText">修改链接</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td class="jhyabTabletdBgcolor01" width="15%" height=23>链接名称 (必填) </td>
	<td class="jhyabTabletdBgcolor01"><input name='name' type='text' id='name'  value="<%=rs("name")%>"size='70'>
	 <input name='l_id' type='hidden' id='l_id' value="<%=rs("id")%>" size='70'>
	  &nbsp;</td>
	</tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>链接网址 (必填) </td>
	    <td class="jhyabTabletdBgcolor01"><input name='url' type='text' id='url' value="<%=rs("url")%>" size='70'>
        &nbsp;以http://开头</td>
      </tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>链接LOGO</td>
	    <td width="85%" class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%" ><input name="web_image" type="text" id="web_image"  value="<%=rs("image")%>" size="30"></td>
           <td width="78%"  ><iframe width=750 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=2&uploadFileOldName=<%=rs("image")%>"></iframe></td>
         </tr>
       </table></td>
      </tr><tr>
	    <td class="jhyabTabletdBgcolor01" height=23>排序</td>
	    <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor02">
	      <input name='order' type='text' id='order' value="<%=rs("order")%>" size='3' maxlength="3">
	    &nbsp;只能是数字，数字越小排名越靠前，默认为100，将排在最后面</span></td>
      </tr><tr>
	  <td class="jhyabTabletdBgcolor01" height=11>备注</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='memo'  cols="100" rows="6" id="memo" ><%=rs("memo")%></textarea></td>
	</tr>
	  
	  <tr>
	  <td class="jhyabTabletdBgcolor01" height=23>NoFollow</td>
	  <td class="jhyabTabletdBgcolor01">
	       <input type="radio" name="view_yes" value="1"<%
		if rs("follow_yes")=1 then
		response.write "checked"
		end if%>>
      是
      &nbsp;
      <input name="view_yes" type="radio" value="0" <%if rs("follow_yes")=0 then
		response.write "checked"
		end if%>>
      否</td>
	</tr>	
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='提交' name=Submit>
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