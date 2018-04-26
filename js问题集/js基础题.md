####js  基础题

 ######字符串
  - 1、使用数组拼接出如下字符串
 ```
  var prod = {
    name: '女装',
    styles: ['短款', '冬季', '春装']
};
function getTpl(data){
//todo...
};
var result = getTplStr(prod);  //result为下面的字符串

<dl class="product"><dt>女装</dt><dd>短款</dd<dd>冬季</dd><dd>春装</dd></dl>
```
解答：
```
var prod = {
    name: '女装',
    styles: ['短款', '冬季', '春装']
};
function getTpl(data){
var a ='';
for(key in data){
    if(typeof data[key]=='string'){
    a += '\t'+ '<dt>'+data[key]+'</dt>'+'\n'
}else if(typeof  data[key] == 'object'){
    for (var i=0;i< data[key].length;i++){
        a = a+'\t'+ '<dd>'+data[key][i]+ "</dt>"+'\n';
    }}

}
return  '<dl class="product">'+'\n'+a+'</dl>'
};
var result = getTpl(prod);
console.log(result)


```

- 2、写出两种以上声明多行字符串的方法

```
法一：
var longString = 'Long '
+ 'long '
+ 'long '
+ 'string';

法二  
var longString = "Long \
long \
long \
string";

longString
// "Long long long string"
```
- 3、补全如下代码,让输出结果为字符串: hello\\NARUTO

```
var str ='hello\\\\NARUTO'
    console.log(str) // 在字符串中显示反斜杠，在反斜杠前再加一个\ ，即可对其转义
```
- 4以下代码输出什么?为什么
```
var str = 'waa\n哈哈'
console.log(str.length)// \n 占一个字符
```

5、写一个函数，判断一个字符串是回文字符串，如 abcdcba是回文字符串, abcdcbb不是
```
function isPalindrome(str) {

    if(typeof  str =='string'){
        var fan = str.split('').reverse().join('')
        if(str === fan){
            return  console.log('str是回文字符串')
        } return   console.log('str不是回文字符串')
    }
    return console.log('非字符串无法判断')
	```
	
- 6、写一个函数，统计字符串里出现出现频率最多的字符
```
function getMostFreq(str) {
  var dict = {}
  var max = 0
  var maxCh 
  for(var i = 0; i < str.length; i++) {
    var ch = str[i]
    if(dict[ch] === undefined) {
      dict[ch] = 1
    }else {
      dict[ch]++
    }
    if(dict[ch] > max){
      max = dict[ch]
      maxCh = str[i]
    }
  }
  return {index: max, ch: maxCh}
}

console.log(getMostFreq('helloooo worlddd'))
```
- 7、写一个camelize函数，把my-short-string形式的字符串转化成myShortString形式的字符串，如
```
function camlize(str){
   return str.split('-').join('')
}
```
- 8、写一个 ucFirst函数，返回第一个字母为大写的字符 （***）
```
function a(str){
    var a = str.split('');
   a.splice(0,1,str[0].toUpperCase())
    return a.join('')


}
console.log(a("naruto") )
```
- 9、写一个函数truncate(str, maxlength), 如果str的长度大于maxlength，会把str截断到maxlength长，并加上...，如

```
function truncate(str,maxlength) {
    var len =str.length;

    if(len > maxlength ){
       str =str.slice(0,maxlength) +'...'

    }
        return str;
}
var a = 'sdsdsdaffffffffffffffff'
console.log(truncate(a,5))//sdsds...
```
- 10、什么是 json？什么是 json 对象？什么是 json 对象字面量？什么是 JSON内置对象？
json是一种轻量级的数据交换格式.

json的对象由key,value组成,类似js的对象,但有所不同,比如在json对象里string用单引号是
不行的,对象的值必须是string,number,null,true,false,object,arry中的一种,这里的object是
狭义上的object不是函数,时间,正则等对象.

json对象字面量是一种简单的声明生成json的方式.

json对象有两个静态函数,一个用于把字符串变成json对象,另一个用于把json对象变成字符串,分别是JSON.parse()和JSON.stringify().


####Math对象
- 1、写一个函数，返回从min到max之间的 随机整数，包括min不包括max 
```
function choose(min,max) {
    return min+Math.floor(Math.random()*(max -min));

}
console.log(choose(3,111));
```
- 2、写一个函数，返回从min都max之间的 随机整数，包括min包括max 
function choose(min,max) {
    return min+Math.floor(Math.random()*(max -min+1));

}
console.log(choose(3,111));
- 3、写一个函数，生成一个长度为 n 的随机字符串，字符串字符的取值范围包括0到9，a到 z，A到Z。
```
function randomLetter(n) {
    var h= '';
    var a ='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    for(var i=0;i<n;i++){

        h +=a[Math.floor(Math.random()*(a.length +1))]
    }
    return h

}
console.log(randomLetter(3));
```

