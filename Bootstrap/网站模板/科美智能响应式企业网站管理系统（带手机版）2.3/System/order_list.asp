<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!--#include file="inc/functions.asp"-->
<!--#include file="inc/page_next.asp"-->

<%
'����ģ��
act=request.querystring("act")
keywords=trim(request.form("keywords"))

s_sql="select * from juhaoyong_tb_order where [content] like '%"&keywords&"%' or [name] like '%"&keywords&"%' or [address] like '%"&keywords&"%' or [tel] like '%"&keywords&"%' or [order_product_name] like '%"&keywords&"%' or [qq] like '%"&keywords&"%' or [email] like '%"&keywords&"%' order by [time] desc "
 
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
 <form name="form2" method="post" action="order_Del.asp?action=AllDel&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">
	    
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr>
            <td width="2%" class="TitleHighlight">&nbsp;</td>
            <td width="12%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">�µ�ʱ��</div></td>
            <td width="4%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">���</div></td>
            <td width="18%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">������Ʒ</div></td>
            <td width="3%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">����</div></td>
            <td width="5%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">����</div></td>
            <td width="5%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">��ϵ��</div></td>
            <td width="10%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">��ϵ��ַ</div></td>
            <td width="9%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">��ϵ�绰</div></td>
            <td width="11%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">��������</div></td>
            <td width="9%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">QQ</div></td>
            <td width="9%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">��ע</div></td>
            <td width="3%" class="TitleHighlight"><div align="center" style="font-weight: bold;color:#ffffff">����</div></td>
          </tr>
<%
'�����б�
strFileName="order_list.asp"
pageno=100
set rs = server.CreateObject("adodb.recordset")
rs.Open (s_sql),cn,1,1
rscount=rs.recordcount
if not rs.eof and not rs.bof then
call showsql(pageno)
rs.move(rsno)
for p_i=1 to loopno
%>

          <tr >
            <td class="jhyabTabletdBgcolor01" height="30" ><div align="center"><input type="checkbox" name="Selectitem" id="Selectitem" value="<%=rs("id")%>"></div></td>
            <td class="jhyabTabletdBgcolor01" ><div align="center"><%=rs("time")%></div></td>
            <td class="jhyabTabletdBgcolor01"><div align="center"><%=rs("id")%></div></td>
            <td class="jhyabTabletdBgcolor01" >
			<%
			set rst=server.createobject("adodb.recordset")
			sql="select a.jhy_fd_leveltwo_id,a.title, a.html_file_name, b.folder, c.folder FROM (juhaoyong_tb_content AS a LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id) LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id WHERE a.id="&rs("order_product_id")&""
			rst.open(sql),cn,1,1
			if not rst.eof and not rst.bof then
			
			rs_url=""
			if trim(rst("jhy_fd_leveltwo_id")&"")<>"" then
				rs_url="../"&rst("b.folder")&"/"&rst("c.folder")
			else
				rs_url="../"&rst("b.folder")
			end if
			response.write "<a href='"&rs_url&"/"&rst("html_file_name")&"' target='_blank'>"&rst("title")&"</a>"
			end if
			rst.close
			set rst=nothing
			%></td>
            <td class="jhyabTabletdBgcolor01"><div align="center"><%=rs("ordercount")%></div></td>
            
            <td class="jhyabTabletdBgcolor01"><div align="center"><a href="order_show_hide.asp?id=<%=rs("id")%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>"><%if rs("view_yes")=1 then%>�Ѵ���<%else%><span style="color: #FF0000">δ����</span><% end if%></a></div></td>
            <td class="jhyabTabletdBgcolor01"><div align="center"><%=rs("name")%></div></td>
            <td class="jhyabTabletdBgcolor01"><div align="center"><%=rs("address")%></div></td>
            <td class="jhyabTabletdBgcolor01"><div align="center"><%=rs("tel")%></div></td>
            <td class="jhyabTabletdBgcolor01"><div align="center"><%=rs("email")%></div></td>
            <td class="jhyabTabletdBgcolor01"><div align="center"><%=rs("qq")%></div></td>
            <td class="jhyabTabletdBgcolor01"><div align="center"><%=rs("content")%></div></td>
            <td class="jhyabTabletdBgcolor01"><div align="center"><a href="order_del.asp?id=<%=rs("id")%>&page=<%=page%>&act=<%=act%>&keywords=<%=keywords%>">ɾ��</a></div></td>
            
          </tr>
<%
rs.movenext
next
else
	response.write "<div align='center'><span style='color: #FF0000'>�������ݣ�</span></div>"
end if 
rs.close
set rs=nothing
%>

		  <tr>
          <td height="35"  colspan="13" >&nbsp;<input name='chkAll' type='checkbox' id='chkAll' onclick='CheckAll(this.form)' value='checkbox'>ȫѡ/ȫ��ѡ&nbsp;<input type="submit" name="Submit" value="ɾ��ѡ��"></td>
          </tr>
		    <tr>

              <td height="35"  colspan="13" align="center"><div align="center">
                <%call showpage(strFileName,rscount,pageno,false,true,"")%>
           </div></td>
		    </tr>
      </table></form>
	    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="25" align="center"> ��������</td>
          </tr>
          <tr>
            <td height="50"><form name="form1" method="post" action="?act=search">
                <div align="center">
               
                  
                    <input name="keywords" type="text"  size="35" maxlength="40">
                  
                   &nbsp;
                    <input type="submit" name="Submit" value="�� ��">
                  
                </div>
            </form></td>
          </tr>
        </table>
	    <br></td>
	</tr>
	</table><br /><br /><br /><br />

<%
Call DbconnEnd()
 %>