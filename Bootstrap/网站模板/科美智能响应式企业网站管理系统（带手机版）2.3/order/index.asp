<!-- #include file="../inc/network_security.asp" -->
<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../inc/html_clear.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<title></title>
<link href="../css/<%=SITE_STYLE_CSS_FOLDER%>/common.css" rel="stylesheet" type="text/css" />
<link href="../css/<%=SITE_STYLE_CSS_FOLDER%>/inside_page_css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../css/<%=SITE_STYLE_CSS_FOLDER%>/functions.js"></script>
</head>
<body>
<%
dim rs,sql,a_id,productName
a_id=request.querystring("id")
set rs=server.createobject("adodb.recordset")
sql="select [title] from [juhaoyong_tb_content] where [id]="&a_id
rs.open(sql),cn,1,1
if not rs.eof then
productName=rs("title")
end if
rs.close 
set rs=nothing
%>
<!--FeedBack start-->
<div class="FeedBack">
<div class="commentbox">
<form id="form1" name="form1" method="post" action="../inc/order.asp?act=add&id=<%=a_id%>">
  <table id="commentform" width="600" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td>订购产品：</td>
      <td><span class="OrderName"><%=productName%></span><input type='hidden' name='productName' value="<%=productName%>"></td>
    </tr>
    <tr>
      <td>订购数量：</td>
      <td><input name='ordercount' type='text' id='ordercount' size='10' maxlength="10" value='1'> <span class="FontRed">*</span></td>
    </tr>    
    <tr>
      <td>联系人：</td>
      <td><input name='name' type='text' id='name' size='15' maxlength="15"> <span class="FontRed">*</span></td>
    </tr>
    <tr>
      <td>联系地址：</td>
      <td><input name='address' type='text' id='address' size='52' maxlength="52"> <span class="FontRed">*</span></td>
    </tr>
    <tr>
      <td>手机：</td>
      <td><input name='tel' type='text' id='tel' size='30' maxlength="30"> <span class="FontRed">*</span></td>
    </tr>    
    <tr>
      <td>Email：</td>
      <td><input name='email' type='text' id='email' size='30' maxlength="30"></td>
    </tr>
    <tr>
      <td>QQ：</td>
      <td><input name='qq' type='text' id='qq' size='30' maxlength="30"></td>
    </tr>	
    <tr>
      <td>备注：</td>
      <td>
        <textarea name="content" cols="50" rows="5"  value="" ></textarea>
           </td>    </tr>
    <tr>
      <td>验证码：</td>
      <td><input name="verycode"  maxLength=5 size=10 > <span class="FontRed">*</span> <img src="../inc/verification_code_image.asp" width="55"  onclick="this.src=this.src+'?'" alt="图片看不清？点击重新得到验证码" style="cursor:hand;"></td>
    </tr>	
    <tr>
      <td>&nbsp;</td>
      <td><input class="Cbutton" type="submit" value=" 立即订购 " onClick='javascript:return order_check()'></td>
    </tr>
  </table>
</form>
</div>

</div>
<!--FeedBack end-->


<script type="text/javascript">
window.onerror=function(){return true;}
</script>

</body>
</html>