function getRandStr(len){
  //补全函数
}
var str = getRandStr(10); // 0a3iJiRZap
- 4、写一个函数，生成一个随机 IP 地址，一个合法的 IP 地址为 0.0.0.0~255.255.255.255
function choose(min,max) {
    return min+Math.floor(Math.random()*(max -min+1));

}
function getRandIP(){
    var str =[];
    for(var i=0;i<4;i++){
        str[i]=choose(0,255)
    }
    return str.join('.')
}

- 5、写一个函数，生成一个随机颜色字符串，合法的颜色为#000000~ #ffffff

```
function choose(min,max) {
    return min+Math.floor(Math.random()*(max -min+1));

}

function getRandIP(){
    var str =[];
    for(var i=0;i<4;i++){
        str[i]=choose(0,255)
        str[i]=str[i].toString(16)
    }
    return '#'+str.join('')
}
console.log(getRandIP())
```

###数组

- 1、数组方法里push、pop、shift、unshift、join、splice分别是什么作用？用 splice函数分别实现push、pop、shift、unshift方法
####push
>push方法用于在数组的末端添加一个或多个元素，并返回添加新元素后的数组长度。注意，该方法会改变原数组。
```
var arr = [1,2];

arr.push() // [1]

```
####pop
>pop方法用于在数组的末端删除一个或多个元素，并返回添加新元素后的数组长度。注意，该方法会改变原数组。
```
var arr = [];

arr.pop(1) // 1
arr.pop('a') // 2
arr.pop(true, {}) // 4
arr // [1, 'a', true, {}]
```
####shift
>shift方法用于删除数组的第一个元素，并返回该元素。注意，该方法会改变原数组。
```
var arr = [2,3,4];

arr.shift() // [3,4]
2

```
shift方法可以遍历并清空一个数组。
```
var list = [1, 2, 3, 4, 5, 6];
var item;

while (item = list.shift()) {
  console.log(item);
}

list // []
```
####unshift
>unshift方法用于在数组的第一个位置添加元素，并返回添加新元素后的数组长度。注意，该方法会改变原数组。。
unshift方法可以接受多个参数，这些参数都会添加到目标数组头部。
```
var arr = [ 'c', 'd' ];
arr.unshift('a', 'b') // 4
arr // [ 'a', 'b', 'c', 'd' ]
```
####join
>join方法以指定参数作为分隔符，将所有数组成员连接为一个字符串返回。如果不提供参数，默认用逗号分隔。
```
var a = [1, 2, 3, 4];

a.join(' ') // '1 2 3 4'
a.join(' | ') // "1 | 2 | 3 | 4"
a.join() // "1,2,3,4"
//如果数组成员是undefined或null或空位，会被转成空字符串。

[undefined, null].join('#')
// '#'

['a',, 'b'].join('-')
// 'a--b'
//通过call方法，这个方法也可以用于字符串或类似数组的对象。

Array.prototype.join.call('hello', '-')
// "h-e-l-l-o"

var obj = { 0: 'a', 1: 'b', length: 2 };
Array.prototype.join.call(obj, '-')
// 'a-b'
```
####splice
>splice方法用于删除原数组的一部分成员，并可以在删除的位置添加新的数组成员，返回值是被删除的元素。注意，该方法会改变原数组。
```
var arr = [];

var a = ['a', 'b', 'c', 'd', 'e', 'f'];
a.splice(4, 2) // ["e", "f"]
a // ["a", "b", "c", "d"]
```
- 2、写一个函数，操作数组，数组中的每一项变为原来的平方，在原数组上操作

function squareArr(arr){
}
var arr = [2, 4, 6]
squareArr(arr)
console.log(arr) // [4, 16, 36]
- 3、写一个函数，操作数组，返回一个新数组，新数组中只包含正数，原数组不变

