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
'修改排序
action1=request.querystring("action")
id1=request.querystring("id")
order1=trim(request.form("order"))
if action1="edit" then
	if isnumeric(order1)=false then
		response.Write JuhaoyongReturnHistoryPage("轮播图片排序","排序值必须为数字")
		response.end
	else
		set rs1=server.createobject("adodb.recordset")
		sql="select id,order from juhaoyong_tb_picture where id="&id1&""
		rs1.open(sql),cn,1,3
		rs1("order")=cint(order1)
		rs1.update
		rs1.close
		set rs1=nothing
		
		'重新生成首页模板
		call RewriteTemplateFile(0,0)
		'生成首页
		call Run_createhtml_index()
		response.Write JuhaoyongResultPage("轮播图片排序","修改成功","index_lunbo_list.asp")
		response.end
	end if
end if

%>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">轮播图片列表</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" class='TipTitle'>操作说明：</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords">

		  	  <p>1、图片类型：.jpg &nbsp;&nbsp;图片尺寸：右键模版图片，“图片另存为...”或“背景另存为...”，把图片存到本地，鼠标放到图片文件上，即可看到尺寸</p>
              <p>2、上传的图片，尽量处理的小点，尽量控制在100K以内，图片太大会影响首页打开速度！</p>
			  <p>3、全部隐藏或全部删除图片，则首页不显示该模块。</p>
				
			</td>
          </tr>
          <tr>
            <td height="10" ></td>
          </tr>
        </table>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30"><a href="index_lunbo_add.asp">添加新的图片</a></td>
          </tr>
          <tr>
            <td height="10"></td>
          </tr>
      </table>
	   
	  
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="4%" height="30" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">编号</div></td>
            <td width="24%" height="30" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">标题</div></td>
            <td width="14%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">类型</div></td>
            <td width="13%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">显示排序</div></td>
            <td width="7%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">审核</div></td>
            <td width="15%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">添加时间</div></td>
            <td width="9%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">操作</div></td>
          </tr>
<% '文章列表模块
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
            <td class='<%=class_style%>' ><div align="center">图片</div></td>
            <td class='<%=class_style%>' > <div align="center">
            <input name="order" type="text" value="<%=rs("order")%>" size="3" maxlength="3">
            <input type="submit" name="submit" value="修改排序"  >
           </div></td>
            <td class='<%=class_style%>' ><div align="center"><a href="index_lunbo_show_hide.asp?id=<%=rs("id")%>"><%if rs("view_yes")=1 then%>已显示<%else%><span style="color: #FF0000">未显示</span><% end if%></a></div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("time")%></div></td>
            <td class='<%=class_style%>' >
            <div align="center"><a href="index_lunbo_edit.asp?id=<%=rs("id")%>">修改</a> | <a href="index_lunbo_del.asp?id=<%=rs("id")%>">删除</a>            </div></td>
          </tr></form>
<%
rs.movenext
imagesNum=imagesNum+1
loop
else
response.write "<div align='center'><span style='color: #FF0000'>暂无链接！</span></div>"
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