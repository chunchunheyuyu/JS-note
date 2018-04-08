![双鱼.jpg](https://upload-images.jianshu.io/upload_images/10758861-3ca92a2d3fe1de73.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####一、数据类型
JavaScript 的数据类型，共有七种。（ES6 又新增了第七种 Symbol 类型的值）
- **数值（number）**:
- **字符串（string）**:
- **布尔值（boolean）**:
- **对象（object）**:
- **未定义（undefined）**:
- **空（null）**:
- **Symbol**:
>ES5 的对象属性名都是字符串，这容易造成属性名的冲突。比如，你使用了一个他人提供的对象，但又想为这个对象添加新的方法（mixin 模式），新方法的名字就有可能与现有方法产生冲突。如果有一种机制，保证每个属性的名字都是独一无二的就好了，这样就从根本上防止属性名的冲突。这就是 ES6 引入Symbol的原因。

######原始类型（primitive type）
即它们是最基本的数据类型，不能再细分了。
- 数值（number）
- 字符串（string）
- 布尔值（boolean）

######合成类型（complex type）
由多种或多个原始类型的值组成的容器。
- 对象（object）
>undefined和null，一般将它们看成两个特殊值。

######**对象（object）**
- 狭义的对象（object）
- 数组（array）
- 函数（function）

####二、判断类型
JavaScript 有三种方法，可以确定一个值到底是什么类型。
- typeof运算符
- instanceof运算符
- Object.prototype.toString方法

typeof运算符可以返回一个值的数据类型。
```
typeof 888
"number" //数字
typeof "888"
"string"//字符串
typeof true
"boolean"//布尔值
typeof undefined
"undefined"//未定义
typeof null
"object"//空
typeof []
"object"//数组

function f(){}
typeof f
"function" //函数

```
**typeof**可以用来检查一个没有声明的变量，而不报错
```
fly
VM115:1 Uncaught ReferenceError: fly is not defined
    at <anonymous>:1:1
(anonymous) @ VM115:1
typeof fly
"undefined"
```
**instanceof**运算符可以区分数组和对象
```
var o = {};
var a = [];
o instanceof Array 
false
a instanceof Array
true
```
 **Object.prototype.toString**
>  1.取得对象的一个内部属性[[Class]]，然后依据这个属性
2.返回一个类似于 "[object Array]" 的字符串作为结果

**Object.prototype.toString.call(value)**
```
判断基本类型：

Object.prototype.toString.call(null);//”[object Null]”
Object.prototype.toString.call(undefined);//”[object Undefined]”
Object.prototype.toString.call(“abc”);//”[object String]”
Object.prototype.toString.call(123);//”[object Number]”
Object.prototype.toString.call(true);//”[object Boolean]”

函数类型
Function fn(){console.log(“test”);}
Object.prototype.toString.call(fn);//”[object Function]”

日期类型
var date = new Date();
Object.prototype.toString.call(date);//”[object Date]”

数组类型
var arr = [1,2,3];
Object.prototype.toString.call(arr);//”[object Array]”

正则表达式
var reg = /[hbc]at/gi;
Object.prototype.toString.call(arr);//”[object Array]”

自定义类型
function Person(name, age) {
    this.name = name;
    this.age = age;
}
var person = new Person("Rose", 18);
Object.prototype.toString.call(arr); //”[object Object]”

判断原生JSON对象：

var isNativeJSON = window.JSON && Object.prototype.toString.call(JSON);
console.log(isNativeJSON);//输出结果为”[object JSON]”说明JSON是原生的，否则不是；
```
####三、null 和 undefined
null
>null表示空值，即该处的值现在为空。调用函数时，某个参数未设置任何值，这时就可以传入null，表示该参数为空。比如，某个函数接受引擎抛出的错误作为参数，如果运行过程中未出错，那么这个参数就会传入null，表示未发生错误。

undefined
```
// 变量声明了，但没有赋值
var i;
i // undefined

// 调用函数时，应该提供的参数没有提供，该参数等于 undefined
function f(x) {
  return x;
}
f() // undefined

// 对象没有赋值的属性
var  o = new Object();
o.p // undefined

// 函数没有返回值时，默认返回 undefined
function f() {}
f() // undefined
```
####四、布尔值
**“真”**用关键字**true**表示
**“假”**用关键字**false**表示。.

下列运算符会返回布尔值：
>两元逻辑运算符： && (And)，|| (Or)
前置逻辑运算符： ! (Not)
相等运算符：===(绝对等于 **值和类型均相等**)，
         !==( 不绝对等于 **值和类型有一个不相等，或两个都不相等**)，
==(等于)，!=(不等于)
比较运算符：>，>=，<，<=


如果 JavaScript 预期某个位置应该是布尔值，会将该位置上现有的值自动转为布尔值。

下面六个值被转为false
>undefined
null
false
0
NaN
""或''（空字符串）
