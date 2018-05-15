<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="inc/head.asp" -->

<%
dim htmltype,type_name,titleinfo
htmltype=request.querystring("htmltype")
titleinfo="按F5刷新"
select case htmltype
	case "all"
		type_name="所有页面"
	case "index"
		type_name="首页"
	case "list"
		type_name="所有栏目列表页"
	case "article"
		type_name="所有文章类型页"
	case "product"
		type_name="所有产品类型页"
	case "singlepage"
		type_name="所有单页"
	case "search"
		type_name="搜索页"
	case "guestmessage"
		type_name="留言页"
	case "sitemap"
		type_name="网站地图页"
	case "mp"
		type_name="手机网站所有页面"
		titleinfo="刷新"
end select



%>
	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">生成<%=type_name%>（生成后，请到前台&nbsp;<%=titleinfo%>&nbsp;查看效果）</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="100"><div align="center">
			<%if htmltype="mp" then%><a href="mp_html_generate.asp?htmltype=<%=htmltype%>"><%else%><a href="html_generate.asp?htmltype=<%=htmltype%>"><%end if%>
            <font color="#FF0000"><b>点击这里生成<%=type_name%></b></font></a><br /><br />
			<%if htmltype="all" or htmltype="article" or htmltype="product" or htmltype="mp" then%><font style="font-weight:bold; color:#0000ff">（温馨提示：生成<%=type_name%>比较耗费时间，请耐心等待......）</font><br /><br /><%end if%>
			<%if htmltype="all" then%><font style="font-weight:bold; color:#006600">（备注：手机网站生成，需单独生成，请点击左侧菜单最下面的“生成手机网站”进行生成）</font><%end if%>
			</div></td>
          </tr>
        </table>
	    </td>
	</tr>
	</table>

<%
Call DbconnEnd()
%>