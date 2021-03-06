
####![天平.jpg](https://upload-images.jianshu.io/upload_images/10758861-6d621bf48c8810a3.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
数值
JavaScript 内部，所有数字都是以64位浮点数形式储存。所以，1与1.0是相同的，是同一个数。
```
console.log(1 === 1.0)
 true
```
浮点数不是精确的值，涉及小数的比较和运算要小心

```
0.1 + 0.2 === 0.3
// false

0.3 / 0.1
// 2.9999999999999996

(0.3 - 0.2) === (0.2 - 0.1)
// false
```
**数值范围**为21024到2-1023（开区间），超出这个范围的数无法表示。

**数值的进制**
>十进制：没有前导0的数值。
八进制：有前缀0o或0O的数值，或者有前导0、且只用到0-7的八个阿拉伯数字的数值。
十六进制：有前缀0x或0X的数值。
二进制：有前缀0b或0B的数值。

JavaScript 内部会自动将八进制、十六进制、二进制转为十进制
**NaN**
NaN不是独立的数据类型，而是一个特殊数值，它的数据类型依然属于Number，使用typeof运算符可以看得很清楚。

NaN不等于任何值，包括它本身。
```
NaN === NaN // false
```
**Infinity**
Infinity表示“无穷”，用来表示两种场景。
>一种是一个正的数值太大，或一个负的数值太小，无法表示；
另一种是非0数值除以0，得到Infinity。

####数值相关的全局方法
**parseInt**方法用于将字符串转为整数。
parseInt的返回值只有两种可能
>要么是一个十进制整数
要么是NaN
特点
- 如果parseInt的参数不是字符串，则会先转为字符串再转换。
- 字符串转为整数的时候，是一个个依次转换，如果遇不能转为数字的字符，就不再进行下去，返回已经转好的部分。
- 如果字符串的第一个字符不能转化为数字（后面跟着数字的正负号除外），返回NaN。
**进制转换**
parseInt方法还可以接受第二个参数（2到36之间），表示被解析的值的进制.
默认值为10
```
parseInt('1000', 2) // 8
parseInt('1000', 6) // 216
parseInt('1000', 8) // 512
这个整数只有在2到36之间，才能得到有意义的结果，超出这个范围，则返回NaN
parseInt('10', 37) // NaN
parseInt('10', 1) // NaN
parseInt('10', 0) // 10
parseInt('10', null) // 10
parseInt('10', undefined) // 10
```
**parseFloat()**
parseFloat方法用于将一个字符串转为浮点数。
```
parseFloat('1.14') // 1.14
```
如参数不是字符串，或者字符串的第一个字符不能转化为浮点数，则返回NaN。
```
parseFloat([]) // NaN
parseFloat('FF2') // NaN
parseFloat('') // NaN
```
**isNaN()**
isNaN方法可以用来判断一个值是否为NaN。

>isNaN只对数值有效，如果传入其他值，会被先转成数值。比如，传入字符串的时候，字符串会被先转成NaN，所以最后返回true，这一点要特别引起注意。也就是说，isNaN为true的值，有可能不是NaN，而是一个字符串。
```
isNaN('Hello') // true
// 相当于
isNaN(Number('Hello')) // true
```
对于空数组和只有一个数值成员的数组，isNaN返回false。
```
isNaN([]) // false
isNaN([123]) // false
isNaN(['123']) // false
```
**isFinite**
isFinite方法返回一个布尔值，表示某个值是否为正常的数值。
```
isFinite(Infinity) // false
isFinite(-Infinity) // false
isFinite(NaN) // false
isFinite(undefined) // false
isFinite(null) // true
isFinite(-1) // true
```