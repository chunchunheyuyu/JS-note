<!-- #include file="network_security.asp" -->
<!-- #include file="conn.asp" -->
<!-- #include file="md5.asp" -->
<!-- #include file="html_clear.asp" -->

<%
'order save start
if request("act")="add" then
	order_product_id=request("id")
	bfolder=request.form("bfolder")
	cfolder=request.form("cfolder")
	html_file_name=request.form("html_file_name")
	
	if trim(cfolder&"")="" then
		htmlfileurl=bfolder&"/"&html_file_name
	else
		htmlfileurl=bfolder&"/"&cfolder&"/"&html_file_name
	end if
	
	name1=trim(request.form("name"))
	ordercount1=trim(request.form("ordercount"))
	address1=trim(request.form("address"))
	tel1=trim(request.form("tel"))
	email1=trim(request.form("email"))
	qq1=trim(request.form("qq"))
	comment=trim(request.form("content"))
	productName=trim(request.form("productName"))
	
	if order_product_id="" then
	response.Write "<script language='javascript'>alert('�Ƿ��ύ��');history.go(-1)</script>"
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
		' ��������
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
		response.write"<br><center>���Ķ������ύ�ɹ������ǽ����촦�����Ķ���^_^��лл��</center><br>"
		response.write"<center><a href='"&htmlfileurl&"'>�� ��</a></center>"
		response.write"<br><br><br>"
	end if
else
'order save end
%>

<!--order form start-->
<%
dim rs,sql,a_id,productName
a_id=request.querystring("id")
bfolder=request("bfolder")
cfolder=request("cfolder")
html_file_name=request("html_file_name")

set rs=server.createobject("adodb.recordset")
sql="select [title] from [juhaoyong_tb_content] where [id]="&a_id
rs.open(sql),cn,1,1
if not rs.eof then
productName=rs("title")
end if
rs.close 
set rs=nothing
%>

<div class="FeedBack">
<div class="commentbox">
<form id="form1" name="form1" method="post" action="?act=add&id=<%=a_id%>">
  <table id="commentform" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td align="right">������Ʒ��</td>
      <td><span class="OrderName"><%=productName%></span><input type='hidden' name='productName' value="<%=productName%>"></td>
    </tr>
    <tr>
      <td align="right">����������</td>
      <td><input name='ordercount' type='text' id='ordercount' size='10' maxlength="10" value='1'> <span class="FontRed">*</span></td>
    </tr>    
    <tr>
      <td align="right">��ϵ�ˣ�</td>
      <td><input name='name' type='text' id='name' size='15' maxlength="15"> <span class="FontRed">*</span></td>
    </tr>
    <tr>
      <td align="right">��ϵ��ַ��</td>
      <td><input name='address' type='text' id='address' size='30'> <span class="FontRed">*</span></td>
    </tr>
    <tr>
      <td align="right">�ֻ���</td>
      <td><input name='tel' type='text' id='tel' size='20'> <span class="FontRed">*</span></td>
    </tr>    
    <tr>
      <td align="right">Email��</td>
      <td><input name='email' type='text' id='email' size='20'></td>
    </tr>
    <tr>
      <td align="right">QQ��</td>
      <td><input name='qq' type='text' id='qq' size='20'></td>
    </tr>	
    <tr>
      <td align="right">��ע��</td>
      <td><textarea name="content" class='juhaoyongFormTitle' value="" ></textarea></td>
    </tr>
    <tr>
      <td align="right">��֤�룺</td>
      <td><input name="verycode"  maxLength=5 size=10 > <span class="FontRed">*</span> <img src="../inc/verification_code_image.asp" width="55"  onclick="this.src=this.src+'?'" alt="ͼƬ�����壿������µõ���֤��" style="cursor:hand;"></td>
    </tr>	
    <tr>
      <td>&nbsp;</td>
      <td>
      <input type='hidden' name='bfolder' value=<%=bfolder%>>
      <input type='hidden' name='cfolder' value=<%=cfolder%>>
      <input type='hidden' name='html_file_name' value=<%=html_file_name%>>
      <input class="Cbutton" type="submit" value=" �������� " onClick='javascript:return order_check()'>
      </td>
    </tr>
  </table>
</form>
</div>

</div>
<script type="text/javascript">
window.onerror=function(){return true;}
</script>
<!--order form end-->
<%end if%>