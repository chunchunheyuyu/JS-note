<%
'=================================================
'�������ܣ��б�ҳ����ҳ����
'=================================================
function PageListHtmlCommon(rscount,pageNumber,totalpage,counter)
'��ҳ���֣�ͨ�ã���ʼ
dim list_page
list_page=""
list_page=list_page&"<div class='t_page ColorLink'>"
list_page=list_page&"������"&rscount&"��&nbsp;&nbsp;��ǰҳ����<span class='FontRed'>" & pageNumber & "</span>/" & totalpage &"</br>"

if pageNumber>1 then
list_page=list_page&"<a href=index.html"&">" & "��ҳ" & "</a>"
else
list_page=list_page& "��ҳ"
end if

if pageNumber=1 then
	list_page=list_page&"&nbsp;&nbsp;��һҳ&nbsp;&nbsp;"
else
	if pageNumber=2  then
	list_page=list_page&"<a href=index.html"&">" & "��һҳ" & "</a>"
	else
	list_page=list_page&"<a href=page_"&pageNumber-1&".html"&">" & "��һҳ" & "</a>"
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
list_page=list_page&"&nbsp;&nbsp;��һҳ&nbsp;&nbsp;"
else
list_page=list_page&"<a href=page_"&pageNumber+1&".html"&">" & "��һҳ" & "</a>"
end if

if pageNumber=totalpage then
list_page=list_page& "βҳ" & "</div>"
else
list_page=list_page&"<a href=page_"&totalpage&".html"&">" & "βҳ" & "</a></div>"
end if
'��ҳ���֣�ͨ�ã�����
PageListHtmlCommon=list_page
end function
%>

<%
'=================================================
'��������ȡ��վ��Ŀ¼
'=================================================
Function GetSiteGenMuLu(twoID,threeID)
	'��������������Ŀ���𣬾���html�ļ�����ڸ�Ŀ¼��·��
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
'��������ȡ�������ڵ�λ�á���������
'=================================================
Function GetCurrentPosition(oneName,oneFolder,twoName,twoFolder,threeName,threeFolder,siteRoot)
	'һ����Ŀ����
	if oneName&""<>"" then GetCurrentPosition="<a href='"&siteRoot&oneFolder&"'>"&oneName&"</a>"
	'������Ŀ����
	if twoName&""<>"" then GetCurrentPosition=GetCurrentPosition&" > <a href='"&siteRoot&oneFolder&"/"&twoFolder&"'>"&twoName&"</a>"
	'������Ŀ����
	if threeName&""<>"" then GetCurrentPosition=GetCurrentPosition&" > <a href='"&siteRoot&oneFolder&"/"&twoFolder&"/"&threeFolder&"'>"&threeName&"</a>"
End Function
%>

<%
'=================================================
'��������ȡ��ǰҳ������ĿID
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
'��������ȡ��ҳ��title
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
'��������⼰��������������Ŀ���ļ��У������ص�ǰ��Ŀ���ļ���·����Ϊ���ɾ�̬�ļ���׼�������ɵľ�̬�ļ����ڸ��ļ����£�
'��ע�������е�fso�����õ��ǳ������Ѿ������õ�fso���󣬽�ʡ��Դ������֮ǰ��ȷ���Ѿ�������fso����
'=================================================
Function CreateContentFolder(fso,oneFolder,twoFolder)
	dim tempFolderString
	if oneFolder&""<>"" then
	tempFolderString="../"&oneFolder
	'�ж��ļ����Ƿ���ڣ����򴴽���
	If fso.FolderExists(Server.MapPath(tempFolderString))=false Then fso.CreateFolder(Server.MapPath(tempFolderString))
	end if
	
	if twoFolder&""<>"" then
	tempFolderString=tempFolderString&"/"&twoFolder
	'�ж��ļ����Ƿ���ڣ����򴴽���
	If fso.FolderExists(Server.MapPath(tempFolderString))=false Then fso.CreateFolder(Server.MapPath(tempFolderString))
	end if

	CreateContentFolder=tempFolderString
End Function
%>


