<%
If trim(Session("log_name")&"")="" and trim(Request.Cookies("log_name")&"")="" Then
response.redirect "login.asp"	
End If
%>