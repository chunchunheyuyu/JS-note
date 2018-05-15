<!-- #include file="../../inc/conn.asp" -->
<%
Sub DBConnEnd()
	On Error Resume Next
	cn.Close
	Set cn = Nothing
End Sub

Sub GoError(str)
	Call DBConnEnd()
	Response.Write "<script language=javascript>alert('" & str & "\n\n������һҳ...');history.back();</script>"
	Response.End
End Sub

Function GetSafeStr(str)
	GetSafeStr = Replace(Replace(Replace(Trim(str), "'", ""), Chr(34), ""), ";", "")
End Function

Function outHTML(str)
	Dim sTemp
	sTemp = str
	outHTML = ""
	If IsNull(sTemp) = True Then
		Exit Function
	End If
	sTemp = Replace(sTemp, "&", "&amp;")
	sTemp = Replace(sTemp, "<", "&lt;")
	sTemp = Replace(sTemp, ">", "&gt;")
	sTemp = Replace(sTemp, Chr(34), "&quot;")
	sTemp = Replace(sTemp, Chr(10), "<br>")
	outHTML = sTemp
End Function

Function inHTML(str)
	Dim sTemp
	sTemp = str
	inHTML = ""
	If IsNull(sTemp) = True Then
		Exit Function
	End If
	sTemp = Replace(sTemp, "&", "&amp;")
	sTemp = Replace(sTemp, "<", "&lt;")
	sTemp = Replace(sTemp, ">", "&gt;")
	sTemp = Replace(sTemp, Chr(34), "&quot;")
	inHTML = sTemp
End Function

