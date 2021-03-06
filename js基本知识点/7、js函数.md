##函数

函数是一段可以反复调用的代码块。函数还能接受输入的参数，不同的参数会返回不同的值。

####1、函数的声明
- function 命令
function命令声明的代码区块，就是一个函数。function命令后面是函数名，函数名后面是一对圆括号，里面是传入函数的参数。函数体放在大括号里面。
```
function print(s) {
  console.log(s);
}

print(q);//q
```
上面的代码命名了一个print函数，以后使用print()这种形式，就可以调用相应的代码。这叫做函数的声明（Function Declaration）

`- 函数表达式
采用变量赋值的写法
```
var print = function(s) {
  console.log(s);
};
```
这种写法将一个匿名函数赋值给变量。
>这个匿名函数又称函数表达式（Function Expression），因为赋值语句的等号右侧只能放表达式。

采用函数表达式声明函数时，function命令后面不带有函数名。
如果加上函数名，该函数名只在函数体内部有效，在函数体外部无效。
```
var halu =function power(){
console.log(typeof power)
}

power//Uncaught ReferenceError: power is not defined
halu();//function
```
这个power只在函数体内部可用，指代函数表达式本身，其他地方都不可用。
用处有两个
>一是可以在函数体内部调用自身
>二是方便除错（除错工具显示函数调用栈时，将显示函数名，而不再显示这里是一个匿名函数）。

因此，下面的形式声明函数也非常常见。
```
var f = function f() {};
```
- Function 构造函数

```
var add = new Function(
  'x',
  'y',
  'return x + y'
);

// 等同于
function add(x, y) {
  return x + y;
}
```
上面代码中，Function构造函数接受三个参数，除了最后一个参数是add函数的“函数体”，其他参数都是add函数的参数。

你可以传递任意数量的参数给Function构造函数，只有最后一个参数会被当做函数体，如果只有一个参数，该参数就是函数体。
```
var foo = new Function(
  'return "hello world"'
);

// 等同于
function foo() {
  return 'hello world';
}
```
Function构造函数可以不使用new命令，返回结果完全一样。

总的来说，这种声明函数的方式非常不直观，几乎无人使用。

###圆括号运算符，return 语句和递归
```
function add(x, y) {
  return x + y;
}

add(1, 1) // 2
```
- 函数名后面紧跟一对圆括号，就会调用这个函数
- return
函数体内部的return语句，表示返回。
JavaScript 引擎遇到return语句，就直接返回return后面的那个表达式的值，后面即使还有语句，也不会得到执行。也就是说，return语句所带的那个表达式，就是函数的返回值。return语句不是必需的，如果没有的话，该函数就不返回任何值，或者说返回undefined。
- 函数可以调用自身，这就是递归（recursion）
```
//阶乘
function f(n) {
    if (n == 1) return n;
    return n * f(n - 1)
}

console.log(f(5)) // 5 * 4 * 3 * 2 * 1 = 120
```
###函数名的提升
用function命令声明函数时，整个函数会像变量声明一样，被提升到代码头部。所以，下面的代码不会报错。
```
f();

function f() {}
```
表面上，上面代码好像在声明之前就调用了函数f。但是实际上，由于“变量提升”，函数f被提升到了代码头部，也就是在调用之前已经声明了。但是，如果采用赋值语句定义函数，JavaScript 就会报错。
```
f();
var f = function (){};
// TypeError: undefined is not a function
```
上面的代码等同于下面的形式。
```
var f;
f();
f = function () {};
```
上面代码第二行，调用f的时候，f只是被声明了，还没有被赋值，等于undefined，所以会报错。因此，如果同时采用function命令和赋值语句声明同一个函数，最后总是采用赋值语句的定义。
```
var f = function () {
  console.log('1');
}

function f() {
  console.log('2');
}

