<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<!-- #include file="../inc/mp_functions.asp" -->
<!-- #include file="../inc/juhaoyongConst.asp" -->
<!-- #include file="../inc/rebuild_modify_template.asp" -->
<!-- #include file="inc/head.asp" -->

<%
dim mp_site_foldername
mp_site_foldername=MP_Get_mp_site_foldername()'��ȡ�ֻ���վĿ¼����
%>

<%
dim dirID,delconfirm
dirID=cint(request.querystring("id"))
delconfirm=request.querystring("delconfirm")
'�������Ŀ��������Ŀ����Ҫ��ɾ������Ŀ�µ�����Ŀ
'�ж���Ŀ¼
if CheckIsInTableById("juhaoyong_tb_directory",dirID)=true then
	response.Write JuhaoyongReturnHistoryPage("��Ŀɾ��","����Ŀ�´�������Ŀ������ɾ������Ŀ")
	response.end
'�ж�����
elseif CheckIsInTableById("juhaoyong_tb_content",dirID)=true then
	response.Write JuhaoyongReturnHistoryPage("��Ŀɾ��","����Ŀ�´������ݣ�����ɾ������")
	response.end
else
	if delconfirm<>"1" then
		response.Write JuhaoyongConfirmPage("��Ŀɾ��","ɾ���󲻿ɻָ���ȷ��ɾ����","back_category_del.asp?delconfirm=1&id="&dirID)
		response.end
	else
		dim rs,sql
		set rs=server.createobject("adodb.recordset")
		sql="select [id],[folder],jhy_fd_image,jhy_fd_dir_parentid,ClassType from [juhaoyong_tb_directory] where id="&dirID
		rs.open(sql),cn,1,3
		if not rs.eof then
			dim c_ClassType,imageName
			c_ClassType=rs("ClassType")
			imageName=rs("jhy_fd_image")
			
			if rs("jhy_fd_dir_parentid")=0 then
				FolderPath="../"&rs("folder")
				mp_FolderPath="../"&mp_site_foldername&"/"&rs("folder")
				oneClassId=rs("id")
			else
				oneClassId=rs("jhy_fd_dir_parentid")
				dim rs2
				set rs2=server.createobject("adodb.recordset")
				sql="select [folder] from [juhaoyong_tb_directory] where id="&rs("jhy_fd_dir_parentid")
				rs2.open(sql),cn,1,1
				if not rs2.eof then
					if rs("ClassType")=3 then
					FolderPath="../"&rs2("folder")&"/"&rs("folder")&".html"
					mp_FolderPath="../"&mp_site_foldername&"/"&rs2("folder")&"/"&rs("folder")&".html"
					else
					FolderPath="../"&rs2("folder")&"/"&rs("folder")
					mp_FolderPath="../"&mp_site_foldername&"/"&rs2("folder")&"/"&rs("folder")
					end if
				end if
				rs2.close 
				set rs2=nothing
			end if
		
			'ɾ���ļ�������Ŀ����Ϊ3ʱ�����ļ���
			if rs("jhy_fd_dir_parentid")>0 and rs("ClassType")=3 then
				JuhaoyongDeleteFile(FolderPath)'ɾ����ҳ���͵ľ�̬�ļ�
				JuhaoyongDeleteFile(mp_FolderPath)'ɾ����ҳ���͵ľ�̬�ļ����ֻ��棩
			else
				JuhaoyongDeleteFolder(FolderPath)'ɾ���ļ���
				JuhaoyongDeleteFolder(mp_FolderPath)'ɾ���ļ��У��ֻ��棩
			end if
			
			rs.delete
			
			'ɾ��ͼƬ�ļ�
			JuhaoyongDeleteFile("../css/"&SITE_STYLE_CSS_FOLDER&"/"&imageName)'ɾ��ͼƬ�ļ�
					
			'�������ɶ�Ӧ���͵�ģ��
			call RewriteTemplateFile(c_ClassType,oneClassId)'������ҳģ��
		end if
	end if
	
	response.Write JuhaoyongResultPage("��Ŀɾ��","ɾ���ɹ�","back_category_list.asp")
	response.end
	rs.close
	set rs=nothing
end if
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