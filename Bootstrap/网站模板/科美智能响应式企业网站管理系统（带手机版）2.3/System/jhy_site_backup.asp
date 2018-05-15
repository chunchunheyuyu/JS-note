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
<title>网站备份</title>
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
	  &nbsp;网站备份-全站备份
	  <%else%>
	  &nbsp;数据库-下载备份
	  <%end if%>
	  </td>
    </tr> 
	<%if baktype=1 then%>
    <tr>
      <td class="left_title_2" width="18%">全站备份</td>
      <td width="82%">&nbsp;通过FTP，下载全站</td>
    </tr>
	<%else%>
    <tr>
      <td width="18%" class="left_title_1"><span class="left-title">数据库-下载备份</span></td>
      <td width="82%">&nbsp;通过FTP，下载数据库，数据库文件位置：Systemdata/systemdata.mdb</td>
    </tr>
	<%end if%>
  </table>

</div>
</body>
</html>
