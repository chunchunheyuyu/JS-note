![Creative.jpg](https://upload-images.jianshu.io/upload_images/10758861-2867638f4d53eca8.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###ajax 

含义：AJAX = Asynchronous JavaScript and XML（异步的 JavaScript 和 XML 通过在后台与服务器进行少量数据交换，AJAX 可以使网页实现异步更新。这意味着可以在不重新加载整个网页的情况下，对网页的某部分进行更新。

作用：实现网页的异步加载，局部刷新网页。当在向服务器获取新数据时不需要刷新整个网页，提高用户体验。
##历程
ajax是一种技术方案，但并不是一种新技术。它依赖的是现有的CSS/HTML/Javascript，而其中最核心的依赖是浏览器提供的XMLHttpRequest对象，是这个对象使得浏览器可以发出HTTP请求与接收HTTP响应。

**使用XMLHttpRequest对象来发送一个Ajax请求。**

`XMLHttpRequest`一开始只是微软浏览器提供的一个接口，后来各大浏览器纷纷效仿也提供了这个接口，再后来W3C对它进行了标准化，提出了[`XMLHttpRequest`标准](https://www.w3.org/TR/XMLHttpRequest/)。`XMLHttpRequest`标准又分为`Level 1`和`Level 2`。

`XMLHttpRequest Level 1`主要存在以下缺点：

*   受同源策略的限制，不能发送跨域请求；

*   不能发送二进制文件（如图片、视频、音频等），只能发送纯文本数据；

*   在发送和获取数据的过程中，无法实时获取进度信息，只能判断是否完成；

`XMLHttpRequest Level 2`中新增了以下功能：

*   可以发送跨域请求，在服务端允许的情况下；

*   支持发送和接收二进制数据；

*   新增formData对象，支持发送表单数据；

*   发送和获取数据时，可以获取进度信息；

*   可以设置请求的超时时间


###发送 Ajax 请求的五个步骤：

（1）创建异步对象。即 XMLHttpRequest 对象。

（2）使用open方法设置请求的参数。open(method, url, async)。参数解释：请求的方法、请求的url、是否异步。

（3）发送请求。

（4）注册事件。 注册onreadystatechange事件，状态改变时就会调用。

（5）获取返回的数据。
- 设置请求发送请求
```
open(method, url, async);
```
>method：请求的类型；GET 或 POST

>url：文件在服务器上的位置

>async：true（异步）或 false（同步）
- onreadystatechange 事件
注册 onreadystatechange 事件后，每当 readyState 属性改变时，就会调用 onreadystatechange 函数。
```
readyState：（存有 XMLHttpRequest 的状态。从 0 到 4 发生变化）

0: 请求未初始化

1: 服务器连接已建立

2: 请求已接收

3: 请求处理中

4: 请求已完成，且响应已就绪

status：

200: "OK"。
304:''已执行，不需更新''

404: 未找到页面。
```
在 onreadystatechange 事件中，当 readyState 等于 4，且状态码为200时，表示响应已就绪。

如果要在数据完整请求回来的时候才调用，我们需要手动写一些判断的逻辑。

###请求实例
```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ajax</title>
</head>
<body>
<h1>Ajax 发送 get 请求</h1>
<input type="button" value="发送put_ajax请求" id='btnAjax'>
<script type="text/javascript">

    // 异步对象
    var xhr = new XMLHttpRequest();

    // 设置属性
    xhr.open('post', '02.post.php'，true);

    // 如果想要使用post提交数据,必须添加此行
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    // 将数据通过send方法传递
    xhr.send('name=fox&age=18');

    // 发送并接受返回值
    xhr.onreadystatechange = function () {
        // 这步为判断服务器是否正确响应
        if (xhr.readyState == 4 && xhr.status == 200) {
            alert(xhr.responseText);
        }
    };
</script>
</body>
</html>
```
###实例点击按钮，使用 ajax 获取数据，如何在数据到来之前防止重复点击?
- 方法一：使用button的disabled属性，配合setTimeout 0，使在数据到来之前按钮都不能被点击
```
el.addEventListener("click",function(){ 
    this.disabled=true; ajax(); 
    setTimeout(this.disabled=false,0);
});
```
- 方法二：可设置标记变量ready，初始时设置flag为true.在用户点击提交按钮后，判断ready是否为true，如果是则发送ajax请求，并把ready设置为false。 等服务端给出响应后再把ready设置为true;
```
var ready = true;
    $('.add-more').on('click', function(){
    ... 
    if(!ready){
        return; 
    } 
    ready = false;
    $.ajax({
       ... 
       complete: function(){
            ready = true; 
            }
         }); 
    });
```
###jQuery 中的 Ajax
JQuery作为最受欢迎的js框架之一，常见的Ajax已经帮助我们封装好了，只需要调用即可。

格式举例：

```source-js
$.ajax({
        url:'data,json',//请求地址
        data:'name=fox&age=18',//发送的数据
        type:'GET',//请求的方式
        success:function (argument) {},// 请求成功执行的方法
        beforeSend:function (argument) {},// 在发送请求之前调用,可以做一些验证之类的处理
        error:function (argument) {console.log(argument);},//请求失败调用
    })
```

代码举例：

（1）index.html

```text-html-basic
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>jquery-ajax</title>
</head>
<body>
<input type="button" value="点击" id="btn">
<div id="showInfo"></div>
<script type="text/javascript" src="jquery-1.11.2.js"></script>
<script type="text/javascript">
	$(function(){

		$("#btn").click(function(){
			$.ajax({
				url:"data.json",
				dataType:"text",
				type:"get",
				success:function(data){
					alert(data);
					//$("#showInfo").html(data);
				},
				error:function(e){
					console.log(e);
				}
			});
		});

	});

</script>
</body>
</html>
```

（2）data.json：

```text-html-php
{"name":"naruto","food":"dumpling"}
```
一，封装一个 ajax 函数，能通过如下方式调用
function ajax(opts){ 
    // todo ...
}
document.querySelector('#btn').addEventListener('click', function(){
    ajax({
        url: 'getData.php', //接口地址 
        type: 'get', // 类型， post 或者 get, 
        data: { 
            username: 'xiaoming', 
            password: 'abcd1234' 
        }, 
        success: function(ret){
        console.log(ret); // {status: 0} 
        }, 
       error: function(){
        console.log('出错了') 
        } 
    })
});
未封装的普通ajax代码：
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
</head>
<body>
<!-- 需求是：在输入框输入用户名，点击按钮，打包请求后发给后台，后台响应对应的姓名和年龄 -->
<input type="text" name="username" id="username" placeholder="请输入用户名">
<button class="btn">提交</button>
<dl id="ct">

</dl>

<script>
  document.querySelector('.btn').addEventListener('click',function(){
    var xmlhttp = new XMLHttpRequest();
    username = document.querySelector('#username').value;
    var url = 'renwu1.php' + '?username='+username;

    // GET方式:
    xmlhttp.open('GET',url,true);
    xmlhttp.send();
    //POST方式：
    // xmlhttp.open('POST','renwu1.php',true);
    // xmlhttp.setRequestHeader("content-type","application/x-www-form-urlencoded");
    // xmlhttp.send("username="+username);

    xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState==4 && xmlhttp.status==200){
        var userInfo = JSON.parse(xmlhttp.responseText);
        dealWith(userInfo);
      }
    }
  });
  function dealWith(userInfo){
    var str = '<dt>性别：</dt>';
    str += '<dd>'+ userInfo.sex +'</dd>';
    str += '<dt>年龄：</dt>';
    str += '<dd>'+userInfo.age +'</dd>';
    document.querySelector('#ct').innerHTML = str;
  }
