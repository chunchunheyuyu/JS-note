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
mp_site_foldername=MP_Get_mp_site_foldername()'��ȡ�ֻ���վĿ¼����
%>

<%
page=request.querystring("page")
act=request.querystring("act")
keywords=request.querystring("keywords")
article_id=cint(request.querystring("id"))

oneid=request.QueryString("oneid")
twoid=request.QueryString("twoid")

'��ȡ��Ŀid
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
	
	'�����ⲻ��Ϊ��
	if a_title&""="" then
		response.Write JuhaoyongReturnHistoryPage("�������������޸�","���ⲻ��Ϊ��")
		response.end
	'����Ƿ�ѡ�����
	elseif a_levelone_id&""="" then
		response.Write JuhaoyongReturnHistoryPage("�������������޸�","û��ѡ�����")
		response.end
	'���html�ļ�������Ϊ��
	elseif a_html_file_name&""="" then
		response.Write JuhaoyongReturnHistoryPage("�������������޸�","�ļ����Ʋ���Ϊ��")
		response.end
	'���html�ļ��������ظ�
	elseif CheckRepeatHtmlFileName(a_html_file_name,a_levelone_id,a_leveltwo_id,a_id)=true then
		response.Write JuhaoyongReturnHistoryPage("�������������޸�","�ļ������Ѿ����ڣ���������")
		response.end
	'���ʱ���ʽ�Ƿ���ȷ
	elseif IsDate(juhaoyongEditTime)=False then
		response.Write JuhaoyongReturnHistoryPage("�������������޸�","ʱ���ʽ����ȷ")
		response.end
	else
		'�޸�����
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
		
		'����༭ʱ������������������ʱ�����ʱ�����һҳ����һҳ��ά����һҳ����һҳ�����ԣ�
		if juhaoyongEditTime&""<>old_juhaoyongEditTime&"" then
			ReCreatehtmlArticlePreNext(old_juhaoyongEditTime)'��������ǰһƪ����һƪ
			ReCreatehtmlArticlePreNext(juhaoyongEditTime)'��������ǰһƪ����һƪ
		end if
	
		'���������Ŀ����������ļ����������ɾ��ԭ����Ŀ�еľ��ļ�
		if old_a_levelone_id<>a_levelone_id or old_a_leveltwo_id<>a_leveltwo_id or a_html_file_name<>old_file_name then
			dim oldFilePath
			oldFilePath=GetFileFolderPath(old_a_levelone_id,old_a_leveltwo_id)&"/"&old_file_name
			mp_oldFilePath=Mp_GetFileFolderPath(old_a_levelone_id,old_a_leveltwo_id,mp_site_foldername)&"/"&old_file_name '�ֻ����ļ�·��
			JuhaoyongDeleteFile(oldFilePath)'ɾ����̬html�ļ�
			JuhaoyongDeleteFile(mp_oldFilePath)'ɾ����̬html�ļ����ֻ��棩
		end if
		
		'�����������գ���ɾ��ԭ���ĸ����ļ�
		if trim(a_jhy_fd_fujian&"")="" and trim(old_a_jhy_fd_fujian&"")<>"" then
			JuhaoyongDeleteFile("../upAttachFile/"&old_a_jhy_fd_fujian)'ɾ�������ļ�
		end if
		
		'���ɵ�ǰ���޸ĵĸõ�ƪ����
		call Run_createhtml_article_content(a_id)
		
		'������ҳ
		call Run_createhtml_index()
		
		'�����ϣ�ԭ���������б�
		call Run_createhtml_article_product_list(1,old_a_levelone_id)
		call Run_createhtml_article_product_list(1,old_a_leveltwo_id)
		'��������б仯�������·����б�
		if a_levelone_id<>old_a_levelone_id then
			call Run_createhtml_article_product_list(1,a_levelone_id)
		end if
		if a_leveltwo_id<>old_a_leveltwo_id then
			call Run_createhtml_article_product_list(1,a_leveltwo_id)
		end if
	
		response.Write JuhaoyongResultPage("�������������޸�","�޸ĳɹ�","abjhy_article_list.asp?oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords)
		response.end
	end if
else
%>
  	<script charset="utf-8" src="hao8editor/kindeditor.js"></script>
	<script charset="utf-8" src="hao8editor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="hao8editor/editor.js"></script>

	<!-- ���������˵� ��ʼ -->
	<script language="JavaScript">
	<!--
	<%
	'�������ݱ��浽����
	Dim count2,rsc2,sqlClass2
	set rsc2=server.createobject("adodb.recordset")
	sqlClass2="select id,jhy_fd_dir_parentid,name from juhaoyong_tb_directory where jhy_fd_dir_parentid>0 and ClassType=1 order by [order],time " 
	rsc2.open sqlClass2,cn,1,1
	%>
	var subval2 = new Array();
	//����ṹ��һ����ֵ,������ֵ,������ʾֵ
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
		document.form1.twoid.options[0] = new Option('ѡ���������','');
		for (i=0; i<subval2.length; i++)
		{
			if (subval2[i][0] == locationid)
			{document.form1.twoid.options[document.form1.twoid.length] = new Option(subval2[i][2],subval2[i][1]);}
		}
	}
	
	//-->
	</script>
	<!-- ���������˵� ���� -->

	<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from [juhaoyong_tb_content] where id="&article_id
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
	%>
	<form id="form1" name="form1" method="post" action="?act1=save&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">

	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">�޸�����</th>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor02"><br>
	  
	  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" class='TipTitle'>����˵����</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords">
          <p>1��ͨ����������ʱ�䣨�ڱ༭�������棩�����Ե�����ʾ˳��</p>
          <p>2��ɾ��������ԭ�и���������������¸�����Ȼ�󱣴棬��ϵͳ���Զ�ɾ��������ԭ���ĸ����ļ���</p>
            </td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table>
	  
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">���±��� (����) </td>
	<td class="jhyabTabletdBgcolor01"><input name="a_title" type="text" value="<%=rs("title")%>" size="70" maxlength="200">
	<input name="a_id" type="hidden" value="<%=rs("id")%>"></td>
	</tr>
    
    <tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">�����ļ������� (����) </td>
	<td class="jhyabTabletdBgcolor01"><input name="html_file_name" type="text" size="36" value="<%=rs("html_file_name")%>">&nbsp;����Ӣ����ĸ��������������ʽ�磺abc.html����Ҫ�������ַ��Ϳո�</td>
	</tr>
    
	<tr>
	<td class="jhyabTabletdBgcolor01" height=23>���·���(��ѡ)</td>
    <td class="jhyabTabletdBgcolor01">
			<%
			set rsc1=server.createobject("adodb.recordset")
			sqlClass1="select id,name from juhaoyong_tb_directory where jhy_fd_dir_parentid=0 and ClassType=1 order by [order],time" 
			rsc1.open sqlClass1,cn,1,1
			%>
            <select name="oneid" id="oneid" onChange="JuhaoyongSelectTwoIdList(this.value)">
			<% '���һ�����࣬��ѡ����ǰ����
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
            <option value="">ѡ���������</option>
			<%'����������࣬��ѡ����ǰ����			
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
        <td  class="jhyabTabletdBgcolor01" height=23>���¹ؼ���</td>
	      <td class="jhyabTabletdBgcolor01"><input type='text' id='v3' name='a_keywords'  value="<%=rs("keywords")%>" size='100' maxlength="200">&nbsp;����ؼ��ʣ����԰��Ӣ�Ķ���","�ָ�</td>
	</tr><tr>
	  <td class="jhyabTabletdBgcolor01" height=11>��������</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='a_description'  cols="100" rows="4" id="a_description" ><%=rs("description")%></textarea></td>
	</tr>
	
	<tr>
	    <td class="jhyabTabletdBgcolor01" height=50>���¸���</td>
	    <td width="85%" class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="25%"><input name="jhy_fd_fujian" type="text" id="jhy_fd_fujian"  value="<%=rs("jhy_fd_fujian")%>" size="30"></td>
           <td width="75%"><iframe width=725 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=3&uploadFileOldName=<%=rs("jhy_fd_fujian")%>"></iframe></td>
         </tr>
       </table></td>
    </tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>����</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name="a_content" style=" width:100%; height:400px; visibility:hidden;"><%=replace(rs("content"),"../../images/","../images/")%></textarea>
	</td>
	</tr>
	
    <tr>
	  <td class="jhyabTabletdBgcolor01" height=23>��ҳ�ö�</td>
	  <td class="jhyabTabletdBgcolor01">
	    <input type="radio" name="a_index_push" value="1" 
		<%if rs("index_push")=1 then
		response.write "checked"
		end if%>>
      ��
      &nbsp;
        <input type="radio" name="a_index_push" value="0" 
		<%if rs("index_push")=0 then
		response.write "checked"
		end if%>>
      ��</td>
	</tr>
    
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>�����������</td>
	  <td class="jhyabTabletdBgcolor01"><input name='a_hit' type='text' id='a_hit' value="<%=rs("hit")%>" size='40'>&nbsp;ֻ��������</td>
	  </tr>

	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>����ʱ��</td>
	  <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor01">
	    <input name="juhaoyongEditTime" type="text" value="<%=GetFormatTime(rs("edit_time"))%>" size="30"></span>��<strong><font color="#FF0000">*ע�Ᵽ��ԭ��ʱ���ʽ*��ʽ�����磺2018-8-8 9:09:09</font>��ͨ������ʱ�䣬���Ե���ǰ̨��ʾ˳��ʱ��Խ��Խ��ǰ��</strong>
	  </td>
	</tr>
	    
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='�ύ' name=Submit>
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