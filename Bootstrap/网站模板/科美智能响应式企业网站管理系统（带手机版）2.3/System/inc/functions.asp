<!-- #include file="../../inc/conn.asp" -->
<%
Sub DBConnEnd()
	On Error Resume Next
	cn.Close
	Set cn = Nothing
End Sub

Sub GoError(str)
	Call DBConnEnd()
	Response.Write "<script language=javascript>alert('" & str & "\n\n返回上一页...');history.back();</script>"
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
'##########################################暂时未用的函数开始##########################################
'**************************************************
'过滤SQL非法字符
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
'过滤HTML代码
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
'作用：过滤表单字符
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
'作  用：检查组件是否已经安装
'参  数：strClassString：组件名
'返回值：True：已经安装，False：没有安装
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
'##########################################暂时未用的函数结束##########################################

Function SStr(sel_name, valuelist, textlist, initvalue, other)
	Dim s, Avaluelist, Atextlist, i
	Select Case	other
		Case "r" other=" dataType='Require' msg='选择' "
		Case Else other=" -- "
	End Select

	s= "<select name='"&sel_name&"' "&other&" >"
	s=s & "<option value=''>请选择...</option>"
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
	       Case "r" o=" dataType='Require' msg='请选择' "
	End Select

	s="<select name='"& sel_name &"' "& o &">"
	s=s & "<option value=''>请选择...</option>"
	other3=Mid(other,2,1)
	If other3="a" Then	s=s & "<option value='0'>无</option>"
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
		Case "r" other=" dataType='Require' msg='选择' "
		Case Else other=" -- "
	End Select
	s=s & "<select name='"&sel_name&"' " & other & ">"
	s=s & "<option value=''>请选择...</option>"
	For i=-5 To 5
		m0=DateAdd("m", i, Date())
		If CDate(m0)> CDate(Date()) Then Exit For
		m1=Year(m0) & "年" & Month(m0) & "月"
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
'作用：修改文件
'参数：file_body ------要创建的文件信息
'参数：file_name ------要创建的文件名(路径)
'参数：Cset -----------定义要创建的文件编码
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
'作用：创建文件夹
'参数：folderPath
'=================================================
function JuhaoyongFolderCreate(folderPath)
dim fso
set fso = server.createobject("scripting.filesystemobject")
'检测文件夹是否存在，如果不存在则重新创建。
If fso.FolderExists(Server.MapPath(folderPath))=false Then fso.CreateFolder(Server.MapPath(folderPath))
Set fso=nothing
end function

'=================================================
'作用：创建文件
'参数：filepath（文件相对路径）
'=================================================
function JuhaoyongCommonFileCreate(codeString,filepath)
dim fso,f
set fso = server.createobject("scripting.filesystemobject")
'生成文件
Set f = fso.CreateTextFile(Server.MapPath(filepath))
f.WriteLine codeString
f.close
set f=nothing
set fso=nothing
end function

'=================================================
'作用：重命名文件夹
'参数：oldFolderPath,newFolderName
'=================================================
function JuhaoyongRenameFolder(oldFolderPath,newFolderName)
dim fso,objFolder
set fso = server.createobject("scripting.filesystemobject")
'检测原文件夹是否存在，若存在则重命名文件夹。
if fso.folderexists(Server.MapPath(oldFolderPath)) then
	Set objFolder=fso.GetFolder(Server.MapPath(oldFolderPath))
	objFolder.Name=newFolderName
	Set objFolder=nothing
end if
Set fso=nothing
end function

'=================================================
'作用：重命名文件
'参数：oldFilePath,newFileName
'=================================================
function JuhaoyongRenameFile(oldFilePath,newFileName)
dim fso,objFile
set fso = server.createobject("scripting.filesystemobject") 
'检测原文件是否存在，若存在则重命名文件。
If fso.FileExists(Server.MapPath(oldFilePath)) Then
	Set objFile=fso.GetFile(Server.MapPath(oldFilePath))
	objFile.Name=newFileName
	Set objFile=nothing
end if
Set fso=nothing
end function

'=================================================
'作用：获取前一篇或后一篇文章编辑时间（该函数只有在文章删除程序abjhy_article_del.asp中用到了）
'参数：editTime（当前文章编辑时间）,position（前一篇或后一篇）
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
'作用：获取前一篇或后一篇文章id，然后重新生成前一篇和后一篇文章，维护上一页、下一页完整性（该函数用在了文章添加和编辑，这两个程序中）
'参数：editTime（当前文章编辑时间）
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
	call Run_createhtml_article_content(rs("id"))'根据id生成文章静态文件
end if
rs.close

rs.open(sql2),cn,1,1
if not rs.eof then
	call Run_createhtml_article_content(rs("id"))'根据id生成文章静态文件
end if
rs.close

set rs=nothing
end function

'=================================================
'作用：重新生成两个"文章编辑时间"之间的所有文章（该函数只有在文章删除程序abjhy_article_del.asp中用到了）
'参数：preArticleEditTime,nextArticleEditTime
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
	call Run_createhtml_article_content(rs("id"))'根据id生成文章静态文件
	rs.movenext
	loop
end if
rs.close
set rs=nothing
end function