</script>
</body>
</html>
PHP代码：

<?php
    // $username = $_GET['username'];
    $username = $_POST['username'];
    if($username === 'har'){
      $ret = array('sex'=>'男','age'=>'23');
    }else if($username === 'marry'){
      $ret = array('sex'=>'女','age'=>'22');
    }else{
      $ret = array('sex'=>'女','age'=>'27');
    }
    echo json_encode($ret);  //输出标准json格式
?>
封装

function ajax(opts){
    var xmlhttp = new XMLHttpRequest();
    var dataStr = '';
    for(var key in opts.data){
      dataStr += key + '=' + opts.data[key]+'&'
    }
    dataStr = dataStr.substr(0,dataStr.length-1)

    if(opts.type.toLowerCase()==='post'){
      xmlhttp.open(opts.type,opts.url,true);
      xmlhttp.setRequestHeader('content-type','application/x-www-form-urlencoded');
      xmlhttp.send(dataStr);
    }
    if(opts.type.toLowerCase()==='get'){
      xmlhttp.open(opts.type,opts.url+'?'+ dataStr,true);
      xmlhttp.send();
    }

    xmlhttp.onreadystatechange = function(){
      if(xmlhttp.readyState == 4 && xmlhttp.status == 200 ){
        var json = JSON.parse(xmlhttp.responseText);
        opts.success(json);
      }
      if(xmlhttp.readyState == 4 && xmlhttp.status == 404 ){
        opts.error();
      }
    };
}

