<table cellpadding='3' cellspacing='1' border='0' class='tableBorder' align=center>
	<tr>
	  <th class="tableHeaderText">修改产品</th>
	</tr>
	<tr><td class="jhyabTabletdBgcolor02"><br>
	
        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td height="25" class='TipTitle'>操作说明：</td>
    </tr>
    <tr>
      <td height="30" valign="top" class="TipWords">
      <p>1、通过调整更新时间（在编辑框最下面），可以调整显示顺序。</p>
      </td>
    </tr>
    <tr>
      <td height="10">&nbsp;</td>
    </tr>
    </table>
    
	<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1">
	<tr>
	<td class="jhyabTabletdBgcolor01">标题 (必填) </td>
	<td class="jhyabTabletdBgcolor01"><input name='a_title' type='text' id='a_title' size='70' maxlength="200"></td>
	</tr>
    
    <tr>
	<td class="jhyabTabletdBgcolor01">生成文件的名称 (必填) </td>
	</tr>
    
	<tr>
	<td class="jhyabTabletdBgcolor01" height=23>分类(必选)</td>
    <td class="jhyabTabletdBgcolor01">
            </select>
            </td>
	</tr>
	  
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>参数或简介</td>
	    <td class="jhyabTabletdBgcolor01"><textarea name='con_jianjie'  cols="80" rows="7"></textarea>（若为空，则前台详情页不显示该项）</font>
        </td>
      </tr>
	  
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>市场价</td>
	    <td class="jhyabTabletdBgcolor01"><input name='con_shichangjia' type='text' id='con_shichangjia' size='30'><font color="#FF0000">（若为空，则前台详情页不显示该项）</font></td>
      </tr>
	  
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>优惠价</td>
	    <td class="jhyabTabletdBgcolor01"><input name='con_youhuijia' type='text' id='con_youhuijia' size='30'><font color="#FF0000">（若为空，则前台详情页不显示该项）</font></td>
      </tr>      
	  
	  <tr>
	    <td class="jhyabTabletdBgcolor01" height=23>产品图片</td>
	    <td width="85%" class="jhyabTabletdBgcolor01"><table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="25%" ><input name="web_image" type="text" id="web_image"  size="30"></td>
           <td width="75%"  ><iframe width=725 name="ad" frameborder=0 height=30 scrolling=no src="upload.asp?uploadType=2"></iframe></td>
         </tr>
       </table></td>
      </tr>

	<tr>
        <td  class="jhyabTabletdBgcolor01" height=23>关键字</td>
	      <td class="jhyabTabletdBgcolor01"><input type='text' id='a_keywords' name='a_keywords' size='100' maxlength="200">&nbsp;多个关键词，请以半角英文逗号","分割</td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=11>描述 </td>
	  <td class="jhyabTabletdBgcolor01"><textarea name='a_description'  cols="100" rows="4" id="a_description" ></textarea></td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>内容</td>
	  <td class="jhyabTabletdBgcolor01">
	  <textarea name="a_content" style=" width:100%; height:400px; visibility:hidden;"></textarea>
	  </td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>是否显示“提交订单”按钮</td>
	  <td class="jhyabTabletdBgcolor01">
	  <input type="radio" name="product_order_show" value="1" checked>是&nbsp;
	  <input type="radio" name="product_order_show" value="0">否
	  </td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>淘宝宝贝网址</td>
	  <td class="jhyabTabletdBgcolor01"><input name='product_tbbuy_url' type='text' id='product_tbbuy_url' size='120'>（为空则不显示“去淘宝拍”按钮）</td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>浏览次数</td>
	  <td class="jhyabTabletdBgcolor01"><input name='a_hit' type='text' id='a_hit' value="0" size='40'>
      &nbsp;只能是数字</td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>推荐到首页</td>
	  <td class="jhyabTabletdBgcolor01"><input type="radio" name="a_index_push" value="1">是&nbsp;<input name="a_index_push" type="radio" value="0" checked>否</td>
	</tr>
	
	<tr>
	  <td class="jhyabTabletdBgcolor01" height=23>更新时间</td>
	  <td class="jhyabTabletdBgcolor01"><span class="jhyabTabletdBgcolor01">
	 <strong><font color="#FF0000">*注意保持原有时间格式*格式必须如：2018-8-8 9:09:09</font>（通过调整时间，可以调整前台显示顺序，时间越大越靠前）</strong>
	  </td>
	</tr>

	  
	<tr><td height="50" colspan=2  class="jhyabTabletdBgcolor02"><div align="center">
	  <INPUT type=submit value='提交' name=Submit>
	  </div></td></tr>
	</table></td></tr></table>
	</form><br /><br /><br />