<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->

<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="../inc/rebuild_modify_template.asp" -->

<!-- #include file="inc/head.asp" -->
<%
act=Request("act")
dim rs,sql
If act="save" Then 
	jhy_fd_index_title=trim(request.form("jhy_fd_index_title"))
	jhy_fd_index_keywords=trim(request.form("jhy_fd_index_keywords"))
	jhy_fd_index_description=trim(request.form("jhy_fd_index_description"))
	
	jhy_fd_index_column1=trim(request.form("jhy_fd_index_column1"))
	jhy_fd_index_url1=trim(request.form("jhy_fd_index_url1"))
	jhy_fd_index_image1=trim(request.form("jhy_fd_index_image1"))
	jhy_fd_index_code1=trim(request.form("jhy_fd_index_code1"))
	
	jhy_fd_index_column2=trim(request.form("jhy_fd_index_column2"))
	jhy_fd_index_url2=trim(request.form("jhy_fd_index_url2"))

	
	jhy_fd_index_column3=trim(request.form("jhy_fd_index_column3"))
	jhy_fd_index_url3=trim(request.form("jhy_fd_index_url3"))
	jhy_fd_index_image3=trim(request.form("jhy_fd_index_image3"))
	jhy_fd_index_code3=trim(request.form("jhy_fd_index_code3"))
	
	jhy_fd_index_column4=trim(request.form("jhy_fd_index_column4"))
	jhy_fd_index_url4=trim(request.form("jhy_fd_index_url4"))
	jhy_fd_index_onoff4=trim(request.form("jhy_fd_index_onoff4"))

	jhy_fd_index_number1=trim(request.form("jhy_fd_index_number1"))
	jhy_fd_index_number2=trim(request.form("jhy_fd_index_number2"))

	jhy_fd_index_lunboheight=trim(request.form("jhy_fd_index_lunboheight"))

	if jhy_fd_index_number1="" then jhy_fd_index_number1=1
	if jhy_fd_index_number2="" then jhy_fd_index_number2=1

	if IsNumeric(jhy_fd_index_number1)=False then jhy_fd_index_number1=1
	if IsNumeric(jhy_fd_index_number2)=False then jhy_fd_index_number2=1

	if jhy_fd_index_number1<=0 then jhy_fd_index_number1=1
	if jhy_fd_index_number2<=0 then jhy_fd_index_number2=1

	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_indexconfig"
	rs.open(sql),cn,1,3
	old_jhy_fd_index_lunboheight=rs("jhy_fd_index_lunboheight")
	old_jhy_fd_index_image1=rs("jhy_fd_index_image1")
	old_jhy_fd_index_image3=rs("jhy_fd_index_image3")
	
	rs("jhy_fd_index_title")=jhy_fd_index_title
	rs("jhy_fd_index_keywords")=jhy_fd_index_keywords
	rs("jhy_fd_index_description")=jhy_fd_index_description
	
	rs("jhy_fd_index_column1")=jhy_fd_index_column1
	rs("jhy_fd_index_url1")=jhy_fd_index_url1
	rs("jhy_fd_index_image1")=jhy_fd_index_image1
	rs("jhy_fd_index_code1")=jhy_fd_index_code1
	
	rs("jhy_fd_index_column2")=jhy_fd_index_column2
	rs("jhy_fd_index_url2")=jhy_fd_index_url2
	
	rs("jhy_fd_index_column3")=jhy_fd_index_column3
	rs("jhy_fd_index_url3")=jhy_fd_index_url3
	rs("jhy_fd_index_image3")=jhy_fd_index_image3
	rs("jhy_fd_index_code3")=jhy_fd_index_code3
	
	rs("jhy_fd_index_column4")=jhy_fd_index_column4
	rs("jhy_fd_index_url4")=jhy_fd_index_url4
	rs("jhy_fd_index_onoff4")=jhy_fd_index_onoff4
	
	rs("jhy_fd_index_number1")=jhy_fd_index_number1
	rs("jhy_fd_index_number2")=jhy_fd_index_number2
	
	rs("jhy_fd_index_lunboheight")=jhy_fd_index_lunboheight

	rs.update
	rs.close
	set rs=nothing
	
	'������ҳ�ֲ��߶�css�ļ�
	if trim(jhy_fd_index_lunboheight&"")<>trim(old_jhy_fd_index_lunboheight&"") then
		str_lunboheight_css="#Focus {height:"&jhy_fd_index_lunboheight&"px;}"
		str_lunboheight_css=str_lunboheight_css&".Focus {height:"&jhy_fd_index_lunboheight&"px;}"
		call JuhaoyongCommonFileCreate(str_lunboheight_css,"../css/"&SITE_STYLE_CSS_FOLDER&"/index_custom_attribute.css")'����css�ļ�
	end if
	
	'�����Ŀ��1��ͼƬ���Ʊ���գ���ɾ��֮ǰ����Ŀ��1��ͼƬ�ļ�
	if trim(jhy_fd_index_image1&"")="" and trim(old_jhy_fd_index_image1&"")<>"" then
		JuhaoyongDeleteFile("../css/"&SITE_STYLE_CSS_FOLDER&"/"&old_jhy_fd_index_image1)'ɾ��ͼƬ�ļ�
	end if
	
	'�����Ŀ��3��ͼƬ���Ʊ���գ���ɾ��֮ǰ����Ŀ��3��ͼƬ�ļ�
	if trim(jhy_fd_index_image3&"")="" and trim(old_jhy_fd_index_image3&"")<>"" then
		JuhaoyongDeleteFile("../css/"&SITE_STYLE_CSS_FOLDER&"/"&old_jhy_fd_index_image3)'ɾ��ͼƬ�ļ�
	end if
	
	'����������ҳģ��
	call RewriteTemplateFile(0,0)
	'������ҳ
	call Run_createhtml_index()
	response.Write JuhaoyongResultPage("��ҳ����","�޸ĳɹ�","jhy_index_config.asp")
	response.end
