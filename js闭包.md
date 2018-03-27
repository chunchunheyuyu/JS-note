
![0019b91ec6f70a6a28a749.jpg](http://upload-images.jianshu.io/upload_images/3016465-3fce50e552563d65.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#####基础数据类型
string 字符串 number 数字 boolean 布尔值  null 空 undefined 未定义
- 基础数据都是按照值来访问的，可以直接操作保存在变量中的实际的值。

#####引用数据类型
object 对象
- 引用类型的值都是按引用访问的。这里的引用可以理解为在对象中保存一个地址，这个地址指向堆内的某个值。

```
var a = 30;
var b = a;
b = 40;

// 这时a的值是多少？30

var m = { a: 10, b: 20 }
var n = m;
n.a = 15;//m = { a: 15, b: 20 }
```


![Paste_Image.png](http://upload-images.jianshu.io/upload_images/3016465-6d6c7792318011f7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/3016465-12da0ba2b6b72420.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
**JavaScript 定义了几种数据类型? 哪些是原始类型?哪些是复杂类型?原始类型和复杂类型的区别是什么?**
6种
number数值，Boolean布尔值，string字符串，null空，object对象，undefined未定义

* 原始类型（primitive type）
number数值，Boolean布尔值，string字符串
* 复杂类型（complex type）
object对象

原始值是固定而简单的值,是存放在栈(stack)中的简单数据段,也就是说,它们的值直接存储在变量访问的位置。原始值是表示Javascript中可用的数据或信息的最底层形式或最简单形式。原始类型的值被称为原始值，是因为它们是不可细化的。
复杂值可以由很多不同类型的javascript对象组成。复杂对象其在内存中的大小是未知的，因为复杂对象可以包含任何值，而不是一个特定的已知值
**typeof和instanceof的作用和区别?**


* typeof 是可以用来检测给定变量的数据类型的操作符，对一个值使用typeof可能会返回某个字符串.

* instanceof 用来在运行时指出对象是否是特定类的一个实例。instanceof通过返回一个布尔值来指出，这个对象是否是这个特定类或者是它的子类的一个实例。
**如何判断一个变量是否是数字、字符串、布尔、函数**
typeof操作符
   可能返回以下字符串：

* “undefined”---如果这个值是未定义
* “boolean”---如果这个值是布尔值
* “string”---如果这个值是字符串
* “number”---如果这个值是数值
* “object”---如果这个值是对象或者null
* “function”---如果这个值是函数
**NaN是什么? 有什么特别之处?**
Not a Number 不是一个number类型的数据
任何NaN的值进行操作都会返回一个NaN
NaN与任何值都不相等即便是他本身 NaN === NaN  //false.
**如何把非数值转化为数值?**
Number()把给定的值转换成数字
 parseInt() 把值转换成整数
 parseFloat()把值转换成浮点数
**==与===有什么区别**
==用于一般比较，===用于严格比较，==在比较的时候可以转换数据类型，===严格比较，只要类型不匹配就返回flase。
==会转换类型
**break与continue有什么区别**
break是指当条件满足或被触发后直接终止所有循环，即便后面的内容并没有完全执行完.continue,则是指当条件触发后跳过当前循环继续下一循环，并输出在次之前和之后的所有结果
**void 0 和 undefined在使用场景上有什么区别**
undefined可以在局部作用域中被覆写，而void 0运算返回都是undefined

```
console.log(1+1);   //2 
console.log("2"+"4");  //字符串24
console.log(2+"4");  //数字转换为字符串24
console.log(+"4"); //4 只有字符串会转换为数字输出

var a = 1;  
a+++a;  //3    a自增，第二个a的值变为2，第一个a还是1
typeof a+2;//number2 typeof操作符优先级高，先判断a的类型再做加法

 var a = 1;
 var b = 3;
 console.log( a+++b );//4  a自增再做加法 1+3=4

var arr = [3,4,5]
//for(i=0;i<arr.length;i++){console.log(arr[i]*arr[i])}

var obj = {
 name: 'hunger', 
 sex: 'male', 
 age: 28 
}
for(a in obj){
console.log(a+":"+obj[a])
}

var a = 1, b = 2, c = 3;
var val = typeof a + b || c >0
console.log(val)//number2   typeof优先级最高 number然后加b ，number2，或运算符左侧为true，右侧就不用再计算，然后number2赋值于val

var d = 5;
var data = d ==5 && console.log('bb')
console.log(data)//bb   d==5为true执行与运算符右侧语句

var data2 = d = 0 || console.log('haha')
console.log(data2)
//输出：haha undefined console.log('haha')先执行输出haha,||优先级高于=，比较0和console.log('haha')，输出undefined,右结合赋值给data2,所以data2为undefined
 
var x = !!"Hello" + (!"world", !!"from here!!");
console.log(x)
//输出：2 !"world"为false, !!"from here!!"为ture, !!"Hello"为ture,
 所以为ture+ture, 输出为2

```