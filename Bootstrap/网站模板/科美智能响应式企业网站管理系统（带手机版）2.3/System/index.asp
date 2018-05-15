<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<title>后台管理</title>
</head>
<frameset rows="50,*" cols="*" frameborder="no" border="0" framespacing="0">
		<frame src="topframe.asp" name="topFrame" frameborder="no" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
		<frameset name="myFrame" cols="199,*" frameborder="no" border="0" framespacing="0">
				<frame src="leftframe.asp" name="leftFrame" frameborder="no" scrolling="No" noresize="noresize" id="leftFrame" title="leftFrame" />
				<frameset rows="35,*" cols="*" frameborder="no" border="0" framespacing="0">
					<frame src="mainframe.asp" name="mainFrame" frameborder="no" scrolling="No"  noresize="noresize" id="mainFrame" title="mainFrame" />
					<frame src="version.asp" name="manFrame" frameborder="no" id="manFrame" title="manFrame" />
				</frameset>
		</frameset>
</frameset><noframes></noframes>
</html>
