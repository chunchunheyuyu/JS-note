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
function a(str) {

    if(typeof  str =='string'){
        var fan = str.split('').reverse().join('')
        if(str === fan){
            return  console.log('str是回文字符串')
        } return   console.log('str不是回文字符串')
    }
    return console.log('非字符串无法判断')
	```
	
6、写一个函数，统计字符串里出现出现频率最多的字符
7、写一个camelize函数，把my-short-string形式的字符串转化成myShortString形式的字符串，如
```
function camlize(str){
   return str.split('-').join('')
}
```
8、写一个 ucFirst函数，返回第一个字母为大写的字符 （***）
```
function a(str){
    var a = str.split('');
   a.splice(0,1,str[0].toUpperCase())
    return a.join('')


}
console.log(a("naruto") )
```


