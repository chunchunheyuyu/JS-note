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
response.Write JuhaoyongResultPage("���ݿ�����ѹ��",compactString,"db_compact_alert.asp")
response.end
%>

<%
'=================================================
'���ã�ѹ�����ݿ�
'������sourcedbPath��Դ���ݿ�·����
'������sourcedbName��Դ���ݿ����ƣ�
'������bakdbFolderName���������ݿ�Ŀ¼���ƣ�
'=================================================
Function JuhaoyongDatabaseCompact(sourcedbPath,sourcedbName,bakdbFolderName)
randomize
dim prov,tempdb,bakdb_path,bakdb
JuhaoyongDatabaseCompact="���ݿ�ѹ���ɹ���"
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	
	'�������ݿ�
	bakdb_path = "../"&bakdbFolderName
	If fso.FolderExists(Server.MapPath(bakdb_path))=false Then fso.CreateFolder(Server.MapPath(bakdb_path))'��ⱸ��Ŀ¼�Ƿ���ڣ��������򴴽�Ŀ¼
	bakdb = bakdb_path&"/"&year(now)&"-"&month(now)&"-"&day(now)&"-"&hour(now)&minute(now)&second(now)&"_"&int(1000*rnd)&".mdb"
	'�������ݿ⣨��ͬ���򸲸ǣ�
	fso.copyfile Server.MapPath(sourcedbPath&sourcedbName), Server.MapPath(bakdb) , true
	
	'ѹ�����ݿ�
	tempdb = sourcedbPath&"temp.mdb"
	If fso.FileExists(Server.MapPath(tempdb)) then fso.DeleteFile(Server.MapPath(tempdb))'���ж�temp.mdb�Ƿ���ڣ���������ɾ��
	set engine = server.createobject("jro.jetengine")
	prov = "provider=microsoft.jet.oledb.4.0;data source="
	engine.compactdatabase prov & Server.MapPath(sourcedbPath&sourcedbName), prov & Server.MapPath(tempdb)'ѹ�����ݿ�
	'������
	if err.number<>0 then
		JuhaoyongDatabaseCompact=err.description
		err.clear
	end if
	set engine = nothing
	
	'ɾ��Դ���ݿ�
	fso.deletefile Server.MapPath(sourcedbPath&sourcedbName)
	
	'����ѹ���õ������ݿ⣬��������ΪԴ���ݿ����ƣ�ǰ����Ҫ�ƶ����ļ����������ƶ���Ŀ�ĵأ�
	fso.movefile Server.MapPath(tempdb), Server.MapPath(sourcedbPath&sourcedbName)
	set fso = nothing
End Function
%>
