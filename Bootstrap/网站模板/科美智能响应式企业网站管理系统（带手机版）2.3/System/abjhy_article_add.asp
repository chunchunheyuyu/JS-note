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
'������ݵ����ݱ�
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
	
	'�����ⲻ��Ϊ��
	if a_title&""="" then
		response.Write JuhaoyongReturnHistoryPage("���������������","���ⲻ��Ϊ��")
		response.end
	'����Ƿ�ѡ�����
	elseif a_levelone_id&""="" then
		response.Write JuhaoyongReturnHistoryPage("���������������","û��ѡ�����")
		response.end
	'���html�ļ�������Ϊ��
	elseif a_html_file_name&""="" then
		response.Write JuhaoyongReturnHistoryPage("���������������","�ļ����Ʋ���Ϊ��")
		response.end
	'���html�ļ��������ظ�
	elseif CheckRepeatHtmlFileName(a_html_file_name,a_levelone_id,a_leveltwo_id,0)=true then
		response.Write JuhaoyongReturnHistoryPage("���������������","�ļ������Ѿ����ڣ���������")
		response.end
	'���ʱ���ʽ�Ƿ���ȷ
	elseif IsDate(juhaoyongEditTime)=False then
		response.Write JuhaoyongReturnHistoryPage("���������������","ʱ���ʽ����ȷ")
		response.end
	else
		'��������
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
		
		'�����������������µ�ʱ�����һҳ����һҳ��ά����һҳ����һҳ�����ԣ�
		call ReCreatehtmlArticlePreNext(juhaoyongEditTime)'��������ǰһƪ����һƪ
		
		'��ȡ����������id
		dim rs2
		set rs2=server.createobject("adodb.recordset")
		sql="select top 1 [id] from [juhaoyong_tb_content] where [title]='"&a_title&"' and ArticleType=1 order by id desc"
		rs2.open(sql),cn,1,1
		if not rs2.eof  then
			a_id=rs2("id")
		end if
		rs2.close
		set rs2=nothing
	
		'���������ӵ�����
		call Run_createhtml_article_content(a_id)
		
		'������ҳ
		call Run_createhtml_index()
		
		'���ɲ�Ʒ���ڷ����б�
		call Run_createhtml_article_product_list(1,a_levelone_id)
		call Run_createhtml_article_product_list(1,a_leveltwo_id)
		%>
		
		<%
		response.Write JuhaoyongResultPage("���������������","��ӳɹ�","abjhy_article_list.asp?oneid="&oneid&"&twoid="&twoid&"&act="&act)
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
	Dim count2,rsClass2,sqlClass2
	set rsClass2=server.createobject("adodb.recordset")
	sqlClass2="select id,jhy_fd_dir_parentid,name from juhaoyong_tb_directory where jhy_fd_dir_parentid>0 and ClassType=1 order by [order],time"
	rsClass2.open sqlClass2,cn,1,1
	%>
	var subval2 = new Array();
	//����ṹ��һ����ֵ,������ֵ,������ʾֵ
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
	oneid_name=juhaoyongGetCategoryName(oneid)
	twoid_name=juhaoyongGetCategoryName(twoid)
	%>
	<form id="form1" name="form1" method="post" action="?act1=save&oneid=<%=oneid%>&twoid=<%=twoid%>&act=<%=act%>">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">�������</th>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor02"><br>
	  
	  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr><td height="25" class='TipTitle'>����˵����</td></tr>
        <tr><td height="30" valign="top" class="TipWords"><p>1��ͨ����������ʱ�䣨�ڱ༭�������棩�����Ե�����ʾ˳��</p></td></tr>
        <tr><td height="10">&nbsp;</td></tr>
      </table>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	
	<tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">���±��� (����) </td>
	<td class="jhyabTabletdBgcolor01"><input name="a_title" type="text" size="70" maxlength="200"></td>
	</tr>
	
    <tr>
	<td width="15%" height=23 class="jhyabTabletdBgcolor01">�����ļ������� (����) </td>
	<td class="jhyabTabletdBgcolor01"><input name="html_file_name" type="text" size="36" value="<%=juhaoyongRndNumber&hour(now)&minute(now)&second(now)&".html"%>">&nbsp;����Ӣ����ĸ��������������ʽ�磺abc.html����Ҫ�������ַ��Ϳո�Ĭ����ϵͳ���ɵ�����������ƣ����޸ģ�</td>
	</tr>
    
	<tr>
	<td class="jhyabTabletdBgcolor01" height=23>���·���(��ѡ)</td>
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
            <option value="">ѡ���������</option>
			<%'����������࣬��ѡ����ǰ����			
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
        <td  class="jhyabTabletdBgcolor01" height=23>���¹ؼ���</td>
	    <td class="jhyabTabletdBgcolor01"><input type="text" name="a_keywords" size="100" maxlength="200">&nbsp;����ؼ��ʣ����԰��Ӣ�Ķ���","�ָ�</td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=11>��������</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name="a_description"  cols="100" rows="4"></textarea></td>
	</tr>
	
	<tr>
	    <td class="jhyabTabletdBgcolor01" height=50>���¸���</td>
	    <td width="85%" class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="25%" ><input name="jhy_fd_fujian" type="text" id="jhy_fd_fujian"  size="30"></td>
           <td width="75%"  ><iframe width=725 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=3"></iframe></td>
         </tr>
       </table></td>
    </tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>����</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name="a_content" style=" width:100%; height:400px; visibility:hidden;"></textarea></td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>�����������</td>
	  <td class="jhyabTabletdBgcolor01"><input name='a_hit' type='text' value="0" size='40'>&nbsp;ֻ��������</td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01" height=23>��ҳ�ö�</td>
	  <td class="jhyabTabletdBgcolor01"><input type="radio" name="a_index_push" value="1">��&nbsp;<input name="a_index_push" type="radio" value="0" checked>��</td>
	</tr>
    
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>����ʱ��</td>
	  <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor01">
	    <input name="juhaoyongEditTime" type="text" value="<%=GetFormatTime(now())%>" size="30"></span>��<strong><font color="#FF0000">*ע�Ᵽ��ԭ��ʱ���ʽ*��ʽ�����磺2018-8-8 9:09:09</font>��ͨ������ʱ�䣬���Ե���ǰ̨��ʾ˳��ʱ��Խ��Խ��ǰ��</strong>
	  </td>
	</tr>
  
  
	  
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='�ύ' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form><br /><br /><br />
<%end if%>
<%
Call DbconnEnd()
%>