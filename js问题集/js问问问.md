### js三千问
=======
### $javascript概念部分

- DOM元素e的e.getAttribute(propName)和e.propName有什么区别和联系
- offsetWidth/offsetHeight,clientWidth/clientHeight与scrollWidth/scrollHeight的区别
- XMLHttpRequest通用属性和方法
- focus/blur与focusin/focusout的区别与联系
- mouseover/mouseout与mouseenter/mouseleave的区别与联系
- sessionStorage,localStorage,cookie区别
- javascript跨域通信
- javascript有哪几种数据类型
>原始类型:布尔值boolean、字符串 string、数字number、undefined、null   、es6新类型symbol 独一无二的值
复杂类型：object对象    es6
- 什么闭包,闭包有什么用
- javascript有哪几种方法定义函数
- 应用程序存储和离线web应用
- 客户端存储localStorage和sessionStorage
- cookie及其操作
- javascript有哪些方法定义对象
- ===运算符判断相等的流程是怎样的
- ==运算符判断相等的流程是怎样的
- 对象到字符串的转换步骤
- 对象到数字的转换步骤
- <,>,<=,>=的比较规则
- +运算符工作流程
- 函数内部arguments变量有哪些特性,有哪些属性,如何将它转换为数组
- DOM事件模型是如何的,编写一个EventUtil工具类实现事件管理兼容
- 评价一下三种方法实现继承的优缺点,并改进

###$javascript编程部分

- 请用原生js实现一个函数,给页面制定的任意一个元素添加一个透明遮罩(透明度可变,默认0.2),使这个区域点击无效,要求兼容IE8+及各主流浏览器,遮罩层效果如下图所示:
- 请用代码写出(今天是星期x)其中x表示当天是星期几,如果当天是星期一,输出应该是"今天是星期一"
- 下面这段代码想要循环延时输出结果0 1 2 3 4,请问输出结果是否正确,如果不正确,请说明为什么,并修改循环内的代码使其输出正确结果
- 现有一个Page类,其原型对象上有许多以post开头的方法(如postMsg);另有一拦截函数chekc,只返回ture或false.请设计一个函数,该函数应批量改造原Page的postXXX方法,在保留其原有功能的同时,为每个postXXX方法增加拦截验证功能,当chekc返回true时继续执行原postXXX方法,返回false时不再执行原postXXX方法
- 完成下面的tool-tip
- 编写javascript深度克隆函数deepClone
- 补充代码,鼠标单击Button1后将Button1移动到Button2的后面
- 网页中实现一个计算当年还剩多少时间的倒数计时程序,要求网页上实时动态显示"××年还剩××天××时××分××秒"
- 完成一个函数,接受数组作为参数,数组元素为整数或者数组,数组元素包含整数或数组,函数返回扁平化后的数组
- 如何判断一个对象是否为数组
- 请评价以下事件监听器代码并给出改进意见
- 如何判断一个对象是否为函数
- 编写一个函数接受url中query string为参数,返回解析后的Object,query string使用application/x-www-form-urlencoded编码
- 解析一个完整的url,返回Object包含域与window.location相同
- 完成函数getViewportSize返回指定窗口的视口尺寸
- 完成函数getScrollOffset返回窗口滚动条偏移量
- 现有一个字符串richText,是一段富文本,需要显示在页面上.有个要求,需要给其中只包含一个img元素的p标签增加一个叫pic的class.请编写代码实现.可以使用jQuery或KISSY.
- 请实现一个Event类,继承自此类的对象都会拥有两个方法on,off,once和trigger
- 编写一个函数将列表子元素顺序反转
- 以下函数的作用是?空白区域应该填写什么
- 编写一个函数实现form的序列化(即将一个表单中的键值序列化为可提交的字符串)
- 使用原生javascript给下面列表中的li节点绑定点击事件,点击时创建一个Object对象,兼容IE和标准浏览器
<<<<<<< HEAD
- 有一个大数组,var a = ['1', '2', '3', ...];a的长度是100,内容填充随机整数的字符串.请先构造此数组a,然后设计一个算法将其内容去重
=======
- 有一个大数组,var a = ['1', '2', '3', ...];a的长度是100,内容填充随机整数的字符串.请先构造此数组a,然后设计一个算法将其内容去重

