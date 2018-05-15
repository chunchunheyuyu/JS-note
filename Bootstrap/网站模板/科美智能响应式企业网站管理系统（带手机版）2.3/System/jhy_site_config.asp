<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->

<!-- #include file="inc/head.asp" -->
<%
act=Request("act")
If act="save" Then 
	jhy_fd_site_name=trim(request.form("jhy_fd_site_name"))
	jhy_fd_site_domain=trim(request.form("jhy_fd_site_domain"))
	jhy_fd_site_logo=trim(request.form("jhy_fd_site_logo"))
	jhy_fd_site_bottomhtml=trim(request.form("jhy_fd_site_bottomhtml"))
	jhy_fd_phonenumber=trim(request.form("jhy_fd_phonenumber"))
	jhy_fd_phonetitle=trim(request.form("jhy_fd_phonetitle"))
	
	jhy_fd_title_channelnameonoff=trim(request.form("jhy_fd_title_channelnameonoff"))
	if jhy_fd_title_channelnameonoff&""="" then jhy_fd_title_channelnameonoff=0
	
	jhy_fd_title_sitenameonoff=trim(request.form("jhy_fd_title_sitenameonoff"))
	if jhy_fd_title_sitenameonoff&""="" then jhy_fd_title_sitenameonoff=0
	
	jhy_fd_topsearchdisplay=trim(request.form("jhy_fd_topsearchdisplay"))
	if jhy_fd_topsearchdisplay&""="" then jhy_fd_topsearchdisplay=0
	
	jhy_fd_hot_product=trim(request.form("jhy_fd_hot_product"))
	
	jhy_fd_side_newestnumber=trim(request.form("jhy_fd_side_newestnumber"))
	jhy_fd_side_hotnumber=trim(request.form("jhy_fd_side_hotnumber"))
	
	if jhy_fd_side_newestnumber="" then jhy_fd_side_newestnumber=0
	if jhy_fd_side_hotnumber="" then jhy_fd_side_hotnumber=0
	
	if IsNumeric(jhy_fd_side_newestnumber)=False then jhy_fd_side_newestnumber=10
	if IsNumeric(jhy_fd_side_hotnumber)=False then jhy_fd_side_hotnumber=10
	
	if jhy_fd_side_newestnumber<0 then jhy_fd_side_newestnumber=0
	if jhy_fd_side_hotnumber<0 then jhy_fd_side_hotnumber=0
	
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_siteconfig"
	rs.open(sql),cn,1,3
	rs("jhy_fd_site_name")=jhy_fd_site_name
	rs("jhy_fd_site_domain")=jhy_fd_site_domain
	rs("jhy_fd_site_logo")=jhy_fd_site_logo
	rs("jhy_fd_site_bottomhtml")=jhy_fd_site_bottomhtml
	rs("jhy_fd_phonenumber")=jhy_fd_phonenumber
	rs("jhy_fd_phonetitle")=jhy_fd_phonetitle
	rs("jhy_fd_title_channelnameonoff")=jhy_fd_title_channelnameonoff
	rs("jhy_fd_title_sitenameonoff")=jhy_fd_title_sitenameonoff
	rs("jhy_fd_topsearchdisplay")=jhy_fd_topsearchdisplay
	rs("jhy_fd_hot_product")=jhy_fd_hot_product
	rs("jhy_fd_side_newestnumber")=jhy_fd_side_newestnumber
	rs("jhy_fd_side_hotnumber")=jhy_fd_side_hotnumber
	rs.update
	rs.close
	set rs=nothing
	
	response.Write JuhaoyongResultPage("网站基本设置","修改成功","jhy_site_config.asp")
	response.end
