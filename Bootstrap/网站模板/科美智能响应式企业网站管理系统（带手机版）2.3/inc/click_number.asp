<!-- #include file="../inc/network_security.asp" -->
<!--#include file="../inc/conn.asp"  -->

<%
dim rs,sql,id1,view_id,hit
hit=0
id1=request.querystring("id")
set rs=server.createobject("adodb.recordset")
sql="select [id],[hit],[ip] from [juhaoyong_tb_content] where id="&id1&""
rs.open(sql),cn,1,3
if not rs.eof then
	hit=rs("hit")+1
	rs("hit")=hit
	view_id=request.cookies(cstr(rs("id")))
	if view_id&""="" then
		rs("ip")=rs("ip")+1
		response.cookies(cstr(rs("id")))=rs("id")
		response.cookies(cstr(rs("id"))).expires=date()+1 '设置cookie过期时间为：1天
	end if
	rs.update
end if
rs.close
set rs=nothing

cn.Close
Set cn = Nothing
%>
document.write(<%=hit%>)