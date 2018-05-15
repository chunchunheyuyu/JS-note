<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!--#include file="inc/functions.asp"-->
<!--#include file="inc/page_next.asp"-->
<% '搜索模块
act=request.querystring("act")
keywords=trim(request.form("keywords"))

s_sql="select * from juhaoyong_tb_guestbook  where [name] like '%"&keywords&"%' or [content] like '%"&keywords&"%' order by time desc"

%>

<script type="text/javascript">
var divDisplayNumber = 0;
function show(id){
divDisplayNumber=divDisplayNumber+1;
var o = document.getElementById(id);
o.style.zIndex = divDisplayNumber;
o.style.display = "block";
}

function closeed(id){
var o = document.getElementById(id);
if(o.style.display == "block"){
o.style.display = "none";
}
}
</script>

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
	  <th class="tableHeaderText">留言列表</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	<form name="form2" method="post" action="Message_Del.asp?action=AllDel&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="4%" height="30" class="TitleHighlight"><div align="center"></div></td>
            <td width="7%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">编号</div></td>
			<td width="8%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">是否回复</div></td>
            <td width="20%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">留言人</div></td>
            <td width="24%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">留言内容</div></td>
            <td width="8%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">显示/隐藏</div></td>
            <td width="16%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">留言时间</div></td>
            <td width="13%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">留言操作</div></td>
          </tr>
<% '文章列表模块
strFileName="message_list.asp" 
pageno=100
set rs = server.CreateObject("adodb.recordset")
rs.Open (s_sql),cn,1,1
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
end if%>
          <tr >
            <td   height="30" class='<%=class_style%>'><div align="center"><input type="checkbox" name="Selectitem" id="Selectitem" value="<%=rs("id")%>"></div></td>
            <td   height="30" class='<%=class_style%>'><div align="center"><%=rs("id")%></div></td>
			<td class='<%=class_style%>' align="center"><%if rs("recontent")<>"" then%>&nbsp;已回复<%else%>&nbsp;<span style="color: #FF0000">未回复</span><% end if%></td>
            <td class='<%=class_style%>' >&nbsp;<%=left(rs("name"),20)%></td>
            <td class='<%=class_style%>' >&nbsp;<%=left(rs("content"),15)%>...</td>
            <td class='<%=class_style%>' ><div align="center"><a href="message_show_hide.asp?id=<%=rs("id")%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>"><%if rs("view_yes")=1 then%>已显示<%else%><span style="color: #FF0000">已隐藏</span><% end if%></a></div></td>
            <td class='<%=class_style%>' ><div align="center"><%=rs("time")%></div></td>
			<td class='<%=class_style%>' >
            <div align="center"><a  href="#"   onclick = "show('fd_<%=rs("id")%>');return false;">查看</a> | <a href="message_reply.asp?id=<%=rs("id")%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">回复</a> | <a href="message_del.asp?id=<%=rs("id")%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">删除</a></div>
			
<div class="fd" id="fd_<%=rs("id")%>" style="display:none;filter:alpha(opacity=100);opacity:1;">
<div class="content_div1"><div class="div_close"><a href="#"  onclick = "closeed('fd_<%=rs("id")%>');return false;">[关闭]</a></div>

<table width="680" border="0" align="center" cellpadding="0" cellspacing="2">

  <tr>
    <td class="jhyabTabletdBgcolor01"  height="25" ><span style="font-weight: bold">留言人</span></td>
    <td class="jhyabTabletdBgcolor01" >&nbsp;<%=rs("name")%>&nbsp;(留言时间：<%=rs("time")%>)</td>
  </tr>

  <tr>
    <td class="jhyabTabletdBgcolor01"  height="25" ><span style="font-weight: bold">电子邮件</span></td>
    <td class="jhyabTabletdBgcolor01" >&nbsp;<%=rs("email")%></td>
  </tr>
   <tr>
    <td class="jhyabTabletdBgcolor01"  height="25"><span style="font-weight: bold">QQ</span></td>
    <td class="jhyabTabletdBgcolor01" >&nbsp;<%=rs("qq")%></td>
  </tr> 
    <tr>
    <td class="jhyabTabletdBgcolor02">&nbsp;</td>
    <td class="jhyabTabletdBgcolor02"></td>
  </tr>
  <tr>
    <td valign="top"><span style="font-weight: bold">留言内容</span></td>
    <td valign="top">
<div class="PostContent"><%=rs("content")%></div>
	</td>
  </tr>
    <tr>
    <td class="jhyabTabletdBgcolor02"  >&nbsp;</td>
    <td class="jhyabTabletdBgcolor02"></td>
  </tr>
  <tr>
    <td  valign="top" class="jhyabTabletdBgcolor01" height="25"><span style="font-weight: bold">回复内容</span></td>
    <td  valign="top" class="jhyabTabletdBgcolor01"><%if rs("recontent")<>"" then%>
<div class="PostReply"><%=rs("recontent")%></div>
<%else%>
<span style='color: #FF0000'>暂无回复！</span>&nbsp;&nbsp;<a href="message_reply.asp?id=<%=rs("id")%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">立即回复>>></a>
<%end if%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table></div> 
</div>		</td>
          </tr>
		  
		  		  <%
		  rs.movenext
		  next
		  else
response.write "<div align='center'><span style='color: #FF0000'>暂无留言！</span></div>"
		  end if 
		  rs.close
		  set rs=nothing
		  %>
		          <tr  >
		            <td height="35"  colspan="9" >&nbsp;<input name='chkAll' type='checkbox' id='chkAll' onclick='CheckAll(this.form)' value='checkbox'>
                    全选/全不选&nbsp;<input type="submit" name="Submit" value="删除选中"></td>
          </tr>
		    <tr  >
              <td height="35"  colspan="7" ><div align="center">
                <%call showpage(strFileName,rscount,pageno,false,true,"")%>
           </div></td>
		    </tr>
      </table></form>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="20" class="jhyabTabletdBgcolor02">&nbsp;</td>
          </tr>
          <tr>
            <td height="25" align="center"> 留言搜索</td>
          </tr>
          <tr>
            <td height="70"><form name="form1" method="post" action="?act=search">
              <div align="center">
            <input name="keywords" type="text"  size="35" maxlength="40">
            &nbsp;<input type="submit" name="Submit" value="搜 索">
              </div>
            </form></td>
          </tr>
        </table>
	    <br></td>
	</tr>
	</table><br /><br /><br /><br />

<%
Call DbconnEnd()
 %>