f() // 1
```
##函数的属性和方法
###name 属性
函数的name属性返回函数的名字。
```
function f1() {}
f1.name // "f1"
```
如果是通过变量赋值定义的函数，那么name属性返回变量名。
```
var f2 = function () {};
f2.name // "f2"
```
但是，上面这种情况，只有在变量的值是一个匿名函数时才是如此。如果变量的值是一个具名函数，那么name属性返回function关键字之后的那个函数名。
```
var f3 = function myName() {};
f3.name // 'myName'
```
上面代码中，f3.name返回函数表达式的名字。**注意，真正的函数名还是f3，而myName这个名字只在函数体内部可用。**

name属性的一个用处，就是获取参数函数的名字。
```
var myFunc = function () {};

function test(f) {
  console.log(f.name);
}

test(myFunc) // myFunc
```
上面代码中，函数test内部通过name属性，就可以知道传入的参数是什么函数。

###length 属性
函数的length属性返回函数预期传入的参数个数，即函数定义之中的参数个数。
```
function f(a, b) {}
f.length // 2
```
上面代码定义了空函数f，它的length属性就是定义时的参数个数。不管调用时输入了多少个参数，length属性始终等于2。

>length属性提供了一种机制，判断定义时和调用时参数的差异，以便实现面向对象编程的”方法重载“（overload）。

###toString()
函数的toString方法返回一个字符串，内容是函数的源码。
```
function f() {
  a();
  b();
  c();
}

f.toString()
// function f() {
//  a();
//  b();
//  c();
// }
```
函数内部的注释也可以返回。
```
function f() {/*
  这是一个
  多行注释
*/}

f.toString()
// "function f(){/*
//   这是一个
//   多行注释
// */}"
```
- 利用这一点，可以变相实现多行字符串。
```
var multiline = function (fn) {
  var arr = fn.toString().split('\n');
  return arr.slice(1, arr.length - 1).join('\n');
};

function f() {/*
  这是一个
  多行注释
*/}

multiline(f);
// " 这是一个
//   多行注释"
```
##函数作用域
定义
作用域（scope）指的是变量存在的范围。
在 ES5 的规范中，Javascript 只有两种作用域：
- 一种是全局作用域，变量在整个程序中一直存在，所有地方都可以读取；
- 另一种是函数作用域，变量只在函数内部存在。ES6 又新增了块级作用域，本教程不涉及。

函数外部声明的变量就是全局变量（global variable），它可以在函数内部读取。
```

var v = 1;

function f() {
  console.log(v);
}

f()
// 1
```
上面的代码表明，函数f内部可以读取全局变量v。

在函数内部定义的变量，外部无法读取，称为“局部变量”（local variable）。
```
function f(){
  var v = 1;
}

v // ReferenceError: v is not defined
```
上面代码中，变量v在函数内部定义，所以是一个局部变量，函数之外就无法读取。

函数内部定义的变量，会在该作用域内覆盖同名全局变量。
```
var v = 1;

function f(){
  var v = 2;
  console.log(v);
}

f() // 2
v // 1
```
上面代码中，变量v同时在函数的外部和内部有定义。结果，在函数内部定义，局部变量v覆盖了全局变量v。

注意，对于var命令来说，局部变量只能在函数内部声明，在其他区块中声明，一律都是全局变量。
```
if (true) {
  var x = 5;
}
console.log(x);  // 5
```
上面代码中，变量x在条件判断区块之中声明，结果就是一个全局变量，可以在区块之外读取。

函数内部的变量提升
与全局作用域一样，函数作用域内部也会产生“变量提升”现象。var命令声明的变量，不管在什么位置，变量声明都会被提升到函数体的头部。
```
function foo(x) {
  if (x > 100) {
    var tmp = x - 100;
  }
}

// 等同于
function foo(x) {
  var tmp;
  if (x > 100) {
    tmp = x - 100;
  };
}
```
函数本身的作用域
函数本身也是一个值，也有自己的作用域。它的作用域与变量一样，就是其声明时所在的作用域，与其运行时所在的作用域无关。
```
var a = 1;
var x = function () {
  console.log(a);
};

function f() {
  var a = 2;
  x();
}

