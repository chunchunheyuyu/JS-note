<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">����ͼƬ���ļ�ɾ������</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100"><div align="center">
            <font color="#993300" size="+1">����˵�����ù��ܣ������������¡���Ʒ����ҳ�ġ����ݱ༭�����ϴ������Ѿ�û���õ���ͼƬ��flash����Ƶ���ļ���</font><br />
            <font color="#339900" size="+1">�����磺�ڱ༭�����в����ġ�����ɾ�����ݺ������ģ��������������������</font>
            <br /><br />
			<a href="no_use_file_list.asp"><font color="#FF0000" size="+1"><b>������￪ʼ���������ļ�</b></font></a><br /><br />
			<font color="#0000ff" size="+1">����ܰ��ʾ�����������ļ��ȽϺķ�ʱ�䣬�����ĵȴ�......��</font>
			</div></td>
          </tr>
        </table>
	    </td>
	</tr>
	</table>

<%
Call DbconnEnd()
%>