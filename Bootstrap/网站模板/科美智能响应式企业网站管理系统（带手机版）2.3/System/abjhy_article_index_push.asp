<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->

<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../generate_html/createhtml_index.asp" -->
<!-- #include file="inc/head.asp" -->
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">首页置顶显示</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100" align="center">
<%
dim rs,sql,id,oneid,twoid,act,keywords,page
act=request.querystring("act")
keywords=trim(request("keywords"))
page=request.querystring("page")

oneid=request.QueryString("oneid")
twoid=request.QueryString("twoid")

id=cint(request.querystring("id"))

set rs=server.createobject("adodb.recordset")
sql="select index_push from juhaoyong_tb_content where id="&id
rs.open(sql),cn,1,3
	if rs("index_push")=1 then
	rs("index_push")=0
	else
	rs("index_push")=1
	end if
rs.update
rs.close
set rs=nothing

call Run_createhtml_index()

response.Write "<font color='#ff0000' size='+1'>操作成功</font><br /><br />"
response.Write "<a href='abjhy_article_list.asp?oneid="&oneid&"&twoid="&twoid&"&page="&page&"&act="&act&"&keywords="&keywords&"'><font size='+1'>返 回</font></a>"
%>
            </td>
          </tr>
        </table>
	    </td>
	</tr>
	</table>


<%
Call DbconnEnd()
 %>