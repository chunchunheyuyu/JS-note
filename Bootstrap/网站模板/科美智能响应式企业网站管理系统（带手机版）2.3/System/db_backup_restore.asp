<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="inc/head.asp" -->

<%Call DbconnEnd()%>

<%
operate=request.querystring("operate")
file_path_name=request.querystring("file_path_name")
%>

<%if operate=1 then%>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">���ݿ�ָ�</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100"><div>
			<center><font color="#ff0000" size="+1">��ȷ���Ѿ����������±��ݣ�Ȼ����ִ�д˻ָ������ݿ�ָ������ǲ�����ģ�ȷ��Ҫ�ָ����ݿ���</font></center><br />
			<center><a href="db_backup_restore.asp?operate=2&file_path_name=<%=file_path_name%>"><font color="#FF0000" size="+2"><b>������￪ʼ���ݿ�ָ�</b></font></a></center><br />
			<center><font color="#0000ff">����ܰ��ʾ���ָ����ݿ�����У�����������������������ݿ�ϴ󣬱ȽϺķ�ʱ�䣬�����ĵȴ�......��</font></center><br /><br />
			
			
			<center><a href=# onclick='history.go(-1)'><font size='+1'>�� ��</font></a></center>
			</div></td>
          </tr>
        </table>
	    </td>
	</tr>
	</table>
<%else%>

<%
dim restoreString
restoreString=JuhaoyongDatabaseRestore(juhaoyongDatabasePath,juhaoyongDatabaseName,DB_BACKUP_PATH_FOLDER,file_path_name)
response.Write JuhaoyongResultPage("���ݿ�ָ�",restoreString,"db_backup_list.asp")
response.end
%>

<%end if%>

<%
'=================================================
'���ã��������ݿ�
'������sourcedbPath��Դ���ݿ�·����
'������sourcedbName��Դ���ݿ����ƣ�
'������bakdbFolderName���������ݿ�Ŀ¼���ƣ�
'������restoreDbName��Ҫ�ָ������ݿ����ƣ�
'=================================================
Function JuhaoyongDatabaseRestore(sourcedbPath,sourcedbName,bakdbFolderName,restoreDbName)
randomize
dim bakdb
JuhaoyongDatabaseRestore="�ָ����ݿ�ɹ���"
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	
	bakdb = "../"&bakdbFolderName&"/"&restoreDbName
	If fso.FileExists(Server.MapPath(bakdb))=false then
		JuhaoyongDatabaseRestore="Ҫ�ָ������ݿ��ļ������ڣ�"'�ж�Ҫ�ָ������ݿ��ļ��Ƿ����
	else
		'�ָ�ǰ����ɾ��Ҫ���ǵ����ݿ�
		fso.deletefile Server.MapPath(sourcedbPath&sourcedbName)
		'�ָ����ݿ⣨ͬ�����ǣ�
		fso.copyfile Server.MapPath(bakdb) , Server.MapPath(sourcedbPath&sourcedbName) , true
	end if
	set fso = nothing
End Function
%>
