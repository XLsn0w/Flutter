## 1.1 Dart简史

Dart语言在2011年10月10日正式诞生, 语言由Google Chrome的V8团队的领导者Lars Bak主导设计, 定位是为下一代的Web开发语言. Dart语言从诞生至今主要经过了1.0和2.0两个阶段.

### 1.1.1 诞生背景

Google公司曾经开发过一个GWT技术, 用于将Java编写到程序翻译为JavaScript语言, 然后在浏览器中执行. 用Java来开发Web程序是为了解决JavaScript语言不擅长复杂工程管理的缺陷, 据说GWT技术曾经大量被用于Gmail等重量级产品的开发工作. 而Dart语言借鉴了C++和Java等诸多面向对象语言的特性, 也是为大型Web应用开发而设计的语言, 可以认为Dart语言是GWT设计思路的延续.

### 1.1.2 Dart 1.0

Dart 1.0是Dart语言第一个重量级的版本, 在2013年10月正式发布. Dart 1.0一发布就全部的携带豪华装备: 一个专门为Dart语言设计的虚拟机; 一个Dart2JS编译工具用于将Dart编译为JavaScript目标代码; 一个基于Eclipse为Dart定制的Dartium IDE集成开发环境. 其中Dartium不仅仅包含了Dart一整套工具链, 而且包含了一个内置Dart虚拟机的Chrome浏览器!

在Dart 1.0诞生的同时, Google公司更是将当时热门的前端开发框架AngularJS移植到了Dart环境. 从Dart语言内置的工具可以看出它有着众多远大目标: Dart2JS/内置Dart VM的Chrome和对AngularJS框架对支持表明Dart语言的定位确实是为下一代的Web开发语言; 同时, 其中Dart VM可以对标Android平台的Dalvik虚拟机, 当时很多业内人生猜测Dart很可能发展为Android开发的主力语言.

在1.0发布之后, ECMA更是成立了专门的TC52技术委员会开展Dart语言的标准化工作. 最终在2014年7月，Dart编程语言第一版成为ECMA国际标准.

### 1.1.3 Dart 2.0

2018年8月, Dart语言正式进入2.0时代. 如果说Dart 1.0只是在各个方向夯实基础, 那么Dart 2.0就是开始真正进入发力阶段了. Dart 2.0针对服务端开发/Web开发/手机开发三大领域做了深度定制细分的工作. 首先Dart语言的标准库为服务器端开发提供了`dart:io`等诸多支持. 在Web方向, Dart继续和Angular框架进行深度整合. 最大的亮点是针对手机设备的Flutter跨平台的开发框架, 它为Dart语言带来了Ahead-of-time编译技术, 可以将Dart语言开发的程序直接编译为本地机器码运行. 同时, Dart2语言针对客户端开发大大加强和精简了类型系统.

虽然Dart语言有着诸多优秀的特性, 国内外的开发人员真正在生产中使用Dart开发的并不多, 甚至坊间有很大Dart语言已死的流言. 但是随着Flutter框架的成熟和Dart2.0的诞生, 而且Google秘密开发的Fuchsia操作系统界面也钦定了Dart语言, Dart语言的再次进入了广大程序开发人员的视线. Dart语言很可能成为是未来几十年中最重要的全栈式开发语言, 它值得每一个严肃的程序开发员认真对待.
