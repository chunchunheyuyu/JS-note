<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="inc/head.asp" -->

<%Call DbconnEnd()%>

<%
dim compactString
compactString=JuhaoyongDatabaseCompact(juhaoyongDatabasePath,juhaoyongDatabaseName,DB_BACKUP_PATH_FOLDER)
response.Write JuhaoyongResultPage("数据库在线压缩",compactString,"db_compact_alert.asp")
response.end
%>

<%
'=================================================
'作用：压缩数据库
'参数：sourcedbPath（源数据库路径）
'参数：sourcedbName（源数据库名称）
'参数：bakdbFolderName（备份数据库目录名称）
'=================================================
Function JuhaoyongDatabaseCompact(sourcedbPath,sourcedbName,bakdbFolderName)
randomize
dim prov,tempdb,bakdb_path,bakdb
JuhaoyongDatabaseCompact="数据库压缩成功！"
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	
	'备份数据库
	bakdb_path = "../"&bakdbFolderName
	If fso.FolderExists(Server.MapPath(bakdb_path))=false Then fso.CreateFolder(Server.MapPath(bakdb_path))'检测备份目录是否存在，不存在则创建目录
	bakdb = bakdb_path&"/"&year(now)&"-"&month(now)&"-"&day(now)&"-"&hour(now)&minute(now)&second(now)&"_"&int(1000*rnd)&".mdb"
	'备份数据库（若同名则覆盖）
	fso.copyfile Server.MapPath(sourcedbPath&sourcedbName), Server.MapPath(bakdb) , true
	
	'压缩数据库
	tempdb = sourcedbPath&"temp.mdb"
	If fso.FileExists(Server.MapPath(tempdb)) then fso.DeleteFile(Server.MapPath(tempdb))'先判断temp.mdb是否存在，若存在则删除
	set engine = server.createobject("jro.jetengine")
	prov = "provider=microsoft.jet.oledb.4.0;data source="
	engine.compactdatabase prov & Server.MapPath(sourcedbPath&sourcedbName), prov & Server.MapPath(tempdb)'压缩数据库
	'错误处理
	if err.number<>0 then
		JuhaoyongDatabaseCompact=err.description
		err.clear
	end if
	set engine = nothing
	
	'删除源数据库
	fso.deletefile Server.MapPath(sourcedbPath&sourcedbName)
	
	'剪切压缩好的新数据库，并重命名为源数据库名称（前面是要移动的文件，后面是移动的目的地）
	fso.movefile Server.MapPath(tempdb), Server.MapPath(sourcedbPath&sourcedbName)
	set fso = nothing
End Function
%>
