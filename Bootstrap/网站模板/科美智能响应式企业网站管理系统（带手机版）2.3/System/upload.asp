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
		'���ñ���Ŀ¼���ļ���չ�����ơ��ļ���С���ơ������ڱ������name����ʼ
		dim uploadType,savepath,uploadExe,uploadMaxSize
		uploadType=request.querystring("uploadType")
		Select Case uploadType
			Case "1"
				savepath="../css/"&SITE_STYLE_CSS_FOLDER'�ļ�����Ŀ¼
				uploadExe="jpg|bmp|jpeg|gif|png"'�ϴ��ļ���������
				uploadMaxSize=20 * 1024 * 1024 '�ϴ��ļ���С���ƣ�20M
				parentFormInputName="parent.form1."&request.querystring("juhaoyongForm1InputName")'�����ڱ������name
			Case "2"
				savepath="../images/up_images"'�ļ�����Ŀ¼
				uploadExe="jpg|bmp|jpeg|gif|png"'�ϴ��ļ���������
				uploadMaxSize=20 * 1024 * 1024 '�ϴ��ļ���С���ƣ�20M
				parentFormInputName="parent.form1.web_image"'�����ڱ������name
			Case "3"
				savepath="../upAttachFile"'�ļ�����Ŀ¼
				uploadExe="jpg|bmp|jpeg|gif|rar|zip|txt|doc|xls|ppt|pdf"'�ϴ��ļ���������
				uploadMaxSize=50 * 1024 * 1024 '�ϴ��ļ���С���ƣ�50M
				parentFormInputName="parent.form1.jhy_fd_fujian"'�����ڱ������name
			Case "5"
				savepath="../css/"&MP_SITE_STYLE_CSS_FOLDER'�ļ�����Ŀ¼���ֻ���վ�ϴ���ͼƬ��
				uploadExe="jpg|bmp|jpeg|gif|png"'�ϴ��ļ���������
				uploadMaxSize=20 * 1024 * 1024 '�ϴ��ļ���С���ƣ�20M
				parentFormInputName="parent.form1."&request.querystring("juhaoyongForm1InputName")'�����ڱ������name			
			Case Else
				savepath="../images/up_images"'�ļ�����Ŀ¼
				uploadExe="jpg|bmp|jpeg|gif|png"'�ϴ��ļ���������
				uploadMaxSize=20 * 1024 * 1024 '�ϴ��ļ���С���ƣ�20M
				parentFormInputName="parent.form1.web_image"'�����ڱ������name
		End Select
		'��Ŀ¼���(/)
		if right(savepath,1)<>"/" then savepath=savepath&"/"
		'���ñ���Ŀ¼���ļ���չ�����ơ��ļ���С���ơ������ڱ������name������
		
		'���ñ����ļ�������������չ������ʼ
		dim uploadFileOldNameFull,uploadFileOldName,ranNum
		uploadFileOldNameFull=trim(request.querystring("uploadFileOldName"))
		uploadFileOldName=JuhaoyongGetUploadFileName(request.querystring("uploadFileOldName"))
		if trim(uploadFileOldName)="" then
			uploadFileOldName=juhaoyongRndNumber&minute(now)&second(now)
		end if
		'���ñ����ļ�������������չ��������
		
		dim upload,file
		set upload=new AnUpLoad '�����ϴ�����
		upload.Exe=uploadExe
		upload.MaxSize=uploadMaxSize
		upload.GetData()
	
		if upload.ErrorID>0 then
			response.Write GetErr(upload.ErrorID)
		elseif upload.FileCount<1 then
			response.Write "��ѡ��Ҫ�ϴ���ͼƬ��"
		else
			
			set file=upload.files("file1")  '����һ���ļ�����
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
			
			'------ɾ�����ļ����Ա��¾��ļ����Ƿ���ͬ����ͬ��ɾ�����ļ�����ʼ------
			if uploadFileOldNameFull<>file.LocalName then call JHYDeleteFile(savepath&uploadFileOldNameFull)
			'------ɾ�����ļ����Ա��¾��ļ����Ƿ���ͬ����ͬ��ɾ�����ļ�������------
			
			'------�����ļ���ʼ------
			if file.isfile and upload.TotalSize>0 then '��� TotalSize > 0 ˵�����ļ�����
				result = file.saveToFile(savepath,0,true)'�����ļ���ͬ���ļ����Ǳ���
				if result then
					msg = file.filename
				else
					msg = file.Exception
				end if
				response.Write GetErr(upload.ErrorID)
				response.write "<script>"&parentFormInputName&".value='"&file.filename&"'</script>"
			end if
			'------�����ļ�����------
			
			set file=nothing
		end if
		set upload=nothing  ''ɾ���˶���
		%>
	