f() // 1
```
上面代码中，函数x是在函数f的外部声明的，所以它的作用域绑定外层，内部变量a不会到函数f体内取值，所以输出1，而不是2。

**总之，函数执行时所在的作用域，是定义时的作用域，而不是调用时所在的作用域。**   

很容易犯错的一点是，如果函数A调用函数B，却没考虑到函数B不会引用函数A的内部变量。
```
var x = function () {
  console.log(a);
};

function y(f) {
  var a = 2;
  f();
}

y(x)
// ReferenceError: a is not defined
```
上面代码将函数x作为参数，传入函数y。但是，函数x是在函数y体外声明的，作用域绑定外层，因此找不到函数y的内部变量a，导致报错。

同样的，函数体内部声明的函数，作用域绑定函数体内部。
```
function foo() {
  var x = 1;
  function bar() {
    console.log(x);
  }
  return bar;
}

var x = 2;
var f = foo();
f() // 1
```  
上面代码中，函数foo内部声明了一个函数bar，bar的作用域绑定foo。当我们在foo外部取出bar执行时，变量x指向的是foo内部的x，而不是foo外部的x。正是这种机制，构成了下文要讲解的“闭包”现象。

###参数
- 概述
函数运行的时候，有时需要提供外部数据，不同的外部数据会得到不同的结果，这种外部数据就叫参数。
```
function square(x) {
  return x * x;
}

square(2) // 4
square(3) // 9
```
上式的x就是square函数的参数。每次运行的时候，需要提供这个值，否则得不到结果。

参数的省略
函数参数不是必需的，Javascript 允许省略参数。
```
function f(a, b) {
  return a;
}

f(1, 2, 3) // 1
f(1) // 1
f() // undefined

f.length // 2
```
上面代码的函数f定义了两个参数，但是运行时无论提供多少个参数（或者不提供参数），JavaScript 都不会报错。省略的参数的值就变为undefined。需要注意的是.
**函数的length属性与实际传入的参数个数无关，只反映函数预期传入的参数个数。**

>但是，没有办法只省略靠前的参数，而保留靠后的参数。如果一定要省略靠前的参数，只有显式传入undefined。
```
function f(a, b) {
  return a;
}

f( , 1) // SyntaxError: Unexpected token ,(…)
f(undefined, 1) // undefined
```
上面代码中，如果省略第一个参数，就会报错。

##传递方式
函数参数如果是原始类型的值（数值、字符串、布尔值），传递方式是传值传递（passes by value）。这意味着，在函数体内修改参数值，不会影响到函数外部。
```
var p = 2;

function f(p) {
  p = 3;
}
f(p);

p // 2
```
上面代码中，变量p是一个原始类型的值，传入函数f的方式是传值传递。因此，在函数内部，p的值是原始值的拷贝，无论怎么修改，都不会影响到原始值。

**但是，如果函数参数是复合类型的值（数组、对象、其他函数），**传递方式是传址传递（pass by reference）。**
**也就是说，传入函数的原始值的地址，因此在函数内部修改参数，将会影响到原始值。**
```
var obj = { p: 1 };

function f(o) {
  o.p = 2;
}
f(obj);

obj.p // 2
```
上面代码中，传入函数f的是参数对象obj的地址。因此，在函数内部修改obj的属性p，会影响到原始值。

>注意，如果函数内部修改的，不是参数对象的某个属性，而是替换掉整个参数，这时不会影响到原始值。
```
var obj = [1, 2, 3];

function f(o) {
  o = [2, 3, 4];
}
f(obj);

obj // [1, 2, 3]
```
上面代码中，在函数f内部，参数对象obj被整个替换成另一个值。这时不会影响到原始值。
**这是因为，形式参数（o）的值实际是参数obj的地址，重新对o赋值导致o指向另一个地址，保存在原地址上的值当然不受影响。**

##同名参数
如果有同名的参数，则取最后出现的那个值。
```
function f(a, a) {
  console.log(a);
}

f(1, 2) // 2
```
上面代码中，函数f有两个参数，且参数名都是a。取值的时候，以后面的a为准，即使后面的a没有值或被省略，也是以其为准。
```
function f(a, a) {
  console.log(a);
}