document.querySelector('#btn').addEventListener('click', function(){
    ajax({
        url: 'renwu1.php',   //接口地址
        type: 'get',               // 类型， post 或者 get,
        data: {
            username: document.querySelector('#username').value;
            password: document.querySelector('#password');
        },
        success: function(jsonData){
            dealWith(jsonData);       // {status: 0}
        },
        error: function(){
           console.log('出错了')
        }
    })
});
function dealWith(userInfo){
  var str = '<dt>性别：</dt>';
  str += '<dd>'+ userInfo.sex +'</dd>';
  str += '<dt>年龄：</dt>';
  str += '<dd>'+userInfo.age +'</dd>';
  document.querySelector('#ct').innerHTML = str;
};
二，封装一个 ajax 函数，能通过如下方式调用
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>任务二</title>
    <style media="screen">
      div,a{
        margin:0;
        padding:0;
      }
      .ct li{
        border:1px solid #ccc;
        height: 50px;
        line-height:50px;
        padding-left: 10px;
        margin: 10px 0;
        list-style:none;
      }
      .ct{
        padding-left: 0px;
      }
      .btn{
        border: 1px solid red;
        text-align: center;
        display: inline-block;
        height: 30px;
        width: 80px;
        line-height: 30px;
        cursor: pointer;
        position:absolute;
        left:50%;
        margin-top: 30px;
        margin-left: -40px;
        border-radius: 5px;
      }
      .btn:active{
        background-color: pink;
        color: #222;
      }
    </style>
  </head>
  <body>
    <ul class="ct">
      <li>内容1</li>
      <li>内容2</li>
    </ul>
    <a class="btn">加载更多</a>

    <script type="text/javascript">


      function ajax(opts){
        var xml = new XMLHttpRequest();
        var datastr = '';
        for(var key in opts.data){
          datastr += key + '=' + opts.data[key] + '&'
        }
        datastr=datastr.substr(0,datastr.length-1);

        if(opts.type.toLowerCase()=='get'){
          xml.open(opts.type,opts.url+'?'+datastr,true);
          xml.send();
        }
        if(opts.type.toLowerCase()=='post'){
          xml.open(opts.type,opts.url,true);
          xml.send(datastr);
          xml.setRequestHeader('content-type','application/x-www-form-urlencoded');
        }
        xml.onreadystatechange = function(){
          if(xml.readyState==4 && xml.status == 200){
            var json = JSON.parse(xml.responseText);
            opts.success(json);
          }
          if(xml.readyState==4 && xml.status ==404){
            opts.error();
          }
        }
      }

      var cur = 3;
      document.querySelector('.btn').addEventListener('click', function(){
          ajax({
              url: 'renwu2.php',   //接口地址
              type: 'get',               // 类型， post 或者 get,
              data: {
                start:cur,
                len: 6
              },
              success: function(json){
                  if(json.status==1){
                    append(json.data);
                    cur += 6;
                  }else{
                    console.log('失败啦')
                  }     // {status: 0}
              },
              error: function(){
                 console.log('出错了')
              }
          })
      });

      function append(arr){
        for(var i=0; i<arr.length; i++){
          var li = document.createElement('li');
          li.innerHTML = arr[i];
          document.querySelector('.ct').appendChild(li);
        }
      }
    </script>
  </body>
</html>
PHP端：

    <?php
        $start = $_GET['start'];
        $len = $_GET['len'];
        $items = array();

        for($i=0;$i<$len;$i++){
            array_push($items,'内容'.($start+$i));
        }
        $ret = array('status'=>1,'data'=>$items);
      sleep(1);
        echo json_encode($ret);

    ?>

