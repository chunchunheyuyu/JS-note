<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!--#include file="inc/functions.asp"-->
<!--#include file="inc/page_next.asp"-->

<!-- 二级联动菜单 开始 -->
<script language="JavaScript">
<!--
<%
'二级数据保存到数组
Dim count2,rsClass2,sqlClass2
set rsClass2=server.createobject("adodb.recordset")
sqlClass2="select id,jhy_fd_dir_parentid,name from juhaoyong_tb_directory where jhy_fd_dir_parentid>0 and ClassType=2 order by id " 
rsClass2.open sqlClass2,cn,1,1
%>
var subval2 = new Array();
//数组结构：一级根值,二级根值,二级显示值
<%
count2 = 0
do while not rsClass2.eof
%>
subval2[<%=count2%>] = new Array('<%=rsClass2("jhy_fd_dir_parentid")%>','<%=rsClass2("id")%>','<%=rsClass2("name")%>')
<%
count2 = count2 + 1
rsClass2.movenext
loop
rsClass2.close
set rsClass2=nothing
%>

function JuhaoyongSelectTwoIdList(locationid)
{
    document.form1.twoid.length = 0;
    document.form1.twoid.options[0] = new Option('选择二级分类','');
    for (i=0; i<subval2.length; i++)
    {
        if (subval2[i][0] == locationid)
        {document.form1.twoid.options[document.form1.twoid.length] = new Option(subval2[i][2],subval2[i][1]);}
    }
}

//-->
</script><!-- 二级联动菜单 结束 -->
<%
dim act,keywords,oneid,twoid
dim rs,sql,sql_where
act=request.querystring("act")
keywords=trim(request("keywords"))

oneid=request("oneid")
twoid=request("twoid")

jhy_page_levelone_id=oneid
jhy_page_leveltwo_id=twoid

sql_where=""

if act="search" then
	if oneid="" and twoid&""="" then
		sql_where="where [title] like '%"&keywords&"%' and ArticleType=2"
	elseif oneid<>"" and twoid&""="" then
		sql_where="where jhy_fd_levelone_id='"&oneid&"' and [title] like '%"&keywords&"%' and ArticleType=2"
	else
		sql_where="where jhy_fd_levelone_id='"&oneid&"' and jhy_fd_leveltwo_id='"&twoid&"' and [title] like '%"&keywords&"%' and ArticleType=2"
	end if
else
	sql_where="where jhy_fd_levelone_id='"&oneid&"' and jhy_fd_leveltwo_id='"&twoid&"' and ArticleType=2"
end if

sql="select id,title,jhy_fd_levelone_id,jhy_fd_leveltwo_id,html_file_name,con_shichangjia,con_youhuijia,image,index_push,hit,ip,edit_time from juhaoyong_tb_content "&sql_where&" order by edit_time desc"
%>

<script language="javascript">

//全选JS
function unselectall(){
if(document.form2.chkAll.checked){
document.form2.chkAll.checked = document.form2.chkAll.checked&0;
}
}
function CheckAll(form){
for (var i=0;i<form.elements.length;i++){
var e = form.elements[i];
if (e.Name != 'chkAll'&&e.disabled==false)
e.checked = form.chkAll.checked;
}
}
</script>
<!-- #include file="inc/head.asp" -->
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">产品列表</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" class='TipTitle'>操作说明：</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords">
				<p>1、[荐]表示推荐到首页展示，推荐方法：编辑产品，在编辑框底部选“是”则可推荐到首页。</p>
				<p>2、添加、修改产品后，前台会自动生成静态。</p>
				<p>3、“未审核”状态，前台不显示。</p>
            </td>
          </tr>
        </table>

<ul class=HoutaiArticleDaohang><li>
<%if oneid<>"" then%>
&nbsp;<img src=images/juhaoyongdaohangjiantou.gif border="0" />　<a href="abjhy_product_list.asp?oneid=<%=oneid%>"><%=JuhaoyongGetLanmuName(oneid)%></a>
<%end if%>

<%if twoid<>"" then%>
>> <a href="abjhy_product_list.asp?oneid=<%=oneid%>&twoid=<%=twoid%>"><%=JuhaoyongGetLanmuName(twoid)%></a>
<%end if%>

</li></ul>

<%
if oneid&""<>"" and twoid&""="" then
Call JuhaoyongGetLowerFolderNameList(2,oneid)
end if
%>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25"><a href="abjhy_product_add.asp?oneid=<%=oneid%>&twoid=<%=twoid%>&act=<%=act%>">添加产品</a></td>
          </tr>
		</table>
		<table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <%if act<>"search" then%><td width="3%" height="30" class="TitleHighlight">&nbsp;</td><%end if%>
            <td width="4%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">编号</div></td>
            <td width="28%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">产品标题</div></td>
            <td width="8%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">推荐到首页</div></td>
            <td width="18%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">产品分类</div></td>
            <td width="5%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">市场价</div></td>
            <td width="5%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">优惠价</div></td>
            <td width="5%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">ip/pv</div></td>
            <td width="12%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">更新时间</div></td>
            <td width="8%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">产品操作</div></td>
          </tr>
<% '产品列表模块
strFileName="abjhy_product_list.asp" 
pageno=25
set rs = server.CreateObject("adodb.recordset")
rs.Open(sql),cn,1,1
rscount=rs.recordcount
if not rs.eof and not rs.bof then
call showsql(pageno)
rs.move(rsno)
for p_i=1 to loopno
%>

