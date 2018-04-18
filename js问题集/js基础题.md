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