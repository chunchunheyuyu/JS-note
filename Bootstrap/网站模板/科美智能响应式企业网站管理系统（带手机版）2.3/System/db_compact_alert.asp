<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">数据库在线压缩</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100"><div>
            <font color="#993300">功能说明：为确保Microsoft Access数据库的最佳性能，我们应该定期对Microsoft Access数据库进行压缩。压缩数据库并不是压缩数据，Access数据库在完成各种任务时会创建临时的隐藏对象，任务结束后系统不会自动回收该对象所占用的磁盘空间，需要通过压缩来清理。</font>
			<br /><br />
			<font color="#339900">
			特别提醒：<br />
			（1）为了安全，压缩前请先备份：通过ftp下载数据库到本地电脑（文件位置：Systemdata/systemdata.mdb）。<br />
			（2）在执行压缩时，会自动备份一次原始数据库，到左侧菜单的“数据库-在线备份”中可以看到，</font>
            <br /><br /><br />
			<center><a href="db_compact.asp"><font color="#FF0000" size="+1"><b>点击这里开始压缩数据库</b></font></a></center><br />
			<center><font color="#0000ff">（温馨提示：压缩过程中，请勿做其他操作，如果数据库较大，比较耗费时间，请耐心等待......）</font></center><br /><br />
			</div></td>
          </tr>
        </table>
	    </td>
	</tr>
	</table>

<%
Call DbconnEnd()
%>