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
mp_site_foldername=MP_Get_mp_site_foldername()'获取手机网站目录名称
%>

<%
dim dirID,delconfirm
dirID=cint(request.querystring("id"))
delconfirm=request.querystring("delconfirm")
'如果该栏目下有子栏目，需要先删除该栏目下的子栏目
'判断子目录
if CheckIsInTableById("juhaoyong_tb_directory",dirID)=true then
	response.Write JuhaoyongReturnHistoryPage("栏目删除","该栏目下存在子栏目，请先删除子栏目")
	response.end
'判断文章
elseif CheckIsInTableById("juhaoyong_tb_content",dirID)=true then
	response.Write JuhaoyongReturnHistoryPage("栏目删除","该栏目下存在内容，请先删除内容")
	response.end
else
	if delconfirm<>"1" then
		response.Write JuhaoyongConfirmPage("栏目删除","删除后不可恢复，确定删除吗？","back_category_del.asp?delconfirm=1&id="&dirID)
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
		
			'删除文件（当栏目类型为3时）或文件夹
			if rs("jhy_fd_dir_parentid")>0 and rs("ClassType")=3 then
				JuhaoyongDeleteFile(FolderPath)'删除单页类型的静态文件
				JuhaoyongDeleteFile(mp_FolderPath)'删除单页类型的静态文件（手机版）
			else
				JuhaoyongDeleteFolder(FolderPath)'删除文件夹
				JuhaoyongDeleteFolder(mp_FolderPath)'删除文件夹（手机版）
			end if
			
			rs.delete
			
			'删除图片文件
			JuhaoyongDeleteFile("../css/"&SITE_STYLE_CSS_FOLDER&"/"&imageName)'删除图片文件
					
			'重新生成对应类型的模版
			call RewriteTemplateFile(c_ClassType,oneClassId)'生成内页模板
		end if
	end if
	
	response.Write JuhaoyongResultPage("栏目删除","删除成功","back_category_list.asp")
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