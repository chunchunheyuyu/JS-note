<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->

<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="../inc/rebuild_modify_template.asp" -->

<!-- #include file="inc/head.asp" -->
<% '添加数据到数据表
article_id=cint(request.querystring("id"))

act1=Request("act1")
If act1="save" Then 
	l_id=trim(request.form("l_id"))
	l_name=trim(request.form("name"))
	l_url=trim(request.form("url"))
	l_image=trim(request.form("web_image"))
	l_order=trim(request.form("order"))
	l_view_yes=trim(request.form("view_yes"))
	l_time=now()
	
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_picture where id="&l_id&""
	rs.open(sql),cn,1,3
	rs("name")=l_name
	rs("url")=l_url
	rs("position")=1
	rs("image")=l_image
	if l_order<>"" then
	rs("order")=cint(l_order)
	end if
	rs("view_yes")=cint(l_view_yes)
	rs.update
	rs.close
	set rs=nothing
	
	'重新生成首页模板
	call RewriteTemplateFile(0,0)
	'生成首页
	call Run_createhtml_index()
	response.Write JuhaoyongResultPage("轮播图片修改","修改成功","index_lunbo_list.asp")
	response.end
else
%>
 
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_picture where id="&article_id&""
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then%>
	<form id="form1" name="form1" method="post" action="?act1=save&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">
	<script language='javascript'>
	function checksignup1() {
	if ( document.form1.name.value == '' ) {
	window.alert('请输入标题^_^');
	document.form1.name.focus();
	return false;}
	
	if ( document.form1.position.value == '' ) {
	window.alert('请选择位置^_^');
	document.form1.position.focus();
	return false;}
	
	if ( document.form1.ADtype.value == '' ) {
	window.alert('请选择类型^_^');
	document.form1.ADtype.focus();
	return false;}
	
	if(document.form1.ADWidth.value.search(/^([0-9]*)([.]?)([0-9]*)$/)   ==   -1)   
		  {   
	  window.alert("长度只能是数字^_^");   
	document.form1.ADWidth.focus();
	return false;}
	
	if(document.form1.ADHeight.value.search(/^([0-9]*)([.]?)([0-9]*)$/)   ==   -1)   
		  {   
	  window.alert("宽度只能是数字^_^");   
	document.form1.ADHeight.focus();
	return false;}
	
	if(document.form1.order.value.search(/^([0-9]*)([.]?)([0-9]*)$/)   ==   -1)   
		  {   
	  window.alert("排序只能是数字^_^");   
	document.form1.order.focus();
	return false;}
	
	return true;}
	</script>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">修改图片</th>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor02"><br />
	  
	  
	  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" class='TipTitle'>操作说明：</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords">
		  
		  	  <p>1、图片类型：.jpg &nbsp;&nbsp;图片尺寸：右键模版图片，“图片另存为...”或“背景另存为...”，把图片存到本地，鼠标放到图片文件上，即可看到尺寸</p>
              <p>2、上传的图片，尽量处理的小点，尽量控制在100K以内，图片太大会影响首页打开速度！</p>
		
		</td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table>
	  
	  
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">标题 (必填) </td>
	<td class="jhyabTabletdBgcolor01"><input name='name' type='text' id='name'  value="<%=rs("name")%>"size='70'>
	 <input name='l_id' type='hidden' id='l_id' value="<%=rs("id")%>" size='70'>
	  &nbsp;（也用于图片alt）</td>
	</tr>

	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>类型</td>
	    <td class="jhyabTabletdBgcolor01">图片</td>
      </tr>
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>链接地址</td>
	    <td class="jhyabTabletdBgcolor01"><input name='url' type='text' id='url' value="<%=rs("url")%>" size='70'>填写“站内链接”或者“站外链接”均可</td>
      </tr>

	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>上传图片 </td>
	    <td width="85%" class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%" ><input name="web_image" type="text" size="30" value="<%=rs("image")%>" readonly></td>
           <td width="78%"  ><iframe width=750 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=1&uploadFileOldName=<%=rs("image")%>&juhaoyongForm1InputName=web_image"></iframe></td>
         </tr>
       </table>
	   图片类型：<font color="red">.jpg</font> &nbsp;&nbsp;图片尺寸：<font color="red">右键模版图片，“图片另存为...”或“背景另存为...”，把图片存到本地，鼠标放到图片文件上，即可看到尺寸</font>
	   </td>
      </tr>


	<tr>
	    <td class="jhyabTabletdBgcolor01" height=23>排序</td>
	    <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor02">
	      <input name='order' type='text' id='order' value="<%=rs("order")%>" size='3' maxlength="3">
	    &nbsp;只能是数字，数字越小排序越靠前</span></td>
      </tr>
	  
	  <tr>
	  <td class="jhyabTabletdBgcolor01" height=23>是否显示</td>
	  <td class="jhyabTabletdBgcolor01">
	       <input type="radio" name="view_yes" value="1"<%
		if rs("view_yes")=1 then
		response.write "checked"
		end if%>>
      是
      &nbsp;
      <input name="view_yes" type="radio" value="0" <%if rs("view_yes")=0 then
		response.write "checked"
		end if%>>
      否</td>
	</tr>
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='提交' onClick='javascript:return checksignup1()' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
</form>
<%
	end if
	rs.close
	set rs=nothing
end if
%>
<%
Call DbconnEnd()
 %>