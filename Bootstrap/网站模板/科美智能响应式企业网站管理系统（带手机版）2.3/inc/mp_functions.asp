<%
'=================================================
'���ã��޸�mp.js���ֻ���վת�򿪹�
'������onoffnumber��0��1��
'=================================================
function MP_modify_mpjs_onoff(onoffnumber)
dim fso,f,rewriteMpJsString
set fso = server.createobject("scripting.filesystemobject")
'��Դmp.js�ļ�
Set f=fso.OpenTextFile(Server.MapPath("../js/mp.js"), 1)
	rewriteMpJsString=f.ReadAll
f.Close
'���ݿ���Ҫ�󣬽����滻�޸�
if onoffnumber=0 then
	rewriteMpJsString=replace(rewriteMpJsString,"location.replace(juhaoyong_mp_site_jump_url);","/*juhaoyong_mp_site_jump*/")
else
	rewriteMpJsString=replace(rewriteMpJsString,"/*juhaoyong_mp_site_jump*/","location.replace(juhaoyong_mp_site_jump_url);")
end if
'��������mp.js�ļ�
Set f=fso.CreateTextFile(Server.MapPath("../js/mp.js"))
	f.Write rewriteMpJsString
f.Close
Set f=Nothing
Set fso=nothing
end function

'=================================================
'���ã���ȡ�ֻ���վĿ¼����
'��������
'=================================================
function MP_Get_mp_site_foldername()
'��ȡ�ֻ���վĿ¼���ƿ�ʼ
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
'��ȡ�ֻ���վĿ¼���ƽ���
end function
%>