function filterPositive(arr){
}
var arr = [3, -1,  2,  '饥人谷', true]
var newArr = filterPositive(arr)
console.log(newArr) //[3, 2]
console.log(arr) //[3, -1,  2,  '饥人谷', true]
Date 任务
- 1、 写一个函数getChIntv，获取从当前时间到指定日期的间隔时间
```
var str = getChIntv("2018-03-20");
function getChIntv(setTime) {
    var curretTime = new Date();
    var targetTime =new Date(setTime);
    console.log(curretTime)
    console.log(targetTime)

    var cha = Math.abs(curretTime - targetTime);
    console.log(cha)
    var chaS = Math.floor(cha/1000)
    console.log(chaS)
    var second = chaS%60;
    var chaM =Math.floor(cha/1000/60)
    var minute =chaM%60
    var chaHours =Math.floor(chaM/60);
    var hour =chaHours%24
    var day =Math.floor(chaHours/24);
  return  '距离还有'+day+'天'+hour+'小时'+minute+'分钟'+second+'秒'

}
console.log(str)
```


- 2、把hh-mm-dd格式数字日期改成中文日期

```
function getChsDate(str) {
	var dist = ["零","一","二","三","四","五","六","七","八","九","十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","二十一","二十二","二十三","二十四","二十五","二十六","二十七","二十八","二十九","三十","三十一"];
	var arr = str.split('-');
	var year = arr[0];
	var month = arr[1];
	var day = arr[2];

    var Chyear = dist[parseInt(year[0])] + dist[parseInt(year[1])] + dist[parseInt(year[2])] +dist[parseInt(year[3])] + '年';
var Chmonth = dist[parseInt(month)] + '月';
var Chday = dist[parseInt(day)] + '日';
return Chyear + Chmonth + Chday ;
}
var str = getChsDate('2015-01-08');
console.log(str);  
```
- 3、写一个函数，参数为时间对象毫秒数的字符串格式，返回值为字符串。假设参数为时间对象毫秒数t，根据t的时间分别返回如下字符串:
```
function friendlyDate(time){
	var now = Date.now();
	var offset = (now - parseInt(time)) / 1000 / 60; 
	var result;
	if ((offset / 60 / 24 / 30 / 12) >= 1 ) {
	  result = parseInt(offset / 60 / 24 / 30 / 12) + "年前";
	}else if ((offset / 60 / 24 / 30) >= 1  ) {
      result = parseInt(offset / 60 / 24 / 30) + "个月前"; 
	}else if ((offset / 60 / 24 ) >=1 ) {
		result = parseInt(offset / 60 / 24) + "天前";
	}else if ((offset / 60 ) >=1) {
		result = parseInt(offset / 60 ) + "小时前";
	}else if (offset >=1) {
		result = parseInt(offset) + "分钟前";
	}else if (offset <1) {
		result = "刚刚";
	}
	return result;
}
var str = friendlyDate( '1484286699422' ) //  1分钟前
var str2 = friendlyDate('1483941245793') //4天前
```

####DOM
- 题目1： dom对象的innerText和innerHTML有什么区别？
			innerText	: 获取的是节点中文本内容
			innerHTML  :获取的是节点的标签及内容
- 题目2： elem.children和elem.childNodes的区别？
			childNodes返回的是节点的子节点集合，包括元素节点、文本节点还有属性节点等
			children返回的只是节点的元素节点集合
			
- 题目3：查询元素有几种常见的方法？ES5的元素选择方法是什么?
>getElementById()      //返回匹配指定ID属性的元素节点
  getElementsByClassName() //返回一个类似数组的对象（HTMLCollection类型的对象） 
  //元素的变化实时反映在返回结果中
  getElementsByTagName() //返回所有指定标签的元素（搜索范围包括本身）。返回值是
  //一个HTMLCollection对象，也就是说，搜索结果是一个动态集合，任何元素的变化都会
  //实时反映在返回的集合中
  getElementsByName()  //用于选择拥有name属性的HTML元素，比如form、img、frame、
  //embed和object，返回一个NodeList格式的对象，不会实时反映元素的变化。
   elementFromPoint()  //返回位于页面指定位置的元素。

  ES5的元素选择方法：
  querySelector()  //返回匹配指定的CSS选择器的元素节点。如果有多个节点满足匹配条件，
  //则返回第一个匹配的节点。如果没有发现匹配的节点，则返回null。
  querySelectorAll()  //返回匹配指定的CSS选择器的所有节点，返回的是NodeList类型的对象。
  //NodeList对象不是动态集合，所以元素节点的变化无法实时反映在返回结果中。
  //elementList = document.querySelectorAll(selectors);
  //querySelectorAll方法的参数，可以是逗号分隔的多个CSS选择器，返回所有匹配
  //其中一个选择器的元素。

			
- 题目4：如何创建一个元素？如何给元素设置属性？如何删除属性
		createElement方法用来生成HTML元素节点
