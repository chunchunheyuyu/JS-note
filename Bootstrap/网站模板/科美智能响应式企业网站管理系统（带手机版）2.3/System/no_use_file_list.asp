<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->
<script language="javascript">
//ȫѡJS
function unselectall(){
if(document.form2.chkAll.checked){
document.form2.chkAll.checked = document.form2.chkAll.checked&0;
}
}
function CheckAll(form){
for (var i=0;i<form.elements.length;i++){
var e = form.elements[i];
if (e.Name != 'chkAll'&&e.disabled==false)
e.checked = form.chkAll.checked;
}
}
</script>
<%
'�������з����ļ��ַ�����ʼ
dim resultimage,resultflash,resultmedia,resultfile
resultimage=GetInFolderFilesNameString("../images/image")
resultflash=GetInFolderFilesNameString("../images/flash")
resultmedia=GetInFolderFilesNameString("../images/media")
resultfile=GetInFolderFilesNameString("../images/file")
set rs=server.createobject("adodb.recordset") 

if resultimage<>"" or resultflash<>"" or resultmedia<>"" or resultfile<>"" then
'��ѯ������ºͲ�Ʒ�������Ƿ��õ���Щ�ļ���û�õ����г�
sql="select [content] from juhaoyong_tb_content"
rs.open sql,cn,1,1
if not rs.eof then
	do while not rs.eof
		if resultimage<>"" then resultimage=NotInContentFileNameString(resultimage,rs("content"))
		if resultflash<>"" then resultflash=NotInContentFileNameString(resultflash,rs("content"))
		if resultmedia<>"" then resultmedia=NotInContentFileNameString(resultmedia,rs("content"))
		if resultfile<>"" then resultfile=NotInContentFileNameString(resultfile,rs("content"))
	rs.movenext
	loop
end if
rs.close

'��ѯ��ⵥҳ�����Ƿ��õ���Щ�ļ���û�õ����г�
sql="select [content] from juhaoyong_tb_directory"
rs.open sql,cn,1,1
if not rs.eof then
	do while not rs.eof
		if resultimage<>"" then resultimage=NotInContentFileNameString(resultimage,rs("content"))
		if resultflash<>"" then resultflash=NotInContentFileNameString(resultflash,rs("content"))
		if resultmedia<>"" then resultmedia=NotInContentFileNameString(resultmedia,rs("content"))
		if resultfile<>"" then resultfile=NotInContentFileNameString(resultfile,rs("content"))
	rs.movenext
	loop
end if
rs.close
set rs=nothing
'�������з����ļ��ַ�������
end if
%>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">����ͼƬ���ļ�ɾ������</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02">
	<form name="form2" method="post" action="no_use_file_del.asp?action=AllDel">
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="5%" height="30" class="TitleHighlight"><div align="center"></div></td>
            <td width="10%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">�����ļ���</div></td>
            <td width="20%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">�ļ���</div></td>
            <td width="5%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">�ļ�����</div></td>
            <td width="20%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">�鿴�������ļ�</div></td>
            <td width="15%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">����</div></td>
          </tr>

<%
dim imageNum,flashNum,mediaNum,fileNum
imageNum=NotUseFileList(resultimage,"ͼƬ","image")
flashNum=NotUseFileList(resultflash,"flash","flash")
mediaNum=NotUseFileList(resultmedia,"��Ƶ�ļ�","media")
fileNum=NotUseFileList(resultfile,"�ļ�","file")
%>
<%
'=================================================
'���ã������ļ��б���
'=================================================
function NotUseFileList(fileNameString,infoname,filepath)
dim fileNumCount
fileNumCount=0
if fileNameString&""<>"" then
dim rString,fnArray
dim counti,cchccount
fnArray=split(fileNameString,",")
cchccount=ubound(fnArray)

for counti=0 to cchccount
	if trim(fnArray(counti)&"")<>"" then
		fileNumCount=fileNumCount+1
		if fileNumCount mod 2 =0 then
			class_style="jhyabTabletdBgcolor02"
		else
			class_style="jhyabTabletdBgcolor01"
		end if
%>
		<tr>
            <td class='<%=class_style%>'><div align="center"><input type="checkbox" name="Selectitem" id="Selectitem" value="<%=filepath&"/"&fnArray(counti)%>"></div></td>
            <td class='<%=class_style%>'>images/<%=filepath%></td>
            <td class='<%=class_style%>'><%=fnArray(counti)%></td>
            <td class='<%=class_style%>'><%=infoname%></td>
            <td class='<%=class_style%>' align="center"><a href="../images/<%=filepath%>/<%=fnArray(counti)%>" target="_blank"><font color="#FF0000"><strong>�������鿴����"�Ҽ����"����</strong></font></a></td>
			<td class='<%=class_style%>' align="center"><a href="no_use_file_del.asp?file_path_name=<%=filepath&"/"&fnArray(counti)%>">ɾ��</a></div></td>
        </tr>
<%		
	end if
next
end if
NotUseFileList=fileNumCount
end function
%>
		  <tr >
          <td height="35"  colspan="6" >
          &nbsp;<input name='chkAll' type='checkbox' id='chkAll' onclick='CheckAll(this.form)' value='checkbox'> ȫѡ/ȫ��ѡ
          &nbsp;<input type="submit" name="Submit" value="ɾ��ѡ��">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ��������
          <font color="#FF0000"><strong><%=imageNum%></strong></font> ��ͼƬ�� 
		  <font color="#FF0000"><strong><%=flashNum%></strong></font> ��flash�� 
		  <font color="#FF0000"><strong><%=mediaNum%></strong></font> ����Ƶ�� 
		  <font color="#FF0000"><strong><%=fileNum%></strong></font> ���ļ�
          ���ϼƣ�
		  <font color="#0066cc"><strong><%=imageNum+flashNum+mediaNum+fileNum%></strong></font> ��
          <br /><br />
          <font color="#FF0000" size="+1"><strong>����ܰ���ѣ�ɾ�������޷��ָ��������أ��������Ҫ�ļ�������ͨ��ftp���ص����ص��Ա��ݡ���</strong></font>
          <br /><br /><br />
          </td>
          </tr>
      </table>
      </form>
	    </td>
	</tr>
	</table><br /><br />

<%
Call DbconnEnd()
%>

<%
'=================================================
'���ã�����һ��Ŀ¼�������ļ������Զ��ŷָ���ɵ��ַ���
'=================================================
function GetInFolderFilesNameString(folderPath)
dim fileNameString
fileNameString=""
dim fs,fo,x
set fs=Server.CreateObject("Scripting.FileSystemObject")
If fs.FolderExists(Server.MapPath(folderPath))=true Then
	set fo=fs.GetFolder(Server.MapPath(folderPath))
	for each x in fo.files
	  fileNameString=fileNameString&","&x.Name
	next
	set fo=nothing
end if
set fs=nothing
GetInFolderFilesNameString=fileNameString
end function

'=================================================
'���ã����û��������ʹ�õ��ļ���������δ���ֵ��ļ����ַ���
'=================================================
function NotInContentFileNameString(fileNameString,contentString)
if trim(fileNameString&"")="" then
	NotInContentFileNameString=""
	Exit Function
end if
dim rString,fnArray
dim counti,cchccount
rString=""
fnArray=split(fileNameString,",")
cchccount=ubound(fnArray)

for counti=0 to cchccount
	if trim(fnArray(counti)&"")<>"" then
		if instr(contentString,fnArray(counti))=0 then
			rString=rString&","&trim(fnArray(counti))
		end if
	end if
next

NotInContentFileNameString=rString
end function
%>