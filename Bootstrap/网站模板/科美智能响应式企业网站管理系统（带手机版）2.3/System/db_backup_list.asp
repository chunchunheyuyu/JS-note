<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="inc/head.asp" -->
<script language="javascript">
//全选JS
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
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">数据库在线备份</th>
	</tr>
	
	<tr>
		<td height="50"><div align="center">
		<font color="#993300">功能说明：把数据库拷贝到目录：<%=DB_BACKUP_PATH_FOLDER%>下，可以用于还原，也可以删除</font>
		</div></td>
	</tr>
	
	<tr>
		<td height="20">
			<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr><td height="20"><a href="db_backup.asp?operate=1">添加数据库备份</a></td></tr>
			</table>
		</td>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02">
	<form name="form2" method="post" action="db_backup_del.asp?action=AllDel">
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="5%" height="30" class="TitleHighlight"><div align="center"></div></td>
            <td width="20%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">备份数据库文件名</div></td>
			<td width="15%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">文件大小</div></td>
			<td width="15%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">所在目录</div></td>
			<td width="15%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">备份时间</div></td>
            <td width="15%" height="30" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">恢复备份</div></td>
            <td width="15%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">删除备份</div></td>
          </tr>

<%
dim folderPath,fileNumCount
folderPath="../"&DB_BACKUP_PATH_FOLDER
fileNumCount=0

dim fso,fod,x
set fso=Server.CreateObject("Scripting.FileSystemObject")
If fso.FolderExists(Server.MapPath(folderPath))=true Then
	set fod=fso.GetFolder(Server.MapPath(folderPath))
	for each x in fod.files
		fileNumCount=fileNumCount+1
		if fileNumCount mod 2 =0 then
			class_style="jhyabTabletdBgcolor02"
		else
			class_style="jhyabTabletdBgcolor01"
		end if
%>
		<tr>
            <td class='<%=class_style%>'><div align="center"><input type="checkbox" name="Selectitem" id="Selectitem" value="<%=x.Name%>"></div></td>
            <td class='<%=class_style%>'><%=x.Name%></td>
			<td class='<%=class_style%>'><%=Formatnumber(x.Size/1024/1024,3,-1)%>M</td>
			<td class='<%=class_style%>'><%=DB_BACKUP_PATH_FOLDER%>/</td>
			<td class='<%=class_style%>'><%=x.DateCreated%></td>
            <td class='<%=class_style%>' align="center"><a href="db_backup_restore.asp?operate=1&file_path_name=<%=x.Name%>"><font color="#FF0000"><strong>恢复此备份</strong></font></a></td>
			<td class='<%=class_style%>' align="center"><a href="db_backup_del.asp?file_path_name=<%=x.Name%>">删除</a></div></td>
        </tr>
<%		
	next
	set fod=nothing
end if
set fso=nothing
%>
		  <tr >
          <td height="35"  colspan="6" >
          &nbsp;<input name='chkAll' type='checkbox' id='chkAll' onclick='CheckAll(this.form)' value='checkbox'> 全选/全不选
          &nbsp;<input type="submit" name="Submit" value="删除选中">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          共：<font color="#FF0000"><strong><%=fileNumCount%></strong></font> 个备份
          <br /><br />
          <font color="#FF0000" size="+1"><strong>（温馨提醒，删除后则无法恢复，请慎重，为了安全，删除前请先通过ftp下载到本地电脑备份。）</strong></font>
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
