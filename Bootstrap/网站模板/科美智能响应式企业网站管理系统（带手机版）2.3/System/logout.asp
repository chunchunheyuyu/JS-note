<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<%
Session.Abandon()
Response.Cookies("log_name").Expires= (now()-1) 'ɾ��Cookies�����ù���ʱ��(-1��)
Response.Redirect "login.asp"
%>