<%else%>

		<%
		uploadType=trim(request.querystring("uploadType"))
		uploadFileOldName=trim(request.querystring("uploadFileOldName"))
		juhaoyongForm1InputName=trim(request.querystring("juhaoyongForm1InputName"))
		
		Select Case uploadType
			Case "1"
				uploadNotesString="��ʽ��jpg|gif|bmp|png����С��< 20M"
			Case "2"
				uploadNotesString="��ʽ��jpg|gif|bmp|png����С��< 20M"
			Case "3"
				uploadNotesString="��ʽ��jpg|bmp|gif|rar|zip|txt|doc|xls|ppt|pdf����С��< 50M"
			Case Else
				uploadNotesString="��ʽ��jpg|gif|bmp|png����С��< 20M"
		End Select
		%>
		<form  method="post" enctype="multipart/form-data" action="upload.asp?uploadType=<%=uploadType%>&uploadFileOldName=<%=uploadFileOldName%>&juhaoyongForm1InputName=<%=juhaoyongForm1InputName%>">
		<table>
		  <tr>
			<td width="350"><input class=c type="file" name="file1" size=10> <input type="submit" name="Submit" value="�ϴ�" style="width:50px; height:22px;"></td>
			<td width="400"><span class="jhyabTabletdBgcolor02 STYLE1"><%=uploadNotesString%></span></td>
		  </tr>
		</table>
		</form>
		
<%end if%>


<%
'****************************************************
'��  �ã���ȡ�ϴ������Ϣ
'��  �����ϴ������Ӧ������
'****************************************************
Private Function GetErr(ByVal Num)
	Select Case Num
		Case 0
			GetErr = "<span class='jhyabTabletdBgcolor02 STYLE1'>&nbsp;&nbsp;�ϴ��ɹ���</span>"
		Case 1
			GetErr = "<span class='jhyabTabletdBgcolor02 STYLE1'>&nbsp;&nbsp;�ϴ�ʧ�ܣ��ϴ��ļ���С��������!</span>"
		Case 2
			GetErr = "δ�����ϴ���enctype����Ϊmultipart/form-data����δ����method����ΪPost,�ϴ���Ч!"
		Case 3
			GetErr = "���зǷ���չ���ļ�!"
		Case 4
			GetErr = "�Բ���,��������ʹ����ͬname���Ե��ļ���!"
		Case 5
			GetErr = "�����ļ���С�����ϴ�����!"
	End Select
End Function
'****************************************************
'��  �ã���ȡ�ļ�����ȥ����չ����
'��  �������ļ��л���ַ���ļ���
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
'��������JHYDeleteFile
'��  �ã�ɾ���ļ�
'��  ����FilePath ------ Ҫɾ�����ļ������·���������ļ�����
'==================================================
Function JHYDeleteFile(FilePath)
dim fso,AbsolutePath
Set fso=Server.CreateObject("Scripting.FileSystemObject")
AbsolutePath=Server.MapPath(FilePath)
'�ж��ļ��Ƿ���ڣ�����ɾ��
If fso.FileExists(AbsolutePath) then
	fso.DeleteFile(AbsolutePath)
end if
set fso=nothing
End Function
%>
</body>
</html>



