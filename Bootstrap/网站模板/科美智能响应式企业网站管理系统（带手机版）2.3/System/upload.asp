<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!--#include file="inc/UpLoad_Class.asp"-->
<!-- #include file="inc/rand.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.STYLE1 {font-size: 12px; color:#0000ff;}
-->
</style>
</head>
<body leftmargin="0" topmargin="0">

<%if lcase(request.ServerVariables("REQUEST_METHOD"))="post" then%>

		<%
		'设置保存目录、文件扩展名限制、文件大小限制、父窗口表单输入框name，开始
		dim uploadType,savepath,uploadExe,uploadMaxSize
		uploadType=request.querystring("uploadType")
		Select Case uploadType
			Case "1"
				savepath="../css/"&SITE_STYLE_CSS_FOLDER'文件保存目录
				uploadExe="jpg|bmp|jpeg|gif|png"'上传文件类型限制
				uploadMaxSize=20 * 1024 * 1024 '上传文件大小限制：20M
				parentFormInputName="parent.form1."&request.querystring("juhaoyongForm1InputName")'父窗口表单输入框name
			Case "2"
				savepath="../images/up_images"'文件保存目录
				uploadExe="jpg|bmp|jpeg|gif|png"'上传文件类型限制
				uploadMaxSize=20 * 1024 * 1024 '上传文件大小限制：20M
				parentFormInputName="parent.form1.web_image"'父窗口表单输入框name
			Case "3"
				savepath="../upAttachFile"'文件保存目录
				uploadExe="jpg|bmp|jpeg|gif|rar|zip|txt|doc|xls|ppt|pdf"'上传文件类型限制
				uploadMaxSize=50 * 1024 * 1024 '上传文件大小限制：50M
				parentFormInputName="parent.form1.jhy_fd_fujian"'父窗口表单输入框name
			Case "5"
				savepath="../css/"&MP_SITE_STYLE_CSS_FOLDER'文件保存目录（手机网站上传的图片）
				uploadExe="jpg|bmp|jpeg|gif|png"'上传文件类型限制
				uploadMaxSize=20 * 1024 * 1024 '上传文件大小限制：20M
				parentFormInputName="parent.form1."&request.querystring("juhaoyongForm1InputName")'父窗口表单输入框name			
			Case Else
				savepath="../images/up_images"'文件保存目录
				uploadExe="jpg|bmp|jpeg|gif|png"'上传文件类型限制
				uploadMaxSize=20 * 1024 * 1024 '上传文件大小限制：20M
				parentFormInputName="parent.form1.web_image"'父窗口表单输入框name
		End Select
		'在目录后加(/)
		if right(savepath,1)<>"/" then savepath=savepath&"/"
		'设置保存目录、文件扩展名限制、文件大小限制、父窗口表单输入框name，结束
		
		'设置保存文件名（不包括扩展名）开始
		dim uploadFileOldNameFull,uploadFileOldName,ranNum
		uploadFileOldNameFull=trim(request.querystring("uploadFileOldName"))
		uploadFileOldName=JuhaoyongGetUploadFileName(request.querystring("uploadFileOldName"))
		if trim(uploadFileOldName)="" then
			uploadFileOldName=juhaoyongRndNumber&minute(now)&second(now)
		end if
		'设置保存文件名（不包括扩展名）结束
		
		dim upload,file
		set upload=new AnUpLoad '建立上传对象
		upload.Exe=uploadExe
		upload.MaxSize=uploadMaxSize
		upload.GetData()
	
		if upload.ErrorID>0 then
			response.Write GetErr(upload.ErrorID)
		elseif upload.FileCount<1 then
			response.Write "请选择要上传的图片！"
		else
			
			set file=upload.files("file1")  '生成一个文件对象
			Select Case uploadType
				Case "1"
					file.NewName=uploadFileOldName&Mid(file.LocalName,InStrRev(file.LocalName,"."))
				Case "2"
					file.NewName=uploadFileOldName&Mid(file.LocalName,InStrRev(file.LocalName,"."))
				Case "3"
					file.NewName=file.LocalName
				Case Else
					file.NewName=uploadFileOldName&Mid(file.LocalName,InStrRev(file.LocalName,"."))
			End Select
			
			'------删除旧文件（对比新旧文件名是否相同，不同则删除旧文件）开始------
			if uploadFileOldNameFull<>file.LocalName then call JHYDeleteFile(savepath&uploadFileOldNameFull)
			'------删除旧文件（对比新旧文件名是否相同，不同则删除旧文件）结束------
			
			'------保存文件开始------
			if file.isfile and upload.TotalSize>0 then '如果 TotalSize > 0 说明有文件数据
				result = file.saveToFile(savepath,0,true)'保存文件，同名文件覆盖保存
				if result then
					msg = file.filename
				else
					msg = file.Exception
				end if
				response.Write GetErr(upload.ErrorID)
				response.write "<script>"&parentFormInputName&".value='"&file.filename&"'</script>"
			end if
			'------保存文件结束------
			
			set file=nothing
		end if
		set upload=nothing  ''删除此对象
		%>
	
