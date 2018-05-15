<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<% '修改顺序模块
action1=request.querystring("action")
id1=request.querystring("id")
order1=trim(request.form("order"))
if action1="edit" then
	if isnumeric(order1)=false then
		response.Write JuhaoyongReturnHistoryPage("顶部Top顶边导航排序","排序值必须为数字")
		response.end
	else
		set rs1=server.createobject("adodb.recordset")
		sql="select id,order from juhaoyong_tb_navfirst where id="&id1&""
		rs1.open(sql),cn,1,3
		rs1("order")=order1
		rs1.update
		rs1.close
		set rs1=nothing
		
		response.Write JuhaoyongResultPage("顶部Top顶边导航排序","修改成功","front_nav_top_list.asp")
		response.end
	end if
end if

%>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr><th class="tableHeaderText">顶部Top顶边导航</th></tr>
	
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" class='TipTitle'>操作说明：</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords">
<p>1、该导航是电脑版“顶部Top导航”，也是手机版“底部导航”和内页“顶部Top导航”。</font></p>
<p>2、<font color="#009933" size="+1"><strong>增加、修改、删除导航后，请重新生成所有静态，然后到前台&nbsp;<font color="#FF0000">按F5刷新</font>&nbsp;查看效果。</strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=all"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>点击这里，去生成所有静态</span></a></p>
            </td>
          </tr>
          <tr>
            <td height="10" ></td>
          </tr>
        </table>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30"> <a href="front_nav_top_add.asp">添加新的顶部Top顶边导航</a></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
      </table>
	   
	  
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="7%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">编号</div></td>
            <td width="17%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">导航名称</div></td>
            <td width="21%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">导航链接</div></td>
            <td width="16%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">显示排序</div></td>
            <td width="13%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">添加时间</div></td>
            <td width="17%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">操作</div></td>
          </tr>
<% '文章列表模块
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
              <input type="submit" name="Submit" value="修改排序">
            </div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("time")%></div></td>
            <td class='<%=class_style%>' >
            <div align="center"><a href="front_nav_top_edit.asp?id=<%=rs("id")%>">修改</a> | <a href="front_nav_top_del.asp?id=<%=rs("id")%>">删除</a></div></td>
          </tr></form>
		  		  <%
		  rs.movenext
		  trStyleNum=trStyleNum+1
		  loop
		  else
response.write "<div align='center'><span style='color: #FF0000'>暂无数据！</span></div>"
		  end if 
		  rs.close
		  set rs=nothing
		  %>
      </table>
        顶部Top顶边导航总数：<%=rscount%>
        </td>
	</tr>
	</table><br /><br /><br /><br />

<%
Call DbconnEnd()
 %>