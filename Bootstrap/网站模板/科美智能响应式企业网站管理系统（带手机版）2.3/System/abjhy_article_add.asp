<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/rand.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../inc/function_common_html_create.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="../generate_html/createhtml_article_content.asp" -->
<!-- #include file="../generate_html/createhtml_article_product_list.asp" -->

<!-- #include file="inc/head.asp" -->
<%
act=Request.QueryString("act")
oneid=request.QueryString("oneid")
twoid=request.QueryString("twoid")

dim act
'添加数据到数据表
act1=Request.QueryString("act1")
If act1="save" and request.form("oneid")<>"" Then
	a_title=trim(request.form("a_title"))
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
		response.Write JuhaoyongReturnHistoryPage("添加文章类型内容","标题不能为空")
		response.end
	'检测是否选择分类
	elseif a_levelone_id&""="" then
		response.Write JuhaoyongReturnHistoryPage("添加文章类型内容","没有选择分类")
		response.end
	'检测html文件名不能为空
	elseif a_html_file_name&""="" then
		response.Write JuhaoyongReturnHistoryPage("添加文章类型内容","文件名称不能为空")
		response.end
	'检测html文件名不能重复
	elseif CheckRepeatHtmlFileName(a_html_file_name,a_levelone_id,a_leveltwo_id,0)=true then
		response.Write JuhaoyongReturnHistoryPage("添加文章类型内容","文件名称已经存在，请重命名")
		response.end
	'检测时间格式是否正确
	elseif IsDate(juhaoyongEditTime)=False then
		response.Write JuhaoyongReturnHistoryPage("添加文章类型内容","时间格式不正确")
		response.end
	else
		'增加文章
		dim rs,sql
		set rs=server.createobject("adodb.recordset")
		sql="select * from juhaoyong_tb_content"
		rs.open(sql),cn,1,3
		rs.addnew
		rs("title")=a_title
		rs("ArticleType")=1
		rs("jhy_fd_levelone_id")=a_levelone_id
		rs("jhy_fd_leveltwo_id")=a_leveltwo_id
		rs("image")=a_image
		rs("jhy_fd_fujian")=a_jhy_fd_fujian
		rs("keywords")=a_keywords
		rs("description")=a_description
		rs("content")=a_content
		rs("hit")=a_hit
		rs("index_push")=a_index_push
		rs("edit_time")=CDate(juhaoyongEditTime)
		rs("html_file_name")=a_html_file_name
		rs.update
		rs.close
		set rs=nothing
		
		'重新生成新增该文章的时间的上一页和下一页（维护上一页、下一页完整性）
		call ReCreatehtmlArticlePreNext(juhaoyongEditTime)'重新生成前一篇、后一篇
		
		'获取新增加文章id
		dim rs2
		set rs2=server.createobject("adodb.recordset")
		sql="select top 1 [id] from [juhaoyong_tb_content] where [title]='"&a_title&"' and ArticleType=1 order by id desc"
		rs2.open(sql),cn,1,1
		if not rs2.eof  then
			a_id=rs2("id")
		end if
		rs2.close
		set rs2=nothing
	
		'生成新增加的文章
		call Run_createhtml_article_content(a_id)
		
		'生成首页
		call Run_createhtml_index()
		
		'生成产品所在分类列表
		call Run_createhtml_article_product_list(1,a_levelone_id)
		call Run_createhtml_article_product_list(1,a_leveltwo_id)
		%>
		
		<%
		response.Write JuhaoyongResultPage("添加文章类型内容","添加成功","abjhy_article_list.asp?oneid="&oneid&"&twoid="&twoid&"&act="&act)
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
	Dim count2,rsClass2,sqlClass2
	set rsClass2=server.createobject("adodb.recordset")
	sqlClass2="select id,jhy_fd_dir_parentid,name from juhaoyong_tb_directory where jhy_fd_dir_parentid>0 and ClassType=1 order by [order],time"
	rsClass2.open sqlClass2,cn,1,1
	%>
	var subval2 = new Array();
	//数组结构：一级根值,二级根值,二级显示值
	<%
	count2 = 0
	do while not rsClass2.eof
	%>
		subval2[<%=count2%>] = new Array('<%=rsClass2("jhy_fd_dir_parentid")%>','<%=rsClass2("id")%>','<%=rsClass2("name")%>')
	<%
	count2 = count2 + 1
	rsClass2.movenext
	loop
	rsClass2.close
	set rsClass2=nothing
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
	oneid_name=juhaoyongGetCategoryName(oneid)
	twoid_name=juhaoyongGetCategoryName(twoid)
	%>
	<form id="form1" name="form1" method="post" action="?act1=save&oneid=<%=oneid%>&twoid=<%=twoid%>&act=<%=act%>">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">添加文章</th>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor02"><br>
	  
	  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr><td height="25" class='TipTitle'>操作说明：</td></tr>
        <tr><td height="30" valign="top" class="TipWords"><p>1、通过调整更新时间（在编辑框最下面），可以调整显示顺序。</p></td></tr>
        <tr><td height="10">&nbsp;</td></tr>
      </table>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	
	<tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">文章标题 (必填) </td>
	<td class="jhyabTabletdBgcolor01"><input name="a_title" type="text" size="70" maxlength="200"></td>
	</tr>
	
    <tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">生成文件的名称 (必填) </td>
	<td class="jhyabTabletdBgcolor01"><input name="html_file_name" type="text" size="36" value="<%=juhaoyongRndNumber&hour(now)&minute(now)&second(now)&".html"%>">&nbsp;请用英文字母或数字命名，格式如：abc.html（不要带特殊字符和空格，默认是系统生成的随机数字名称，可修改）</td>
	</tr>
    
	<tr>
	<td class="jhyabTabletdBgcolor01" height=23>文章分类(必选)</td>
    <td class="jhyabTabletdBgcolor01">
	<%
	Dim count1,rsClass1,sqlClass1
	set rsClass1=server.createobject("adodb.recordset")
	sqlClass1="select id,name from juhaoyong_tb_directory where jhy_fd_dir_parentid=0 and ClassType=1 order by [order],time"
	rsClass1.open sqlClass1,cn,1,1
	%>
				<select name="oneid" id="oneid" onChange="JuhaoyongSelectTwoIdList(this.value)">
	
	<%
	count1 = 0
	do while not rsClass1.eof
	
		if rsClass1("id")&""=oneid then
		response.write"<option value="&rsClass1("id")&" selected>"&rsClass1("name")&"</option>"
		else
		response.write"<option value="&rsClass1("id")&">"&rsClass1("Name")&"</option>"
		end if
	
	count1 = count1 + 1
	rsClass1.movenext
	loop
	rsClass1.close
	set rsClass1=nothing
	%>
            </select>
            &nbsp;&nbsp;
            
            <select name="twoid" id="twoid">
            <option value="">选择二级分类</option>
			<%'输出二级分类，并选定当前分类			
			set rsc2=server.createobject("adodb.recordset")
			sqlClass2="select id,name from juhaoyong_tb_directory where ClassType=1 and jhy_fd_dir_parentid="&oneid&" order by [order],time" 
			rsc2.open sqlClass2,cn,1,1
			do while not rsc2.eof%>
            <option value="<%=rsc2("ID")%>" <%if rsc2("id")&""=twoid&"" then%> selected<%end if%>><%=rsc2("name")%></option>
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
	    <td class="jhyabTabletdBgcolor01"><input type="text" name="a_keywords" size="100" maxlength="200">&nbsp;多个关键词，请以半角英文逗号","分割</td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=11>文章描述</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name="a_description"  cols="100" rows="4"></textarea></td>
	</tr>
	
	<tr>
	    <td class="jhyabTabletdBgcolor01" height=50>文章附件</td>
	    <td width="85%" class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="25%" ><input name="jhy_fd_fujian" type="text" id="jhy_fd_fujian"  size="30"></td>
           <td width="75%"  ><iframe width=725 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=3"></iframe></td>
         </tr>
       </table></td>
    </tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>内容</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name="a_content" style=" width:100%; height:400px; visibility:hidden;"></textarea></td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>文章浏览次数</td>
	  <td class="jhyabTabletdBgcolor01"><input name='a_hit' type='text' value="0" size='40'>&nbsp;只能是数字</td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01" height=23>首页置顶</td>
	  <td class="jhyabTabletdBgcolor01"><input type="radio" name="a_index_push" value="1">是&nbsp;<input name="a_index_push" type="radio" value="0" checked>否</td>
	</tr>
    
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>更新时间</td>
	  <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor01">
	    <input name="juhaoyongEditTime" type="text" value="<%=GetFormatTime(now())%>" size="30"></span>　<strong><font color="#FF0000">*注意保持原有时间格式*格式必须如：2018-8-8 9:09:09</font>（通过调整时间，可以调整前台显示顺序，时间越大越靠前）</strong>
	  </td>
	</tr>
  
  
	  
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='提交' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form><br /><br /><br />
<%end if%>
<%
Call DbconnEnd()
%>