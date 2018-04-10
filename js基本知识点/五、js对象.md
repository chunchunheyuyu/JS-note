对象（object）是 JavaScript 语言的核心概念，也是最重要的数据类型。
####生成方法
对象就是一组“键值对”（key-value）的集合，是一种无序的复合数据集合。
```
var obj = {
  foo: 'Hello',
  bar: 'World'
};
```
大括号就定义了一个对象，它被赋值给变量obj，所以变量obj就指向一个对象。
对象内部包含两个**键值对**（又称为两个“成员”）.
第一个键值对是foo: 'Hello'，其中foo是“键名”（成员的名称），字符串Hello是“键值”（成员的值）
第二个键值对是bar: 'World'，bar是键名，World是键值。
两个键值对之间用逗号分隔
###键名
对象的所有键名都是字符串（ES6 又引入了 Symbol 值也可以作为键值）
```
var obj = {
  'foo': 'Hello',
  'bar': 'World'
};
```
如果键名是数值，会被自动转为字符串。
```
var obj = {
  1: 'a',
  3.2: 'b',
  1e2: true,
  1e-2: true,
  .234: true,
  0xFF: true
};

obj
// Object {
//   1: "a",
//   3.2: "b",
//   100: true,
//   0.01: true,
//   0.234: true,
//   255: true
// }

obj['100'] // true
```
如果键名不符合标识名的条件（比如第一个字符为数字，或者含有空格或运算符），且也不是数字，则必须加上引号，否则会报错。
```
var obj = {
  p: function (x) {
    return 2 * x;
  }
};

obj.p(1) // 2
```
对象的每一个键名又称为“属性”（property），它的“键值”可以是任何数据类型。如果一个属性的值为函数，通常把这个属性称为“**方法**”，它可以像函数那样调用。
###对象的引用
如果不同的变量名指向同一个对象，那么它们都是这个对象的引用，也就是说指向同一个内存地址

修改其中一个变量，会影响到其他所有变量。
```
var o1 = {};"hello world"
var o2 = o1;

o1.a = 1;
o2.a // 1

o2.b = 2;
o1.b // 2
```
o1 o2 都指向同一个对象，因此为其中任何一个变量添加属性，另一个变量都可以读写该属性。
```
var o1 = {};
var o2 = o1;

o1 = 1;
o2 // {}
```
取消某一个变量对于原对象的引用，不会影响到另一个变量。
但是，这种引用只局限于对象，如果两个变量指向同一个原始类型的值。那么，变量这时都是值的拷贝。
```
var x = 1;
var y = x;

x = 2;
y // 1
```

JavaScript 规定，如果行首是大括号，一律解释为语句（即代码块）。如果要解释为表达式（即对象），必须在大括号前加上圆括号。
```
{ foo: 123 } //代码块
（{ foo: 123 }）//表达式
```
###操作属性
- 读取属性
>1.使用点运算符
2.使用方括号运算符。

```
var a = "b";
var obj ={
  a:"fang",
  b:123
}
obj.a //fang
obj[a]//123
obj['a']//fang
```
方括号内不 加 引号，那a就是一个变量，指向字符串 "b"


```

var obj ={
  135:"fang",
  246:123
}
obj.135//报错
obj[135]//fang
obj['135']//fang
```
数字键可以不加引号，因为会自动转成字符串。 
数字键名**不能使用点运算符**，因为会被当成小数点

###属性赋值
点运算符和方括号运算符，不仅可以用来读取值，还可以用来赋值。
```
var obj = {};

obj.foo = 'Hello';
obj['bar'] = 'World';
```
JavaScript 允许属性的“后绑定”，也就是说，你可以在任意时刻新增属性.

###查看所有属性
**Object.keys**
>查看一个对象本身的所有属性

```
var obj = {
  key1: 1,
  key2: 2
};

Object.keys(obj);
// ['key1', 'key2']
```
###删除命令
**delete**命令用于删除对象的属性，删除成功后返回**true**

```
var obj = { p: 1 };
Object.keys(obj) // ["p"]

delete obj.p // true
obj.p // undefined
Object.keys(obj) // []

注意，删除一个不存在的属性，delete不报错，而且返回true

var obj = {};
delete obj.p // true
```
因此，不能根据delete命令的结果，认定某个属性是存在的。
```
var obj = Object.defineProperty({}, 'p', {
  value: 123,
  configurable: false
});

obj.p // 123
delete obj.p // false
```
delete命令只能删除对象本身的属性，无法删除继承的属性

####in 运算符
in运算符用于检查 **键名** 是否包含于某个对象
```
var  peter = { level: '99ji'}
"level"   in peter // true
```
继承的属性   in运算符也同样 返回 true
```
var  alice = {};
"toString" in alice //true
```
toString方法不是对象alice自身的属性，而是继承的属性。但是，in运算符不能识别，对继承的属性也返回true。

### for   in 循环