'=================================================
'作用：获取所有一级目录下的二级目录名称，并加上链接，生成代码
'参数：class_type,oneid
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
'作用：根据id获取栏目名称
'参数：id
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
'作用：获取轮播图片id
'参数：无
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
'作用：检查一个文件夹下子文件夹是否有重名，有则返回true，没有则返回false
'      该函数主要是为了检测文件夹名是否与系统文件夹（网站根目录的文件夹）重名，用于生成或编辑栏目时调用进行文件夹名称检测
'参数：folderName
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
'作用：检查栏目名称或栏目文件夹名称是否有重复，有则返回true，没有则返回false
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
'作用：检查html文件名是否有重复，有则返回true，没有则返回false
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
'作用：检查一个表中是否有符合条件的记录，有则返回true，没有则返回false
'参数：tableName，id
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
'作用：根据内容id获取内容文件路径（前台路径）（此函数暂未使用）
'参数：contentId
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
'作用：根据文章一级目录id和二级目录id，获取文件夹路径（后台路径）
'参数：oneid（一级栏目id）
'参数：twoid（二级栏目id）
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
'作用：根据文章一级目录id和二级目录id，获取文件夹路径（后台路径）（手机版）
'参数：oneid（一级栏目id）
'参数：twoid（二级栏目id）
'参数：mp_foldername（手机网址目录名称）
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
'作用：根据内容最后一级栏目id获取内容文件所在文件夹路径（后台路径）
'参数：directoryId（最后一级栏目id）
'参数：dirlevelnumber（栏目级别1，2）
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
'作用：获取父目录id（此函数暂未用到）
'参数：id（当前目录id）
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
'作用：根据栏目id获取栏目名称
'参数：栏目id
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
'作用：删除文件夹
'参数：folderPath（要删除的文件夹路径）
'=================================================
Function JuhaoyongDeleteFolder(folderPath)
if trim(folderPath)&""="" then
	Exit Function
end if
Set fso=Server.CreateObject("Scripting.FileSystemObject")
	folderPath=Server.MapPath(folderPath)
	'先判断文件夹是否存在，存在则删除
	If fso.FolderExists(folderPath) Then fso.DeleteFolder(folderPath)
set fso=nothing
End Function

'=================================================
'作用：删除文件
'参数：filePath（要删除的文件路径）
'=================================================
Function JuhaoyongDeleteFile(filePath)
if trim(filePath)&""="" then
	Exit Function
end if
Set fso=Server.CreateObject("Scripting.FileSystemObject")
	filePath=Server.MapPath(filePath)
	'先判断文件是否存在，存在则删除
	If fso.FileExists(filePath) then fso.DeleteFile(filePath)
set fso=nothing
End Function

'=================================================
'作用：通用操作结果返回信息（返回加链接地址）
'参数：infotitle（标题）infocontent（显示的操作成功或失败信息）,filepath（点击返回的文件路径和参数字符串）
'=================================================
Function JuhaoyongResultPage(infotitle,infocontent,filepath)
dim strCodeString
					strCodeString= "<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
strCodeString=strCodeString& "	<tr><th class='tableHeaderText'>"&infotitle&"</th></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />"&infocontent&"</font><br /><br /></td></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><a href='"&filepath&"'><font size='+1'>返 回</font></a><br /><br /></td></tr>"
strCodeString=strCodeString& "</table>"
JuhaoyongResultPage=strCodeString
End Function

'=================================================
'作用：通用操作结果返回上一页（返回上一个历史页）
'参数：infotitle（标题）infocontent（显示的操作成功或失败信息）
'=================================================
Function JuhaoyongReturnHistoryPage(infotitle,infocontent)
dim strCodeString
					strCodeString= "<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
strCodeString=strCodeString& "	<tr><th class='tableHeaderText'>"&infotitle&"</th></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />"&infocontent&"</font><br /><br /></td></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><a href=# onclick='history.go(-1)'><font size='+1'>返 回</font></a><br /><br /></td></tr>"
strCodeString=strCodeString& "</table>"
JuhaoyongReturnHistoryPage=strCodeString
End Function

'=================================================
'作用：通用带“确认按钮的”操作结果返回信息，确认则继续执行，返回则不执行
'参数：infotitle（标题）infocontent（显示的操作成功或失败信息）,confirmfilepath（点击确定的文件路径和参数字符串）
'=================================================
Function JuhaoyongConfirmPage(infotitle,infocontent,confirmfilepath)
dim strCodeString
			  strCodeString= "<table cellpadding=3 cellspacing=1 border=0 class=tableBorder align=center>"
strCodeString=strCodeString& "	<tr><th class='tableHeaderText'>"&infotitle&"</th></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><font color='#ff0000' size='+1'><br />"&infocontent&"</font><br /><br /></td></tr>"
strCodeString=strCodeString& "	<tr><td class='jhyabTabletdBgcolor02' align=center><a href='"&confirmfilepath&"'><font size='+1'>确 定</font></a>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=# onclick='history.go(-1)'><font size='+1'>返 回</font></a><br /><br /></td></tr>"
strCodeString=strCodeString& "</table>"
JuhaoyongConfirmPage=strCodeString
End Function

'=================================================
'作用：根据表名、字段名，获取字段值（用于获取“网站设置表”或“首页设置表”中的值）
'参数：tableName
'参数：fieldName
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
'作用：标准格式化“时间”格式
'参数：strtime
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
'作用：标准格式化“日期”格式
'参数：strtime
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
