<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/mp_functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../inc/function_common_html_create.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="../generate_html/createhtml_article_content.asp" -->
<!-- #include file="../generate_html/createhtml_article_product_list.asp" -->
<!-- #include file="inc/head.asp" -->

<%
dim mp_site_foldername
mp_site_foldername=MP_Get_mp_site_foldername()'获取手机网站目录名称
%>

<%
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")
article_id=cint(request.querystring("id"))

oneid=request.QueryString("oneid")
twoid=request.QueryString("twoid")

'获取栏目id
oneid=request.QueryString("oneid")
twoid=request.QueryString("twoid")

act1=Request("act1")
If act1="save" Then
	a_id=cint(request.form("a_id"))
	a_title=request.form("a_title")
	a_levelone_id=trim(request.form("oneid"))
	a_leveltwo_id=trim(request.form("twoid"))
	a_image=trim(request.form("web_image"))
	a_jhy_fd_fujian=trim(request.form("jhy_fd_fujian"))
	a_html_file_name=trim(request.form("html_file_name"))
	a_keywords=trim(request.form("a_keywords"))
	a_description=trim(request.form("a_description"))
	a_content=request.form("a_content")
	if a_leveltwo_id&""<>"" then
	a_content=replace(a_content,"../images/","../../images/")
	end if
	a_hit=trim(request.form("a_hit"))
	a_index_push=trim(request.form("a_index_push"))
	juhaoyongEditTime=trim(request.form("juhaoyongEditTime"))
	if juhaoyongEditTime="" then juhaoyongEditTime="2016-10-08 12:18:18"
	
	'检测标题不能为空
	if a_title&""="" then
		response.Write JuhaoyongReturnHistoryPage("文章类型内容修改","标题不能为空")
		response.end
	'检测是否选择分类
	elseif a_levelone_id&""="" then
		response.Write JuhaoyongReturnHistoryPage("文章类型内容修改","没有选择分类")
		response.end
	'检测html文件名不能为空
	elseif a_html_file_name&""="" then
		response.Write JuhaoyongReturnHistoryPage("文章类型内容修改","文件名称不能为空")
		response.end
	'检测html文件名不能重复
	elseif CheckRepeatHtmlFileName(a_html_file_name,a_levelone_id,a_leveltwo_id,a_id)=true then
		response.Write JuhaoyongReturnHistoryPage("文章类型内容修改","文件名称已经存在，请重命名")
		response.end
	'检测时间格式是否正确
	elseif IsDate(juhaoyongEditTime)=False then
		response.Write JuhaoyongReturnHistoryPage("文章类型内容修改","时间格式不正确")
		response.end
	else
		'修改文章
		dim rs,sql
		dim old_a_levelone_id,old_a_leveltwo_id,old_file_name
		set rs=server.createobject("adodb.recordset")
		sql="select * from [juhaoyong_tb_content] where id="&a_id&""
		rs.open(sql),cn,1,3
		old_a_levelone_id=rs("jhy_fd_levelone_id")
		old_a_leveltwo_id=rs("jhy_fd_leveltwo_id")
		old_file_name=rs("html_file_name")
		old_juhaoyongEditTime=rs("edit_time")
		old_a_jhy_fd_fujian=rs("jhy_fd_fujian")
		
		rs("title")=a_title
		rs("ArticleType")=1
		rs("jhy_fd_levelone_id")=a_levelone_id
		rs("jhy_fd_leveltwo_id")=a_leveltwo_id
		rs("image")=a_image
		rs("jhy_fd_fujian")=a_jhy_fd_fujian
		rs("html_file_name")=a_html_file_name
		rs("keywords")=a_keywords
		rs("description")=a_description
		rs("content")=a_content
		rs("hit")=a_hit
		rs("index_push")=a_index_push
		rs("edit_time")=CDate(juhaoyongEditTime)
		rs.update
		rs.close
		set rs=nothing
		
		'如果编辑时间变更，则重新生成老时间和新时间的上一页和下一页（维护上一页、下一页完整性）
		if juhaoyongEditTime&""<>old_juhaoyongEditTime&"" then
			ReCreatehtmlArticlePreNext(old_juhaoyongEditTime)'重新生成前一篇、后一篇
			ReCreatehtmlArticlePreNext(juhaoyongEditTime)'重新生成前一篇、后一篇
		end if
	
		'如果文章栏目变更，或者文件名变更，则删除原来栏目中的旧文件
		if old_a_levelone_id<>a_levelone_id or old_a_leveltwo_id<>a_leveltwo_id or a_html_file_name<>old_file_name then
			dim oldFilePath
			oldFilePath=GetFileFolderPath(old_a_levelone_id,old_a_leveltwo_id)&"/"&old_file_name
			mp_oldFilePath=Mp_GetFileFolderPath(old_a_levelone_id,old_a_leveltwo_id,mp_site_foldername)&"/"&old_file_name '手机版文件路径
			JuhaoyongDeleteFile(oldFilePath)'删除静态html文件
			JuhaoyongDeleteFile(mp_oldFilePath)'删除静态html文件（手机版）
		end if
		
		'如果附件框清空，则删除原来的附件文件
		if trim(a_jhy_fd_fujian&"")="" and trim(old_a_jhy_fd_fujian&"")<>"" then
			JuhaoyongDeleteFile("../upAttachFile/"&old_a_jhy_fd_fujian)'删除附件文件
		end if
		
		'生成当前被修改的该单篇文章
		call Run_createhtml_article_content(a_id)
		
		'生成首页
		call Run_createhtml_index()
		
		'生成老（原来）分类列表
		call Run_createhtml_article_product_list(1,old_a_levelone_id)
		call Run_createhtml_article_product_list(1,old_a_leveltwo_id)
		'如果分类有变化则生成新分类列表
		if a_levelone_id<>old_a_levelone_id then
			call Run_createhtml_article_product_list(1,a_levelone_id)
		end if
		if a_leveltwo_id<>old_a_leveltwo_id then
			call Run_createhtml_article_product_list(1,a_leveltwo_id)
		end if
	
		response.Write JuhaoyongResultPage("文章类型内容修改","修改成功","abjhy_article_list.asp?oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	end if
else
%>
  	<script charset="utf-8" src="hao8editor/kindeditor.js"></script>
	<script charset="utf-8" src="hao8editor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="hao8editor/editor.js"></script>

	<!-- 二级联动菜单 开始 -->
	<script language="JavaScript">
	<!--
	<%
	'二级数据保存到数组
	Dim count2,rsc2,sqlClass2
	set rsc2=server.createobject("adodb.recordset")
	sqlClass2="select id,jhy_fd_dir_parentid,name from juhaoyong_tb_directory where jhy_fd_dir_parentid>0 and ClassType=1 order by [order],time " 
	rsc2.open sqlClass2,cn,1,1
	%>
	var subval2 = new Array();
	//数组结构：一级根值,二级根值,二级显示值
	<%
	count2 = 0
	do while not rsc2.eof
	%>
	subval2[<%=count2%>] = new Array('<%=rsc2("jhy_fd_dir_parentid")%>','<%=rsc2("id")%>','<%=rsc2("name")%>')
	<%
	count2 = count2 + 1
	rsc2.movenext
	loop
	rsc2.close
	set rsc2=nothing
	%>
	
	function JuhaoyongSelectTwoIdList(locationid)
	{
		document.form1.twoid.length = 0;
		document.form1.twoid.options[0] = new Option('选择二级分类','');
		for (i=0; i<subval2.length; i++)
		{
			if (subval2[i][0] == locationid)
			{document.form1.twoid.options[document.form1.twoid.length] = new Option(subval2[i][2],subval2[i][1]);}
		}
	}
	
	//-->
	</script>
	<!-- 二级联动菜单 结束 -->

	<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from [juhaoyong_tb_content] where id="&article_id
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
	%>
	<form id="form1" name="form1" method="post" action="?act1=save&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">修改文章</th>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor02"><br>
	  
	  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" class='TipTitle'>操作说明：</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords">
          <p>1、通过调整更新时间（在编辑框最下面），可以调整显示顺序。</p>
          <p>2、删除该文章原有附件方法：清空文章附件框，然后保存，则系统会自动删除该文章原来的附件文件。</p>
            </td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table>
	  
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">文章标题 (必填) </td>
	<td class="jhyabTabletdBgcolor01"><input name="a_title" type="text" value="<%=rs("title")%>" size="70" maxlength="200">
	<input name="a_id" type="hidden" value="<%=rs("id")%>"></td>
	</tr>
    
    <tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">生成文件的名称 (必填) </td>
	<td class="jhyabTabletdBgcolor01"><input name="html_file_name" type="text" size="36" value="<%=rs("html_file_name")%>">&nbsp;请用英文字母或数字命名，格式如：abc.html（不要带特殊字符和空格）</td>
	</tr>
    
	<tr>
	<td class="jhyabTabletdBgcolor01" height=23>文章分类(必选)</td>
    <td class="jhyabTabletdBgcolor01">
			<%
			set rsc1=server.createobject("adodb.recordset")
			sqlClass1="select id,name from juhaoyong_tb_directory where jhy_fd_dir_parentid=0 and ClassType=1 order by [order],time" 
			rsc1.open sqlClass1,cn,1,1
			%>
            <select name="oneid" id="oneid" onChange="JuhaoyongSelectTwoIdList(this.value)">
			<% '输出一级分类，并选定当前分类
			do while not rsc1.eof
			%>
            <option value="<%=rsc1("id")%>" <%if cint(rs("jhy_fd_levelone_id"))=rsc1("id") then%> selected<%end if%>><%=rsc1("name")%></option>
			<%
			rsc1.movenext
			loop
			rsc1.close
			set rsc1=nothing
			%>
            </select>
            &nbsp;&nbsp;
	
            <select name="twoid" id="twoid">
            <option value="">选择二级分类</option>
			<%'输出二级分类，并选定当前分类			
			set rsc2=server.createobject("adodb.recordset")
			sqlClass2="select id,name from juhaoyong_tb_directory where ClassType=1 and jhy_fd_dir_parentid="&cint(rs("jhy_fd_levelone_id"))&" order by [order],time" 
			rsc2.open sqlClass2,cn,1,1
			do while not rsc2.eof%>
            <option value="<%=rsc2("ID")%>" <%if rs("jhy_fd_leveltwo_id")&""=rsc2("id")&"" then%> selected<%end if%>><%=rsc2("name")%></option>
			<%
			rsc2.movenext
			loop
			rsc2.close
			set rsc2=nothing
			%>
            </select>
       </td>
	</tr>
	  
	<tr>
        <td  class="jhyabTabletdBgcolor01" height=23>文章关键字</td>
	      <td class="jhyabTabletdBgcolor01"><input type='text' id='v3' name='a_keywords'  value="<%=rs("keywords")%>" size='100' maxlength="200">&nbsp;多个关键词，请以半角英文逗号","分割</td>
	</tr><tr>
	  <td class="jhyabTabletdBgcolor01" height=11>文章描述</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='a_description'  cols="100" rows="4" id="a_description" ><%=rs("description")%></textarea></td>
	</tr>
	
	<tr>
	    <td class="jhyabTabletdBgcolor01" height=50>文章附件</td>
	    <td width="85%" class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="25%"><input name="jhy_fd_fujian" type="text" id="jhy_fd_fujian"  value="<%=rs("jhy_fd_fujian")%>" size="30"></td>
           <td width="75%"><iframe width=725 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=3&uploadFileOldName=<%=rs("jhy_fd_fujian")%>"></iframe></td>
         </tr>
       </table></td>
    </tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>内容</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name="a_content" style=" width:100%; height:400px; visibility:hidden;"><%=replace(rs("content"),"../../images/","../images/")%></textarea>
	</td>
	</tr>
	
    <tr>
	  <td class="jhyabTabletdBgcolor01" height=23>首页置顶</td>
	  <td class="jhyabTabletdBgcolor01">
	    <input type="radio" name="a_index_push" value="1" 
		<%if rs("index_push")=1 then
		response.write "checked"
		end if%>>
      是
      &nbsp;
        <input type="radio" name="a_index_push" value="0" 
		<%if rs("index_push")=0 then
		response.write "checked"
		end if%>>
      否</td>
	</tr>
    
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>文章浏览次数</td>
	  <td class="jhyabTabletdBgcolor01"><input name='a_hit' type='text' id='a_hit' value="<%=rs("hit")%>" size='40'>&nbsp;只能是数字</td>
	  </tr>

	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>更新时间</td>
	  <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor01">
	    <input name="juhaoyongEditTime" type="text" value="<%=GetFormatTime(rs("edit_time"))%>" size="30"></span>　<strong><font color="#FF0000">*注意保持原有时间格式*格式必须如：2018-8-8 9:09:09</font>（通过调整时间，可以调整前台显示顺序，时间越大越靠前）</strong>
	  </td>
	</tr>
	    
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='提交' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form><br /><br /><br />
<%
	end if
	rs.close
	set rs=nothing
end if
%>
<%
Call DbconnEnd()
 %>