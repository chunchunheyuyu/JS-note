<%
dim pageno,pagemax,rscount,rsno,loopno,i,page

'**************************************************
'��  �ã���ҳЧ��
'��  ����spage  ----��ǰҳ
'��  ����spageno  ----ÿҳ����
'��  ����srscount  ---��������
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
'��������showpage
'��  �ã���ʾ����һҳ ��һҳ������Ϣ
'��  ����sfilename  ----���ӵ�ַ
'       totalnumber ----������
'       maxperpage  ----ÿҳ����
'       ShowTotal   ----�Ƿ���ʾ������
'       ShowAllPages ---�Ƿ��������б���ʾ����ҳ���Թ���ת����ĳЩҳ�治��ʹ�ã���������JS����
'       strUnit     ----������λ
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
		strTemp=strTemp & "�� <b>" & totalnumber & "</b> " & strUnit & "&nbsp;&nbsp;"
	end if

  	if page<2 then
    		strTemp=strTemp & "��ҳ ��һҳ&nbsp;"
  	else
    		strTemp=strTemp & "<a href='" & strUrl &"?act="&act&"&keywords="&keywords&"&page=1 '>��ҳ</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl &"?page="&(Page-1)&"&act="&act&"&keywords="&keywords&"'>��һҳ</a>&nbsp;"
  	end if

  	if n-page<1 then
    		strTemp=strTemp & "��һҳ βҳ"
  	else
    		strTemp=strTemp & "<a href='" & strUrl &"?page="&(Page+1)&"&act="&act&"&keywords="&keywords&"'>��һҳ</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl &"?page="&n&"&act="&act&"&keywords="&keywords&"'>βҳ</a>"
  	end if
   	strTemp=strTemp & "&nbsp;ҳ�Σ�<strong><font color=red>" & Page & "</font>/" & n & "</strong>ҳ "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & strUnit & "��/ҳ"
	if ShowAllPages=True then
act="?act="&request("act")
keywords="keywords="&request("keywords")
		strTemp=strTemp & "&nbsp;ת����<select name='page' size='1' onchange=""javascript:window.location='" & strUrl &act&"&"&keywords&"&"& "page=" & "'+this.options[this.selectedIndex].value;"">"   
    	for i = 1 to n   
    		strTemp=strTemp & "<option value='" & i & "'"
			if cint(Page)=cint(i) then strTemp=strTemp & " selected "
			strTemp=strTemp & ">��" & i & "ҳ</option>"   
	    next
		strTemp=strTemp & "</select>"
	end if
	strtemp=strtemp&"&nbsp;&nbsp;��������:<b>"&rscount&"</b>��"
	strTemp=strTemp & "</td></tr></table>"
	response.write strTemp
end sub

'**************************************************
'��������showpage_AritcleProduct
'��  �ã���ʾ����һҳ ��һҳ������Ϣ
'��  ����sfilename  ----���ӵ�ַ
'       totalnumber ----������
'       maxperpage  ----ÿҳ����
'       ShowTotal   ----�Ƿ���ʾ������
'       ShowAllPages ---�Ƿ��������б���ʾ����ҳ���Թ���ת����ĳЩҳ�治��ʹ�ã���������JS����
'       strUnit     ----������λ
'       oneid     ----  һ��Ŀ¼id
'       twoid     ----  ����Ŀ¼id
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
		strTemp=strTemp & "�� <b>" & totalnumber & "</b> " & strUnit & "&nbsp;&nbsp;"
	end if

  	if page<2 then
    		strTemp=strTemp & "��ҳ ��һҳ&nbsp;"
  	else
    		strTemp=strTemp & "<a href='"&strUrl&"?oneid="&oneid&"&twoid="&twoid&"&act="&act&"&keywords="&keywords&"&page=1 '>��ҳ</a>&nbsp;"
    		strTemp=strTemp & "<a href='"&strUrl&"?oneid="&oneid&"&twoid="&twoid&"&page="&(Page-1)&"&act="&act&"&keywords="&keywords&"'>��һҳ</a>&nbsp;"
  	end if

  	if n-page<1 then
    		strTemp=strTemp & "��һҳ βҳ"
  	else
    		strTemp=strTemp & "<a href='"&strUrl&"?oneid="&oneid&"&twoid="&twoid&"&page="&(Page+1)&"&act="&act&"&keywords="&keywords&"'>��һҳ</a>&nbsp;"
    		strTemp=strTemp & "<a href='"&strUrl&"?oneid="&oneid&"&twoid="&twoid&"&page="&n&"&act="&act&"&keywords="&keywords&"'>βҳ</a>"
  	end if
   	strTemp=strTemp & "&nbsp;ҳ�Σ�<strong><font color=red>" & Page & "</font>/" & n & "</strong>ҳ "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & strUnit & "��/ҳ"
	if ShowAllPages=True then
act="act="&request("act")
keywords="keywords="&request("keywords")
		strTemp=strTemp & "&nbsp;ת����<select name='page' size='1' onchange=""javascript:window.location='"&strUrl&"?oneid="&oneid&"&twoid="&twoid&"&"&act&"&"&keywords&"&"& "page=" & "'+this.options[this.selectedIndex].value;"">"   
    	for i = 1 to n   
    		strTemp=strTemp & "<option value='" & i & "'"
			if cint(Page)=cint(i) then strTemp=strTemp & " selected "
			strTemp=strTemp & ">��" & i & "ҳ</option>"   
	    next
		strTemp=strTemp & "</select>"
	end if
	strtemp=strtemp&"&nbsp;&nbsp;��������:<b>"&rscount&"</b>��"
	strTemp=strTemp & "</td></tr></table>"
	response.write strTemp
end sub
%>
