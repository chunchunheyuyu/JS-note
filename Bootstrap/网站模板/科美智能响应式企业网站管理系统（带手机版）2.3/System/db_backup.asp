<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="inc/head.asp" -->

<%Call DbconnEnd()%>

<%operate=request.querystring("operate")%>

<%if operate=1 then%>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">���ݿ����߱���</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100"><div>
			<center><a href="db_backup.asp?operate=2"><font color="#FF0000" size="+1"><b>������￪ʼ�������ݿ�</b></font></a></center><br />
			<center><font color="#0000ff">����ܰ��ʾ�����ݿⱸ�ݹ����У�����������������������ݿ�ϴ󣬱ȽϺķ�ʱ�䣬�����ĵȴ�......��</font></center><br /><br />
			
			<center><a href=# onclick='history.go(-1)'><font size='+1'>�� ��</font></a></center>
			</div></td>
          </tr>
        </table>
	    </td>
	</tr>
	</table>
<%else%>

<%
dim backupString
backupString=JuhaoyongDatabaseBackup(juhaoyongDatabasePath,juhaoyongDatabaseName,DB_BACKUP_PATH_FOLDER)
response.Write JuhaoyongResultPage("���ݿ����߱���",backupString,"db_backup_list.asp")
response.end
%>

<%end if%>

<%
'=================================================
'���ã��������ݿ�
'������sourcedbPath��Դ���ݿ�·����
'������sourcedbName��Դ���ݿ����ƣ�
'������bakdbFolderName���������ݿ�Ŀ¼���ƣ�
'=================================================
Function JuhaoyongDatabaseBackup(sourcedbPath,sourcedbName,bakdbFolderName)
randomize
dim bakdb_path,bakdb
JuhaoyongDatabaseBackup="���ݿⱸ�ݳɹ���"
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	
	'�������ݿ�
	bakdb_path = "../"&bakdbFolderName
	If fso.FolderExists(Server.MapPath(bakdb_path))=false Then fso.CreateFolder(Server.MapPath(bakdb_path))'��ⱸ��Ŀ¼�Ƿ���ڣ��������򴴽�Ŀ¼
	bakdb = bakdb_path&"/"&year(now)&"-"&month(now)&"-"&day(now)&"-"&hour(now)&minute(now)&second(now)&"_"&int(1000*rnd)&".mdb"
	'�������ݿ⣨��ͬ���򸲸ǣ�
	fso.copyfile Server.MapPath(sourcedbPath&sourcedbName), Server.MapPath(bakdb) , true

	set fso = nothing
End Function
%>