<%else%>

		<%
		uploadType=trim(request.querystring("uploadType"))
		uploadFileOldName=trim(request.querystring("uploadFileOldName"))
		juhaoyongForm1InputName=trim(request.querystring("juhaoyongForm1InputName"))
		
		Select Case uploadType
			Case "1"
				uploadNotesString="格式：jpg|gif|bmp|png，大小：< 20M"
			Case "2"
				uploadNotesString="格式：jpg|gif|bmp|png，大小：< 20M"
			Case "3"
				uploadNotesString="格式：jpg|bmp|gif|rar|zip|txt|doc|xls|ppt|pdf，大小：< 50M"
			Case Else
				uploadNotesString="格式：jpg|gif|bmp|png，大小：< 20M"
		End Select
		%>
		<form  method="post" enctype="multipart/form-data" action="upload.asp?uploadType=<%=uploadType%>&uploadFileOldName=<%=uploadFileOldName%>&juhaoyongForm1InputName=<%=juhaoyongForm1InputName%>">
		<table>
		  <tr>
			<td width="350"><input class=c type="file" name="file1" size=10> <input type="submit" name="Submit" value="上传" style="width:50px; height:22px;"></td>
			<td width="400"><span class="jhyabTabletdBgcolor02 STYLE1"><%=uploadNotesString%></span></td>
		  </tr>
		</table>
		</form>
		
<%end if%>


<%
'****************************************************
'作  用：获取上传结果信息
'参  数：上传结果对应的数字
'****************************************************
Private Function GetErr(ByVal Num)
	Select Case Num
		Case 0
			GetErr = "<span class='jhyabTabletdBgcolor02 STYLE1'>&nbsp;&nbsp;上传成功！</span>"
		Case 1
			GetErr = "<span class='jhyabTabletdBgcolor02 STYLE1'>&nbsp;&nbsp;上传失败！上传文件大小超过限制!</span>"
		Case 2
			GetErr = "未设置上传表单enctype属性为multipart/form-data或者未设置method属性为Post,上传无效!"
		Case 3
			GetErr = "含有非法扩展名文件!"
		Case 4
			GetErr = "对不起,程序不允许使用相同name属性的文件域!"
		Case 5
			GetErr = "单个文件大小超出上传限制!"
	End Select
End Function
'****************************************************
'作  用：获取文件名（去掉扩展名）
'参  数：带文件夹或网址的文件名
'****************************************************
function JuhaoyongGetUploadFileName(fileName)
dim ranNum
if trim(fileName)="" or trim(fileName)="/" then
	ranNum=int(90000*rnd)+10000
	JuhaoyongGetUploadFileName=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&ranNum
else
    dim pos
    pos=InStrRev(filename,"/")
    if pos>0 and pos<Len(filename) then
        JuhaoyongGetUploadFileName=mid(fileName,pos+1)
    elseif pos=Len(filename) then
		JuhaoyongGetUploadFileName=left(fileName,InStrRev(fileName,"/")-1)
	else
		JuhaoyongGetUploadFileName=filename
    end if
	
	if InStrRev(JuhaoyongGetUploadFileName,".")>0 then
	JuhaoyongGetUploadFileName=left(JuhaoyongGetUploadFileName,InStrRev(JuhaoyongGetUploadFileName,".")-1)
	end if
end if
end function
'==================================================
'函数名：JHYDeleteFile
'作  用：删除文件
'参  数：FilePath ------ 要删除的文件的相对路径（包括文件名）
'==================================================
Function JHYDeleteFile(FilePath)
dim fso,AbsolutePath
Set fso=Server.CreateObject("Scripting.FileSystemObject")
AbsolutePath=Server.MapPath(FilePath)
'判断文件是否存在，否则删除
If fso.FileExists(AbsolutePath) then
	fso.DeleteFile(AbsolutePath)
end if
set fso=nothing
End Function
%>
</body>
</html>