f(1) // undefined
```
调用函数f的时候，没有提供第二个参数，a的取值就变成了undefined。这时，如果要获得第一个a的值，可以使用arguments对象。
```
function f(a, a) {
  console.log(arguments[0]);
}

f(1) // 1
```
###arguments 对象
（1）定义

由于 JavaScript 允许函数有不定数目的参数，所以需要一种机制，可以在函数体内部读取所有参数。这就是arguments对象的由来。

arguments对象包含了函数运行时的所有参数，arguments[0]就是第一个参数，arguments[1]就是第二个参数，以此类推。这个对象只有在函数体内部，才可以使用。
```
var f = function (one) {
  console.log(arguments[0]);
  console.log(arguments[1]);
  console.log(arguments[2]);
}

f(1, 2, 3)
// 1
// 2
// 3
```
正常模式下，arguments对象可以在运行时修改。
```
var f = function(a, b) {
  arguments[0] = 3;
  arguments[1] = 2;
  return a + b;
}

f(1, 1) // 5
```
上面代码中，函数f调用时传入的参数，在函数内部被修改成3和2。

严格模式下，arguments对象是一个只读对象，修改它是无效的，但不会报错。
```
var f = function(a, b) {
  'use strict'; // 开启严格模式
  arguments[0] = 3; // 无效
  arguments[1] = 2; // 无效
  return a + b;
}

f(1, 1) // 2
```
上面代码中，函数体内是严格模式，这时修改arguments对象就是无效的。

通过arguments对象的length属性，可以判断函数调用时到底带几个参数。
```
function f() {
  return arguments.length;
}

f(1, 2, 3) // 3
f(1) // 1
f() // 0
```
（2）与数组的关系

需要注意的是，虽然arguments很像数组，但它是一个对象。数组专有的方法（比如slice和forEach），不能在arguments对象上直接使用。

如果要让arguments对象使用数组方法，真正的解决方法是将arguments转为真正的数组。下面是两种常用的转换方法：slice方法和逐一填入新数组。
```
var args = Array.prototype.slice.call(arguments);

// 或者 
var args = [];
for (var i = 0; i < arguments.length; i++) {
  args.push(arguments[i]);
}
```
（3）callee 属性

arguments对象带有一个callee属性，返回它所对应的原函数。
```
var f = function () {
  console.log(arguments.callee === f);
}

f() // true
```
可以通过arguments.callee，达到调用函数自身的目的。这个属性在严格模式里面是禁用的，因此不建议使用。

###函数的其他知识点
##闭包
闭包（closure）是 Javascript 语言的一个难点，也是它的特色，很多高级应用都要依靠闭包实现。

理解闭包，首先必须理解变量作用域。前面提到，JavaScript 有两种作用域：全局作用域和函数作用域。函数内部可以直接读取全局变量。
```
var n = 999;

function f1() {
  console.log(n);
}
f1() // 999
```
上面代码中，函数f1可以读取全局变量n。

但是，函数外部无法读取函数内部声明的变量。
```
function f1() {
  var n = 999;
}

console.log(n)
// Uncaught ReferenceError: n is not defined(
```
上面代码中，函数f1内部声明的变量n，函数外是无法读取的。

如果出于种种原因，需要得到函数内的局部变量。正常情况下，这是办不到的，只有通过变通方法才能实现。那就是在函数的内部，再定义一个函数。
```
function f1() {
  var n = 999;
  function f2() {
　　console.log(n); // 999
  }
}
```
上面代码中，函数f2就在函数f1内部，这时f1内部的所有局部变量，对f2都是可见的。但是反过来就不行，f2内部的局部变量，对f1就是不可见的。这就是 JavaScript 语言特有的”链式作用域”结构（chain scope），子对象会一级一级地向上寻找所有父对象的变量。所以，父对象的所有变量，对子对象都是可见的，反之则不成立。

既然f2可以读取f1的局部变量，那么只要把f2作为返回值，我们不就可以在f1外部读取它的内部变量了吗！
```
function f1() {
  var n = 999;
  function f2() {
    console.log(n);
  }
  return f2;
}