setAttribute()方法用于设置元素属性
removeAttribute()用于删除元素属性
- 题目5：如何给页面元素添加子元素？如何删除页面元素下的子元素?
appendChild()方法在元素末尾添加元素
insertBefore()方法在某个元素之前插入元素
removeChild()方法可用于删除某元素下的子元素
replaceChild()接受两个参数：要插入的元素和要替换的元素
- 题目6： element.classList有哪些方法？如何判断一个元素的 class 列表中是包含某个 class？如何添加一个class？如何删除一个class?
add(class1, class2, ...) //在元素中添加一个或多个类名。如果指定的类名已存在，则不会添加
toggle()支持一个类名字符串参数,若类名列表中有此类名，移除之，并返回false; 如果没有，则添加该类名，并返回true.
contains(class): //返回布尔值，判断指定的类名是否存在
classList.add(''):添加一个class
classList.remove(''):删除一个class


- 题目7： 如何选中如下代码所有的li元素？ 如何选中btn元素？
```
<div class="mod-tabs">
   <ul>
       <li>list1</li>
       <li>list2</li>
       <li>list3</li>
   </ul>
   <button class="btn">点我</button>
</div>
//选中所有的li元素
document.getElementsByTagName('li')或document.querySelectorAll('li')

//选中btn元素
document.getElementsByClassName('btn')或
getElementsByClassName('btn')
document.querySelector('.btn')

```

####事件模型
- 题目1： DOM0 事件和DOM2级在事件监听使用方式上有什么区别？

 html代码和JavaScript代码紧密耦合，维护不方便
存在加载顺序问题，如果事件处理程序在html代码之后加载，用户可能在事件处理程序还未加载完成时就点击按钮之类的触发事件，存在时间差问题

DOM2可以在一个节点多次绑定，易维护

- 题目2： attachEvent与addEventListener的区别？
1.参数个数不同    attachEvent 有2个  addEventListener 有3个
2.首参数意义不同   attachEvent  事件处理函数名称   addEventListener  事件类型
3.作用域不同    attachEvent 全局环境  Windows      addEventListener this是触发元素

- 题目3： 解释IE事件冒泡和DOM2事件传播机制？

IE   div-> body->html->document   冒泡阶段
DOM2  1：document->html->body->div  捕获阶段    2:目标阶段  div-> body->html->document   3:冒泡阶段

- 题目4：如何阻止事件冒泡？ 如何阻止默认事件？
Event.preventDefault方法取消浏览器对当前事件的默认行为。
比如点击链接后，浏览器默认会跳转到另一个页面，使用这个方法以后，就不会跳转了；
再比如，按一下空格键，页面向下滚动一段距离，使用这个方法以后也不会滚动了。
该方法生效的前提是，事件对象的cancelable属性为true，如果为false，调用该方法没有任何效果

stopPropagation方法阻止事件在 DOM 中继续传播，防止再触发定义在别的节点上的监听函数，但是不包括在当前节点上其他的事件监听函数

- 题目5：有如下代码，要求当点击每一个元素li时控制台展示该元素的文本内容。不考虑兼容

<ul class="ct">
    <li>这里是</li>
    <li>饥人谷</li>
    <li>前端6班</li>
</ul>
<script>
 var ap = document.querySelectorAll('li');

 ap.forEach(function (node) {
     node.addEventListener('click',function (e) {
         alert(e.target.innerText)

     })

 })
</script>
- 题目6： 补全代码，要求：

当点击按钮开头添加时在<li>这里是</li>元素前添加一个新元素，内容为用户输入的非空字符串；当点击结尾添加时在最后一个 li 元素后添加用户输入的非空字符串.
当点击每一个元素li时控制台展示该元素的文本内容。
<ul class="ct">
    <li>这里是</li>
    <li>饥人谷</li>
    <li>任务班</li>
</ul>
<input class="ipt-add-content" placeholder="添加内容"/>
<button id="btn-add-start">开头添加</button>
<button id="btn-add-end">结尾添加</button>
<script>
//你的代码
</script>
题目7： 补全代码，要求：当鼠标放置在li元素上，会在img-preview里展示当前li元素的data-img对应的图片。

<ul class="ct">
    <li data-img="1.png">鼠标放置查看图片1</li>
    <li data-img="2.png">鼠标放置查看图片2</li>
    <li data-img="3.png">鼠标放置查看图片3</li>
</ul>
<div class="img-preview"></div>
<script>
//你的代码
</script>

