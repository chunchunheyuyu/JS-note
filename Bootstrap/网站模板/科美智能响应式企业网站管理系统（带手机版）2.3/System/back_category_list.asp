<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<%
'栏目文件夹获取
MainClass_FolderName=".."
%>

<SCRIPT language=javascript>
<!--
function class_show(meval)
{
  var left_n=eval(meval);
  if (left_n.style.display=="none")
  { eval(meval+".style.display='';"); }
  else
  { eval(meval+".style.display='none';"); }
}
-->
</SCRIPT>
<style>
.TitleHighlight2{
	color:#CCC;}
	
.TitleHighlight2 a{
	color:#FFF;
	font-weight:bold;
	text-decoration:none;}
	
.TitleHighlight3 a{
	text-decoration:none;}
	
.contenttable a:hover{
	color:#FF0000;
	text-decoration:underline;}

.TitleHighlight4 a{
	text-decoration:none;}
</style>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">管理栏目</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
		  
          <tr>
            <td height="25" class='TipTitle'>操作说明：</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords">
              <p>1、<font color="#000000" size="+1"><strong>“添加”</strong></font>产品或文章，请点击<font color="#03d8d8" size="+1"><strong>“栏目下内容管理”</strong></font>，<b>“单页”</b>类型栏目，点击<b>“栏目设置”</b>修改内容，<font color="#009900"><strong>点击 <img src="images/tree_folder1.gif">&nbsp;&nbsp;可展开下级栏目。</strong></font></p>
			  <p>2、<font color="#0099ff"><strong>推荐到首页的栏目，是按照序号大小排序，序号小的在前</strong></font></p>
              <p>3、<font color="#FF0000">特别提醒：</font>增加、修改、删除“栏目”后，请到“导航管理”中修改对应的导航，并重新生成所有静态，然后到前台<font color="#339900">&nbsp;<b>按F5刷新</b>&nbsp;</font>查看效果。&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=all"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>点击这里，去生成所有静态</span></a></p>
			  <br />
			  </td>
          </tr>
        </table>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="10">&nbsp;</td>
          </tr>
		  <tr>
            <td height="25"><a href="back_category_add_select_type.asp?dirparentid=0&juhaoyongClassType=0">添加一级栏目</a></td>
          </tr>
      </table>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" class="contenttable">
          <tr>
            <td width="8%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">点击开合</div></td>
            <td width="12%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">栏目名称</div></td>
			<td width="11%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">文件夹名称</div></td>
            <td width="11%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">栏目下内容管理</div></td>
			<td width="6%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">栏目类别</div></td>
			<td width="7%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">栏目级别</div></td>
			<td width="9%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">推荐为首页栏目</div></td>
            <td width="8%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">添加下级栏目</div></td>
			<td width="8%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">栏目设置</div></td>
            <td width="6%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">栏目排序</div></td>
			<td width="9%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">栏目删除</div></td>
			
          </tr>
<%'输出一级栏目
set rs=server.createobject("adodb.recordset")
sql="select id,name,folder,ClassType,index_push,[order] from juhaoyong_tb_directory where jhy_fd_dir_parentid=0 order by [order],time"
rs.open(sql),cn,1,1
rscount=rs.recordcount
if not rs.eof and not rs.bof then
for p_i=1 to rscount

	class_front_view_url="../"&rs("folder")

	select case rs("ClassType")
	case 1
		class_type_name="文章"
		ListName="abjhy_article_list.asp"
	case 2
		class_type_name="产品"
		ListName="abjhy_product_list.asp"
	case 3
		class_type_name="单页"
		ListName="#"
	end select
%>
          <tr >
            <td class="TitleHighlight2" onClick="javascript:class_show('class_<%=rs("id")%>');" style="cursor:pointer;" height="30"><div align="center"><img src="images/tree_folder1.gif">点击开合</div></td>
            <td class="TitleHighlight2" onClick="javascript:class_show('class_<%=rs("id")%>');"><a href="<%=class_front_view_url%>" target="_blank"><%=rs("name")%></a></td>
            <td class="TitleHighlight2" onClick="javascript:class_show('class_<%=rs("id")%>');"><%=rs("folder")%></td>
            
			<td class="TitleHighlight2" align="center">
			<%if rs("ClassType")=3 then%>
				---
			<%else%>
				<a href="<%=ListName%>?oneid=<%=rs("id")%>"><font color="#99ff00">栏目下内容管理</font></a>
			<%end if%>
			</td>
			
			<td class="TitleHighlight2" onClick="javascript:class_show('class_<%=rs("id")%>');"><div align="center"><%=class_type_name%></div></td>
			
			<td class="TitleHighlight2" onClick="javascript:class_show('class_<%=rs("id")%>');" align="center">
			<%if rs("ClassType")=3 then%>
				一级单页
			<%else%>
				一级栏目
			<%end if%>
			</td>
			
			<td class="TitleHighlight2" align="center">
            <%if rs("ClassType")=1 or rs("ClassType")=2 then%>
				  <%if rs("index_push")=1 then%>
				  <font color="#ffffff">[已推荐]</font> <a href="back_category_index_push.asp?id=<%=rs("id")%>"><font color="#ffff00" style="text-decoration:underline; font-weight:bold;">取消</font></a>
				  <%else%>
				  <font color="#000000">[未推荐]</font> <a href="back_category_index_push.asp?id=<%=rs("id")%>"><font color="#901b1b" style="text-decoration:underline; font-weight:bold;">推荐</font></a>
				  <%end if%>
			<%else%>
            ---
            <%end if%>
            </td>
            
			<td class="TitleHighlight2" align="center">
			<%
			dim categoryAddFileName,categoryAddClassType
			if rs("ClassType")=1 then
				categoryAddFileName="back_category_add_select_type.asp"
			else
				categoryAddFileName="back_category_add.asp"
			end if
			
			if rs("ClassType")=3 then
				categoryAddClassType=3
			else
				categoryAddClassType=rs("ClassType")
			end if
			%>
            <a href="<%=categoryAddFileName%>?dirparentid=<%=rs("id")%>&pClassName=<%=rs("name")%>&juhaoyongClassType=<%=categoryAddClassType%>">
			<%if rs("ClassType")=3 then%>
				添加二级单页
			<%else%>
				添加二级栏目
			<%end if%>
			</a>
			
			</td>
			<td class="TitleHighlight2" align="center">
			<a href="back_category_edit.asp?id=<%=rs("id")%>&dirparentid=0">栏目设置</a>
			</td>
			<td class="TitleHighlight2" align="center" onClick="javascript:class_show('class_<%=rs("id")%>');"><%=rs("order")%></td>
			<td class="TitleHighlight2" align="center"><a href="back_category_del.asp?id=<%=rs("id")%>">删除栏目</a></td>
          </tr>
		    <tr id="class_<%=rs("id")%>" style="DISPLAY: none">
            <td height="35"  colspan="12">
			
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
<%'输出二级栏目
set rs2=server.createobject("adodb.recordset")
sql="select id,name,folder,index_push,ClassType,[order],jhy_fd_dir_parentid from juhaoyong_tb_directory where jhy_fd_dir_parentid="&rs("id")&" order by [order],time"
rs2.open(sql),cn,1,1
if not rs2.eof and not rs2.bof then
do while not rs2.eof
	
	class_front_view_url="../"&rs("folder")&"/"&rs2("folder")
	if rs2("ClassType")=3 then class_front_view_url=class_front_view_url&".html"
	
	select case rs2("ClassType")
	case 1
		class_type_name="文章"
		ListName="abjhy_article_list.asp"
	case 2
		class_type_name="产品"
		ListName="abjhy_product_list.asp"
	case 3
		class_type_name="单页"
		ListName="#"
	end select	  
%>
			<tr>
			
			<td width="8%" height="27" class="TitleHighlight3"> </td>
           	<td width="12%" class="TitleHighlight3"><a href="<%=class_front_view_url%>" target="_blank"><%=rs2("name")%></a></td>
			<td width="11%" class="TitleHighlight3"><%=rs2("folder")%></td>
			<td width="11%" class="TitleHighlight3" align="center">
			  <%if rs2("ClassType")=3 then%>
			  ---
			  <%else%>
			  <a href="<%=ListName%>?oneid=<%=rs("id")%>&twoid=<%=rs2("id")%>"><strong><font color="#003399">栏目下内容管理</font></strong></a>
			  <%end if%>
			</td>
			
			<td width="6%" class="TitleHighlight3"><div align="center"><%=class_type_name%></div></td>
			
			<td width="7%" class="TitleHighlight3" align="center">
			<%if rs2("ClassType")=3 then%>
			二级单页
			<%else%>
			二级栏目
			<%end if%>
			</td>
			
			<td width="9%" class="TitleHighlight3" align="center">
              <%if rs2("ClassType")=1 or rs2("ClassType")=2 then%>
				  <%if rs2("index_push")=1 then%>
				  <font color="#ffffff">[已推荐]</font> <a href="back_category_index_push.asp?id=<%=rs2("id")%>"><font color="#666600" style="text-decoration:underline; font-weight:bold;">取消</font></a>
				  <%else%>
				  <font color="#000000">[未推荐]</font> <a href="back_category_index_push.asp?id=<%=rs2("id")%>"><font color="#336600" style="text-decoration:underline; font-weight:bold;">推荐</font></a>
				  <%end if%>
			  <%else%>
			  ---
			  <%end if%>
			  </td>
			
			  <td width="8%" class="TitleHighlight3" align="center">---</td>
			  <td width="8%" class="TitleHighlight3" align="center">
			  <a href="back_category_edit.asp?id=<%=rs2("id")%>&pClassName=<%=rs("name")%>&dirparentid=<%=rs2("jhy_fd_dir_parentid")%>">
				<%if rs2("ClassType")=3 then%>
				修改单页
				<%else%>
				栏目设置
				<%end if%>
			  </a>
			  </td>
			  <td width="6%" class="TitleHighlight3" align="center"><%=rs2("order")%></td>
			  <td width="9%" class="TitleHighlight3" align="center"><a href="back_category_del.asp?id=<%=rs2("id")%>">删除栏目</a></td>
			  </tr>
<%
rs2.movenext
loop 
else
response.write "<div align='center'><span style='color: #FF0000'>无下级栏目！</span></div>"
end if 

rs2.close
set rs2=nothing
%>
</table> </td>
          </tr>

<%
rs.movenext
next
else
response.write "<div align='center'><span style='color: #FF0000'>暂无数据！</span></div>"
end if
		  
rs.close
set rs=nothing
%>
		  		    <tr  >
              <td height="35"  colspan="5" >共 <%=rscount%>个 一级栏目</td>
		    </tr>
      </table>
	    <br></td>
	</tr>
	</table><br /><br /><br /><br />

<%
Call DbconnEnd()
 %>