var result = f1();
result(); // 999
```
上面代码中，函数f1的返回值就是函数f2，由于f2可以读取f1的内部变量，所以就可以在外部获得f1的内部变量了。

闭包就是函数f2，即能够读取其他函数内部变量的函数。由于在 JavaScript 语言中，只有函数内部的子函数才能读取内部变量，因此可以把闭包简单理解成“定义在一个函数内部的函数”。闭包最大的特点，就是它可以“记住”诞生的环境，比如f2记住了它诞生的环境f1，所以从f2可以得到f1的内部变量。在本质上，闭包就是将函数内部和函数外部连接起来的一座桥梁。

闭包的最大用处有两个，一个是可以读取函数内部的变量，另一个就是让这些变量始终保持在内存中，即闭包可以使得它诞生环境一直存在。请看下面的例子，闭包使得内部变量记住上一次调用时的运算结果。
```
function createIncrementor(start) {
  return function () {
    return start++;
  };
}

var inc = createIncrementor(5);

inc() // 5
inc() // 6
inc() // 7
```
上面代码中，start是函数createIncrementor的内部变量。通过闭包，start的状态被保留了，每一次调用都是在上一次调用的基础上进行计算。从中可以看到，闭包inc使得函数createIncrementor的内部环境，一直存在。所以，闭包可以看作是函数内部作用域的一个接口。

为什么会这样呢？原因就在于inc始终在内存中，而inc的存在依赖于createIncrementor，因此也始终在内存中，不会在调用结束后，被垃圾回收机制回收。

闭包的另一个用处，是封装对象的私有属性和私有方法。
```
function Person(name) {
  var _age;
  function setAge(n) {
    _age = n;
  }
  function getAge() {
    return _age;
  }

  return {
    name: name,
    getAge: getAge,
    setAge: setAge
  };
}

var p1 = Person('张三');
p1.setAge(25);
p1.getAge() // 25
```
上面代码中，函数Person的内部变量_age，通过闭包getAge和setAge，变成了返回对象p1的私有变量。

>注意，外层函数每次运行，都会生成一个新的闭包，而这个闭包又会保留外层函数的内部变量，所以内存消耗很大。因此不能滥用闭包，否则会造成网页的性能问题。

###立即调用的函数表达式（IIFE）
在 Javascript 中，圆括号()是一种运算符，跟在函数名之后，表示调用该函数。比如，print()就表示调用print函数。

有时，我们需要在定义函数之后，立即调用该函数。这时，你不能在函数的定义之后加上圆括号，这会产生语法错误。
```
function(){ /* code */ }();
// SyntaxError: Unexpected token (
```
产生这个错误的原因是，function这个关键字即可以当作语句，也可以当作表达式。
```
// 语句
function f() {}

// 表达式
var f = function f() {}
```
为了避免解析上的歧义，JavaScript 引擎规定，如果function关键字出现在行首，一律解释成语句。因此，JavaScript引擎看到行首是function关键字之后，认为这一段都是函数的定义，不应该以圆括号结尾，所以就报错了。

解决方法就是不要让function出现在行首，让引擎将其理解成一个表达式。最简单的处理，就是将其放在一个圆括号里面。
```
(function(){ /* code */ }());
// 或者
(function(){ /* code */ })();
```
上面两种写法都是以圆括号开头，引擎就会认为后面跟的是一个表示式，而不是函数定义语句，所以就避免了错误。这就叫做“立即调用的函数表达式”（Immediately-Invoked Function Expression），简称 IIFE。

注意，上面两种写法最后的分号都是必须的。如果省略分号，遇到连着两个 IIFE，可能就会报错。
```
// 报错
(function(){ /* code */ }())
(function(){ /* code */ }())
```
上面代码的两行之间没有分号，JavaScript 会将它们连在一起解释，将第二行解释为第一行的参数。

推而广之，任何让解释器以表达式来处理函数定义的方法，都能产生同样的效果，比如下面三种写法。
```
var i = function(){ return 10; }();
true && function(){ /* code */ }();
0, function(){ /* code */ }();
```
甚至像下面这样写，也是可以的。
```
!function () { /* code */ }();
~function () { /* code */ }();
-function () { /* code */ }();
+function () { /* code */ }();
```
通常情况下，只对匿名函数使用这种“立即执行的函数表达式”。
它的目的有两个：
- 一是不必为函数命名，避免了污染全局变量；
- 二是 IIFE 内部形成了一个单独的作用域，可以封装一些外部无法读取的私有变量。
```
// 写法一
var tmp = newData;
processData(tmp);
storeData(tmp);

