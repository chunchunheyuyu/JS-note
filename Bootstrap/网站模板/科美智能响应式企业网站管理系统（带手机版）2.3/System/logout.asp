<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<%
Session.Abandon()
Response.Cookies("log_name").Expires= (now()-1) '删除Cookies，设置过期时间(-1天)
Response.Redirect "login.asp"
%>