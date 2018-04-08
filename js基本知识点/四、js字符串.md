
####一、定义
字符串就是零个或多个排在一起的字符，放在单引号或双引号之中。
```
"happy"
'happy'
```
单引号可以在双引号里使用，反之亦然。
```
'"sometime"happy'
"all 'work 'and"
```
如果要在单引号字符串的内部，使用单引号，就必须在内部的单引号前面加上反斜杠，用来转义。
双引号字符串内部使用双引号，也是如此。
```
console.log("make john \'boy\'")
make john 'boy'

console.log('make john \"boy\"')
make john "boy
```
字符串默认只能写在一行内，分成多行将会报错
```
'w
o
w'
// SyntaxError: Unexpected token ILLEGAL
```
如果长字符串必须分成多行，可以在每一行的尾部使用反斜杠。
```
'w\
o\
w'
//"wow"
```
也可以用+连接运算符,也是输出成单行
```
var longString = 'Long '
  + 'long '
  + 'long '
  + 'string';
//Long long long string
```
如需多行显示字符串,利用多行注释的变通方法

```
let v= /*ff
ff
ff*/
'abc'
```
###转义
 >\0 ：null（\u0000）
\b ：后退键（\u0008）
\f ：换页符（\u000C）
\n ：换行符（\u000A）
\r ：回车键（\u000D）
\t ：制表符（\u0009）
\v ：垂直制表符（\u000B）
\' ：单引号（\u0027）
\" ：双引号（\u0022）
\\ ：反斜杠（\u005C）

反斜杠还有三种特殊用法。

- （1）\HHH

反斜杠后面紧跟三个八进制数（000到377），代表一个字符。HHH对应该字符的 Unicode 码点，比如\251表示版权符号。显然，这种方法只能输出256种字符。

- （2）\xHH

\x后面紧跟两个十六进制数（00到FF），代表一个字符。HH对应该字符的 Unicode 码点，比如\xA9表示版权符号。这种方法也只能输出256种字符。

- （3）\uXXXX

\u后面紧跟四个十六进制数（0000到FFFF），代表一个字符。XXXX对应该字符的 Unicode 码点，比如\u00A9表示版权符号。
```
'\251' // "©"
'\xA9' // "©"
'\u00A9' // "©"

'\172' === 'z' // true
'\x7A' === 'z' // true
'\u007A' === 'z' // true
```
如果字符串的正常内容之中，需要包含反斜杠，则反斜杠前面需要再加一个反斜杠，用来对自身转义。
```
"AC \\ FUN"
// "AC \FUN"
```
###字符串与数组
```
var s = 'ACFUN';
s[0] // "A"
s[1] // "C"
s[4] // "N"

// 直接对字符串使用方括号运算符
'ACFUN'[1] // "C"
```
如果方括号中的数字超过字符串的长度，或者方括号中根本不是数字，则返回undefined。
```
'abc'[3] // undefined
'abc'[-1] // undefined
'abc'['x'] // undefined
```
###length 属性
```
var s = 'hello';
s.length // 5

s.length = 3;
s.length // 5

s.length = 7;
s.length // 5
```
###字符集
JavaScript 使用 Unicode 字符集。JavaScript 引擎内部，所有字符都用 Unicode 表示。

>「Unicode」是一整套技术标准，包括字符集、编码方案等

>utf-8 是 unicode 字符集一种编码方式。
