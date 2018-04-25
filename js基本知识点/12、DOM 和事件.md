###概念
- DOM 是 JavaScript 操作网页的接口，全称为“文档对象模型”（Document Object Model）。
>它的作用是将网页转为一个 JavaScript 对象，从而可以用脚本进行各种操作（比如增删内容）。

浏览器会根据 DOM 模型，将结构化文档（比如 HTML 和 XML）解析成一系列的节点，再由这些节点组成一个树状结构（DOM Tree）。所有的节点和最终的树状结构，都有规范的对外接口。
![DOM结构.png](https://upload-images.jianshu.io/upload_images/10758861-be33a1bc2132cf3f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


DOM 只是一个接口规范，可以用各种语言实现。离开了 DOM，JavaScript 就无法控制网页。

JavaScript 也是最常用于 DOM 操作的语言。

###DOM对象的属性
#####innerHTML和innerText的区别

1 .value：标签的value属性。

2.innerHTML：双闭合标签里面的内容（识别标签）。

3.innerText：双闭合标签里面的内容（不识别标签）。
![innerHTML和innerText的故事.png](https://upload-images.jianshu.io/upload_images/10758861-96308e6083065d61.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![区别.png](https://upload-images.jianshu.io/upload_images/10758861-43bca03e6ffa873f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###nodeType属性
>文档节点（document）：9，对应常量Node.DOCUMENT_NODE
元素节点（element）：1，对应常量Node.ELEMENT_NODE
属性节点（attr）：2，对应常量Node.ATTRIBUTE_NODE
文本节点（text）：3，对应常量Node.TEXT_NODE
文档片断节点（DocumentFragment）：11，对应常量Node.DOCUMENT_FRAGMENT_NODE
文档类型节点（DocumentType）：10，对应常量Node.DOCUMENT_TYPE_NODE
注释节点（Comment）：8，对应常量Node.COMMENT_NODE
```
console.log(document.getElementById('bc').nodeType=== Node.ELEMENT_NODE)//true  
```
确定节点类型时，使用`nodeType`属性是常用方法
```
var node = document.documentElement.firstChild;
if (node.nodeType !== Node.ELEMENT_NODE) {
  console.log('该节点是元素节点');
}
```
###Node.nodeName
`nodeName`属性返回节点的名称。
```
// HTML 代码如下
// <div id="d1">hello world</div>
var div = document.getElementById('d1');
div.nodeName // "DIV"
//上面代码中，元素节点<div>的nodeName属性就是大写的标签名DIV。
```

不同节点的nodeName属性值如下。

>文档节点（document）：#document
元素节点（element）：大写的标签名
属性节点（attr）：属性的名称
文本节点（text）：#text
文档片断节点（DocumentFragment）：#document-fragment
文档类型节点（DocumentType）：文档的类型
注释节点（Comment）：#comment

###Node.nodeValue
`nodeValue`属性返回一个字符串，表示当前节点本身的文本值，该属性可读写。

只有**文本节点**（text）和**注释节点**（comment）有文本值，因此这两类节点的nodeValue可以返回结果，其他类型的节点一律返回null。
```
// HTML 代码如下
// <div id="d1">hello world</div>
var div = document.getElementById('d1');
div.nodeValue // null
div.firstChild.nodeValue // "hello world"
//上面代码中，div是元素节点，nodeValue属性返回null。div.firstChild是文本节点，所以可以返回文本值。
```
###查询元素
- getElementById()
`getElementById`方法返回匹配指定ID属性的元素节点。如果没有发现匹配的节点，则返回null。这也是获取一个元素最快的方法
```
var elem = document.getElementById("test");
```
- getElementsByClassName()
`getElementsByClassName`方法返回一个类似数组的对象（HTMLCollection类型的对象），包括了所有class名字符合指定条件的元素（搜索范围包括本身），元素的变化实时反映在返回结果中。这个方法不仅可以在document对象上调用，也可以在任何元素节点上调用。
```
var elements = document.getElementsByClassName('tab');

document.getElementsByClassName('red test');
``` 
- getElementsByTagName()
`getElementsByTagName`方法返回所有指定标签的元素（搜索范围包括本身）。
```
var paras = document.getElementsByTagName("p");
//代码返回当前文档的所有p元素节点。
```

- getElementsByName()
`getElementsByName`方法用于选择拥有name属性的HTML元素，比如form、img、frame、embed和object.
```
// 假定有一个表单是<form name="x"></form>
var forms = document.getElementsByName("x");
forms[0].tagName // "FORM"
```
注意，在IE浏览器使用这个方法，会将没有name属性、但有同名id属性的元素也返回，所以name和id属性最好设为不一样的值。

- querySelector()
`querySelector`方法返回匹配指定的CSS选择器的元素节点。如果有多个节点满足匹配条件，则返回第一个匹配的节点。如果没有发现匹配的节点，则返回null。
```
var el1 = document.querySelector(".myclass");
var el2 = document.querySelector('#myParent > [ng-click]');
```
**querySelector方法无法选中CSS伪元素。**

- querySelectorAll()
querySelectorAll·方法返回匹配指定的CSS选择器的所有节点，返回的是NodeList类型的对象。
```
elementList = document.querySelectorAll(selectors);

var matches = document.querySelectorAll("div.note, div.alert");
//返回class属性是note或alert的div元素。
```


###创建元素
- createElement()
`createElement`方法用来生成HTML元素节点。
```
var newDiv = document.createElement("div");
```
createElement方法的参数为元素的标签名，即元素节点的tagName属性。如果传入大写的标签名，会被转为小写。如果参数带有尖括号（即<和>）或者是null，会报错。

- createTextNode()
`createTextNode`方法用来生成文本节点，参数为所要生成的文本节点的内容。
```
var newDiv = document.createElement("div");
var newContent = document.createTextNode("Hello");
上面代码新建一个div节点和一个文本节点
```
- createDocumentFragment()
`createDocumentFragment`方法生成一个DocumentFragment对象。
```
var docFragment = document.createDocumentFragment();
```
DocumentFragment对象是一个存在于内存的DOM片段，但是不属于当前文档，常常用来生成较复杂的DOM结构，然后插入当前文档。
这样做的好处在于，因为DocumentFragment不属于当前文档，对它的任何改动，都不会引发网页的重新渲染，比直接修改当前文档的DOM有更好的性能表现。

###修改元素
- appendChild()
在元素末尾添加元素
```
var newDiv = document.createElement("div");
var newContent = document.createTextNode("Hello");
newDiv.appendChild(newContent);
```
- insertBefore()
在某个元素之前插入元素
```
var newDiv = document.createElement("div");
var newContent = document.createTextNode("Hello");
newDiv.insertBefore(newContent, newDiv.firstChild);
```
- replaceChild()
replaceChild()接受两个参数：要插入的元素和要替换的元素
```
newDiv.replaceChild(newElement, oldElement);
删除元素
删除元素使用removeChild()方法即可

parentNode.removeChild(childNode);
```
- clone元素
`cloneNode()`方法用于克隆元素，方法有一个布尔值参数，传入true的时候会深复制，也就是会复制元素及其子元素（IE还会复制其事件），false的时候只复制元素本身
```
node.cloneNode(true);
```
###属性操作
- getAttribute()
`getAttribute()`用于获取元素的attribute值
```
node.getAttribute('id');
```
- createAttribute()
`createAttribute()`方法生成一个新的属性对象节点，并返回它。
```
attribute = document.createAttribute(name);
//createAttribute方法的参数name，是属性的名称。
```

- setAttribute()
`setAttribute()`方法用于设置元素属性
```
var node = document.getElementById("div1");
node.setAttribute("my_attrib", "newVal");
```
- romoveAttribute()
`removeAttribute()`用于删除元素属性
```
node.removeAttribute('id');
```

##事件
>JavaScript和HTML的交互是通过事件实现的。JavaScript采用异步事件驱动编程模型，当文档、浏览器、元素或与之相关对象发生特定事情时，浏览器会产生事件。如果JavaScript关注特定类型事件，那么它可以注册当这类事件发生时要调用的句柄

常见事件
![image.png](https://upload-images.jianshu.io/upload_images/10758861-9c994cc528fbda4b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##事件流
目前主要有三种模型

事件冒泡：事件开始时由最具体的元素接收，然后逐级向上传播到较为不具体的元素

事件捕获：不太具体的节点更早接收事件，而最具体的元素最后接收事件，和事件冒泡相反

DOM事件流：DOM2级事件规定事件流包括三个阶段，事件捕获阶段，处于目标阶段，事件冒泡阶段，首先发生的是事件捕获，为截取事件提供机会，然后是实际目标接收事件，最后是冒泡阶段

![事件模型.png](https://upload-images.jianshu.io/upload_images/10758861-a78a1a6e97c32f0c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 绑定事件的方式


####DOM0的写法：onclick


举例：

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<button id="make">点击</button>

</body>
</html>
<script>

    var btn = document.getElementById('make');
    btn.onclick =function () {
        console.log('出现一次')
    }
</script>
```

点击按钮后，上方代码的打印结果：

```
出现一次
```
但如果我们把代码改成
```
<script>

    var btn = document.getElementById('make');
    btn.onclick =function () {
        console.log('出现一次')
    }
    btn.onclick =function () {
        console.log('西游记')
    }

</script>
```

我们可以看到，控制台只出现 ‘西游记’，因为这是赋值语句后面的会覆盖前面的语句。

### [](https://github.com/smyhvae/Web/blob/master/03-JavaScript%E5%9F%BA%E7%A1%80/12-%E4%BA%8B%E4%BB%B6%E5%AF%B9%E8%B1%A1Event%E5%92%8C%E5%86%92%E6%B3%A1.md#dom2%E7%9A%84%E5%86%99%E6%B3%95addeventlistener)DOM2的写法：addEventListener

```
target.addEventListener(type, listener[, useCapture]);
```



*   type：事件名(注意，没有on)

*   listener：事件名(执行函数)

*   useCapture：**true表示捕获阶段触发，false表示冒泡阶段触发（默认）**。如果不写，则默认为false。

举例：

```text-html-basic
<body>
<button>按钮</button>
<script>
    var btn = document.getElementsByTagName("button")[0];

    //addEventListener: 事件监听器。 原事件被执行的时候，后面绑定的事件照样被执行
    //第二种事件绑定的方法不会出现层叠。（更适合团队开发）
    btn.addEventListener("click", fn1);
    btn.addEventListener("click", fn2);

    function fn1() {
        console.log("红楼梦");
    }

    function fn2() {
        console.log("水浒传");
    }

</script>
</body>
```

点击按钮后，上方代码的打印结果：

```
    红楼梦
    水浒传
```
addEventListener可以在同一个节点绑定多个事件

