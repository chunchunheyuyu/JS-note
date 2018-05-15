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
	  <th class="tableHeaderText">数据库恢复</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100"><div>
			<center><font color="#ff0000" size="+1">请确定已经做好了最新备份，然后再执行此恢复，数据库恢复过程是不可逆的，确定要恢复数据库吗？</font></center><br />
			<center><a href="db_backup_restore.asp?operate=2&file_path_name=<%=file_path_name%>"><font color="#FF0000" size="+2"><b>点击这里开始数据库恢复</b></font></a></center><br />
			<center><font color="#0000ff">（温馨提示：恢复数据库过程中，请勿做其他操作，如果数据库较大，比较耗费时间，请耐心等待......）</font></center><br /><br />
			
			
			<center><a href=# onclick='history.go(-1)'><font size='+1'>返 回</font></a></center>
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
response.Write JuhaoyongResultPage("数据库恢复",restoreString,"db_backup_list.asp")
response.end
%>

<%end if%>

<%
'=================================================
'作用：备份数据库
'参数：sourcedbPath（源数据库路径）
'参数：sourcedbName（源数据库名称）
'参数：bakdbFolderName（备份数据库目录名称）
'参数：restoreDbName（要恢复的数据库名称）
'=================================================
Function JuhaoyongDatabaseRestore(sourcedbPath,sourcedbName,bakdbFolderName,restoreDbName)
randomize
dim bakdb
JuhaoyongDatabaseRestore="恢复数据库成功！"
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	
	bakdb = "../"&bakdbFolderName&"/"&restoreDbName
	If fso.FileExists(Server.MapPath(bakdb))=false then
		JuhaoyongDatabaseRestore="要恢复的数据库文件不存在！"'判断要恢复的数据库文件是否存在
	else
		'恢复前，先删除要覆盖的数据库
		fso.deletefile Server.MapPath(sourcedbPath&sourcedbName)
		'恢复数据库（同名覆盖）
		fso.copyfile Server.MapPath(bakdb) , Server.MapPath(sourcedbPath&sourcedbName) , true
	end if
	set fso = nothing
End Function
%>
