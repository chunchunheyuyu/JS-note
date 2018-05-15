<!-- #include file="network_security.asp" -->
<!-- #include file="conn.asp" -->
<!-- #include file="html_clear.asp" -->
<!-- #include file="mp_functions.asp" -->
<!--search content start-->
<div id="search_content" class="clearfix">

<%
dim rs,sql,rs_url
dim searchString,strArray,keywords
comefrom=trim(request.querystring("comefrom"))
searchString=request.querystring("q")
if trim(searchString)="请输入关键词" then searchString=""

dim mp_site_foldername
mp_site_foldername=MP_Get_mp_site_foldername()'获取手机网站目录名称

strArray=split(searchString," ")

dim i,c,search_sql
c=ubound(strArray)
for i=0 to c
	if i=0 then
		search_sql=search_sql&"([a.title] like '%"&strArray(i)&"%'"
		keywords=strArray(i)
	else
		search_sql=search_sql&" or [a.title] like '%"&strArray(i)&"%'"
		keywords=keywords&"+"&strArray(i)
	end if
next
search_sql=search_sql&")"

sql="SELECT a.jhy_fd_leveltwo_id, a.title, a.content, a.html_file_name, a.edit_time, a.ArticleType, b.folder, c.folder"
sql=sql&" FROM (juhaoyong_tb_content AS a"
sql=sql&" LEFT JOIN juhaoyong_tb_directory AS b ON CStr(b.id)=a.jhy_fd_levelone_id)"
sql=sql&" LEFT JOIN juhaoyong_tb_directory AS c ON CStr(c.id)=a.jhy_fd_leveltwo_id"
sql=sql&" WHERE "&search_sql&" ORDER BY a.edit_time DESC,a.id DESC"



if searchString<>"" then 

	set rs=server.createobject("adodb.recordset")
	rs.open(sql),cn,1,1
	'------分页定义部分------开始------
	'错误处理
	if err.number<>0 then
		response.write "数据库操作失败：" & err.description
		err.clear
	else
		if not rs.eof and not rs.bof then
		r=cint(rs.RecordCount) '记录总数
		rowcount = 10 '设置每一页的数据记录数，可根据实际自定义
		rs.pagesize = rowcount '分页记录集每页显示记录数
		maxpagecount=rs.pagecount '分页页数
		page=request.querystring("page")
		  if page="" then
		  page=1
		  end if
		rs.absolutepage = page 
		rcount1=0
		pagestart=page-5
		pageend=page+5
		if pagestart<1 then
		pagestart=1
		end if
		if pageend>maxpagecount then
		pageend=maxpagecount
		end if
		rcount=rs.RecordCount
		'------分页定义部分------结束------
		%>
		
		<!--position start-->
		<div class="searchtip">您正在搜索"<span class="FontRed"><%=searchString%></span>",找到 <span class="font_brown"><%=rcount%></span> 条</div>
		<!--position end-->
		<!--list start-->
		<div class="result_list">
		<div class="gray">提示：多个关键词，可用空格隔开，如"网站 空间 模版"。</div>
		<dl>
		
		<%
		if comefrom="mp" then
			websiteroot="../"&mp_site_foldername&"/"
		else
			websiteroot="../"
		end if
		'循环输出显示开始
		do while not rs.eof and rowcount>0
			rs_url=""
			if rs("jhy_fd_leveltwo_id")<>"" then
				rs_url=websiteroot&rs("b.folder")&"/"&rs("c.folder")&"/"&rs("html_file_name")
			else
				rs_url=websiteroot&rs("b.folder")&"/"&rs("html_file_name")
			end if
		
            title1=left(rs("title"),30)
            for i=0 to c
				title1=Replace(title1, strArray(i), "<span class='FontRed'>" & strArray(i)& "</span>")
            next
            
            content1=left(nohtml(rs("content")),110)
            for i=0 to c
				content1=Replace(content1,strArray(i), "<span class='FontRed'>" & strArray(i)& "</span>")
            next
            %>
            <dt ><a href='<%=rs_url%>' target='_blank' title='<%=rs("title")%>'><%=title1%>&nbsp; <%=year(rs("edit_time"))%>-<%=month(rs("edit_time"))%>-<%=day(rs("edit_time"))%></a></dt>
            <dd><font color="#666666"><%=content1%>...</font></dd>
		<%
		rowcount=rowcount-1 
		rs.movenext
		loop
		'循环输出显示结束
		%>
		
		</dl>
		</div>
		<!--list end-->
		
		<!--page start-->
		<div class="result_page clearfix">
		
		<!------分页部分------开始------>
		<div class="t_page">
		<%
		call listPages() '分页过程调用
		rs.close
		set rs=nothing
		%>
		</div>
		<!------分页部分------结束------>
		</div>
		<!--page end-->
<%
		else
			response.write "<div class='search_welcome'>很抱歉,没有找到与 <span class='FontRed'>"&searchString&"</span> 相关的信息！<p >提示：多个搜索关键词可用空格隔开，如：最新 产品。</p></div>"
		end if
	end if
else
	response.write "<div class='search_welcome'><p >请输入关键词</p></div>"
end if%>
</div>
<!--search content end-->	



<%
'分页过程开始
sub listPages()
n=cint(request.querystring("page"))
if n=0 or n<0 then n=1

response.write "当前页数：<span class='FontRed'>"&n&"</span>/"&maxpagecount&"&nbsp;&nbsp;"

if n>1 then response.write "<a href=?page=1&q="&keywords&" >"
response.write "首页"
if n>1 then response.write "</a> " 
response.write "&nbsp;"

if n>=2 then response.write"<a href=?page="&n-1&"&q="&keywords&" title='第"&n-1&"页'>上一页</a>&nbsp;"

for i=pagestart to pageend
	if i=0 then	i=1
	strurl="<span><a href=?page="&i&"&q="&keywords&" title='第"&i&"页' >"&i&"</a></span>"
	response.write strurl
next

if n<maxpagecount then response.write"&nbsp;<a href=?page="&n+1&"&q="&keywords&" title='第"&n+1&"页'>下一页</a> "

response.write "&nbsp;"
if n<maxpagecount then response.write "<a href=?page="&maxpagecount&"&q="&keywords&" >"
response.write "尾页"
if n<maxpagecount then response.write "</a> " 
end sub
'分页过程结束
%>