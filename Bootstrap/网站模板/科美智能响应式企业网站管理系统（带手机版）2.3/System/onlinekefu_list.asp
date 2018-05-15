<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="inc/head.asp" -->
<%
'修改排序
action=request.querystring("action")
id=request.querystring("id")
kfshunxu=trim(request.form("kfshunxu"))
if action="edit" then
	if isnumeric(kfshunxu)=false then
		response.Write JuhaoyongReturnHistoryPage("在线客服排序","排序值必须为数字")
		response.end
	else
		set rs=server.createobject("adodb.recordset")
		sql="select kfshunxu from juhaoyong_tb_kefu where id="&id&""
		rs.open(sql),cn,1,3
		rs("kfshunxu")=cint(kfshunxu)
		rs.update
		rs.close
		set rs=nothing
		response.Write JuhaoyongResultPage("在线客服排序","修改成功","onlinekefu_list.asp")
		response.end
	end if
end if
%>

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">在线客服列表</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	
		 <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" class='TipTitle'>操作说明：</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords">
		    <p>1、点击修改，把在线客服代码替换为自己的，即可。</p>
			<p>2、<font color="#ff0000" size="+1"><b>在线客服代码获取方法：</b></font></p>
			<p><font color="#0066ff">（1）QQ在线代码生成网址：<a href="http://shang.qq.com/" target="_blank">http://shang.qq.com/</a>，打开后，点击“推广工具”进入。</font>另外，登录QQ，设置>>权限设置>>临时坏话，这里的“不接收任何临时回话消息”前面的勾去掉。</p>
			<p><font color="#ff0000">（2）旺旺在线代码生成网址：<a href="https://www.taobao.com/market/seller/aliclient/ww/wangbiantianxia.php" target="_blank">https://www.taobao.com/market/seller/aliclient/ww/wangbiantianxia.php</a>（必须是卖家版的旺旺，且在系统设置>>安全设置>>验证设置，选择“不用我验证就能加我为好友”）</font></p>
			<p>（3）其他在线代码，如：MSN、Skype等，请到官方生成代码。</p>
            <p>3、<font color="#009933" size="+1"><strong>增加、修改、删除在线客服后，请重新生成所有静态，然后到前台&nbsp;<font color="#FF0000">按F5刷新</font>&nbsp;查看效果。</strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=all"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>点击这里，去生成所有静态</span></a></p>
			<p>4、如果不想要在线客服，则删除所有，然后重新生成所有静态，就不会显示在线客服悬浮框了。</p>
			</td>
          </tr>
          <tr>
            <td height="10" ></td>
          </tr>
        </table>
		
	
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="30" width="120"> <a href="onlinekefu_add.asp">添加在线客服</a></td>
            <td height="30"> <a href="onlinekefu_add.asp?kftype=2wm">添加二维码图片</a></td>
          </tr>
		  <tr>
            <td height="10" ></td><td height="10" ></td>
          </tr>
      </table>
	   
	  
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="5%" height="30" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">编号</div></td>
            <td width="10%" height="30" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">类别</div></td>
            <td width="15%" height="30" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">名称</div></td>
            <td width="30%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">显示效果</div></td>
            <td width="20%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">显示排序</div></td>
            <td width="20%" bgcolor="#A5C6FC" class="TitleHighlight"><div align="center" style="font-weight: bold; color: #FFFFFF">操作</div></td>
          </tr>
<%
'在线客服列表模块
dim kefuNum
kefuNum=1
set rs = server.CreateObject("adodb.recordset")
s_sql="select * from juhaoyong_tb_kefu order by kfshunxu,id"
rs.Open (s_sql),cn,1,1
if not rs.eof and not rs.bof then
do while not rs.eof
if kefuNum mod 2 =0 then
class_style="jhyabTabletdBgcolor02"
else
class_style="jhyabTabletdBgcolor01"
end if%>
            <form name="form1" method="post" action="?action=edit&id=<%=rs("id")%>">
          <tr >
            <td height="40" class='<%=class_style%>'><div align="center"><%=rs("id")%></div></td>
            <td height="40" class='<%=class_style%>'><%if rs("kftype")=2 then%>二维码图片<%else%>在线客服<%end if%></td>
           <td class='<%=class_style%>' ><div align="center"><%=rs("name")%></div></td>
            <td class='<%=class_style%>' >
            <div align="center">
            <%if rs("kftype")=2 then%>
			<img src="../css/<%=SITE_STYLE_CSS_FOLDER%>/<%=rs("image")%>" width="115" boder="0">
            <%else%>
            <%=rs("memo")%>
            <%end if%>
            </div>
            </td>
            <td class='<%=class_style%>' > <div align="center">
            <input name="kfshunxu" type="text" value="<%=rs("kfshunxu")%>" size="3" maxlength="3">
            <input type="submit" name="submit" value="修改排序">
           </div></td>
            <td class='<%=class_style%>' >
            <div align="center"><a href="onlinekefu_edit.asp?id=<%=rs("id")%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">修改</a> | <a href="onlinekefu_del.asp?id=<%=rs("id")%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">删除</a>            </div></td>
          </tr></form>
<%
rs.movenext
kefuNum=kefuNum+1
loop
else
	response.write "<div align='center'><span style='color: #FF0000'>暂无数据！</span></div>"
end if 
rs.close
set rs=nothing
%>
      </table>
	    <br></td>
	</tr>
	</table><br /><br /><br /><br />

<%
Call DbconnEnd()
 %>