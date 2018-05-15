<!-- #include file="network_security.asp" -->
<!-- #include file="conn.asp" -->
<!-- #include file="md5.asp" -->
<!-- #include file="html_clear.asp" -->

<%
'判断
if request("act")="add" then
	order_product_id=request("id")
	name1=trim(request.form("name"))
	ordercount1=trim(request.form("ordercount"))
	address1=trim(request.form("address"))
	tel1=trim(request.form("tel"))
	email1=trim(request.form("email"))
	qq1=trim(request.form("qq"))
	comment=trim(request.form("content"))
	productName=trim(request.form("productName"))
	
	if order_product_id="" then
	response.Write "<script language='javascript'>alert('非法提交！');history.go(-1)</script>"
		Response.End 
	elseif request("verycode")="" then
		response.write "<script language=javascript>alert('您输入的验证码有误，或者是您的浏览器禁止了cookie，请开启接受cookie再试^_^');history.go(-1);</script>"
		Response.End 
	elseif session("getcode")="" then
		response.write "<script language=javascript>alert('您输入的验证码有误，或者是您的浏览器禁止了cookie，请开启接受cookie再试^_^');history.go(-1);</script>"
		Response.End 
	elseif cstr(session("getcode"))<>cstr(trim(request("verycode"))) then
		response.write "<script language=javascript>alert('您输入的验证码有误，或者是您的浏览器禁止了cookie，请开启接受cookie再试^_^');history.go(-1);</script>"
		Response.End
	else
		' 发布评论
		set rs=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_order"
		rs.open(sql),cn,1,3
		
		rs.addnew
		if order_product_id<>"" then
		rs("order_product_id")=order_product_id
		end if
		
		rs("name")=nohtml(name1)
		rs("ordercount")=nohtml(ordercount1)
		rs("address")=nohtml(address1)
		rs("tel")=nohtml(tel1)
		rs("email")=nohtml(email1)
		rs("qq")=nohtml(qq1)
		rs("order_product_name")=productName
		rs("content")=nohtml(comment)
		rs("ip")=Request.serverVariables("REMOTE_ADDR")
		rs("time")=now()
		rs("view_yes")=0
		rs.update
		rs.close
		set rs=nothing
		cn.Close
		Set cn = Nothing
		response.write"<br><center>您的订单已提交成功，我们将尽快处理您的订单，您可以关闭该窗口了^_^，谢谢！</center>"
	end if
end if
%>