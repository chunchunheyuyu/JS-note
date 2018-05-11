![002.jpg](https://upload-images.jianshu.io/upload_images/10758861-d70c333f8d3fd9eb.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####JavaScript的组成
- ECMAScript：JavaScript的语法标准。包括变量、表达式、运算符、函数、if语句、for语句等。

- DOM：文档对象模型，操作网页上的元素的API。比如让盒子移动、变色、轮播图等。

- BOM：浏览器对象模型，操作浏览器部分功能的API。比如让浏览器自动滚动
###window
**window对象**是BOM的顶层(核心)对象，所有对象都是通过它延伸出来的，也可以称为window的子对象
>从语言设计的角度看，所有变量都是window对象的属性，其实不是很合理。因为window对象有自己的实体含义，不适合当作最高一层的顶层对象。这个设计失误与JavaScript语言匆忙的设计过程有关，最早的设想是语言内置的对象越少越好，这样可以提高浏览器的性能。因此，语言设计者Brendan Eich就把window对象当作顶层对象，所有未声明就赋值的变量都自动变成window对象的属性。这种设计使得编译阶段无法检测出未声明变量，但到了今天已经没有办法纠正了。

####打开窗口、关闭窗口
`window.open(url,target,param)`
参数解释：

- `url`：要打开的地址。

- `target`：新窗口的位置。可以是：_blank 、_self、 _parent 父框架。

- `param`：新窗口的一些设置。

- 返回值：新窗口的句柄。

######param这个参数，可以填各种各样的参数（），比如：

`name`：新窗口的名称，可以为空

`featurse`：属性控制字符串，在此控制窗口的各种属性，属性之间以逗号隔开。

`fullscreen= { yes/no/1/0 }` 是否全屏，默认no

`channelmode= { yes/no/1/0 }` 是否显示频道栏，默认no

`toolbar= { yes/no/1/0 }` 是否显示工具条，默认no

`location= { yes/no/1/0 }` 是否显示地址栏，默认no。（有的浏览器不一定支持）

`directories = { yes/no/1/0 }` 是否显示转向按钮，默认no

`status= { yes/no/1/0 }` 是否显示窗口状态条，默认no

`menubar= { yes/no/1/0 }` 是否显示菜单，默认no

`scrollbars= { yes/no/1/0 }` 是否显示滚动条，默认yes

`resizable= { yes/no/1/0 }` 是否窗口可调整大小，默认no

`width=number` 窗口宽度（像素单位）

`height=number` 窗口高度（像素单位）

`top=number` 窗口离屏幕顶部距离（像素单位）

`left=number` 窗口离屏幕左边距离（像素单位）

各个参数之间用逗号隔开就行，但我们最好是把它们统一放到json里。
#navigator对象
window对象的navigator属性，指向一个包含浏览器信息的对象。
`navigator.cookieEnabled`:属性返回一个布尔值，表示浏览器是否能储存Cookie
`navigator.javaEnabled()`:方法返回一个布尔值，表示浏览器是否能运行Java Applet小程序。
`navigator.geolocation`:返回一个Geolocation对象，包含用户地理位置的信息。
`navigator.onLine`:属性返回一个布尔值，表示用户当前在线还是离线
`navigator.plugins`:属性返回一个类似数组的对象，成员是浏览器安装的插件，比如Flash、ActiveX等。
`navigator.userAgent`:属性返回浏览器的User-Agent字符串，标示浏览器的厂商和版本信息。
##location对象
`window.location`可以简写成location。location相当于浏览器地址栏，可以将url解析成独立的片段。

**location对象**的属性

*   **href**：跳转

*   hash 返回url中#后面的内容，包含#

*   host 主机名，包括端口

*   hostname 主机名

*   pathname url中的路径部分

*   protocol 协议 一般是http、https

*   search 查询字符串

`location.assign()`：改变浏览器地址栏的地址，并记录到历史中
设置location.href 就会调用assign()。一般使用location.href 进行页面之间的跳转。

`location.replace()`：替换浏览器地址栏的地址，不会记录到历史中

`location.reload()`：重新加载
##window.screen对象
`window.screen`对象包含了显示设备的信息。

`screen.height`和`screen.width`两个属性，一般用来了解设备的分辨率。
```
// 显示设备的高度，单位为像素
screen.height // 1920

// 显示设备的宽度，单位为像素
screen.width // 1080
```
`screen.availHeight`和`screen.availWidth`属性返回屏幕可用的高度和宽度，单位为像素。它们的值为屏幕的实际大小减去操作系统某些功能占据的空间，比如系统的任务栏。

##history对象

1、历史记录管理

2、后退：

`history.back()`

`history.go(-1)`：0是刷新

3、前进：

`history.forward()`

`history.go(1)`

用的不多。因为浏览器中已经自带了这些功能的按钮：