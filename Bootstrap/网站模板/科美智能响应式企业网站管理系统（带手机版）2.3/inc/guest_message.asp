<!-- #include file="network_security.asp" -->
<!-- #include file="conn.asp" -->
<!-- #include file="md5.asp" -->
<!-- #include file="html_clear.asp" -->
<!-- #include file="mp_functions.asp" -->
<%
article_id=request("id")
name1=trim(request.form("name"))
email1=trim(request.form("email"))
qq1=trim(request.form("qq"))
comment=trim(request.form("content"))
input_code=trim(request.form("verycode"))
url1=trim(request.form("homepage"))
image1=trim(request.form("img"))
comefrom=trim(request.form("comefrom"))

dim mp_site_foldername
mp_site_foldername=MP_Get_mp_site_foldername()'��ȡ�ֻ���վĿ¼����

if comment="" then
	response.Write "<script language='javascript'>alert('���������ݣ�');history.go(-1)</script>"
	Response.End 
elseif request("verycode")="" then
	response.write "<script language=javascript>alert('���������֤�����󣬻����������������ֹ��cookie���뿪������cookie����^_^');history.go(-1);</script>"
	Response.End 
elseif session("getcode")="" then
	response.write "<script language=javascript>alert('���������֤�����󣬻����������������ֹ��cookie���뿪������cookie����^_^');history.go(-1);</script>"
	Response.End 
elseif cstr(session("getcode"))<>cstr(trim(request("verycode"))) then
	response.write "<script language=javascript>alert('���������֤�����󣬻����������������ֹ��cookie���뿪������cookie����^_^');history.go(-1);</script>"
	Response.End 
else	
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_guestbook where [content]='"&nohtml(comment)&"'"
	rs.open(sql),cn,1,3
	if not rs.eof then  
		response.Write "<script language='javascript'>alert('�벻Ҫ�ظ����ԣ�лл');history.go(-1)</script>"
	else
		rs.addnew
		rs("name")=nohtml(name1)
		rs("email")=nohtml(email1)
		rs("qq")=nohtml(qq1)
		rs("url")=nohtml(url1)
		rs("content")=nohtml(comment)
		rs("ip")=Request.serverVariables("REMOTE_ADDR")
		rs("time")=now()
		rs("view_yes")=0
		rs.update
		
		response.write"<SCRIPT language=JavaScript>alert('���������Ѿ�����ɹ�,лл^_^');"
	end if
	
	rs.close
	Set rs=nothing
	
	cn.Close
	Set cn = Nothing
	
	if comefrom="mp" then
		response.write"location.href='../"&mp_site_foldername&"/guestmessage/';"
	else
		response.write"location.href='../guestmessage/';"
	end if
	response.write"</SCRIPT>"
	
end if
%>
