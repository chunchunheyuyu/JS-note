<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">���ݿ�����ѹ��</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100"><div>
            <font color="#993300">����˵����Ϊȷ��Microsoft Access���ݿ��������ܣ�����Ӧ�ö��ڶ�Microsoft Access���ݿ����ѹ����ѹ�����ݿⲢ����ѹ�����ݣ�Access���ݿ�����ɸ�������ʱ�ᴴ����ʱ�����ض������������ϵͳ�����Զ����ոö�����ռ�õĴ��̿ռ䣬��Ҫͨ��ѹ��������</font>
			<br /><br />
			<font color="#339900">
			�ر����ѣ�<br />
			��1��Ϊ�˰�ȫ��ѹ��ǰ���ȱ��ݣ�ͨ��ftp�������ݿ⵽���ص��ԣ��ļ�λ�ã�Systemdata/systemdata.mdb����<br />
			��2����ִ��ѹ��ʱ�����Զ�����һ��ԭʼ���ݿ⣬�����˵��ġ����ݿ�-���߱��ݡ��п��Կ�����</font>
            <br /><br /><br />
			<center><a href="db_compact.asp"><font color="#FF0000" size="+1"><b>������￪ʼѹ�����ݿ�</b></font></a></center><br />
			<center><font color="#0000ff">����ܰ��ʾ��ѹ�������У�����������������������ݿ�ϴ󣬱ȽϺķ�ʱ�䣬�����ĵȴ�......��</font></center><br /><br />
			</div></td>
          </tr>
        </table>
	    </td>
	</tr>
	</table>

<%
Call DbconnEnd()
%>