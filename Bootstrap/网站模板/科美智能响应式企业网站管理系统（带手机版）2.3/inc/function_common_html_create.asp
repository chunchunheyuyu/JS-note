<%
'=================================================
'函数功能：列表页，分页部分
'=================================================
function PageListHtmlCommon(rscount,pageNumber,totalpage,counter)
'分页部分（通用）开始
dim list_page
list_page=""
list_page=list_page&"<div class='t_page ColorLink'>"
list_page=list_page&"总数："&rscount&"条&nbsp;&nbsp;当前页数：<span class='FontRed'>" & pageNumber & "</span>/" & totalpage &"</br>"

if pageNumber>1 then
list_page=list_page&"<a href=index.html"&">" & "首页" & "</a>"
else
list_page=list_page& "首页"
end if

if pageNumber=1 then
	list_page=list_page&"&nbsp;&nbsp;上一页&nbsp;&nbsp;"
else
	if pageNumber=2  then
	list_page=list_page&"<a href=index.html"&">" & "上一页" & "</a>"
	else
	list_page=list_page&"<a href=page_"&pageNumber-1&".html"&">" & "上一页" & "</a>"
	end if
end if

for counter=pageNumber-2 to pageNumber+2
	if counter>=1 and counter<=totalpage then
			if counter=pageNumber then
				list_page=list_page&"<span class='FontRed'>" & counter & "</span> "
			else
				if counter=1 then
				list_page=list_page&"<a href=index.html"&">" & counter & "</a> "
				else
				list_page=list_page&"<a href=page_"&counter&".html"&">" & counter & "</a> "
				end if
			end if
	end if
next
if counter-1<totalpage then
	list_page=list_page&" ... "
end if
	
if pageNumber>=totalpage then
list_page=list_page&"&nbsp;&nbsp;下一页&nbsp;&nbsp;"
else
list_page=list_page&"<a href=page_"&pageNumber+1&".html"&">" & "下一页" & "</a>"
end if

if pageNumber=totalpage then
list_page=list_page& "尾页" & "</div>"
else
list_page=list_page&"<a href=page_"&totalpage&".html"&">" & "尾页" & "</a></div>"
end if
'分页部分（通用）结束
PageListHtmlCommon=list_page
end function
%>

<%
'=================================================
'函数：获取网站根目录
'=================================================
Function GetSiteGenMuLu(twoID,threeID)
	'根据文章所在栏目级别，决定html文件相对于根目录的路径
	if threeID&""<>"" then
		GetSiteGenMuLu="../../../"
	elseif twoID&""<>"" then
		GetSiteGenMuLu="../../"
	else
		GetSiteGenMuLu="../"
	end if
End Function
%>

<%
'=================================================
'函数：获取“您现在的位置”导航代码
'=================================================
Function GetCurrentPosition(oneName,oneFolder,twoName,twoFolder,threeName,threeFolder,siteRoot)
	'一级栏目导航
	if oneName&""<>"" then GetCurrentPosition="<a href='"&siteRoot&oneFolder&"'>"&oneName&"</a>"
	'二级栏目导航
	if twoName&""<>"" then GetCurrentPosition=GetCurrentPosition&" > <a href='"&siteRoot&oneFolder&"/"&twoFolder&"'>"&twoName&"</a>"
	'三级栏目导航
	if threeName&""<>"" then GetCurrentPosition=GetCurrentPosition&" > <a href='"&siteRoot&oneFolder&"/"&twoFolder&"/"&threeFolder&"'>"&threeName&"</a>"
End Function
%>

<%
'=================================================
'函数：获取当前页所在栏目ID
'=================================================
Function GetCurrentClassID(oneID,twoID,threeID)
	if threeID&""<>"" then
		GetCurrentClassID=threeID
	elseif twoID&""<>"" then
		GetCurrentClassID=twoID
	else
		GetCurrentClassID=oneID
	end if
End Function
%>

<%
'=================================================
'函数：获取本页面title
'=================================================
Function GetThisPageTitle(contentTitle,oneName,twoName,threeName)
	dim tempNameString
	if oneName&""<>"" then tempNameString="_"&oneName
	if twoName&""<>"" then tempNameString="_"&twoName&tempNameString
	if threeName&""<>"" then tempNameString="_"&threeName&tempNameString
	GetThisPageTitle=contentTitle&tempNameString
End Function
%>

<%
'=================================================
'函数：检测及创建内容所在栏目的文件夹，并返回当前栏目的文件夹路径（为生成静态文件做准备，生成的静态文件放在该文件夹下）
'备注：函数中的fso对象，用的是程序中已经创建好的fso对象，节省资源，调用之前先确认已经创建了fso对象。
'=================================================
Function CreateContentFolder(fso,oneFolder,twoFolder)
	dim tempFolderString
	if oneFolder&""<>"" then
	tempFolderString="../"&oneFolder
	'判断文件夹是否存在（否，则创建）
	If fso.FolderExists(Server.MapPath(tempFolderString))=false Then fso.CreateFolder(Server.MapPath(tempFolderString))
	end if
	
	if twoFolder&""<>"" then
	tempFolderString=tempFolderString&"/"&twoFolder
	'判断文件夹是否存在（否，则创建）
	If fso.FolderExists(Server.MapPath(tempFolderString))=false Then fso.CreateFolder(Server.MapPath(tempFolderString))
	end if

	CreateContentFolder=tempFolderString
End Function
%>


