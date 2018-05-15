<%
'=================================================
'作用：修改mp.js，手机网站转向开关
'参数：onoffnumber（0或1）
'=================================================
function MP_modify_mpjs_onoff(onoffnumber)
dim fso,f,rewriteMpJsString
set fso = server.createobject("scripting.filesystemobject")
'读源mp.js文件
Set f=fso.OpenTextFile(Server.MapPath("../js/mp.js"), 1)
	rewriteMpJsString=f.ReadAll
f.Close
'根据开关要求，进行替换修改
if onoffnumber=0 then
	rewriteMpJsString=replace(rewriteMpJsString,"location.replace(juhaoyong_mp_site_jump_url);","/*juhaoyong_mp_site_jump*/")
else
	rewriteMpJsString=replace(rewriteMpJsString,"/*juhaoyong_mp_site_jump*/","location.replace(juhaoyong_mp_site_jump_url);")
end if
'重新生成mp.js文件
Set f=fso.CreateTextFile(Server.MapPath("../js/mp.js"))
	f.Write rewriteMpJsString
f.Close
Set f=Nothing
Set fso=nothing
end function

'=================================================
'作用：获取手机网站目录名称
'参数：无
'=================================================
function MP_Get_mp_site_foldername()
'获取手机网站目录名称开始
MP_Get_mp_site_foldername=""
dim rs,sql
set rs=server.createobject("adodb.recordset")
sql="select mp_fd_site_folder from mp_juhaoyong_tb_siteconfig"
rs.open(sql),cn,1,1
if not rs.eof and not rs.bof then
	MP_Get_mp_site_foldername=rs("mp_fd_site_folder")
end if
rs.close
set rs=nothing
'获取手机网站目录名称结束
end function
%>