else
%>
 
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_siteconfig"
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
%>
  <form name="form1" method="post" action="?act=save">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">网站基本设置</th>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor02"><br>
	  
	  
	  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" class='TipTitle'>操作说明：</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords">
			<p>1、<font size="+1"><strong>修改设置后，请重新生成所有静态，然后到前台&nbsp;<font color="#FF0000">按F5刷新</font>&nbsp;查看效果。</strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=all"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>点击这里，去生成所有静态</span></a></p>
		  </td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table>
	  
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">网站名称</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input name="jhy_fd_site_name" type="text" value="<%=rs("jhy_fd_site_name")%>" size="60" maxlength="100"></td>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>网站网址</td>
	  <td class="jhyabTabletdBgcolor01"><input name="jhy_fd_site_domain" type="text" value="<%=rs("jhy_fd_site_domain")%>" size="60"> 
 		 &nbsp;格式如：<a href="http://www.baidu.com" target="_blank">www.baidu.com</a></td>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor01">网站标志(logo)</td>
	  <td class="jhyabTabletdBgcolor01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			 <tr>
			   <td class="jhyabTabletdBgcolor02"><input name="jhy_fd_site_logo" type="text" value="<%=rs("jhy_fd_site_logo")%>"  size="30" readonly></td>
			   <td class="jhyabTabletdBgcolor02"><iframe width=700 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=1&uploadFileOldName=<%=rs("jhy_fd_site_logo")%>&juhaoyongForm1InputName=jhy_fd_site_logo"></iframe></td>
			 </tr>
		   </table>
	   图片类型：<font color="red">.jpg | .gif | .png</font> &nbsp;&nbsp;图片尺寸：<font color="red">右键模版图片，“图片另存为...”或“背景另存为...”，把图片存到本地，鼠标放到图片文件上，即可看到尺寸</font>
	  </td>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor01">网站底部 HTML代码</td>
	  <td class="jhyabTabletdBgcolor01"> <textarea name="jhy_fd_site_bottomhtml" cols="100" rows="10"><%=rs("jhy_fd_site_bottomhtml")%></textarea></td>
	</tr>	
	<tr>
	  <td class="jhyabTabletdBgcolor01">页面顶部联系电话</td>
	  <td class="jhyabTabletdBgcolor01">
      电话标题：<input type="text" name="jhy_fd_phonetitle"  value="<%=rs("jhy_fd_phonetitle")%>" size='40' maxlength="35"> &nbsp;&nbsp;&nbsp;&nbsp;
      电话号码：<input type="text" name="jhy_fd_phonenumber"  value="<%=rs("jhy_fd_phonenumber")%>" size='40' maxlength="35">
	  </td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" style="background-color:#92cafd">SEO：内页title是否显示 频道名称</td>
	  <td class="jhyabTabletdBgcolor01" style="background-color:#92cafd">
       <input type="radio" name="jhy_fd_title_channelnameonoff" value="1"<%if rs("jhy_fd_title_channelnameonoff")=1 then%> checked<%end if%>>是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" name="jhy_fd_title_channelnameonoff" value="0"<%if rs("jhy_fd_title_channelnameonoff")=0 then%> checked<%end if%>>否
	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#cc3300" style="font-weight:bold">【请勿频繁修改此项，以免影响搜索引擎优化（SEO）效果】</font>
      </td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" style="background-color:#92cafd">SEO：内页title是否显示 网站名称</td>
	  <td class="jhyabTabletdBgcolor01" style="background-color:#92cafd">
       <input type="radio" name="jhy_fd_title_sitenameonoff" value="1"<%if rs("jhy_fd_title_sitenameonoff")=1 then%> checked<%end if%>>是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" name="jhy_fd_title_sitenameonoff" value="0"<%if rs("jhy_fd_title_sitenameonoff")=0 then%> checked<%end if%>>否
	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#cc3300" style="font-weight:bold">【请勿频繁修改此项，以免影响搜索引擎优化（SEO）效果】</font>
      </td>
	</tr>
	
    <tr>
	  <td class="jhyabTabletdBgcolor01">是否显示 顶部搜索框</td>
	  <td class="jhyabTabletdBgcolor01">
       <input type="radio" name="jhy_fd_topsearchdisplay" value="1" <%if rs("jhy_fd_topsearchdisplay")=1 then%>checked<%end if%>>是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" name="jhy_fd_topsearchdisplay" value="0" <%if rs("jhy_fd_topsearchdisplay")=0 then%>checked<%end if%>>否
      </td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">点击排行名称</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input name="jhy_fd_hot_product" type="text" value="<%=rs("jhy_fd_hot_product")%>" size="20" maxlength="50"></td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01">侧边栏最新资讯显示条数</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='jhy_fd_side_newestnumber' value="<%=rs("jhy_fd_side_newestnumber")%>" size='2' maxlength="2"><span style="color: #FF0000" > *</span>（请输入“0或正整数”,若为0则不显示该模块）</td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01">侧边栏点击排行显示条数</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='jhy_fd_side_hotnumber' value="<%=rs("jhy_fd_side_hotnumber")%>" size='2' maxlength="2"><span style="color: #FF0000" > *</span>（请输入“0或正整数”,若为0则不显示该模块）</td>
	</tr>
	
	<tr>
	<td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center"><INPUT type=submit value='提交' name=Submit></div></td>
	</tr>
	</table></td></tr></table>
</form><br /><br /><br /><br />

<%
	else
		response.write "暂时无数据"
	end if
	rs.close
	set rs=nothing
end if
Call DbconnEnd()
%>