Function InitSelect(s_FieldName, a_Name, a_Value, v_InitValue, s_Sql, s_AllName)
	Dim i
	InitSelect = "<select name='" & s_FieldName & "' size=1>"
	If s_AllName <> "" Then
		InitSelect = InitSelect & "<option value=''>" & s_AllName & "</option>"
	End If
	If s_Sql <> "" Then
		oRs.Open s_Sql, Cn, 0, 1
		Do While Not oRs.Eof
			InitSelect = InitSelect & "<option value=""" & inHTML(oRs(1)) & """"
			If oRs(1) = v_InitValue Then
				InitSelect = InitSelect & " selected"
			End If
			InitSelect = InitSelect & ">" & outHTML(oRs(0)) & "</option>"
			oRs.MoveNext
		Loop
		oRs.Close
	Else
		For i = 0 To UBound(a_Name)
			InitSelect = InitSelect & "<option value=""" & inHTML(a_Value(i)) & """"
			If a_Value(i) = v_InitValue Then
				InitSelect = InitSelect & " selected"
			End If
			InitSelect = InitSelect & ">" & outHTML(a_Name(i)) & "</option>"
		Next
	End If
	InitSelect = InitSelect & "</select>"
End Function

Function md5en(enstr)
	Dim s1,s2,s3
	s1=md5(Mid(enstr,1,1),16)
	s1=Left(s1,2)
	s2=Mid(enstr,2)
	s3=s1 & s2e
	md5en=md5(s3,16)
End Function

Sub Footer()
	Call DBConnEnd()
	Response.Write "</BODY></HTML>"
End Sub


Function fixjs(Str)
	If Str <>"" Then
		str = replace(str,"\", "\\")
		Str = replace(str, chr(34), "\""")
		Str = replace(str, chr(39),"\'")
		Str = Replace(str, chr(13), "\n")
		Str = Replace(str, chr(10), "\r")
		str = replace(str,"'", "&#39;")
	End If
	fixjs=Str
End Function

Function enfixjs(Str)
	If Str <>"" Then
		Str = replace(str,"&#39;", "'")
		Str = replace(str,"\""" , chr(34))
		Str = replace(str, "\'",chr(39))
		Str = Replace(str, "\r", chr(10))
		Str = Replace(str, "\n", chr(13))
		Str = replace(str,"\\", "\")
	End If
	enfixjs=Str
End Function
'##########################################��ʱδ�õĺ�����ʼ##########################################
'**************************************************
'����SQL�Ƿ��ַ�
'**************************************************
function FilterSqlChar(str)
    str=trim(str) 
	if isnull(str) then
		FilterSqlChar = ""
		exit function
	end if
	FilterSqlChar=replace(str,"'","")
end function

'**************************************************
'����HTML����
'**************************************************
function FilterHtmlCode(sourceString)
if not isnull(sourceString) then
    sourceString = replace(sourceString, ">", "&gt;")
    sourceString = replace(sourceString, "<", "&lt;")

    sourceString = Replace(sourceString, CHR(32), "&nbsp;")
    sourceString = Replace(sourceString, CHR(9), "&nbsp;")
    sourceString = Replace(sourceString, CHR(34), "&quot;")
    sourceString = Replace(sourceString, CHR(39), "&#39;")
    sourceString = Replace(sourceString, CHR(13), "")
    sourceString = Replace(sourceString, CHR(10) & CHR(10), "</P><P> ")
    sourceString = Replace(sourceString, CHR(10), "<BR> ")

    FilterHtmlCode = sourceString
end if
end function

'**************************************************
'���ã����˱��ַ�
'**************************************************
function FilterFormCode(sourceString)
if not isnull(sourceString) then
    sourceString = Replace(sourceString,"'","")
	sourceString = Replace(sourceString, CHR(13), "")
    sourceString = Replace(sourceString, CHR(10) & CHR(10), "</P><P>")
    sourceString = Replace(sourceString, CHR(10), "<BR>")
    FilterFormCode = sourceString
end if
end function

'**************************************************
'��  �ã��������Ƿ��Ѿ���װ
'��  ����strClassString�������
'����ֵ��True���Ѿ���װ��False��û�а�װ
'**************************************************
Function IsObjInstalled(strClassString)
    On Error Resume Next
    IsObjInstalled = False
    Err=0
    Dim xTestObj
    SET xTestObj=Server.CreateObject(strClassString)
    IF Err=0 THEN IsObjInstalled = True
    SET xTestObj=Nothing
    Err=0
End Function
'##########################################��ʱδ�õĺ�������##########################################

Function SStr(sel_name, valuelist, textlist, initvalue, other)
	Dim s, Avaluelist, Atextlist, i
	Select Case	other
		Case "r" other=" dataType='Require' msg='ѡ��' "
		Case Else other=" -- "
	End Select

	s= "<select name='"&sel_name&"' "&other&" >"
	s=s & "<option value=''>��ѡ��...</option>"
	Avaluelist=Split(valuelist,"|")
	Atextlist=Split(textlist,"|")
	For i=0 To UBound(Avaluelist)
		s=s & "<option value='" & Avaluelist(i) & "'"
		If CStr(initvalue)=CStr(Avaluelist(i)) Then s=s & " selected "
		s=s & ">" & Atextlist(i) & "</option>"
	Next
	s=s & "</select>"
	Set Avaluelist=Nothing
	Set Atextlist=Nothing
	SStr=s
End Function

Function SDB(sel_name, sql, initvalue, other)
	'response.Write "<br> " & sql
	Dim s, rs,other2,o
	other2=Left(other,1)
	Select Case other2
	       Case "r" o=" dataType='Require' msg='��ѡ��' "
	End Select

	s="<select name='"& sel_name &"' "& o &">"
	s=s & "<option value=''>��ѡ��...</option>"
	other3=Mid(other,2,1)
	If other3="a" Then	s=s & "<option value='0'>��</option>"
	Set rs=cn.execute(sql)
	Do While Not rs.eof
		s=s & "<option value='" & rs(0) & "'"
		If CStr(rs(0))=CStr(initvalue) Then s=s & " selected "
		s=s & ">" & rs(1) & "</option>"
		rs.MoveNext
	Loop
	rs.close:Set rs=Nothing
	s=s & "</select>"
	SDB=s
End Function

Function SMonth(sel_name, initvalue, other)
	Dim s, i, m0, m1
	Select Case	other
		Case "r" other=" dataType='Require' msg='ѡ��' "
		Case Else other=" -- "
	End Select
	s=s & "<select name='"&sel_name&"' " & other & ">"
	s=s & "<option value=''>��ѡ��...</option>"
	For i=-5 To 5
		m0=DateAdd("m", i, Date())
		If CDate(m0)> CDate(Date()) Then Exit For
		m1=Year(m0) & "��" & Month(m0) & "��"
		s=s & "<option value='"&m0&"'"
		If CDate(initvalue)=CDate(m0) Then s=s & " selected "
		s=s & ">" & m1 & "</option>"
	Next
	s=s & "</select>"
	SMonth= s
End Function

Function GetUrl() 
	On Error Resume Next 
	Dim strTemp 
	If LCase(Request.ServerVariables("HTTPS")) = "off" Then 
	 strTemp = "http://"
	Else 
	 strTemp = "https://"
	End If 
	strTemp = strTemp & Request.ServerVariables("SERVER_NAME") 
	If Request.ServerVariables("SERVER_PORT") <> 80 Then 
	 strTemp = strTemp & ":" & Request.ServerVariables("SERVER_PORT") 
	end if
	strTemp = strTemp & Request.ServerVariables("URL") 
	If Trim(Request.QueryString) <> "" Then 
	 strTemp = strTemp & "?" & Trim(Request.QueryString) 
	end if
	GetUrl = strTemp 
End Function

Function logr()
	Dim s
	If Session("log_role")=1 Then 
		logr=True
	Else 
		logr=False
	End If 
End Function 

Function GStr(valuelist, textlist, initvalue)
	Dim s, Avaluelist, Atextlist, i
	Avaluelist=Split(valuelist, "|")
	Atextlist=Split(textlist, "|")
	For i=0 To UBound(Avaluelist)
		If CStr(initvalue)=CStr(Avaluelist(i)) Then s=AtextList(i)
	Next
	Set Avaluelist=Nothing
	Set Atextlist=Nothing
	If s<>"" Then
		GStr=s
	Else
		GStr="null"
	End If

End Function

Function subids(id,db)
	Dim ids,rs
	If id<>"" Then
		Set rs=cn.execute("select id from "&db&" where ParentId=" & id)
		If Not (rs.bof Or rs.eof) Then
			Do While Not rs.eof
				If ids="" Then
					ids=rs(0)
				Else
					ids=ids & "," & rs(0)
				End If
				rs.MoveNext
			Loop
			rs.close:Set rs=Nothing
		End If
	Else
		subids="0"
	End If
	subids=ids
End Function

Function laststr(s)
	Dim i,a1,s2
	a1=Split(s,",")
	s2=a1(UBound(a1))
	Set a1=Nothing
	laststr=s2
End Function

%>

<%
'==================================================
'���ã��޸��ļ�
'������file_body ------Ҫ�������ļ���Ϣ
'������file_name ------Ҫ�������ļ���(·��)
'������Cset -----------����Ҫ�������ļ�����
'==================================================
Function Savefile(file_body,file_name,Cset)
dim OS
Set OS=Server.CreateObject("ADODB.Stream")
        OS.Type=2
        OS.Open
        OS.Charset = Cset
        OS.Position=OS.Size
        OS.WriteText=file_body
        OS.SaveToFile Server.MapPath(file_name),2
        OS.Close
Set OS=Nothing
End Function

'=================================================
'���ã������ļ���
'������folderPath
'=================================================
function JuhaoyongFolderCreate(folderPath)
dim fso
set fso = server.createobject("scripting.filesystemobject")
'����ļ����Ƿ���ڣ���������������´�����
If fso.FolderExists(Server.MapPath(folderPath))=false Then fso.CreateFolder(Server.MapPath(folderPath))
Set fso=nothing
end function

'=================================================
'���ã������ļ�
'������filepath���ļ����·����
'=================================================
function JuhaoyongCommonFileCreate(codeString,filepath)
dim fso,f
set fso = server.createobject("scripting.filesystemobject")
'�����ļ�
Set f = fso.CreateTextFile(Server.MapPath(filepath))
f.WriteLine codeString
f.close
set f=nothing
set fso=nothing
end function

'=================================================
'���ã��������ļ���
'������oldFolderPath,newFolderName
'=================================================
function JuhaoyongRenameFolder(oldFolderPath,newFolderName)
dim fso,objFolder
set fso = server.createobject("scripting.filesystemobject")
'���ԭ�ļ����Ƿ���ڣ����������������ļ��С�
if fso.folderexists(Server.MapPath(oldFolderPath)) then
	Set objFolder=fso.GetFolder(Server.MapPath(oldFolderPath))
	objFolder.Name=newFolderName
	Set objFolder=nothing
end if
Set fso=nothing
end function

'=================================================
'���ã��������ļ�
'������oldFilePath,newFileName
'=================================================
function JuhaoyongRenameFile(oldFilePath,newFileName)
dim fso,objFile
set fso = server.createobject("scripting.filesystemobject") 
'���ԭ�ļ��Ƿ���ڣ����������������ļ���
If fso.FileExists(Server.MapPath(oldFilePath)) Then
	Set objFile=fso.GetFile(Server.MapPath(oldFilePath))
	objFile.Name=newFileName
	Set objFile=nothing
end if
Set fso=nothing
end function

'=================================================
'���ã���ȡǰһƪ���һƪ���±༭ʱ�䣨�ú���ֻ��������ɾ������abjhy_article_del.asp���õ��ˣ�
'������editTime����ǰ���±༭ʱ�䣩,position��ǰһƪ���һƪ��
'=================================================
function GetNextOrPreEditTime(editTime,position)
if trim(editTime&"")="" then
	Exit Function
end if
dim rs,sql
if position="pre" then
	sql="select top 1 edit_time from juhaoyong_tb_content where edit_time>#"&GetFormatTime(editTime)&"# and ArticleType=1 order by [edit_time] asc,id asc"
else
	sql="select top 1 edit_time from juhaoyong_tb_content where edit_time<#"&GetFormatTime(editTime)&"# and ArticleType=1 order by [edit_time] desc,id desc"
end if
set rs=server.createobject("adodb.recordset")
rs.open(sql),cn,1,1
if not rs.eof then
	GetNextOrPreEditTime=rs("edit_time")
else
	GetNextOrPreEditTime=GetFormatTime(now())
end if
rs.close
set rs=nothing
end function

'=================================================
'���ã���ȡǰһƪ���һƪ����id��Ȼ����������ǰһƪ�ͺ�һƪ���£�ά����һҳ����һҳ�����ԣ��ú���������������Ӻͱ༭�������������У�
'������editTime����ǰ���±༭ʱ�䣩
'=================================================
function ReCreatehtmlArticlePreNext(editTime)
if trim(editTime&"")="" then
	Exit Function
end if
dim rs,sql1,sql2
'pre
sql1="select top 1 id from juhaoyong_tb_content where edit_time>#"&GetFormatTime(editTime)&"# and ArticleType=1 order by [edit_time] asc,id asc"
'next
sql2="select top 1 id from juhaoyong_tb_content where edit_time<#"&GetFormatTime(editTime)&"# and ArticleType=1 order by [edit_time] desc,id desc"
set rs=server.createobject("adodb.recordset")
rs.open(sql1),cn,1,1
if not rs.eof then
	call Run_createhtml_article_content(rs("id"))'����id�������¾�̬�ļ�
end if
rs.close

rs.open(sql2),cn,1,1
if not rs.eof then
	call Run_createhtml_article_content(rs("id"))'����id�������¾�̬�ļ�
end if
rs.close

set rs=nothing
end function

'=================================================
'���ã�������������"���±༭ʱ��"֮����������£��ú���ֻ��������ɾ������abjhy_article_del.asp���õ��ˣ�
'������preArticleEditTime,nextArticleEditTime
'=================================================
function CreatehtmlBetweenArticleEditTime(preArticleEditTime,nextArticleEditTime)
dim rs,sql
if preArticleEditTime="" and nextArticleEditTime="" then
	Exit Function
end if
set rs=server.createobject("adodb.recordset")
if preArticleEditTime="" then
	sql="select id from juhaoyong_tb_content where edit_time>=#"&GetFormatTime(nextArticleEditTime)&"# and ArticleType=1 order by [edit_time] desc"
elseif nextArticleEditTime="" then
	sql="select id from juhaoyong_tb_content where edit_time<=#"&GetFormatTime(preArticleEditTime)&"# and ArticleType=1 order by [edit_time] desc"
else
	sql="select id from juhaoyong_tb_content where edit_time>=#"&GetFormatTime(nextArticleEditTime)&"# and edit_time<=#"&GetFormatTime(preArticleEditTime)&"# and ArticleType=1 order by [edit_time] desc"
end if
rs.open(sql),cn,1,1
if not rs.eof then
	do while not rs.eof
	call Run_createhtml_article_content(rs("id"))'����id�������¾�̬�ļ�
	rs.movenext
	loop
end if
rs.close
set rs=nothing
end function

'=================================================
'���ã���ȡ����һ��Ŀ¼�µĶ���Ŀ¼���ƣ����������ӣ����ɴ���
'������class_type,oneid
'=================================================
function JuhaoyongGetLowerFolderNameList(class_type,oneid)
dim rs,sql
set rs=server.createobject("adodb.recordset")
sql="select id,name,ClassType,[order] from juhaoyong_tb_directory where ClassType="&class_type&" and jhy_fd_dir_parentid="&oneid&" order by [order],time"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
	response.Write("<ul class=LowerFolderNameList>")
	do while not rs.eof
		if class_type=1 then
		response.Write("<li><a href=abjhy_article_list.asp?oneid="&oneid&"&twoid="&rs("id")&"><img src=images/lowerFolderImg.gif border=0 />"&rs("name")&"</a></li>")
		else
		response.Write("<li><a href=abjhy_product_list.asp?oneid="&oneid&"&twoid="&rs("id")&"><img src=images/lowerFolderImg.gif border=0 />"&rs("name")&"</a></li>")
		end if
	rs.movenext
	loop
	response.Write("</ul>")
end if
rs.close
set rs=nothing
end function

'=================================================
'���ã�����id��ȡ��Ŀ����
'������id
'=================================================
function JuhaoyongGetLanmuName(id)
dim rs,sql
set rs=server.createobject("adodb.recordset")
sql="select name from juhaoyong_tb_directory where id="&id
rs.open(sql),cn,1,1
	if not rs.eof and not rs.bof then
	JuhaoyongGetLanmuName=rs("name")
	end if
rs.close
set rs=nothing
end function

'=================================================
'���ã���ȡ�ֲ�ͼƬid
'��������
'=================================================
function JuhaoyongGetLunboImgTotal()
	dim rs,sql
	sql="select id from juhaoyong_tb_picture order by [id] desc"
	Set rs= Server.CreateObject("ADODB.Recordset")
	rs.open sql,cn,1,1
	if not rs.eof and not rs.bof then
		JuhaoyongGetLunboImgTotal=rs("id")
	else
		JuhaoyongGetLunboImgTotal=1
	end if
	rs.close
	set rs=nothing
end function

'=================================================
'���ã����һ���ļ��������ļ����Ƿ������������򷵻�true��û���򷵻�false
'      �ú�����Ҫ��Ϊ�˼���ļ������Ƿ���ϵͳ�ļ��У���վ��Ŀ¼���ļ��У��������������ɻ�༭��Ŀʱ���ý����ļ������Ƽ��
'������folderName
'=================================================
function CheckRepeatSysFoldName(folderName)
CheckRepeatSysFoldName=false
dim Fso,subFolderObject
Set Fso=Server.CreateObject("Scripting.FileSystemObject")
set subFolderObject=Fso.GetFolder(Server.MapPath("../"))
dim x
for each x in subFolderObject.SubFolders
	if x.Name=folderName then
		CheckRepeatSysFoldName=true
		Exit for
	end if
next
Set subFolderObject=nothing
Set Fso=nothing
end function

'=================================================
'���ã������Ŀ���ƻ���Ŀ�ļ��������Ƿ����ظ������򷵻�true��û���򷵻�false
'=================================================
function CheckRepeatDirFoldOrName(dirName,dirFolder,dirID)
CheckRepeatDirFoldOrName=false
dim rs,sql
set rs=server.createobject("adodb.recordset")
if dirID>0 then
	sql="select id from juhaoyong_tb_directory where ([name]='"&dirName&"' or [folder]='"&dirFolder&"') and [id]<>"&dirID
else
	sql="select id from juhaoyong_tb_directory where ([name]='"&dirName&"' or [folder]='"&dirFolder&"')"
end if
rs.open(sql),cn,1,1
if not rs.eof then
	CheckRepeatDirFoldOrName=true
end if
rs.close
set rs=nothing
end function

'=================================================
'���ã����html�ļ����Ƿ����ظ������򷵻�true��û���򷵻�false
'=================================================
function CheckRepeatHtmlFileName(htmlfilename,classoneid,classtwoid,id)
CheckRepeatHtmlFileName=false
dim rs,sql
set rs=server.createobject("adodb.recordset")
sql="select id from juhaoyong_tb_content where html_file_name='"&htmlfilename&"' and jhy_fd_levelone_id='"&classoneid&"' and jhy_fd_leveltwo_id='"&classtwoid&"'"
if id>0 then sql=sql&" and [id]<>"&id
rs.open(sql),cn,1,1
if not rs.eof then
	CheckRepeatHtmlFileName=true
end if
rs.close
set rs=nothing
end function

'=================================================
'���ã����һ�������Ƿ��з��������ļ�¼�����򷵻�true��û���򷵻�false
'������tableName��id
'=================================================
function CheckIsInTableById(tableName,id)
CheckIsInTableById=false
dim rs,sql
set rs=server.createobject("adodb.recordset")
if tableName="juhaoyong_tb_directory" then
	sql="select [id] from "&tableName&" where jhy_fd_dir_parentid="&id
else
	sql="select [id] from "&tableName&" where jhy_fd_levelone_id='"&id&"' or jhy_fd_leveltwo_id='"&id&"'"
end if
rs.open(sql),cn,1,1
if not rs.eof then
	CheckIsInTableById=true
end if
rs.close
set rs=nothing
end function

'=================================================
'���ã���������id��ȡ�����ļ�·����ǰ̨·�������˺�����δʹ�ã�
'������contentId
'=================================================
function GetContentDirFile(contentId)
dim rs,sql,rs_url
set rs=server.createobject("adodb.recordset")
sql="SELECT a.jhy_fd_leveltwo_id,a.title, a.html_file_name, a.image, b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id WHERE a.id="&contentId
rs.open(sql),cn,1,1
if not rs.eof then
	rs_url=""
	if rs("jhy_fd_leveltwo_id")&""<>"" then
	rs_url="../../"&rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
	else
	rs_url="../"&rs("b.folder")&"/"&rs("html_file_name")
	end if
end if
rs.close
set rs=nothing
end function
'=================================================
'���ã���������һ��Ŀ¼id�Ͷ���Ŀ¼id����ȡ�ļ���·������̨·����
'������oneid��һ����Ŀid��
'������twoid��������Ŀid��
'=================================================
function GetFileFolderPath(oneid,twoid)
if trim(oneid&"")="" then
	Exit Function
end if
dim rs,sql
set rs=server.createobject("adodb.recordset")
sql="SELECT folder from juhaoyong_tb_directory WHERE id="&oneid
rs.open(sql),cn,1,1
if not rs.eof then
	GetFileFolderPath="../"&rs("folder")
end if
rs.close

if trim(twoid&"")<>"" then
	sql="SELECT folder from juhaoyong_tb_directory WHERE id="&twoid
	rs.open(sql),cn,1,1
	if not rs.eof then
		GetFileFolderPath=GetFileFolderPath&"/"&rs("folder")
	end if
	rs.close
end if
set rs=nothing
end function
'=================================================
'���ã���������һ��Ŀ¼id�Ͷ���Ŀ¼id����ȡ�ļ���·������̨·�������ֻ��棩
'������oneid��һ����Ŀid��
'������twoid��������Ŀid��
'������mp_foldername���ֻ���ַĿ¼���ƣ�
'=================================================
function Mp_GetFileFolderPath(oneid,twoid,mp_foldername)
if trim(oneid&"")="" then
	Exit Function
end if
dim rs,sql
set rs=server.createobject("adodb.recordset")
sql="SELECT folder from juhaoyong_tb_directory WHERE id="&oneid
rs.open(sql),cn,1,1
if not rs.eof then
	Mp_GetFileFolderPath="../"&mp_foldername&"/"&rs("folder")
end if
rs.close

if trim(twoid&"")<>"" then
	sql="SELECT folder from juhaoyong_tb_directory WHERE id="&twoid
	rs.open(sql),cn,1,1
	if not rs.eof then
		Mp_GetFileFolderPath=Mp_GetFileFolderPath&"/"&rs("folder")
	end if
	rs.close
end if
set rs=nothing
end function
'=================================================
'���ã������������һ����Ŀid��ȡ�����ļ������ļ���·������̨·����
'������directoryId�����һ����Ŀid��
'������dirlevelnumber����Ŀ����1��2��
'=================================================
function GetContentDirFolder(directoryId,dirlevelnumber)
dim rs,sql
set rs=server.createobject("adodb.recordset")
select case dirlevelnumber
	case 1
	sql="SELECT a.folder from juhaoyong_tb_directory AS a WHERE a.id="&directoryId
	case 2
	sql="SELECT a.folder, b.folder from juhaoyong_tb_directory AS a LEFT JOIN juhaoyong_tb_directory AS b ON b.id=a.jhy_fd_dir_parentid WHERE a.id="&directoryId
end select
rs.open(sql),cn,1,1
if not rs.eof then
	select case dirlevelnumber
		case 1
		GetContentDirFolder="../"&rs("folder")
		case 2
		GetContentDirFolder="../"&rs("b.folder")&"/"&rs("a.folder")
	end select
end if
rs.close
set rs=nothing
end function

'=================================================
'���ã���ȡ��Ŀ¼id���˺�����δ�õ���
'������id����ǰĿ¼id��
'=================================================
Function juhaoyongGetCategoryParentId(id)
if trim(id&"")="" then
	juhaoyongGetCategoryParentId=""
	Exit Function
end if
dim rs,sql
set rs=server.createobject("adodb.recordset")
sql="select jhy_fd_dir_parentid from juhaoyong_tb_directory where id="&id 
rs.open sql,cn,1,1
if not rs.eof then
	juhaoyongGetCategoryParentId=rs("jhy_fd_dir_parentid")
end if
rs.close
set rs=nothing
End Function

'=================================================
'���ã�������Ŀid��ȡ��Ŀ����
'��������Ŀid
'=================================================
Function juhaoyongGetCategoryName(id)
if trim(id&"")="" then
	juhaoyongGetCategoryName=""
	Exit Function
end if
dim rs,sql
set rs=server.createobject("adodb.recordset")
sql="select name from juhaoyong_tb_directory where id="&id
rs.open sql,cn,1,1
if not rs.eof and not rs.bof then
	juhaoyongGetCategoryName=rs("name")
end if
rs.close
set rs=nothing
End Function

'=================================================
'���ã�ɾ���ļ���
'������folderPath��Ҫɾ�����ļ���·����
'=================================================
Function JuhaoyongDeleteFolder(folderPath)
if trim(folderPath)&""="" then
	Exit Function
end if
Set fso=Server.CreateObject("Scripting.FileSystemObject")
	folderPath=Server.MapPath(folderPath)
	'���ж��ļ����Ƿ���ڣ�������ɾ��
	If fso.FolderExists(folderPath) Then fso.DeleteFolder(folderPath)
set fso=nothing
End Function

'=================================================
'���ã�ɾ���ļ�
'������filePath��Ҫɾ�����ļ�·����
'=================================================
Function JuhaoyongDeleteFile(filePath)
if trim(filePath)&""="" then
	Exit Function
end if
Set fso=Server.CreateObject("Scripting.FileSystemObject")
	filePath=Server.MapPath(filePath)
	'���ж��ļ��Ƿ���ڣ�������ɾ��
	If fso.FileExists(filePath) then fso.DeleteFile(filePath)
set fso=nothing
End Function

'=================================================
'���ã�ͨ�ò������������Ϣ�����ؼ����ӵ�ַ��
'������infotitle�����⣩infocontent����ʾ�Ĳ����ɹ���ʧ����Ϣ��,filepath��������ص��ļ�·���Ͳ����ַ�����
'=================================================
Function JuhaoyongResultPage(infotitle,infocontent,filepath)
dim strCodeString
					strCodeString= "<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
strCodeString=strCodeString& "	<tr><th class='tableHeaderText'>"&infotitle&"</th></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />"&infocontent&"</font><br /><br /></td></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><a href='"&filepath&"'><font size='+1'>�� ��</font></a><br /><br /></td></tr>"
strCodeString=strCodeString& "</table>"
JuhaoyongResultPage=strCodeString
End Function

'=================================================
'���ã�ͨ�ò������������һҳ��������һ����ʷҳ��
'������infotitle�����⣩infocontent����ʾ�Ĳ����ɹ���ʧ����Ϣ��
'=================================================
Function JuhaoyongReturnHistoryPage(infotitle,infocontent)
dim strCodeString
					strCodeString= "<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
strCodeString=strCodeString& "	<tr><th class='tableHeaderText'>"&infotitle&"</th></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />"&infocontent&"</font><br /><br /></td></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><a href=# onclick='history.go(-1)'><font size='+1'>�� ��</font></a><br /><br /></td></tr>"
strCodeString=strCodeString& "</table>"
JuhaoyongReturnHistoryPage=strCodeString
End Function

'=================================================
'���ã�ͨ�ô���ȷ�ϰ�ť�ġ��������������Ϣ��ȷ�������ִ�У�������ִ��
'������infotitle�����⣩infocontent����ʾ�Ĳ����ɹ���ʧ����Ϣ��,confirmfilepath�����ȷ�����ļ�·���Ͳ����ַ�����
'=================================================
Function JuhaoyongConfirmPage(infotitle,infocontent,confirmfilepath)
dim strCodeString
			  strCodeString= "<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
strCodeString=strCodeString& "	<tr><th class='tableHeaderText'>"&infotitle&"</th></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />"&infocontent&"</font><br /><br /></td></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><a href='"&confirmfilepath&"'><font size='+1'>ȷ ��</font></a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=# onclick='history.go(-1)'><font size='+1'>�� ��</font></a><br /><br /></td></tr>"
strCodeString=strCodeString& "</table>"
JuhaoyongConfirmPage=strCodeString
End Function

'=================================================
'���ã����ݱ������ֶ�������ȡ�ֶ�ֵ�����ڻ�ȡ����վ���ñ�����ҳ���ñ��е�ֵ��
'������tableName
'������fieldName
'=================================================
Function juhaoyongGetFieldValue(tableName,fieldName)
if trim(tableName&"")="" or trim(fieldName&"")="" then
	juhaoyongGetFieldValue=""
	Exit Function
end if
dim rs,sql
set rs=server.createobject("adodb.recordset")
sql="select "&fieldName&" from "&tableName
rs.open sql,cn,1,1
if not rs.eof and not rs.bof then
	juhaoyongGetFieldValue=rs(0)
end if
rs.close
set rs=nothing
End Function

'=================================================
'���ã���׼��ʽ����ʱ�䡱��ʽ
'������strtime
'=================================================
Function GetFormatTime(strtime)
if trim(strtime&"")="" then
	GetFormatTime=""
	Exit Function
end if

GetFormatTime=""
GetFormatTime=GetFormatTime&year(strtime)&"-"
GetFormatTime=GetFormatTime&right("0"&Month(strtime),2)&"-"
GetFormatTime=GetFormatTime&right("0"&day(strtime),2)&" "
GetFormatTime=GetFormatTime&right("0"&hour(strtime),2)&":"
GetFormatTime=GetFormatTime&right("0"&minute(strtime),2)&":"
GetFormatTime=GetFormatTime&right("0"&second(strtime),2)
End Function

'=================================================
'���ã���׼��ʽ�������ڡ���ʽ
'������strtime
'=================================================
Function GetFormatDate(strtime)
if trim(strtime&"")="" then
	GetFormatDate=""
	Exit Function
end if

GetFormatDate=""
GetFormatDate=GetFormatDate&year(strtime)&"-"
GetFormatDate=GetFormatDate&right("0"&Month(strtime),2)&"-"
GetFormatDate=GetFormatDate&right("0"&day(strtime),2)
End Function
%>
