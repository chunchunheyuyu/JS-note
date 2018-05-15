<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/mp_functions.asp" -->

<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../inc/mp_rebuild_modify_template.asp" -->
<!-- #include file="../mp_generate_html/mp_createhtml_index.asp" -->

<!-- #include file="inc/head.asp" -->
<%
act=Request("act")
dim rs,sql
If act="save" Then 
	mp_fd_site_onoff=trim(request.form("mp_fd_site_onoff"))
	mp_fd_site_folder=trim(request.form("mp_fd_site_folder"))
	old_mp_fd_site_folder=trim(request.form("old_mp_fd_site_folder"))
	
	mp_fd_site_logo=trim(request.form("mp_fd_site_logo"))
	
	mp_fd_index_onoff4=trim(request.form("mp_fd_index_onoff4"))
	mp_fd_index_number1=trim(request.form("mp_fd_index_number1"))
	mp_fd_index_number2=trim(request.form("mp_fd_index_number2"))

	if mp_fd_index_number1="" then mp_fd_index_number1=0
	if mp_fd_index_number2="" then mp_fd_index_number2=0

	if IsNumeric(mp_fd_index_number1)=False then mp_fd_index_number1=0
	if IsNumeric(mp_fd_index_number2)=False then mp_fd_index_number2=0


	'检测文件夹名称是否为空
	if mp_fd_site_folder&""="" then
		response.Write JuhaoyongReturnHistoryPage("手机网站设置","文件夹名称不能为空")
		response.end
	'检测文件夹名称是否含有斜杠和空格
	elseif instr(mp_fd_site_folder,"/")>0 or instr(mp_fd_site_folder,"\")>0 or instr(mp_fd_site_folder," ")>0 then
		response.Write JuhaoyongReturnHistoryPage("手机网站设置","文件夹名称，不能包含空格和斜杠：/\，请重新命名")
		response.end
	'检测文件夹名是否与系统文件夹（网站根目录的文件夹）重名
	elseif mp_fd_site_folder<>old_mp_fd_site_folder and CheckRepeatSysFoldName(mp_fd_site_folder)=true then
		response.Write JuhaoyongReturnHistoryPage("手机网站设置","文件夹名称已存在，请重新命名")
		response.end
	else
		set rs=server.createobject("adodb.recordset")
		sql="select * from mp_juhaoyong_tb_siteconfig"
		rs.open(sql),cn,1,3
		old_mp_fd_site_onoff=rs("mp_fd_site_onoff")
		rs("mp_fd_site_onoff")=mp_fd_site_onoff
		rs("mp_fd_site_folder")=mp_fd_site_folder
		rs("mp_fd_site_logo")=mp_fd_site_logo
		rs("mp_fd_index_onoff4")=mp_fd_index_onoff4
		rs("mp_fd_index_number1")=mp_fd_index_number1
		rs("mp_fd_index_number2")=mp_fd_index_number2
		rs.update
		rs.close
		set rs=nothing
		
		'手机网站跳转开关控制
		if mp_fd_site_onoff&""<>old_mp_fd_site_onoff&"" then MP_modify_mpjs_onoff(mp_fd_site_onoff)
	
		'检测原（老的）文件夹是否存在，如果不存在则重新创建。
		call JuhaoyongFolderCreate("../"&old_mp_fd_site_folder)
		'如果新文件夹与原（老的）文件夹不同，则更名。
		if mp_fd_site_folder<>old_mp_fd_site_folder  then call JuhaoyongRenameFolder("../"&old_mp_fd_site_folder,mp_fd_site_folder)
		
		'生成模版开始
		call MP_RewriteTemplateFile(0,0)'生成首页模板
		'生成页面开始
		call MP_Run_createhtml_index(mp_fd_site_folder)'生成首页
		
		response.Write JuhaoyongResultPage("手机网站设置","修改成功","mp_jhy_index_config.asp")
		response.end
	end if
else
%>

<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from mp_juhaoyong_tb_siteconfig"
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
%>
  <form name="form1" method="post" action="?act=save">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">手机网站设置</th>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor02"><br>
	  
	  
	  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" class='TipTitle'>操作说明：</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords">
			<p>1、<font>修改文件夹名称后，请重新生成电脑版本所有静态，然后刷新前台页面查看效果。</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=all"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>点击这里，去生成电脑版所有静态</span></a></p>
			<p>2、<font>修改其他设置后，请重新生成手机网站所有静态，然后刷新前台页面查看效果。</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=mp"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>点击这里，去生成手机网站所有静态</span></a></p>
		  </td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	  <td class="jhyabTabletdBgcolor01">手机网站开关</td>
	  <td class="jhyabTabletdBgcolor01">
       <input type="radio" name="mp_fd_site_onoff" value="1"<%if rs("mp_fd_site_onoff")=1 then%> checked<%end if%>>是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" name="mp_fd_site_onoff" value="0"<%if rs("mp_fd_site_onoff")=0 then%> checked<%end if%>>否
      </td>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">手机网站文件夹名称</td>
	  <td class="jhyabTabletdBgcolor01" width="70%">
      <input type='text' name='mp_fd_site_folder' value="<%=rs("mp_fd_site_folder")%>" size='18' maxlength="15"> 请输入英文或数字名称，不要带特殊字符和斜杠，格式如：mp
      <input type="hidden" name="old_mp_fd_site_folder" value="<%=rs("mp_fd_site_folder")%>">
      </td>
	</tr>
    
    <tr>
	  <td style="background:#8aabca" width="100%" colspan="2" height="25">&nbsp;</td>
	</tr>



    <tr>
	  <td class="jhyabTabletdBgcolor01">手机网站 Logo 图片</td>
	  <td class="jhyabTabletdBgcolor01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			 <tr>
			   <td class="jhyabTabletdBgcolor02"><input name="mp_fd_site_logo" type="text" value="<%=rs("mp_fd_site_logo")%>"  size="30" readonly></td>
			   <td class="jhyabTabletdBgcolor02"><iframe width=700 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=5&uploadFileOldName=<%=rs("mp_fd_site_logo")%>&juhaoyongForm1InputName=mp_fd_site_logo"></iframe></td>
			 </tr>
		   </table>
	   图片类型：<font color="red">.jpg | .gif | .png</font> &nbsp;&nbsp;建议图片尺寸：<font color="red">640 * 132 </font>
	  </td>
    </tr>
    
    <tr>
	  <td style="background:#8aabca" width="100%" colspan="2" height="25">&nbsp;</td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01">首页是否显示“产品推荐”栏目</td>
	  <td class="jhyabTabletdBgcolor01">
       <input type="radio" name="mp_fd_index_onoff4" value="1" <%if rs("mp_fd_index_onoff4")=1 then%>checked<%end if%>>是&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" name="mp_fd_index_onoff4" value="0" <%if rs("mp_fd_index_onoff4")=0 then%>checked<%end if%>>否
	   &nbsp;&nbsp;&nbsp;&nbsp;（若选择“是”，则请到内容管理中推荐产品到首页，才可以显示该栏目）
      </td>
	</tr>
    
	<tr>
	  <td class="jhyabTabletdBgcolor01">首页-点击排行显示条数</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='mp_fd_index_number1' value="<%=rs("mp_fd_index_number1")%>" size='2' maxlength="2"><span style="color: #FF0000" > *</span>（请输入“0或正整数”,若为0则不显示该模块）</td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01">首页-最新资讯显示条数</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='mp_fd_index_number2' value="<%=rs("mp_fd_index_number2")%>" size='2' maxlength="2"><span style="color: #FF0000" > *</span>（请输入“0或正整数”,若为0则不显示该模块）</td>
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