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
	  <th class="tableHeaderText">数据库在线备份</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100"><div>
			<center><a href="db_backup.asp?operate=2"><font color="#FF0000" size="+1"><b>点击这里开始备份数据库</b></font></a></center><br />
			<center><font color="#0000ff">（温馨提示：数据库备份过程中，请勿做其他操作，如果数据库较大，比较耗费时间，请耐心等待......）</font></center><br /><br />
			
			<center><a href=# onclick='history.go(-1)'><font size='+1'>返 回</font></a></center>
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
response.Write JuhaoyongResultPage("数据库在线备份",backupString,"db_backup_list.asp")
response.end
%>

<%end if%>

<%
'=================================================
'作用：备份数据库
'参数：sourcedbPath（源数据库路径）
'参数：sourcedbName（源数据库名称）
'参数：bakdbFolderName（备份数据库目录名称）
'=================================================
Function JuhaoyongDatabaseBackup(sourcedbPath,sourcedbName,bakdbFolderName)
randomize
dim bakdb_path,bakdb
JuhaoyongDatabaseBackup="数据库备份成功！"
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	
	'备份数据库
	bakdb_path = "../"&bakdbFolderName
	If fso.FolderExists(Server.MapPath(bakdb_path))=false Then fso.CreateFolder(Server.MapPath(bakdb_path))'检测备份目录是否存在，不存在则创建目录
	bakdb = bakdb_path&"/"&year(now)&"-"&month(now)&"-"&day(now)&"-"&hour(now)&minute(now)&second(now)&"_"&int(1000*rnd)&".mdb"
	'备份数据库（若同名则覆盖）
	fso.copyfile Server.MapPath(sourcedbPath&sourcedbName), Server.MapPath(bakdb) , true

	set fso = nothing
End Function
%>
