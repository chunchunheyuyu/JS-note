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


	'����ļ��������Ƿ�Ϊ��
	if mp_fd_site_folder&""="" then
		response.Write JuhaoyongReturnHistoryPage("�ֻ���վ����","�ļ������Ʋ���Ϊ��")
		response.end
	'����ļ��������Ƿ���б�ܺͿո�
	elseif instr(mp_fd_site_folder,"/")>0 or instr(mp_fd_site_folder,"\")>0 or instr(mp_fd_site_folder," ")>0 then
		response.Write JuhaoyongReturnHistoryPage("�ֻ���վ����","�ļ������ƣ����ܰ����ո��б�ܣ�/\������������")
		response.end
	'����ļ������Ƿ���ϵͳ�ļ��У���վ��Ŀ¼���ļ��У�����
	elseif mp_fd_site_folder<>old_mp_fd_site_folder and CheckRepeatSysFoldName(mp_fd_site_folder)=true then
		response.Write JuhaoyongReturnHistoryPage("�ֻ���վ����","�ļ��������Ѵ��ڣ�����������")
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
		
		'�ֻ���վ��ת���ؿ���
		if mp_fd_site_onoff&""<>old_mp_fd_site_onoff&"" then MP_modify_mpjs_onoff(mp_fd_site_onoff)
	
		'���ԭ���ϵģ��ļ����Ƿ���ڣ���������������´�����
		call JuhaoyongFolderCreate("../"&old_mp_fd_site_folder)
		'������ļ�����ԭ���ϵģ��ļ��в�ͬ���������
		if mp_fd_site_folder<>old_mp_fd_site_folder  then call JuhaoyongRenameFolder("../"&old_mp_fd_site_folder,mp_fd_site_folder)
		
		'����ģ�濪ʼ
		call MP_RewriteTemplateFile(0,0)'������ҳģ��
		'����ҳ�濪ʼ
		call MP_Run_createhtml_index(mp_fd_site_folder)'������ҳ
		
		response.Write JuhaoyongResultPage("�ֻ���վ����","�޸ĳɹ�","mp_jhy_index_config.asp")
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
	  <th class="tableHeaderText">�ֻ���վ����</th>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor02"><br>
	  
	  
	  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" class='TipTitle'>����˵����</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords">
			<p>1��<font>�޸��ļ������ƺ����������ɵ��԰汾���о�̬��Ȼ��ˢ��ǰ̨ҳ��鿴Ч����</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=all"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>������ȥ���ɵ��԰����о�̬</span></a></p>
			<p>2��<font>�޸��������ú������������ֻ���վ���о�̬��Ȼ��ˢ��ǰ̨ҳ��鿴Ч����</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="html_generate_alert.asp?htmltype=mp"><span style=" font-weight:bold; color:#093; font-size:18px; text-decoration:none;"> >>>������ȥ�����ֻ���վ���о�̬</span></a></p>
		  </td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	  <td class="jhyabTabletdBgcolor01">�ֻ���վ����</td>
	  <td class="jhyabTabletdBgcolor01">
       <input type="radio" name="mp_fd_site_onoff" value="1"<%if rs("mp_fd_site_onoff")=1 then%> checked<%end if%>>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" name="mp_fd_site_onoff" value="0"<%if rs("mp_fd_site_onoff")=0 then%> checked<%end if%>>��
      </td>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor01" width="30%">�ֻ���վ�ļ�������</td>
	  <td class="jhyabTabletdBgcolor01" width="70%">
      <input type='text' name='mp_fd_site_folder' value="<%=rs("mp_fd_site_folder")%>" size='18' maxlength="15"> ������Ӣ�Ļ��������ƣ���Ҫ�������ַ���б�ܣ���ʽ�磺mp
      <input type="hidden" name="old_mp_fd_site_folder" value="<%=rs("mp_fd_site_folder")%>">
      </td>
	</tr>
    
    <tr>
	  <td style="background:#8aabca" width="100%" colspan="2" height="25">&nbsp;</td>
	</tr>



    <tr>
	  <td class="jhyabTabletdBgcolor01">�ֻ���վ Logo ͼƬ</td>
	  <td class="jhyabTabletdBgcolor01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
			 <tr>
			   <td class="jhyabTabletdBgcolor02"><input name="mp_fd_site_logo" type="text" value="<%=rs("mp_fd_site_logo")%>"  size="30" readonly></td>
			   <td class="jhyabTabletdBgcolor02"><iframe width=700 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=5&uploadFileOldName=<%=rs("mp_fd_site_logo")%>&juhaoyongForm1InputName=mp_fd_site_logo"></iframe></td>
			 </tr>
		   </table>
	   ͼƬ���ͣ�<font color="red">.jpg | .gif | .png</font> &nbsp;&nbsp;����ͼƬ�ߴ磺<font color="red">640 * 132 </font>
	  </td>
    </tr>
    
    <tr>
	  <td style="background:#8aabca" width="100%" colspan="2" height="25">&nbsp;</td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01">��ҳ�Ƿ���ʾ����Ʒ�Ƽ�����Ŀ</td>
	  <td class="jhyabTabletdBgcolor01">
       <input type="radio" name="mp_fd_index_onoff4" value="1" <%if rs("mp_fd_index_onoff4")=1 then%>checked<%end if%>>��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <input type="radio" name="mp_fd_index_onoff4" value="0" <%if rs("mp_fd_index_onoff4")=0 then%>checked<%end if%>>��
	   &nbsp;&nbsp;&nbsp;&nbsp;����ѡ���ǡ������뵽���ݹ������Ƽ���Ʒ����ҳ���ſ�����ʾ����Ŀ��
      </td>
	</tr>
    
	<tr>
	  <td class="jhyabTabletdBgcolor01">��ҳ-���������ʾ����</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='mp_fd_index_number1' value="<%=rs("mp_fd_index_number1")%>" size='2' maxlength="2"><span style="color: #FF0000" > *</span>�������롰0����������,��Ϊ0����ʾ��ģ�飩</td>
	</tr>
    
    <tr>
	  <td class="jhyabTabletdBgcolor01">��ҳ-������Ѷ��ʾ����</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='mp_fd_index_number2' value="<%=rs("mp_fd_index_number2")%>" size='2' maxlength="2"><span style="color: #FF0000" > *</span>�������롰0����������,��Ϊ0����ʾ��ģ�飩</td>
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