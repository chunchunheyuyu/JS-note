<%
dim pageno,pagemax,rscount,rsno,loopno,i,page

'**************************************************
'作  用：分页效果
'参  数：spage  ----当前页
'参  数：spageno  ----每页数量
'参  数：srscount  ---数据总数
'**************************************************
sub showsql(spageno)
page=request("page")
if page="" or not isnumeric(page) then
page=1
else
page=clng(page)
end if
pageno=spageno
if page<1 then
page=1
end if

rscount=rscount

pagemax=rscount\pageno
if rscount mod pageno <>0 then
pagemax=pagemax+1
end if
if page>pagemax then
page=pagemax
end if
rsno=pageno*page-pageno
if page=pagemax then
loopno=rscount-rsno
else 
loopno=pageno
end if
end sub

'**************************************************
'过程名：showpage
'作  用：显示“上一页 下一页”等信息
'参  数：sfilename  ----链接地址
'       totalnumber ----总数量
'       maxperpage  ----每页数量
'       ShowTotal   ----是否显示总数量
'       ShowAllPages ---是否用下拉列表显示所有页面以供跳转。有某些页面不能使用，否则会出现JS错误。
'       strUnit     ----计数单位
'**************************************************
sub showpage(sfilename,totalnumber,maxperpage,ShowTotal,ShowAllPages,strUnit)
	dim n, i,strTemp,strUrl
	if totalnumber mod maxperpage=0 then
    	n= totalnumber \ maxperpage
  	else
    	n= totalnumber \ maxperpage+1
  	end if
  	strTemp= "<table width='100%'><tr><td align='center' height=25>"
	if ShowTotal=true then 
		strTemp=strTemp & "共 <b>" & totalnumber & "</b> " & strUnit & "&nbsp;&nbsp;"
	end if

  	if page<2 then
    		strTemp=strTemp & "首页 上一页&nbsp;"
  	else
    		strTemp=strTemp & "<a href='" & strUrl &"?act="&act&"&keywords="&keywords&"&page=1 '>首页</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl &"?page="&(Page-1)&"&act="&act&"&keywords="&keywords&"'>上一页</a>&nbsp;"
  	end if

  	if n-page<1 then
    		strTemp=strTemp & "下一页 尾页"
  	else
    		strTemp=strTemp & "<a href='" & strUrl &"?page="&(Page+1)&"&act="&act&"&keywords="&keywords&"'>下一页</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl &"?page="&n&"&act="&act&"&keywords="&keywords&"'>尾页</a>"
  	end if
   	strTemp=strTemp & "&nbsp;页次：<strong><font color=red>" & Page & "</font>/" & n & "</strong>页 "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & strUnit & "条/页"
	if ShowAllPages=True then
act="?act="&request("act")
keywords="keywords="&request("keywords")
		strTemp=strTemp & "&nbsp;转到：<select name='page' size='1' onchange=""javascript:window.location='" & strUrl &act&"&"&keywords&"&"& "page=" & "'+this.options[this.selectedIndex].value;"">"   
    	for i = 1 to n   
    		strTemp=strTemp & "<option value='" & i & "'"
			if cint(Page)=cint(i) then strTemp=strTemp & " selected "
			strTemp=strTemp & ">第" & i & "页</option>"   
	    next
		strTemp=strTemp & "</select>"
	end if
	strtemp=strtemp&"&nbsp;&nbsp;数据总数:<b>"&rscount&"</b>条"
	strTemp=strTemp & "</td></tr></table>"
	response.write strTemp
end sub

'**************************************************
'过程名：showpage_AritcleProduct
'作  用：显示“上一页 下一页”等信息
'参  数：sfilename  ----链接地址
'       totalnumber ----总数量
'       maxperpage  ----每页数量
'       ShowTotal   ----是否显示总数量
'       ShowAllPages ---是否用下拉列表显示所有页面以供跳转。有某些页面不能使用，否则会出现JS错误。
'       strUnit     ----计数单位
'       oneid     ----  一级目录id
'       twoid     ----  二级目录id
'**************************************************
sub showpage_AritcleProduct(sfilename,totalnumber,maxperpage,ShowTotal,ShowAllPages,strUnit,oneid,twoid)
	dim n, i,strTemp,strUrl
	if totalnumber mod maxperpage=0 then
    	n= totalnumber \ maxperpage
  	else
    	n= totalnumber \ maxperpage+1
  	end if
  	strTemp= "<table width='100%'><tr><td align='center' height=25>"
	if ShowTotal=true then 
		strTemp=strTemp & "共 <b>" & totalnumber & "</b> " & strUnit & "&nbsp;&nbsp;"
	end if

  	if page<2 then
    		strTemp=strTemp & "首页 上一页&nbsp;"
  	else
    		strTemp=strTemp & "<a href='"&strUrl&"?oneid="&oneid&"&twoid="&twoid&"&act="&act&"&keywords="&keywords&"&page=1 '>首页</a>&nbsp;"
    		strTemp=strTemp & "<a href='"&strUrl&"?oneid="&oneid&"&twoid="&twoid&"&page="&(Page-1)&"&act="&act&"&keywords="&keywords&"'>上一页</a>&nbsp;"
  	end if

  	if n-page<1 then
    		strTemp=strTemp & "下一页 尾页"
  	else
    		strTemp=strTemp & "<a href='"&strUrl&"?oneid="&oneid&"&twoid="&twoid&"&page="&(Page+1)&"&act="&act&"&keywords="&keywords&"'>下一页</a>&nbsp;"
    		strTemp=strTemp & "<a href='"&strUrl&"?oneid="&oneid&"&twoid="&twoid&"&page="&n&"&act="&act&"&keywords="&keywords&"'>尾页</a>"
  	end if
   	strTemp=strTemp & "&nbsp;页次：<strong><font color=red>" & Page & "</font>/" & n & "</strong>页 "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & strUnit & "条/页"
	if ShowAllPages=True then
act="act="&request("act")
keywords="keywords="&request("keywords")
		strTemp=strTemp & "&nbsp;转到：<select name='page' size='1' onchange=""javascript:window.location='"&strUrl&"?oneid="&oneid&"&twoid="&twoid&"&"&act&"&"&keywords&"&"& "page=" & "'+this.options[this.selectedIndex].value;"">"   
    	for i = 1 to n   
    		strTemp=strTemp & "<option value='" & i & "'"
			if cint(Page)=cint(i) then strTemp=strTemp & " selected "
			strTemp=strTemp & ">第" & i & "页</option>"   
	    next
		strTemp=strTemp & "</select>"
	end if
	strtemp=strtemp&"&nbsp;&nbsp;数据总数:<b>"&rscount&"</b>条"
	strTemp=strTemp & "</td></tr></table>"
	response.write strTemp
end sub
%>