else
%>

<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from juhaoyong_tb_indexconfig"
	rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
%>
  <form name="form1" method="post" action="?act=save">
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">��ҳ����</th>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor02"><br>
	  
	  
	  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" class='TipTitle'>����˵����</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords">
			<p>1��<font size="+1"><strong>�޸���ҳ���ú�������������ҳ��̬��Ȼ��ǰ̨&nbsp;<font color="#FF0000">��F5ˢ��</font>&nbsp;�鿴Ч����</strong></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="html_generate_alert.asp?htmltype=index"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;">>>>������ȥ������ҳ��̬</span></a></p>
		  </td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">��ҳ����(Title)</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input type='text' name='jhy_fd_index_title' value="<%=rs("jhy_fd_index_title")%>" size='80'></td>
	</tr>
	  <td class="jhyabTabletdBgcolor01">��ҳ�ؼ���(keywords)</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='jhy_fd_index_keywords' value="<%=rs("jhy_fd_index_keywords")%>" size='80'>&nbsp;����ؼ��ʣ����԰��Ӣ�Ķ���","�ָ�</td>
	</tr><tr>
	  <td class="jhyabTabletdBgcolor01">��ҳ����(Description)</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='jhy_fd_index_description' cols="100" rows="4" ><%=rs("jhy_fd_index_description")%></textarea></td>
	</tr>
	
    <tr>
	  <td style="background:#8aabca" width="100%" colspan="2" height="25">&nbsp;</td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">��Ŀ��1������</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input type='text' name='jhy_fd_index_column1' value="<%=rs("jhy_fd_index_column1")%>" size='20'></td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">��Ŀ��1�����ӵ�ַ</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input type='text' name='jhy_fd_index_url1' value="<%=rs("jhy_fd_index_url1")%>" size='60'></td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01">��Ŀ��1��ͼƬ</td>
	  <td class="jhyabTabletdBgcolor01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			 <tr>
			   <td class="jhyabTabletdBgcolor02"><input name="jhy_fd_index_image1" type="text" value="<%=rs("jhy_fd_index_image1")%>"  size="30"></td>
			   <td class="jhyabTabletdBgcolor02"><iframe width=700 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=1&uploadFileOldName=<%=rs("jhy_fd_index_image1")%>&juhaoyongForm1InputName=jhy_fd_index_image1"></iframe></td>
			 </tr>
		   </table>
	   �������Ϊ�գ�����ʾ��ͼƬ��ͼƬ���ͣ�<font color="red">.jpg | .gif | .png</font> &nbsp;&nbsp;ͼƬ�ߴ磺<font color="red">�Ҽ�ģ��ͼƬ>>���ԣ����ɿ����ߴ�</font>
	  </td>
    </tr>
    
	<tr>
	  <td class="jhyabTabletdBgcolor01">��Ŀ��1��HTML����</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='jhy_fd_index_code1' cols="100" rows="10" ><%=rs("jhy_fd_index_code1")%></textarea></td>
	</tr>
	
    <tr>
	  <td style="background:#8aabca" width="100%" colspan="2" height="25">&nbsp;</td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">��Ŀ��2������</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input type='text' name='jhy_fd_index_column2' value="<%=rs("jhy_fd_index_column2")%>" size='20'></td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">��Ŀ��2�����ӵ�ַ</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input type='text' name='jhy_fd_index_url2' value="<%=rs("jhy_fd_index_url2")%>" size='60'></td>
	</tr>
    
    <tr>
	  <td style="background:#8aabca" width="100%" colspan="2" height="25">&nbsp;</td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">��Ŀ��3������</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input type='text' name='jhy_fd_index_column3' value="<%=rs("jhy_fd_index_column3")%>" size='20'></td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">��Ŀ��3�����ӵ�ַ</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input type='text' name='jhy_fd_index_url3' value="<%=rs("jhy_fd_index_url3")%>" size='60'></td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01">��Ŀ��3����ͼƬ</td>
	  <td class="jhyabTabletdBgcolor01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			 <tr>
			   <td width="22%"  class="jhyabTabletdBgcolor02"><input name="jhy_fd_index_image3" type="text" value="<%=rs("jhy_fd_index_image3")%>"  size="30"></td>
			   <td width="78%"  class="jhyabTabletdBgcolor02"><iframe width=700 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=1&uploadFileOldName=<%=rs("jhy_fd_index_image3")%>&juhaoyongForm1InputName=jhy_fd_index_image3"></iframe></td>
			 </tr>
		   </table>
	   �������Ϊ�գ�����ʾ��ͼƬ��ͼƬ���ͣ�<font color="red">.jpg | .gif | .png</font> &nbsp;&nbsp;ͼƬ�ߴ磺<font color="red">�Ҽ�ģ��ͼƬ>>���ԣ����ɿ����ߴ�</font>
	  </td>
    </tr>

	<tr>
	  <td class="jhyabTabletdBgcolor01">��Ŀ��3����HTML����</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='jhy_fd_index_code3' cols="100" rows="10"><%=rs("jhy_fd_index_code3")%></textarea></td>
	</tr>	
	
    <tr>
	  <td style="background:#8aabca" width="100%" colspan="2" height="25">&nbsp;</td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">��Ŀ��4������</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input type='text' name='jhy_fd_index_column4' value="<%=rs("jhy_fd_index_column4")%>" size='20'></td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">��Ŀ��4�����ӵ�ַ</td>
	  <td class="jhyabTabletdBgcolor01" width="70%"><input type='text' name='jhy_fd_index_url4' value="<%=rs("jhy_fd_index_url4")%>" size='60'></td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01">�Ƿ���ʾ����Ŀ</td>
	  <td class="jhyabTabletdBgcolor01">
       <input type="radio" name="jhy_fd_index_onoff4" value="1" <%if rs("jhy_fd_index_onoff4")=1 then%>checked<%end if%>>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" name="jhy_fd_index_onoff4" value="0" <%if rs("jhy_fd_index_onoff4")=0 then%>checked<%end if%>>��
	   &nbsp;&nbsp;&nbsp;&nbsp;����ѡ���ǡ������뵽���ݹ������Ƽ���Ʒ����ҳ���ſ�����ʾ����Ŀ��
      </td>
	</tr>

    <tr>
	  <td style="background:#8aabca" width="100%" colspan="2" height="25">&nbsp;</td>
	</tr>
    
	<tr>
	  <td class="jhyabTabletdBgcolor01">��ҳ�����ֲ���ͼ�߶�</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='jhy_fd_index_lunboheight' value="<%=rs("jhy_fd_index_lunboheight")%>" size='2' maxlength="5"> px<span style="color: #FF0000" > *</span>�������롰��ֵ����</td>
	</tr>
    
    <tr>
	  <td style="background:#8aabca" width="100%" colspan="2" height="25">&nbsp;</td>
	</tr>
    
	<tr>
	  <td class="jhyabTabletdBgcolor01">�ײ���Ʒ��Ŀ��ʾ����</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='jhy_fd_index_number1' value="<%=rs("jhy_fd_index_number1")%>" size='2' maxlength="2"><span style="color: #FF0000" > *</span>�������롰����������</td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01">�ײ�������Ŀ��ʾ����</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='jhy_fd_index_number2' value="<%=rs("jhy_fd_index_number2")%>" size='2' maxlength="2"><span style="color: #FF0000" > *</span>�������롰����������</td>
	</tr>
	<tr>
	<td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center"><INPUT type=submit value='�ύ' name=Submit></div></td>
	</tr>
	</table></td></tr></table>
</form><br /><br /><br /><br />

<%
	else
		response.write "��ʱ������"
	end if
	rs.close
	set rs=nothing
end if
Call DbconnEnd()
%>