<% if p_i mod 2 =0 then
class_style="jhyabTabletdBgcolor02"
else
class_style="jhyabTabletdBgcolor01"
end if
%>

<%
'获取文件所在文件夹
if rs("jhy_fd_leveltwo_id")&""<>"" then
	strContentDirFolder=GetContentDirFolder(rs("jhy_fd_leveltwo_id"),2)
else
	strContentDirFolder=GetContentDirFolder(rs("jhy_fd_levelone_id"),1)
end if
%>
          <form name="form2" method="post" action="abjhy_product_del.asp?action=AllDel&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">
          <tr >
            <%if act<>"search" then%><td   height="30" class='<%=class_style%>'><div align="center"><input type="checkbox" name="Selectitem" id="Selectitem" value="<%=rs("id")%>"></div></td><%end if%>
            <td class='<%=class_style%>'><div align="center"><%=rs("id")%></div></td>
            <td class='<%=class_style%>'>&nbsp;<a href="<%=strContentDirFolder&"/"&rs("html_file_name")%>" title="<%=rs("title")%>" target="_blank"><%=left(rs("title"),26)%></a><%if rs("image")<>"" then%>&nbsp;[<span style="color: #FF0000">图</span>]<%end if%><%if rs("index_push")=1 then%>&nbsp;[<span style="color: #FF0000">荐</span>]<%end if%></td>
            <td class='<%=class_style%>'>
            	<div align="center">
				<%if rs("index_push")=1 then%>
				  <font color="#006600">[已推荐]</font> <a href="abjhy_product_index_push.asp?id=<%=rs("id")%>&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>"><font color="#666600" style="text-decoration:underline; font-weight:bold;">取消</font></a>
				<%else%>
				  <font color="#666666">[未推荐]</font> <a href="abjhy_product_index_push.asp?id=<%=rs("id")%>&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>"><font color="#ff0000" style="text-decoration:underline; font-weight:bold;">推荐</font></a>
				<%end if%>
                </div>
            </td>
            <td class='<%=class_style%>' >&nbsp;
			<% '分类显示
			set rs1=server.createobject("adodb.recordset")
			sql="select name from juhaoyong_tb_directory where id="&cint(rs("jhy_fd_levelone_id"))&""
			rs1.open(sql),cn,1,1
			if not rs1.eof and not rs1.bof then
			response.write rs1("name")
			response.write "&nbsp;>&nbsp;"
			end if
			rs1.close
			set rs1=nothing
			
			if rs("jhy_fd_leveltwo_id")<>"" then
			set rs1=server.createobject("adodb.recordset")
			sql="select name from juhaoyong_tb_directory where id="&cint(rs("jhy_fd_leveltwo_id"))&""
			rs1.open(sql),cn,1,1
			if not rs1.eof and not rs1.bof then
			response.write rs1("name")
			response.write "&nbsp;>&nbsp;"
			end if
			rs1.close
			set rs1=nothing
			end if
			
			%>
            </td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("con_shichangjia")%></div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("con_youhuijia")%></div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("ip")%>/<%=rs("hit")%></div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("edit_time")%></div></td>
            <td class='<%=class_style%>' >
            <div align="center"><a href="abjhy_product_edit.asp?id=<%=rs("id")%>&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">修改</a> | 
            					 <a href="abjhy_product_del.asp?id=<%=rs("id")%>&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">删除</a>
            </div>
            </td>
          </tr>
		  		  <%
		  rs.movenext
		  next
		  else
response.write "<div align='center'><span style='color: #FF0000'>暂无产品！</span></div>"
		  end if 
		  rs.close
		  set rs=nothing
		  %>
		  <%if act<>"search" then%>
          <tr>
		       <td height="35"  colspan="9" >&nbsp;
               <input name='chkAll' type='checkbox' id='chkAll' onclick='CheckAll(this.form)' value='checkbox'>全选/全不选&nbsp;
               <input type="submit" name="Submit" value="删除选中">
               </td>
          </tr>
          <%end if%>
		    <tr  >
              <td height="35"  colspan="9" ><div align="center">
                <%call showpage_AritcleProduct(strFileName,rscount,pageno,false,true,"",jhy_page_levelone_id,jhy_page_leveltwo_id)%>
           </div></td>
		    </tr>
      </table>
 </form>  
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="20" class="jhyabTabletdBgcolor02">&nbsp;</td>
          </tr>
          <tr>
            <td height="25" align="center"> 产品搜索</td>
          </tr>
          <tr>
            <td height="70"><form name="form1" method="post" action="?act=search">
              <div align="center"><%
Dim count1,rsClass1,sqlClass1
set rsClass1=server.createobject("adodb.recordset")
sqlClass1="select id,name from juhaoyong_tb_directory where jhy_fd_dir_parentid=0 and ClassType=2 order by id" 
rsClass1.open sqlClass1,cn,1,1
%>
            <select name="oneid" id="oneid" onChange="JuhaoyongSelectTwoIdList(this.value)">
              <option value="">选择一级分类</option>
              <%
count1 = 0
do while not rsClass1.eof
response.write"<option value="&rsClass1("id")&">"&rsClass1("name")&"</option>"
count1 = count1 + 1
rsClass1.movenext
loop
rsClass1.close
set rsClass1=nothing
%>
            </select>
            &nbsp;&nbsp;
            <select name="twoid" id="twoid">
              <option value="">选择二级分类</option>
            </select>&nbsp;
            
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