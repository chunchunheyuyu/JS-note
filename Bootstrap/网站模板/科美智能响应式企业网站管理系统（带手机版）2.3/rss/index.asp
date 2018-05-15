<%@ CODEPAGE=65001 %>
<!--#include file="../inc/conn.asp"  -->
<%
'网站基本信息
set rs=server.createobject("adodb.recordset")
sql="select jhy_fd_site_name,jhy_fd_site_domain from juhaoyong_tb_siteconfig"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
	jhy_fd_site_name=rs("jhy_fd_site_name")
	jhy_fd_site_domain=rs("jhy_fd_site_domain")
end if
rs.close
%>

<%
sql="SELECT top 50 a.jhy_fd_leveltwo_id, a.title, a.description, a.html_file_name, a.edit_time, a.ArticleType, b.folder, b.name, c.folder, c.name"
sql=sql&" FROM (juhaoyong_tb_content AS a"
sql=sql&" LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id)"
sql=sql&" LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id"
sql=sql&" ORDER BY a.edit_time DESC,a.id DESC"

rs.open sql,cn,1,1
response.contenttype="text/xml"   
XMLContent=XMLContent&"<?xml version=""1.0"" encoding=""utf-8"" ?>" & vbcrlf
XMLContent=XMLContent&"<?xml-stylesheet type=""text/xsl"" href=""rss.xslt"" version=""1.0"" ?>" & vbcrlf
XMLContent=XMLContent&"<rss version=""2.0"">" & vbcrlf
XMLContent=XMLContent&"<channel>" & vbcrlf
XMLContent=XMLContent&"<title>"&jhy_fd_site_name&"</title>" & vbcrlf
XMLContent=XMLContent&"<link>../</link>" & vbcrlf
XMLContent=XMLContent&"<language>zh-cn</language>" & vbcrlf
XMLContent=XMLContent&"<copyright>RSS Feed By "&jhy_fd_site_domain&"</copyright>" & vbcrlf

do while not rs.eof 
	rs_url=""
	if rs("jhy_fd_leveltwo_id")<>"" then
		rs_url="../"&rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
	else
		rs_url="../"&rs("b.folder")&"/"&rs("html_file_name")
	end if
	
	rs_categoryName=""
	if rs("jhy_fd_leveltwo_id")<>"" then
		rs_categoryName=rs("b.name")&" >> "&rs("c.name")
	else
		rs_categoryName=rs("b.name")
	end if
	
	
	XMLContent=XMLContent&"<item>" & vbcrlf   
	XMLContent=XMLContent&"<title><![CDATA[" &rs("title")& "]]></title>" & vbcrlf   
	XMLContent=XMLContent&"<link>"&rs_url&"</link>"& vbcrlf    
	XMLContent=XMLContent&"<description><![CDATA["&rs("description")&"]]></description>" & vbcrlf   
	XMLContent=XMLContent&"<pubDate>"&GetFormatTime(rs("edit_time"))&"</pubDate>" & vbcrlf   
	XMLContent=XMLContent&"<author>"&jhy_fd_site_name&"</author>"& vbcrlf
	XMLContent=XMLContent&"<category>"&rs_categoryName&"</category>"& vbcrlf
	XMLContent=XMLContent&"</item>" & vbcrlf
rs.movenext
loop   
XMLContent=XMLContent&"</channel>" & vbcrlf   
XMLContent=XMLContent&"</rss>" & vbcrlf   
rs.close   
set rs=nothing   

cn.close
set cn=nothing
%>

<%
call Generation_File("Feed.xml",XMLContent) '在xml目录下生成编码为utf-8的feed.xml文件
response.write XMLContent
%>

<%
'******************************************
'功能：读取模板，生成UTF-8文件
'参数：File_name 文件名
'参数：filePath  生成文件所在相对目录
'参数：content   写入内容
'******************************************
Sub Generation_File(File_name,content)
dim map_path
Set objStream = Server.CreateObject("ADODB.Stream")
With objStream
.Open
.Charset = "utf-8"
.Position = objStream.Size
.WriteText=XMLContent
.SaveToFile server.mappath(File_name),2
.Close
End With
Set objStream = Nothing
End Sub

'=================================================
'作用：标准格式化“时间”格式
'参数：strtime
'=================================================
Function GetFormatTime(strtime)
if trim(strtime&"")="" then
	GetFormatTime=""
	Exit Function
end if

GetFormatTime=""
GetFormatTime=GetFormatTime&year(strtime)&"-"
GetFormatTime=GetFormatTime&right("0"&Month(strtime),2)&"-"
GetFormatTime=GetFormatTime&right("0"&day(strtime),2)&" "
GetFormatTime=GetFormatTime&right("0"&hour(strtime),2)&":"
GetFormatTime=GetFormatTime&right("0"&minute(strtime),2)&":"
GetFormatTime=GetFormatTime&right("0"&second(strtime),2)
End Function

'星期转换函数
Function EnWeekDayName(InputDate)   
Dim Result   
Select Case WeekDay(InputDate,1)   
Case 1:Result="Sun"   
Case 2:Result="Mon"   
Case 3:Result="Tue"   
Case 4:Result="Wed"   
Case 5:Result="Thu"   
Case 6:Result="Fri"   
Case 7:Result="Sat"   
End Select   
EnWeekDayName = Result   
End Function

'月份转换函数
Function EnMonthName(InputDate)   
Dim Result   
Select Case Month(InputDate)   
Case 1:Result="Jan"   
Case 2:Result="Feb"   
Case 3:Result="Mar"   
Case 4:Result="Apr"   
Case 5:Result="May"   
Case 6:Result="Jun"   
Case 7:Result="Jul"   
Case 8:Result="Aug"   
Case 9:Result="Sep"   
Case 10:Result="Oct"   
Case 11:Result="Nov"   
Case 12:Result="Dec"   
End Select   
EnMonthName = Result   
End Function   
%>

