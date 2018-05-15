	<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">修改栏目</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td height="25" class='TipTitle'>操作说明：</td>
        </tr>
        <tr>
          <td height="30" valign="top" class="TipWords">
		  	<p>1、栏目文件夹名称不能与系统文件夹名称重名，若栏目文件夹名称为空，则系统自动用栏目名称拼音命名。</p>
            <p>2、栏目图片即栏目页及该栏目下内容页的banner，若为空则不显示banner。</p>
            </td>
        </tr>
        <tr>
          <td height="10">&nbsp;</td>
        </tr>
      </table>
	
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	  <td class="jhyabTabletdBgcolor01" width="20%">上级栏目</td>
	  <td class="jhyabTabletdBgcolor01" width="80%">
		
	  </td>
	</tr>
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>栏目类别</td>
	  <td class="jhyabTabletdBgcolor01">
		</td>
	 </tr>

	<tr>
	<td class="jhyabTabletdBgcolor01">栏目名称（必填）</td>
	<td class="jhyabTabletdBgcolor01"><input type='text' name='c_name' size='40'>
	</td>
	</tr>
	
	<tr>
	<td class="jhyabTabletdBgcolor01" height=23>栏目文件夹名称（必填）</td>
    <td class="jhyabTabletdBgcolor01"><input type='text' name='c_folder' size='40'>
      &nbsp;<span style="color: #FF0000">&nbsp;格式如：abc（请用英文字母命名，且不要带特殊字符和空格），若为空将自动用栏目名称拼音。</span></td>
	</tr>
	
	 <tr>
	  <td class="jhyabTabletdBgcolor01" height=23>栏目页标题</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='c_title' size='50' maxlength="200" /></td>
	</tr>

	<tr>
      <td class="jhyabTabletdBgcolor01" height=11>栏目页关键字</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='c_keywords' size='80'>&nbsp;多个关键词，请以半角英文逗号","分割</td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=11>栏目页描述</td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='c_description'  cols="100" rows="4"></textarea></td>
	</tr>
    
    <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>栏目图片</td>
	    <td class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="22%"  class="jhyabTabletdBgcolor01"><input type="text" name="web_image" size="30"></td>
         </tr>
       </table></td>
     </tr>
     
     <tr>
      <td class="jhyabTabletdBgcolor01" height=11>栏目图片链接地址</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='jhy_fd_image_url' size='80'>&nbsp;（如：http://www.baidu.com/，若为空则链接到本栏目页）</td>
	</tr>
    
    <tr>
      <td class="jhyabTabletdBgcolor01" height=11>栏目图片说明</td>
	  <td class="jhyabTabletdBgcolor01"><input type='text' name='jhy_fd_image_alt' size='80'>&nbsp;（用于图片alt）</td>
	</tr> 
     
	<tr>
	    <td class="jhyabTabletdBgcolor01" height=23>栏目排序</td>
	    <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor02">
	      <input type='text' name='order' value="100" size='20' maxlength="5">
	    &nbsp;只能是数字，数字越小排名越靠前，默认为100，将排在最后面</span></td>
    </tr>
	  
	<tr>
		<td height="50" colspan=2  class="jhyabTabletdBgcolor02">
			<div align="center">
				<INPUT type=submit value='提交' name=Submit>
			</div>
		</td>
	</tr>
	</table></td></tr></table>
	</form><br /><br /><br />