<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!--#include file="inc/functions.asp"-->
<!--#include file="inc/page_next.asp"-->

<!-- ���������˵� ��ʼ -->
<script language="JavaScript">
<!--
<%
'�������ݱ��浽����
Dim count2,rsClass2,sqlClass2
set rsClass2=server.createobject("adodb.recordset")
sqlClass2="select id,jhy_fd_dir_parentid,name from juhaoyong_tb_directory where jhy_fd_dir_parentid>0 and ClassType=1 order by id " 
rsClass2.open sqlClass2,cn,1,1
%>
var subval2 = new Array();
//����ṹ��һ����ֵ,������ֵ,������ʾֵ
<%
count2 = 0
do while not rsClass2.eof
%>
subval2[<%=count2%>] = new Array('<%=rsClass2("jhy_fd_dir_parentid")%>','<%=rsClass2("id")%>','<%=rsClass2("Name")%>')
<%
count2 = count2 + 1
rsClass2.movenext
loop
rsClass2.close
set rsClass2=nothing
%>

function JuhaoyongSelectTwoIdList(locationid)
{
    document.form1.twoid.length = 0;
    document.form1.twoid.options[0] = new Option('ѡ���������','');
    for (i=0; i<subval2.length; i++)
    {
        if (subval2[i][0] == locationid)
        {document.form1.twoid.options[document.form1.twoid.length] = new Option(subval2[i][2],subval2[i][1]);}
    }
}

//-->
</script><!-- ���������˵� ���� -->
<%
dim act,keywords,oneid,twoid
dim rs,sql,sql_where
act=request.querystring("act")
keywords=trim(request("keywords"))

oneid=request("oneid")
twoid=request("twoid")

jhy_page_levelone_id=oneid
jhy_page_leveltwo_id=twoid

sql_where=""

if act="search" then
	if oneid="" and twoid&""="" then
		sql_where="where [title] like '%"&keywords&"%' and ArticleType=1"
	elseif oneid<>"" and twoid&""="" then
		sql_where="where jhy_fd_levelone_id='"&oneid&"' and [title] like '%"&keywords&"%' and ArticleType=1"
	else
		sql_where="where jhy_fd_levelone_id='"&oneid&"' and jhy_fd_leveltwo_id='"&twoid&"' and [title] like '%"&keywords&"%' and ArticleType=1"
	end if
else
	sql_where="where jhy_fd_levelone_id='"&oneid&"' and jhy_fd_leveltwo_id='"&twoid&"' and ArticleType=1"
end if

sql="select id,title,jhy_fd_levelone_id,jhy_fd_leveltwo_id,html_file_name,image,index_push,hit,ip,edit_time from juhaoyong_tb_content "&sql_where&" order by edit_time desc"
%>

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
<!-- #include file="inc/head.asp" -->
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">�����б�</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" class='TipTitle'>����˵����</td>
          </tr>
          <tr>
            <td height="30" valign="top" class="TipWords">
				<p>1����ӡ��޸����º�ǰ̨���Զ����ɾ�̬��</p>
				<p>2����δ��ˡ�״̬��ǰ̨����ʾ��</p>
            </td>
          </tr>
          <tr>
            <td height="10" ></td>
          </tr>
        </table>

	    

<ul class=HoutaiArticleDaohang><li>
<%if oneid<>"" then%>
&nbsp;<img src=images/juhaoyongdaohangjiantou.gif border="0" />��<a href="abjhy_article_list.asp?oneid=<%=oneid%>"><%=JuhaoyongGetLanmuName(oneid)%></a>
<%end if%>

<%if twoid<>"" then%>
>> <a href="abjhy_article_list.asp?oneid=<%=oneid%>&twoid=<%=twoid%>"><%=JuhaoyongGetLanmuName(twoid)%></a>
<%end if%>

</li></ul>

<%
if oneid<>"" and twoid="" then
Call JuhaoyongGetLowerFolderNameList(1,oneid)
end if
%>
 	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25"><a href="abjhy_article_add.asp?oneid=<%=oneid%>&twoid=<%=twoid%>&act=<%=act%>">�������</a></td>
          </tr>
		</table>
		<table width="95%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <%if act<>"search" then%><td width="2%" height="30" class="TitleHighlight">&nbsp;</td><%end if%>
            <td width="4%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">���</div></td>
            <td width="37%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">���±���</div></td>
            <td width="8%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">��ҳ�ö�</div></td>
            <td width="15%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">���·���</div></td>
            <td width="6%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">ip/pv</div></td>
            <td width="15%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">����ʱ��</div></td>
            <td width="8%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">���²���</div></td>
          </tr>
<% '�����б�ģ��
strFileName="abjhy_article_list.asp" 
pageno=25
set rs = server.CreateObject("adodb.recordset")
rs.Open (sql),cn,1,1
rscount=rs.recordcount
if not rs.eof and not rs.bof then
call showsql(pageno)
rs.move(rsno)
for p_i=1 to loopno
%>

<% if p_i mod 2 =0 then
class_style="jhyabTabletdBgcolor02"
else
class_style="jhyabTabletdBgcolor01"
end if
%>

<%
'��ȡ�ļ������ļ���
if rs("jhy_fd_leveltwo_id")&""<>"" then
	strContentDirFolder=GetContentDirFolder(rs("jhy_fd_leveltwo_id"),2)
else
	strContentDirFolder=GetContentDirFolder(rs("jhy_fd_levelone_id"),1)
