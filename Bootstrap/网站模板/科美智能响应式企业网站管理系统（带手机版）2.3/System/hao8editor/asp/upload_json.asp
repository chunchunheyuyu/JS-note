<%@ CODEPAGE=65001 %>
<% Option Explicit %>
<% Response.CodePage=65001 %>
<% Response.Charset="UTF-8" %>
<!--#include file="UpLoad_Class.asp"-->
<!--#include file="JSON_2.0.4.asp"-->
<%

' KindEditor ASP

Dim aspUrl, savePath,  maxSize, fileName, fileExt, newFileName, filePath, fileUrl, dirName
Dim extStr, imageExtStr, flashExtStr, mediaExtStr, fileExtStr
Dim upload, file, fso, ranNum, hash, result


'文件保存目录路径
savePath = "../../../images/"

'定义允许上传的文件扩展名
imageExtStr = "gif|jpg|jpeg|png|bmp"
flashExtStr = "swf|flv"
mediaExtStr = "swf|flv|mp3|wav|wma|wmv|mid|avi|mpg|asf|rm|rmvb"
fileExtStr = "doc|docx|xls|xlsx|ppt|htm|html|txt|zip|rar|gz|bz2"

maxSize = 50 * 1024 * 1024 '文件大小限制50M

Set fso = Server.CreateObject("Scripting.FileSystemObject")
If Not fso.FolderExists(Server.mappath(savePath)) Then
	showError("上传目录不存在。")
End If

dirName = Request.QueryString("dir")
If isEmpty(dirName) Then
	dirName = "image"
End If
If instr(lcase("image,flash,media,file"), dirName) < 1 Then
	showError("目录名不正确。")
End If

Select Case dirName
	Case "flash" extStr = flashExtStr
	Case "media" extStr = mediaExtStr
	Case "file" extStr = fileExtStr
	Case Else  extStr = imageExtStr
End Select

set upload = new AnUpLoad
upload.Exe = extStr
upload.MaxSize = maxSize
upload.GetData()
if upload.ErrorID>0 then 
	showError(upload.Description)
end if

'创建文件夹
savePath = savePath & dirName & "/"
If Not fso.FolderExists(Server.mappath(savePath)) Then
	fso.CreateFolder(Server.mappath(savePath))
End If

set file = upload.files("imgFile")
if file is nothing then
	showError("请选择文件。")
end if

set result = file.saveToFile(savePath, 0, true)
if result.error then
	showError(file.Exception)
end if

filePath = Server.mappath(savePath & file.filename)
filename = file.filename

Set upload = nothing
Set file = nothing

If Not fso.FileExists(filePath) Then
	showError("上传文件失败。")
End If

Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
Set hash = jsObject()
hash("error") = 0
hash("url") = "../images/"& dirName & "/" & filename
hash.Flush
Response.End

Function showError(message)
	Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
	Dim hash
	Set hash = jsObject()
	hash("error") = 1
	hash("message") = message
	hash.Flush
	Response.End
End Function
%>
