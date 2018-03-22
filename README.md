##什么是 JavaScript 语言？
####JavaScript 是一种**轻量级的脚本语言**
>“脚本语言”，指的是它不具备开发操作系统的能力，而是只用来编写控制其他大型应用程序的“脚本”。
####JS是一种**嵌入式**语言， 本身不提供任何与 I/O（输入/输出）相关的 API。
>靠宿主环境提供，常见的宿主环境有**浏览器**，**Node项目**

以浏览器为例，它提供的额外 API 可以分成三大类。
- 浏览器控制类：操作浏览器
- DOM 类：操作网页的各种元素
- Web 类：实现互联网的各种功能
##JavaScript 语言的使用领域
####浏览器的平台化
随着 HTML5 的出现，浏览器本身的功能越来越强，不再仅仅能浏览网页，而是越来越像一个平台，JavaScript 因此得以调用许多系统功能。
####Node
Node 项目使得 JavaScript 可以用于开发服务器端的大型项目，
####数据库操作
NoSQL 数据库这个概念，本身就是在 JSON（JavaScript Object Notation，JavaScript 对象表示法）格式的基础上诞生的
####跨移动平台
JavaScript 也正在成为手机应用的开发语言。

Facebook 公司的 React Native 项目则是将 JavaScript 写的组件，编译成原生组件，从而使它们具备优秀的性能。
###JavaScript 优点
####灵活的语法，表达力强。

JavaScript 既支持类似 C 语言清晰的过程式编程，也支持灵活的函数式编程。可以用来写并发处理（concurrent）。这些语法特性已经被证明非常强大，可以用于许多场合，尤其适用异步编程。

JavaScript 的所有值都是对象，这为程序员提供了灵活性和便利性。因为你可以很方便地、按照需要随时创造数据结构，不用进行麻烦的预定义。

JavaScript 的标准还在快速进化中，并不断合理化，并添加更适用的语法特性。

####支持编译运行。

JavaScript 语言本身，虽然是一种解释型语言，但是在现代浏览器中，JavaScript 都是编译后运行。程序会被高度优化，运行效率接近二进制程序。而且，JavaScript 引擎正在快速发展，性能将越来越好。

####事件驱动和非阻塞式设计。

JavaScript 程序可以采用事件驱动（event-driven）和非阻塞式（non-blocking）设计，在服务器端适合高并发环境，普通的硬件就可以承受很大的访问量。
