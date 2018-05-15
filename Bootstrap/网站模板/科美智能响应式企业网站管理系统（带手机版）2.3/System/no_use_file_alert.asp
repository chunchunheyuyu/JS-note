<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">废弃图片或文件删除清理</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100"><div align="center">
            <font color="#993300" size="+1">功能说明：该功能，是清理在文章、产品、或单页的“内容编辑框”中上传的且已经没有用到的图片、flash、视频和文件。</font><br />
            <font color="#339900" size="+1">（比如：在编辑过程中产生的、或者删除内容后遗留的，都可以在这里进行清理）</font>
            <br /><br />
			<a href="no_use_file_list.asp"><font color="#FF0000" size="+1"><b>点击这里开始搜索废弃文件</b></font></a><br /><br />
			<font color="#0000ff" size="+1">（温馨提示：搜索废弃文件比较耗费时间，请耐心等待......）</font>
			</div></td>
          </tr>
        </table>
	    </td>
	</tr>
	</table>

<%
Call DbconnEnd()
%>