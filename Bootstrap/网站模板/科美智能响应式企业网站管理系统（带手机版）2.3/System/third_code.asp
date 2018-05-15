<%@ LANGUAGE=VBScript CodePage=936%>
<%response.charset="gb2312"%>
<%response.codepage=936%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="inc/access.asp"-->
<!-- #include file="inc/functions.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<title>网站备份</title>
</head>
<body>
<div id="jhy_info_outside">
<br />
  <table width="90%" border="0" align="center"  cellpadding="3" cellspacing="1" class="table_style">
	<tr>
      <td height="30" style="color:#009933; font-size:14px; font-weight:bold;" bgcolor="#dbf2b1" align="center">第三方代码：统计、分享、商桥等代码的安装方法</td>
    </tr> 

    <tr>
      <td style="color:#000000; font-size:14px; padding-left:20px;"><br />
	  
<font style="font-weight:bold; color:#ff0000;">为了防止网站被挂码或攻击，第三方 javascript 代码请用下面的方法安装：</font><br />
	  <br />
<font style="font-weight:bold; color:#0099ff;">第一步：用记事本打开下面4个模版文件：</font><br /><br />
	  
　　/templates/juhaoyongfgstyleSource/template_index.html<br />
　　/templates/juhaoyongfgstyleSource/template_inside.html<br /><br />

　　/templates/mp_juhaoyongfgstyleSource/mp_template_index.html<br />
　　/templates/mp_juhaoyongfgstyleSource/mp_template_inside.html<br /><br />

　　把代码加到这4个模版文件最下面<font color="#FF0000">&lt;/body&gt;标签之前</font>，保存，然后通过ftp上传到空间覆盖这4个文件，完成！<br /><br />

<font style="font-weight:bold; color:#0099ff;">第二步：登录网站后台，重新生成所有静态（手机网站也要重新生成），然后到前台按f5刷新即可看到效果（手机查看，请先清空手机浏览器缓存，然后刷新）。</font><br /><br /><br />

<font style="font-weight:bold; color:#FF00FF;">（温馨提醒：有的代码安装后，是不显示图标的，比如新版百度统计代码，只要能看到统计结果或能正常使用，就说明安装好了）</font>
<br /><br /><br />
	  </td>
    </tr>
  </table>
</div>
</body>
</html>
