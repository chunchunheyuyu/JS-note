<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<title>��վ����</title>
</head>
<body>
<%
baktype=request.querystring("baktype")
%>
<div id="jhy_info_outside">
<br />
  <table width="90%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
	<tr>
      <td colspan="2">
	  <%if baktype=1 then%>
	  &nbsp;��վ����-ȫվ����
	  <%else%>
	  &nbsp;���ݿ�-���ر���
	  <%end if%>
	  </td>
    </tr> 
	<%if baktype=1 then%>
    <tr>
      <td class="left_title_2" width="18%">ȫվ����</td>
      <td width="82%">&nbsp;ͨ��FTP������ȫվ</td>
    </tr>
	<%else%>
    <tr>
      <td width="18%" class="left_title_1"><span class="left-title">���ݿ�-���ر���</span></td>
      <td width="82%">&nbsp;ͨ��FTP���������ݿ⣬���ݿ��ļ�λ�ã�Systemdata/systemdata.mdb</td>
    </tr>
	<%end if%>
  </table>

</div>
</body>
</html>