end if
%>
          <form name="form2" method="post" action="abjhy_article_del.asp?action=AllDel&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">
          <tr>
            <%if act<>"search" then%><td   height="30" class='<%=class_style%>'><div align="center"><input type="checkbox" name="Selectitem" value="<%=rs("id")%>"></div></td><%end if%>
            <td   height="30" class='<%=class_style%>'><div align="center"><%=rs("id")%></div></td>
            <td class='<%=class_style%>'>&nbsp;<a href="<%=strContentDirFolder&"/"&rs("html_file_name")%>" target="_blank" title="<%=rs("title")%>"><%=left(rs("title"),26)%></a><%if rs("image")<>"" then%>&nbsp;[<span style="color: #FF0000">ͼ</span>]<%end if%><%if rs("index_push")=1 then%>&nbsp;[<span style="color: #FF0000">��</span>]<%end if%></td>
            <td class='<%=class_style%>'>
            	<div align="center">
				<%if rs("index_push")=1 then%>
				  <font color="#006600">[���ö�]</font> <a href="abjhy_article_index_push.asp?id=<%=rs("id")%>&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>"><font color="#666600" style="text-decoration:underline; font-weight:bold;">ȡ��</font></a>
				<%else%>
				  <font color="#666666">[δ�ö�]</font> <a href="abjhy_article_index_push.asp?id=<%=rs("id")%>&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>"><font color="#ff0000" style="text-decoration:underline; font-weight:bold;">�ö�</font></a>
				<%end if%>
                </div>
            </td>
            <td class='<%=class_style%>' >&nbsp;
			<% '������ʾ
			set rs1=server.createobject("adodb.recordset")
			sql="select name from juhaoyong_tb_directory where id="&cint(rs("jhy_fd_levelone_id"))&""
			rs1.open(sql),cn,1,1
			if not rs1.eof and not rs1.bof then
			response.write rs1("name")
			response.write "&nbsp;>&nbsp;"
			end if
			rs1.close

			
			if rs("jhy_fd_leveltwo_id")<>"" then
			sql="select name from juhaoyong_tb_directory where id="&cint(rs("jhy_fd_leveltwo_id"))&""
			rs1.open(sql),cn,1,1
				if not rs1.eof and not rs1.bof then
				response.write rs1("name")
				response.write "&nbsp;>&nbsp;"
				end if
			rs1.close
			end if

			set rs1=nothing
			%>            </td>
            <td class='<%=class_style%>'><div align="center"><%=rs("ip")%>/<%=rs("hit")%></div></td>
            <td class='<%=class_style%>'><div align="center"><%=rs("edit_time")%></div></td>
            <td class='<%=class_style%>'>
            <div align="center"><a href="abjhy_article_edit.asp?id=<%=rs("id")%>&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">�޸�</a> | 
                                 <a href="abjhy_article_del.asp?id=<%=rs("id")%>&oneid=<%=oneid%>&twoid=<%=twoid%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">ɾ��</a>
            </div>
            </td>
          </tr>
		  <%
		  rs.movenext
		  next
		  else
			response.write "<div align='center'><span style='color: #FF0000'>�������£�</span></div>"
		  end if 
		  rs.close
		  set rs=nothing
		  %>
		     <%if act<>"search" then%>
             <tr>
             	<td height="35"  colspan="8" >&nbsp;
                <input name='chkAll' type='checkbox' id='chkAll' onclick='CheckAll(this.form)' value='checkbox'>ȫѡ/ȫ��ѡ&nbsp;
                <input type="submit" name="Submit" value="ɾ��ѡ��">
                </td>
             </tr>
			 <%end if%>
            <tr  >
              <td height="35"  colspan="8" ><div align="center">
				<%call showpage_AritcleProduct(strFileName,rscount,pageno,false,true,"",jhy_page_levelone_id,jhy_page_leveltwo_id)%>
           </div></td>
		    </tr>
      </table> </form>  
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="20" class="jhyabTabletdBgcolor02">&nbsp;</td>
          </tr>
          <tr>
            <td height="25" align="center">��������</td>
          </tr>
          <tr>
            <td height="70"><form name="form1" method="post" action="?act=search">
              <div align="center">
<%
Dim count1,rsClass1,sqlClass1
set rsClass1=server.createobject("adodb.recordset")
sqlClass1="select id,name from juhaoyong_tb_directory where jhy_fd_dir_parentid=0 and ClassType=1 order by id"
rsClass1.open sqlClass1,cn,1,1
%>
            <select name="oneid" id="oneid" onChange="JuhaoyongSelectTwoIdList(this.value)">
              <option value="">ѡ��һ������</option>
<%
count1 = 0
do while not rsClass1.eof
response.write"<option value="&rsClass1("id")&">"&rsClass1("Name")&"</option>"
count1 = count1 + 1
rsClass1.movenext
loop
rsClass1.close
set rsClass1=nothing
%>
            </select>
            &nbsp;&nbsp;
            <select name="twoid" id="twoid">
              <option value="">ѡ���������</option>
            </select>
            
			<input name="keywords" type="text"  size="35" maxlength="40">&nbsp;
            <input type="submit" name="Submit" value="�� ��">
            </div>
            </form>
            </td>
          </tr>
      </table>
	    <br></td>
	</tr>
	</table><br /><br /><br /><br />

<%
Call DbconnEnd()
 %>