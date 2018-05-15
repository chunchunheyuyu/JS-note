<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>

<%
Dim errmsg

username=Request("username")
password=Request("password")
verifycode=Request("verifycode")

If username="" Or password="" Then 
	Response.Redirect "login.asp?errno=2"
	Response.End 
End If 

If verifycode="" Then 
	Response.Redirect "login.asp?errno=0"
	Response.End 
End If

if cstr(session("getcode"))<>cstr(trim(verifycode)) then
	Response.Redirect "login.asp?errno=0"
	Response.End 
end if

%>
<!-- #include file="inc/md5.asp" -->
<!-- #include file="inc/functions.asp" -->
<%
username=getSafeStr(username)
password=getSafeStr(password)
verifycode=getSafeStr(verifycode)
password_m=md5(password,16)
sql="select id,username,password,class from juhaoyong_tb_user where username='"&username&"' and password='"&password_m&"'"
response.Write sql
Set rs=cn.execute(sql)
If Not (rs.bof Or rs.eof) Then 
	session.Timeout=1000
	Session("log_name")=rs("username")
	Session("log_role")=rs("class")
	
	Response.Cookies("log_name")=rs("username")
	Response.Cookies("log_name").expires = DateAdd("h", 2, Now())'保留COOKIES两小时
	
	Response.Redirect "index.asp"
Else 
	Response.Redirect "login.asp?errno=1"
End If 

Call DBconnEnd()
%>