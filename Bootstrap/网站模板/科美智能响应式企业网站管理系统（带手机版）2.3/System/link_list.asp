<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<%
act=request.querystring("act")
keywords=trim(request("keywords"))
if act="search" then
	s_sql="select * from juhaoyong_tb_link where [name] like '%"&keywords&"%' order by [order],id "
else
	s_sql="select * from juhaoyong_tb_link  order by [order],id "
end if
%>

<% '修改顺序模块
action1=request.querystring("action")
id1=request.querystring("id")
order1=trim(request.form("order"))
if action1="edit" then
	if isnumeric(order1)=false then
		response.Write JuhaoyongReturnHistoryPage("友情链接修改排序","排序值只能为数字")
		response.end
	else
		set rs1=server.createobject("adodb.recordset")
		sql="select id,order from juhaoyong_tb_link where id="&id1&""
		rs1.open(sql),cn,1,3
		rs1("order")=cint(order1)
		rs1.update
		rs1.close
		set rs1=nothing

		response.Write JuhaoyongResultPage("友情链接修改排序","修改成功","link_list.asp")
		response.end
	end if
end if
%>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">链接列表</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
            <td height="25" class='TipTitle'>操作说明：</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords">

		  	<p>1、全部隐藏或删除，则首页自动不显示友情链接模块。</p>
            <p>2、<font color="#009933" size="+1"><strong>增加、修改、删除友情链接后，请重新生成所有静态，然后到前台&nbsp;<font color="#FF0000">按F5刷新</font>&nbsp;查看效果。</strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=all"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>点击这里，去生成所有静态</span></a></p>
				
			</td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>		  
          <tr>
            <td height="30"> <a href="link_add.asp">添加新的链接</a></td>
          </tr>
		  <tr>
            <td height="10"></td>
          </tr>	
      </table>
	   
	  
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="4%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">编号</div></td>
            <td width="13%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">链接名称</div></td>
            <td width="22%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">链接网址</div></td>
            <td width="15%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">链接LOGO</div></td>
            <td width="15%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">显示排序</div></td>
            <td width="7%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">审核</div></td>
            <td width="15%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">添加时间</div></td>
            <td width="9%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">操作</div></td>
          </tr>
<% '文章列表模块
dim linkNum
linkNum=1
set rs = server.CreateObject("adodb.recordset")
rs.Open (s_sql),cn,1,1
rscount=rs.recordcount
if not rs.eof then
do while not rs.eof
%>
<% if linkNum mod 2 =0 then
class_style="jhyabTabletdBgcolor02"
else
class_style="jhyabTabletdBgcolor01"
end if%>
            <form name="form1" method="post" action="?action=edit&id=<%=rs("id")%>">
          <tr >
            <td   height="40" class='<%=class_style%>'><div align="center"><%=rs("id")%></div></td>
           <td class='<%=class_style%>' ><div align="center"><%=rs("name")%>
		   <% if rs("follow_yes")=1 then 
		   response.write " <span style='color: #FF0000'>NoF...</span>"
		   end if
		   %></div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("url")%></div></td>
            <td class='<%=class_style%>' >
			  <div align="center"><% if rs("image")<>"" then%>
			   <img src="../images/up_images/<%=rs("image")%>">
			   <% end if%>            
	        </div></td>
            <td class='<%=class_style%>' > <div align="center">
            <input name="order" type="text" value="<%=rs("order")%>" size="3" maxlength="3">
            <input type="submit" name="Submit" value="修改排序"  >
           </div></td>
            <td class='<%=class_style%>' ><div align="center"><a href="link_show_hide.asp?id=<%=rs("id")%>&keywords=<%=keywords%>"><%if rs("view_yes")=1 then%>已显示<%else%><span style="color: #FF0000">未显示</span><% end if%></a></div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("time")%></div></td>
            <td class='<%=class_style%>' >
            <div align="center"><a href="link_edit.asp?id=<%=rs("id")%>&act=<%=act%>&keywords=<%=keywords%>">修改</a> | <a href="link_del.asp?id=<%=rs("id")%>&act=<%=act%>&keywords=<%=keywords%>">删除</a>            </div></td>
          </tr></form>
		  		  <%
		  rs.movenext
		  linkNum=linkNum+1
		  loop
		  else
			response.write "<div align='center'><span style='color: #FF0000'>暂无链接！</span></div>"
		  end if 
		  rs.close
		  set rs=nothing
		  %>
      </table>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="20" class="jhyabTabletdBgcolor02">&nbsp;</td>
          </tr>
          <tr>
            <td height="25" align="center"> 链接搜索</td>
          </tr>
          <tr>
            <td height="70">
<form name="form1" method="post" action="?act=search"><div align="center">&nbsp;
<input name="keywords" type="text"  size="35" maxlength="40">&nbsp;
<input type="submit" name="Submit" value="搜 索">
              </div>
            </form>
            </td>
          </tr>
      </table>
	    <br></td>
	</tr>
	</table><br /><br /><br /><br />

<%
Call DbconnEnd()
 %>