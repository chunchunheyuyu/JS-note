<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->

<%
dim htmltype,type_name,titleinfo
htmltype=request.querystring("htmltype")
titleinfo="��F5ˢ��"
select case htmltype
	case "all"
		type_name="����ҳ��"
	case "index"
		type_name="��ҳ"
	case "list"
		type_name="������Ŀ�б�ҳ"
	case "article"
		type_name="������������ҳ"
	case "product"
		type_name="���в�Ʒ����ҳ"
	case "singlepage"
		type_name="���е�ҳ"
	case "search"
		type_name="����ҳ"
	case "guestmessage"
		type_name="����ҳ"
	case "sitemap"
		type_name="��վ��ͼҳ"
	case "mp"
		type_name="�ֻ���վ����ҳ��"
		titleinfo="ˢ��"
end select



%>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">����<%=type_name%>�����ɺ��뵽ǰ̨&nbsp;<%=titleinfo%>&nbsp;�鿴Ч����</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100"><div align="center">
			<%if htmltype="mp" then%><a href="mp_html_generate.asp?htmltype=<%=htmltype%>"><%else%><a href="html_generate.asp?htmltype=<%=htmltype%>"><%end if%>
            <font color="#FF0000"><b>�����������<%=type_name%></b></font></a><br /><br />
			<%if htmltype="all" or htmltype="article" or htmltype="product" or htmltype="mp" then%><font style="font-weight:bold; color:#0000ff">����ܰ��ʾ������<%=type_name%>�ȽϺķ�ʱ�䣬�����ĵȴ�......��</font><br /><br /><%end if%>
			<%if htmltype="all" then%><font style="font-weight:bold; color:#006600">����ע���ֻ���վ���ɣ��赥�����ɣ��������˵�������ġ������ֻ���վ���������ɣ�</font><%end if%>
			</div></td>
          </tr>
        </table>
	    </td>
	</tr>
	</table>

<%
Call DbconnEnd()
%>