// 写法二
(function () {
  var tmp = newData;
  processData(tmp);
  storeData(tmp);
}());
```
上面代码中，写法二比写法一更好，因为完全避免了污染全局变量。

##eval 命令
eval命令的作用是，将字符串当作语句执行。
```
eval('var a = 1;');
a // 1
```
上面代码将字符串当作语句运行，生成了变量a。

放在eval中的字符串，应该有独自存在的意义，不能用来与eval以外的命令配合使用。举例来说，下面的代码将会报错。

eval('return;');
eval没有自己的作用域，都在当前作用域内执行，因此可能会修改当前作用域的变量的值，造成安全问题。

```
var a = 1;
eval('a = 2');

a // 2
```
上面代码中，eval命令修改了外部变量a的值。由于这个原因，eval有安全风险。

为了防止这种风险，JavaScript 规定，如果使用严格模式，eval内部声明的变量，不会影响到外部作用域。
```
(function f() {
  'use strict';
  eval('var foo = 123');
  console.log(foo);  // ReferenceError: foo is not defined
})()
```
上面代码中，函数f内部是严格模式，这时eval内部声明的foo变量，就不会影响到外部。

不过，即使在严格模式下，eval依然可以读写当前作用域的变量。
```
(function f() {
  'use strict';
  var foo = 1;
  eval('foo = 2');
  console.log(foo);  // 2
})()
```
上面代码中，严格模式下，eval内部还是改写了外部变量，可见安全风险依然存在。

此外，eval的命令字符串不会得到 JavaScript 引擎的优化，运行速度较慢。这也是一个不应该使用它的理由。

通常情况下，eval最常见的场合是解析 JSON 数据字符串，不过正确的做法应该是使用浏览器提供的JSON.parse方法。

JavaScript 引擎内部，eval实际上是一个引用，默认调用一个内部方法。这使得eval的使用分成两种情况，一种是像上面这样的调用eval(expression)，这叫做“直接使用”，这种情况下eval的作用域就是当前作用域。除此之外的调用方法，都叫“间接调用”，此时eval的作用域总是全局作用域。
```
var a = 1;

function f() {
  var a = 2;
  var e = eval;
  e('console.log(a)');
}

f() // 1
```
上面代码中，eval是间接调用，所以即使它是在函数中，它的作用域还是全局作用域，因此输出的a为全局变量。

eval的间接调用的形式五花八门，只要不是直接调用，都属于间接调用。
```
eval.call(null, '...')
window.eval('...')
(1, eval)('...')
(eval, eval)('...')
```
上面这些形式都是eval的间接调用，因此它们的作用域都是全局作用域。

与eval作用类似的还有Function构造函数。利用它生成一个函数，然后调用该函数，也能将字符串当作命令执行。
```
var jsonp = 'foo({"id": 42})';

var f = new Function( 'foo', jsonp );
// 相当于定义了如下函数
// function f(foo) {
//   foo({"id":42});
// }

f(function (json) {
  console.log( json.id ); // 42
})
```
上面代码中，jsonp是一个字符串，Function构造函数将这个字符串，变成了函数体。调用该函数的时候，jsonp就会执行。这种写法的实质是将代码放到函数作用域执行，避免对全局作用域造成影响。

不过，new Function()的写法也可以读写全局作用域，所以也是应该避免使用它。
