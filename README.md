# Flutter
Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 
Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。

## iOS知识

一.HTTP post的body体使用form-urlencoded和multipart/form-data的区别。
1）application/x-www-form-urlencoded：
窗体数据被编码为名称/值对，这是标准且默认的编码格式。当action为get时候，客户端把form数据转换成一个字串append到url后面，用?分割。当action为post时候，浏览器把form数据封装到http body中，然后发送到server。
2）multipart/form-data：
multipart表示的意思是单个消息头包含多个消息体的解决方案。multipart媒体类型对发送非文本的各媒体类型是有用的。一般多用于文件上传。
multipart/form-data只是multipart的一种。目前常用的有以下这些类型(注：任何一种执行时无法识别的multipart子类型都被视为子类型"mixed")
二.给你1w让你设计一种机制检测UIViewController的内存泄漏，你会怎么做
如果Controller被释放了，但其曾经持有过的子对象如果还存在，那么这些子对象就是泄漏的可疑目标。
一个小示例：子对象（比如view）建立一个对controller的weak引用，如果Controller被释放，这个weak引用也随之置为nil。那怎么知道子对象没有被释放呢？用一个单例对象每个一小段时间发出一个ping通知去ping这个子对象，如果子对象还活着就会一个pong通知。所以结论就是：如果子对象的controller已不存在，但还能响应这个ping通知，那么这个对象就是可疑的泄漏对象。
三.[通过[UIImage imageNamed:]生成的对象什么时候被释放？]
使用imageNamed这个方法生成的UIImage对象,会在应用的bundle中寻找图片,如果找到则Cache到系统缓存中,作为内存的cache,而程序员是无法操作cache的,只能由系统自动处理,如果我们需要重复加载一张图片,那这无疑是一种很好的方式,因为系统能很快的从内存的cache找到这张图片,但是试想,如果加载很多很大的图片的时候,内存消耗过大的时候,就会会强制释放内存，即会遇到内存警告(memory warnings).
由于在iOS系统中释放图片的内存比较麻烦,所以冲易产生内存泄露。
像[[UIImageView alloc] init]还有一些其他的 init 方法，返回的都是 autorelease 对象。而 autorelease 不能保证什么时候释放，所以不一定在引用计数为 0 就立即释放，只能保证在 autoreleasepool 结尾的时候释放。
像 UIImage 还有 NSData 这种，大部分情况应该是延迟释放的，可以理解为到 autoreleasepool 结束的时候才释放。
四.applicationDidBecomeActive和applicationWillEnterForeground在哪些场景下被调用呢？举例越多越好
1）applicationWillResignActive（将进入后台）
对应applicationWillEnterForeground（将进入前台）
程序将要失去Active状态时调用，比如按下Home键或有电话信息进来，这个方法用来

暂停正在执行的任务；
禁止计时器；
减少OpenGL ES帧率；
若为游戏应暂停游戏；

总结为一个字：停！
2）applicationDidEnterBackground（已经进入后台）
对应applicationDidBecomeActive（已经变成前台）
程序已经进入后台时调用，这个方法用来

释放共享资源；
保存用户数据（写到硬盘）；
作废计时器；
保存足够的程序状态以便下次恢复；总结为4个字：释放、保存！

五.dSYM我们可以如何分析的
方法1 使用XCode
这种方法可能是最容易的方法了。

要使用Xcode符号化 crash log，你需要下面所列的3个文件：
crash报告（.crash文件）
符号文件 (.dsymb文件)
应用程序文件 (appName.app文件，把IPA文件后缀改为zip，然后解压，Payload目录下的appName.app文件), 这里的appName是你的应用程序的名称。
把这3个文件放到同一个目录下，打开Xcode的Window菜单下的organizer，然后点击Devices tab，然后选中左边的Device Logs。
然后把.crash文件拖到Device Logs或者选择下面的import导入.crash文件。
这样你就可以看到crash的详细log了。

方法2 使用命令行工具symbolicatecrash

有时候Xcode不能够很好的符号化crash文件。我们这里介绍如何通过symbolicatecrash来手动符号化crash log。
在处理之前，请依然将“.app“, “.dSYM”和 ".crash"文件放到同一个目录下。现在打开终端(Terminal)然后输入如下的命令：
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
然后输入命令：
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/PrivateFrameworks/DTDeviceKitBase.framework/Versions/A/Resources/symbolicatecrash appName.crash appName.app > appName.log
现在，符号化的crash log就保存在appName.log中了。

方法3 使用命令行工具atos

如果你有多个“.ipa”文件，多个".dSYMB"文件，你并不太确定到底“dSYMB”文件对应哪个".ipa"文件，那么，这个方法就非常适合你。
特别当你的应用发布到多个渠道的时候，你需要对不同渠道的crash文件，写一个自动化的分析脚本的时候，这个方法就极其有用。
具体方法 请百度

六.多线程有哪几种？你更倾向于哪一种？

NSThread
Cocoa NSOperation （使用NSOperation和NSOperationQueue）
GCD （Grand Central Dispatch）

1.NSThread:(两种创建方式)
1. [NSThread detachNewThreadSelector:@selector(doSomething:) toTarget:self withObject:nil];
2.
3.NSThread *myThread = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething:) object:nil];
4.
5.[myThread start];
6.
复制代码
优点：NSThread 比其他两个轻量级。 缺点：需要自己管理线程的生命周期，线程同步，线程同步时对数据的加锁会有一定的系统开销。
2.Cocoa Operation
1.NSOperationQueue*oprationQueue= [[NSOperationQueuealloc] init];
2.
3.oprationQueueaddOperationWithBlock:^{
4.
5.//这个block语句块在子线程中执行
6.
7.}
复制代码
优点：不需要关心线程管理，数据同步的事情。 Cocoa Operation 相关的类是 NSOperation ，NSOperationQueue。NSOperation是个抽象类，使用它必须用它的子类，可以实现它或者使用它定义好的两个子类：NSInvocationOperation 和 NSBlockOperation。创建NSOperation子类的对象，把对象添加到NSOperationQueue队列里执行，我们会把我们的执行操作放在NSOperation中main函数中。
3.GCD Grand Central Dispatch (GCD)是Apple开发的一个多核编程的解决方法，GCD是一个替代诸如NSThread, NSOperationQueue, NSInvocationOperation等技术的很高效和强大的技术。它让程序平行排队的特定任务，根据可用的处理资源，安排他们在任何可用的处理器核心上执行任务，一个任务可以是一个函数(function)或者是一个block。 dispatch queue分为下面三种： private dispatch queues，同时只执行一个任务，通常用于同步访问特定的资源或数据。 global dispatch queue，可以并发地执行多个任务，但是执行完成的顺序是随机的。 Main dispatch queue 它是在应用程序主线程上执行任务的。
七.单例的弊端
优点：
1：一个类只被实例化一次，提供了对唯一实例的受控访问。
2：节省系统资源
3：允许可变数目的实例。
缺点：
1：一个类只有一个对象，可能造成责任过重，在一定程度上违背了“单一职责原则”。
2：由于单例模式中没有抽象层，因此单例类的扩展有很大的困难。
3：滥用单例将带来一些负面问题，如为了节省资源将数据库连接池对象设计为的单例类，可能会导致共享连接池对象的程序过多而出现连接池溢出；如果实例化的对象长时间不被利用，系统会认为是垃圾而被回收，这将导致对象状态的丢失。
八.App启动过慢，因素有哪些？欢迎讨论。
1. App启动过程

解析Info.plist


加载相关信息，例如如闪屏
沙箱建立、权限检查


Mach-O加载


如果是胖二进制文件，寻找合适当前CPU类别的部分
加载所有依赖的Mach-O文件（递归调用Mach-O加载的方法）
定位内部、外部指针引用，例如字符串、函数等
执行声明为attribute((constructor))的C函数
加载类扩展（Category）中的方法
C++静态对象加载、调用ObjC的 +load 函数


程序执行


调用main()
调用UIApplicationMain()
调用applicationWillFinishLaunching

2、影响启动性能的因素

main()函数之前耗时的影响因素


动态库加载越多，启动越慢。
ObjC类越多，启动越慢
C的constructor函数越多，启动越慢
C++静态对象越多，启动越慢
ObjC的+load越多，启动越慢


main()函数之后耗时的影响因素


执行main()函数的耗时
执行applicationWillFinishLaunching的耗时
rootViewController及其childViewController的加载、view及其subviews的加载


另外参考一下今日头条的启动优化方案

针对于今日头条这个App我们可以优化的点如下：

纯代码方式而不是storyboard加载首页UI。
对didFinishLaunching里的函数考虑能否挖掘可以延迟加载或者懒加载，需要与各个业务方pm和rd共同check 对于一些已经下线的业务，删减冗余代码。
对于一些与UI展示无关的业务，如微博认证过期检查、图片最大缓存空间设置等做延迟加载。
对实现了+load()方法的类进行分析，尽量将load里的代码延后调用。
上面统计数据显示展示feed的导航控制器页面(NewsListViewController)比较耗时，对于viewDidLoad以及viewWillAppear方法中尽量去尝试少做，晚做，不做。

九.如何防止反编译？

本地数据加密。


iOS应用防反编译加密技术之一：对NSUserDefaults，sqlite存储文件数据加密，保护帐号和关键信息


URL编码加密。


iOS应用防反编译加密技术之二：对程序中出现的URL进行编码加密，防止URL被静态分析


网络传输数据加密。


iOS应用防反编译加密技术之三：对客户端传输数据提供加密方案，有效防止通过网络接口的拦截获取数据


方法体，方法名高级混淆。


iOS应用防反编译加密技术之四：对应用程序的方法名和方法体进行混淆，保证源码被逆向后无法解析代码


程序结构混排加密。


iOS应用防反编译加密技术之五：对应用程序逻辑结构进行打乱混排，保证源码可读性降到最低

十.UDP和TCP的区别于联系

TCP为传输控制层协议，为面向连接、可靠的、点到点的通信；
UDP为用户数据报协议，非连接的不可靠的点到多点的通信；
TCP侧重可靠传输，UDP侧重快速传输。

十一.TCP连接的三次握手
第一次握手：客户端发送 syn 包(syn=j)到服务器，并进入 SYN_SEND 状态，等待服务器确认；
第二次握手：服务器收到 syn 包，必须确认客户的 SYN（ack=j+1），同时自己也发送一个 SYN 包（syn=k），即 SYN+ACK 包，此时服务器进入 SYN_RECV 状态；
第三次握手：客户端收到服务器的SYN＋ACK包，向服务器发送确认包ACK(ack=k+1)，此包发送完毕，客户端和服务器进入 ESTABLISHED 状态，完成三次握手。
握手过程中传送的包里不包含数据，三次握手完毕后，客户端与服务器才正式开始传送数据。理想状态下，TCP 连接一旦建立，在通信双方中的任何一方主动关闭连接之前，TCP 连接都将被一直保持下去。断开连接时服务器和客户端均可以主动发起断开 TCP 连接的请求，断开过程需要经过“四次握手”（过程就不细写了，就是服务器和客户端交互，最终确定断开）

十二.Scoket连接和HTTP连接有什么区别
区别：


HTTP协议是基于TCP连接的，是应用层协议，主要解决如何包装数据。Socket是对TCP/IP协议的封装，Socket本身并不是协议，而是一个调用接口（API），通过Socket，我们才能使用TCP/IP协议。


HTTP连接：短连接，客户端向服务器发送一次请求，服务器响应后连接断开，节省资源。服务器不能主动给客户端响应（除非采用HTTP长连接技术），iPhone主要使用类NSURLConnection。


Socket连接：长连接，客户端跟服务器端直接使用Socket进行连接，没有规定连接后断开，因此客户端和服务器段保持连接通道，双方可以主动发送数据，一般多用于游戏.Socket默认连接超时时间是30秒，默认大小是8K（理解为一个数据包大小）。


十三.HTTP协议的特点，关于HTTP请求GET和POST的区别
GET和POST的区别：


HTTP超文本传输协议，是短连接，是客户端主动发送请求，服务器做出响应，服务器响应之后，链接断开。HTTP是一个属于应用层面向对象的协议，HTTP有两类报文：请求报文和响应报文。


HTTP请求报文：一个HTTP请求报文由请求行、请求头部、空行和请求数据4部分组成。


HTTP响应报文：由三部分组成：状态行、消息报头、响应正文。


GET请求：参数在地址后拼接，没有请求数据，不安全（因为所有参数都拼接在地址后面），不适合传输大量数据（长度有限制，为1024个字节）。



GET提交、请求的数据会附在URL之后，即把数据放置在HTTP协议头< requestline>中。
以分割URL和传输数据，多个参数用&连接。如果数据是英文字母或数字，原样发送，
如果是空格，转换为+，如果是中文/其他字符，则直接把字符串用BASE64加密。



POST请求：参数在请求数据区放着，相对GET请求更安全，并且数据大小没有限制。把提交的数据放置在HTTP包的包体< request-body>中.


GET提交的数据会在地址栏显示出来，而POST提交，地址栏不会改变。


传输数据的大小：

GET提交时，传输数据就会受到URL长度限制，POST由于不是通过URL传值，理论上书不受限。

安全性：


POST的安全性要比GET的安全性高；


通过GET提交数据，用户名和密码将明文出现在URL上，比如登陆界面有可能被浏览器缓存。


HTTPS：安全超文本传输协议（Secure Hypertext Transfer Protocol），它是一个安全通信通道，基于HTTP开发，用于客户计算机和服务器之间交换信息，使用安全套结字层（SSL）进行信息交换，即HTTP的安全版。


十四.AFNetWorking、ASIHttpRequest两者的区别


ASIHttpRequest功能强大，主要是在MRC下实现的，是对系统CFNetwork API进行了封装，支持HTTP协议的CFHTTP，配置比较复杂，并且ASIHttpRequest框架默认不会帮你监听网络改变，如果需要让ASIHttpRequest帮你监听网络状态改变，并且手动开始这个功能。


AFNetWorking构建于NSURLConnection、NSOperation以及其他熟悉的Foundation技术之上。拥有良好的架构，丰富的API及模块构建方式，使用起来非常轻松。它基于NSOperation封装的，AFURLConnectionOperation子类。


ASIHttpRequest是直接操作对象ASIHttpRequest是一个实现了NSCoding协议的NSOperation子类；AFNetWorking直接操作对象的AFHttpClient，是一个实现NSCoding和NSCopying协议的NSObject子类。


同步请求：ASIHttpRequest直接通过调用一个startSynchronous方法；AFNetWorking默认没有封装同步请求，如果开发者需要使用同步请求，则需要重写getPath:paraments:success:failures方法，对于AFHttpRequestOperation进行同步处理。


性能对比：AFNetworking请求优于ASIHttpRequest；


十五.XML有各有什么不同的数据解析方式，JSON解析有哪些框架？（iOS面试题）


XML数据解析的两种解析方式：DOM解析和SAX解析；


DOM解析必须完成DOM树的构造，在处理规模较大的XML文档时就很耗内存，占用资源较多，读入整个XML文档并构建一个驻留内存的树结构（节点树），通过遍历树结构可以检索任意XML节点，读取它的属性和值，通常情况下，可以借助XPath查询XML节点；


SAX与DOM不同，它是事件驱动模型，解析XML文档时每遇到一个开始或者结束标签、属性或者一条指令时，程序就产生一个事件进行相应的处理，一边读取XML文档一边处理，不必等整个文档加载完才采取措施，当在读取解析过程中遇到需要处理的对象，会发出通知进行处理。因此，SAX相对于DOM来说更适合操作大的XML文档。
-JSON解析：性能比较好的主要是第三方的JSONKIT和iOS自带的JSON解析类，其中自带的JSON解析性能最高，只能用于iOS5之后。


十六.SVN的使用


SVN=版本控制+备份服务器，可以把SVN当成备份服务器，并且可以帮助你记住每次上服务器的档案内容，并自动赋予每次变更的版本；


SVN的版本控制：所有上传版本都会帮您记录下来，也有版本分支及合并等功能。SVN可以让不同的开发者存取同样的档案，并且利用SVN Server作为档案同步的机制，即您有档案更新时，无需将档案寄送给您的开发成员。SVN的存放档案方式是采用差异备份的方式，即会备份到不同的地方，节省硬盘空间，也可以对非文字文件进行差异备份。


SVN的重要性：备份工作档案的重要性、版本控管的重要性、伙伴间的数据同步的重要性、备份不同版本是很耗费硬盘空间的；


防止冲突：
1.防止代码冲突：不要多人同时修改同一文件，例如：A、B都修改同一个文件，先让A修改，然后提交到服务器，然后B更新下来，再进行修改；
2.服务器上的项目文件Xcodeproj，仅让一个人管理提交，其他人只更新，防止文件发生冲突。


十七.如何高效的进行网络消息的推送


一种是Apple自己提供的通知服务（APNS服务器）、一种是用第三方推送机制。


首先应用发送通知，系统弹出提示框询问用户是否允许，当用户允许后向苹果服务器(APNS)请求deviceToken，并由苹果服务器发送给自己的应用，自己的应用将DeviceToken发送自己的服务器，自己服务器想要发送网络推送时将deviceToken以及想要推送的信息发送给苹果服务器，苹果服务器将信息发送给应用。


推送信息内容，总容量不超过256个字节；


iOS SDK本身提供的APNS服务器推送，它可以直接推送给目标用户并根据您的方式弹出提示。
优点：不论应用是否开启，都会发送到手机端；
缺点：消息推送机制是苹果服务端控制，个别时候可能会有延迟，因为苹果服务器也有队列来处理所有的消息请求；


第三方推送机制，普遍使用Socket机制来实现，几乎可以达到即时的发送到目标用户手机端，适用于即时通讯类应用。
优点：实时的，取决于心跳包的节奏；
缺点：iOS系统的限制，应用不能长时间的后台运行，所以应用关闭的情况下这种推送机制不可用。


十八.网络七层协议


应用层：
1.用户接口、应用程序；
2.Application典型设备：网关；
3.典型协议、标准和应用：TELNET、FTP、HTTP


表示层：
1.数据表示、压缩和加密presentation
2.典型设备：网关
3.典型协议、标准和应用：ASCLL、PICT、TIFF、JPEG|MPEG
4.表示层相当于一个东西的表示，表示的一些协议，比如图片、声音和视频MPEG。


会话层：
1.会话的建立和结束；
2.典型设备：网关；
3.典型协议、标准和应用：RPC、SQL、NFS、X WINDOWS、ASP


传输层：
1.主要功能：端到端控制Transport；
2.典型设备：网关；
3.典型协议、标准和应用：TCP、UDP、SPX


网络层：
1.主要功能：路由、寻址Network；
2.典型设备：路由器；
3.典型协议、标准和应用：IP、IPX、APPLETALK、ICMP；


数据链路层：
1.主要功能：保证无差错的疏忽链路的data link；
2.典型设备：交换机、网桥、网卡；
3.典型协议、标准和应用：802.2、802.3ATM、HDLC、FRAME RELAY；


物理层：
1.主要功能：传输比特流Physical；
2.典型设备：集线器、中继器
3.典型协议、标准和应用：V.35、EIA/TIA-232.


十九.知道关键字volatile有什么含意?

一个定义为volatile的变量是说这变量可能会被意想不到地改变，这样，编译器就不会去假设这个变量的值了。精确地说就是，优化器在用到这个变量时必须每次都小心地重新读取这个变量的值，而不是使用保存在寄存器里的备份。下面是volatile变量的几个例子：
• 并行设备的硬件寄存器（如：状态寄存器）；
•一个中断服务子程序中会访问到的非自动变量(Non-automatic variables)；
• 多线程应用中被几个任务共享的变量。

二十.属性property修饰符的作用


getter=getName、setter=setName：设置setter与getter的方法名；


readwrite、readonly：设置可供访问级别；


assign：方法直接赋值，不进行任何retain操作，为了解决原类型与环循引用问题；


retain：其setter方法对参数进行release旧值再* retain新值，所有实现都是这个顺序；


copy：其setter方法进行copy操作，与retain处理流程一样，先对旧值release，再copy出新的对象，retainCount为1。这是为了减少对上下文的依赖而引入的机制。


nonatomic：非原子性访问，不加同步， 多线程并发访问会提高性能。注意，如果不加此属性，则默认是两个访问方法都为原子型事务访问。

二十一：XIB与Storyboards的优缺点
优点：

XIB：在编译前就提供了可视化界面，可以直接拖控件，也可以直接给控件添加约束，更直观一些，而且类文件中就少了创建控件的代码，确实简化不少，通常每个XIB对应一个类。
Storyboard：在编译前提供了可视化界面，可拖控件，可加约束，在开发时比较直观，而且一个storyboard可以有很多的界面，每个界面对应一个类文件，通过storybard，可以直观地看出整个App的结构。

缺点：

XIB：需求变动时，需要修改XIB很大，有时候甚至需要重新添加约束，导致开发周期变长。XIB载入相比纯代码自然要慢一些。对于比较复杂逻辑控制不同状态下显示不同内容时，使用XIB是比较困难的。当多人团队或者多团队开发时，如果XIB文件被发动，极易导致冲突，而且解决冲突相对要困难很多。
Storyboard：需求变动时，需要修改storyboard上对应的界面的约束，与XIB一样可能要重新添加约束，或者添加约束会造成大量的冲突，尤其是多团队开发。对于复杂逻辑控制不同显示内容时，比较困难。当多人团队或者多团队开发时，大家会同时修改一个storyboard，导致大量冲突，解决起来相当困难。

二十二：内存的使用和优化的注意事项


重用问题：如UITableViewCells、UICollectionViewCells、UITableViewHeaderFooterViews设置正确的reuseIdentifier，充分重用；


尽量把views设置为不透明：当opque为NO的时候，图层的半透明取决于图片和其本身合成的图层为结果，可提高性能；


不要使用太复杂的XIB/Storyboard：载入时就会将XIB/storyboard需要的所有资源，包括图片全部载入内存，即使未来很久才会使用。那些相比纯代码写的延迟加载，性能及内存就差了很多；


选择正确的数据结构：学会选择对业务场景最合适的数组结构是写出高效代码的基础。比如，数组: 有序的一组值。使用索引来查询很快，使用值查询很慢，插入/删除很慢。字典: 存储键值对，用键来查找比较快。集合: 无序的一组值，用值来查找很快，插入/删除很快。
gzip/zip压缩：当从服务端下载相关附件时，可以通过gzip/zip压缩后再下载，使得内存更小，下载速度也更快。


延迟加载：对于不应该使用的数据，使用延迟加载方式。对于不需要马上显示的视图，使用延迟加载方式。比如，网络请求失败时显示的提示界面，可能一直都不会使用到，因此应该使用延迟加载。


数据缓存：对于cell的行高要缓存起来，使得reload数据时，效率也极高。而对于那些网络数据，不需要每次都请求的，应该缓存起来，可以写入数据库，也可以通过plist文件存储。


处理内存警告：一般在基类统一处理内存警告，将相关不用资源立即释放掉
重用大开销对象：一些objects的初始化很慢，比如NSDateFormatter和NSCalendar，但又不可避免地需要使用它们。通常是作为属性存储起来，防止反复创建。


避免反复处理数据：许多应用需要从服务器加载功能所需的常为JSON或者XML格式的数据。在服务器端和客户端使用相同的数据结构很重要;


使用Autorelease Pool：在某些循环创建临时变量处理数据时，自动释放池以保证能及时释放内存;


正确选择图片加载方式：UIImage加载方式


二十三：基于CTMediator的组件化方案，有哪些核心组成？
假如主APP调用某业务A，那么需要以下组成部分：

CTMediator类，该类提供了函数 - (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;
这个函数可以根据targetName生成对象，根据actionName构造selector，然后可以利用performSelector:withObject:方法，在目标上执行动作。
业务A的实现代码，另外要加一个专门的类，用于执行Target Action
类的名字的格式：Target_%@，这里就是Target_A。
这个类里面的方法，名字都以Action_开头，需要传参数时，都统一以NSDictionary*的形式传入。
CTMediator类会创建Target类的对象，并在对象上执行方法。
业务A的CTMediator扩展
扩展里声明了所有A业务的对外接口，参数明确，这样外部调用者可以很容易理解如何调用接口。
在扩展的实现里，对Target, Action需要通过硬编码进行指定。由于扩展的负责方和业务的负责方是相同的，所以这个不是问题。

二十四：为什么CTMediator方案优于基于Router的方案？
Router的缺点：

在组件化的实施过程中，注册URL并不是充分必要条件。组件是不需要向组件管理器注册URL的，注册了URL之后，会造成不必要的内存常驻。注册URL的目的其实是一个服务发现的过程，在iOS领域中，服务发现的方式是不需要通过主动注册的，使用runtime就可以了。另外，注册部分的代码的维护是一个相对麻烦的事情，每一次支持新调用时，都要去维护一次注册列表。如果有调用被弃用了，是经常会忘记删项目的。runtime由于不存在注册过程，那就也不会产生维护的操作，维护成本就降低了。 由于通过runtime做到了服务的自动发现，拓展调用接口的任务就仅在于各自的模块，任何一次新接口添加，新业务添加，都不必去主工程做操作，十分透明。
在iOS领域里，一定是组件化的中间件为openURL提供服务，而不是openURL方式为组件化提供服务。如果在给App实施组件化方案的过程中是基于openURL的方案的话，有一个致命缺陷：非常规对象(不能被字符串化到URL中的对象，例如UIImage)无法参与本地组件间调度。
在本地调用中使用URL的方式其实是不必要的，如果业务工程师在本地间调度时需要给出URL，那么就不可避免要提供params，在调用时要提供哪些params是业务工程师很容易懵逼的地方。
为了支持传递非常规参数，蘑菇街的方案采用了protocol，这个会侵入业务。由于业务中的某个对象需要被调用，因此必须要符合某个可被调用的protocol，然而这个protocol又不存在于当前业务领域，于是当前业务就不得不依赖public Protocol。这对于将来的业务迁移是有非常大的影响的。

CTMediator的优点：

调用时，区分了本地应用调用和远程应用调用。本地应用调用为远程应用调用提供服务。
组件仅通过Action暴露可调用接口，模块与模块之间的接口被固化在了Target-Action这一层，避免了实施组件化的改造过程中，对Business的侵入，同时也提高了组件化接口的可维护性。
方便传递各种类型的参数。

二十五：MVVM设计模式
组成部分如下图所示：

在这个设计模式里，核心是ViewModel，它是一种特殊类型的model，代表了应用中UI的状态。它包含如下内容：

每个UI控件的一些属性。例如，text field控件的当前文本，某个button是否是enable状态。
视图可以执行的动作，例如按钮点击或者是手势。

将ViewModel想象为视图的模型，会比较容易理解。
MVVM模式中，三个组件的关系比MVC模式的要简单，有下面的严格规则：

视图引用ViewModel，但反向不成立。
ViewModel引用Model，但反向不成立。

如果违背了上面两条规则，那么就是错误的MVVM实施行为。
这种模式的好处：

轻量级的视图(控制器)， 所有的UI逻辑都位于ViewModel中。
易测试性。可以在没有视图的情况下，运行整个应用。

二十六：weak修饰的释放则自动被置为nil的实现原理


Runtime维护着一个Weak表，用于存储指向某个对象的所有Weak指针


Weak表是Hash表，Key是所指对象的地址，Value是Weak指针地址的数组


在对象被回收的时候，经过层层调用，会最终触发下面的方法将所有Weak指针的值设为nil。* runtime源码，objc-weak.m 的 arr_clear_deallocating 函数


weak指针的使用涉及到Hash表的增删改查，有一定的性能开销.


二十七：HTTPS的加密原理


服务器端用非对称加密(RSA)生成公钥和私钥


然后把公钥发给客户端, 服务器则保存私钥


客户端拿到公钥后, 会生成一个密钥, 这个密钥就是将来客户端和服务器用来通信的钥匙


然后客户端用公钥对密钥进行加密, 再发给服务器


服务器拿到客户端发来的加密后的密钥后, 再使用私钥解密密钥, 到此双方都获得通信的钥匙


二十八：你认为开发中那些导致crash?

当iOS设备上的App应用闪退时，操作系统会生成一个crash日志，保存在设备上。crash日志上有很多有用的信息，比如每个正在执行线程的完整堆栈跟踪信息和内存映像，这样就能够通过解析这些信息进而定位crash发生时的代码逻辑，从而找到App闪退的原因。


通常来说，crash产生来源于两种问题：违反iOS系统规则导致的crash和App代码逻辑BUG导致的crash

1.应用逻辑的Bug

SEGV：（Segmentation Violation，段违例），无效内存地址，比如空指针，未初始化指针，栈溢出等；
SIGABRT：收到Abort信号，可能自身调用abort()或者收到外部发送过来的信号；
SIGBUS：总线错误。与SIGSEGV不同的是，SIGSEGV访问的是无效地址（比如虚存映射不到物理内存），而SIGBUS访问的是有效地址，但总线访问异常（比如地址对齐问题）；
SIGILL：尝试执行非法的指令，可能不被识别或者没有权限；
SIGFPE：Floating Point Error，数学计算相关问题（可能不限于浮点计算），比如除零操作；
SIGPIPE：管道另一端没有进程接手数据； 常见的崩溃原因基本都是代码逻辑问题或资源问题，比如数组越界，访问野指针或者资源不存在，或资源大小写错误等

2.违反iOS系统规则产生crash的三种类型


内存报警闪退

当iOS检测到内存过低时，它的VM系统会发出低内存警告通知，尝试回收一些内存；如果情况没有得到足够的改善，iOS会终止后台应用以回收更多内存；最后，如果内存还是不足，那么正在运行的应用可能会被终止掉。在Debug模式下，可以主动将客户端执行的动作逻辑写入一个log文件中，这样程序童鞋可以将内存预警的逻辑写入该log文件，当发生如下截图中的内存报警时，就是提醒当前客户端性能内存吃紧，可以通过Instruments工具中的Allocations 和 Leaks模块库来发现内存分配问题和内存泄漏问题。



响应超时

当应用程序对一些特定的事件（比如启动、挂起、恢复、结束）响应不及时，苹果的Watchdog机制会把应用程序干掉，并生成一份相应的crash日志。



用户强制退出

一看到“用户强制退出”，首先可能想到的双击Home键，然后关闭应用程序。不过这种场景一般是不会产生crash日志的，因为双击Home键后，所有的应用程序都处于后台状态，而iOS随时都有可能关闭后台进程，当应用阻塞界面并停止响应时这种场景才会产生crash日志。这里指的“用户强制退出”场景，是稍微比较复杂点的操作：先按住电源键，直到出现“滑动关机”的界面时，再按住Home键，这时候当前应用程序会被终止掉，并且产生一份相应事件的crash日志。



二十九：分析下SDWebImage
1.SDWebImage 加载图片的流程
1.入口 setImageWithURL:placeholderImage:options: 会先把 placeholderImage 显示，然后 SDWebImageManager 根据 URL 开始处理图片。
2.进入 SDWebImageManager-downloadWithURL:delegate:options:userInfo:，交给 SDImageCache 从缓存查找图片是否已经下载 queryDiskCacheForKey:delegate:userInfo:.
3.先从内存图片缓存查找是否有图片，如果内存中已经有图片缓存，SDImageCacheDelegate 回调 imageCache:didFindImage:forKey:userInfo: 到 SDWebImageManager。
4.SDWebImageManagerDelegate 回调 webImageManager:didFinishWithImage: 到 UIImageView+WebCache 等前端展示图片。
5.如果内存缓存中没有，生成 NSInvocationOperation 添加到队列开始从硬盘查找图片是否已经缓存。
6.根据 URLKey 在硬盘缓存目录下尝试读取图片文件。这一步是在 NSOperation 进行的操作，所以回主线程进行结果回调 notifyDelegate:。
7.如果上一操作从硬盘读取到了图片，将图片添加到内存缓存中（如果空闲内存过小，会先清空内存缓存）。SDImageCacheDelegate 回调 imageCache:didFindImage:forKey:userInfo:。进而回调展示图片。
8.如果从硬盘缓存目录读取不到图片，说明所有缓存都不存在该图片，需要下载图片，回调 imageCache:didNotFindImageForKey:userInfo:。
9.共享或重新生成一个下载器 SDWebImageDownloader 开始下载图片。
10.图片下载由 NSURLConnection 来做，实现相关 delegate 来判断图片下载中、下载完成和下载失败。
11.connection:didReceiveData: 中利用 ImageIO 做了按图片下载进度加载效果。
12.connectionDidFinishLoading: 数据下载完成后交给 SDWebImageDecoder 做图片解码处理。
13.图片解码处理在一个 NSOperationQueue 完成，不会拖慢主线程 UI。如果有需要对下载的图片进行二次处理，最好也在这里完成，效率会好很多。
14.在主线程 notifyDelegateOnMainThreadWithInfo: 宣告解码完成，imageDecoder:didFinishDecodingImage:userInfo: 回调给 SDWebImageDownloader。
15.imageDownloader:didFinishWithImage: 回调给 SDWebImageManager 告知图片下载完成。
16.通知所有的 downloadDelegates 下载完成，回调给需要的地方展示图片。
17.将图片保存到 SDImageCache 中，内存缓存和硬盘缓存同时保存。写文件到硬盘也在以单独 NSInvocationOperation 完成，避免拖慢主线程。
18.SDImageCache 在初始化的时候会注册一些消息通知，在内存警告或退到后台的时候清理内存图片缓存，应用结束的时候清理过期图片。
19.SDWI 也提供了 UIButton+WebCache 和 MKAnnotationView+WebCache，方便使用。
20.SDWebImagePrefetcher 可以预先下载图片，方便后续使用。

SDWebImage原理图

SDWebImage原理图
2. SDImageCache是怎么做数据管理的？
SDImageCache分两个部分，一个是内存层面的，一个是硬盘层面的。内存层面的相当是个缓存器，以Key-Value的形式存储图片。当内存不够的时候会清除所有缓存图片。用搜索文件系统的方式做管理，文件替换方式是以时间为单位，剔除时间大于一周的图片文件。当SDWebImageManager向SDImageCache要资源时，先搜索内存层面的数据，如果有直接返回，没有的话去访问磁盘，将图片从磁盘读取出来，然后做Decoder，将图片对象放到内存层面做备份，再返回调用层。
3.内部做Decoder的原因 (典型的空间换时间)
由于UIImage的imageWithData函数是每次画图的时候才将Data解压成ARGB的图像，所以在每次画图的时候，会有一个解压操作，这样效率很低，但是只有瞬时的内存需求。为了提高效率通过SDWebImageDecoder将包装在Data下的资源解压，然后画在另外一张图片上，这样这张新图片就不再需要重复解压了
三十：SEL和Method和IMP分别说下再谈下对IMP的理解?
Method
先看下定义
1. runtime.h
2. /// An opaque type that represents a method in a class definition.代表类定义中一个方法的不透明类型
3. typedef struct objc_method *Method;
4. 
5. struct objc_method {
6.     SEL method_name                                          OBJC2_UNAVAILABLE;
7.     char *method_types                                       OBJC2_UNAVAILABLE;
8.     IMP method_imp                                           OBJC2_UNAVAILABLE;
9. } 
复制代码
Method和我们平时理解的函数是一致的，就是表示能够独立完成一个功能的一段代码，比如：
1. - (void)logName
2. {
3.     NSLog(@"name");
4. } 
复制代码
这段代码，就是一个函数。
我们来看下objc_method这个结构体的内容：

SEL method_name 方法名
char *method_types 方法类型
IMP method_imp 方法实现

在这个结构体重，我们已经看到了SEL和IMP，说明SEL和IMP其实都是Method的属性。
我们接着来看SEL。
SEL
还是先看定义
1. Objc.h
2. /// An opaque type that represents a method selector.代表一个方法的不透明类型
3. typedef struct objc_selector *SEL;
复制代码
这里要先说明下selector和SEL的关系，我在写本文的时候，其实搜索的是selector，直到我看到了selector的定义，才发现我理解一直不对。
1. @property SEL selector;
复制代码
在文档中，selector的定义都是这样声明，也就是说：selector是SEL的一个实例，只是在iOS中，selector的使用是如此的频繁，我们才会把他当成一个概念。
selector怎么理解呢？我们可以想想股票，比如市场上有如此多公司在纳斯达克上市，而且他们的名字又非常的长，或者有些公司的名称也是相似的，都是**有限公司。那当市场去指定一个股票的时候，效率会非常低，当你着急想买股票的时候，你会跟你的经纪人说：“hi，peter，给我买一百股Tuniu limited liability company的股票吗？”，也许等你说完，经纪人输入完，市场就变化了，所以纳斯达克通常用代码，比如“TOUR”.这里的selector有类似的作用，就是让我们能够快速找到对应的函数。
文档中是这样讲的：

A method selector is a C string that has been registered (or “mapped“) with the Objective-C runtime. Selectors generated by the compiler are automatically mapped by the runtime when the class is loaded.

在iOS中，runtime会在运行的时候，通过load函数，将所有的methodhash然后map到set中。这样在运行的时候，寻找selector的速度就会非常快，不会因为runtime特性牺牲太多的性能。
selector既然是一个string，我觉得应该是类似className+method的组合，命名规则有两条：

同一个类，selector不能重复
不同的类，selector可以重复

这也带来了一个弊端，我们在写C代码的时候，经常会用到函数重载，就是函数名相同，参数不同，但是这在Objective-C中是行不通的，因为selector只记了method的name，没有参数，所以没法区分不同的method。
比如：
1. - (void)caculate(NSInteger)num;
2. 
3. - (void)caculate(CGFloat)num;
复制代码
是会报错的。
我们只能通过命名来区别：
1. - (void)caculateWithInt(NSInteger)num;
2. 
3. - (void)caculateWithFloat(CGFloat)num;
复制代码
IMP
看下IMP的定义
1. /// A pointer to the function of a method implementation.  指向一个方法实现的指针
2. typedef id (*IMP)(id, SEL, ...); 
3. #endif
复制代码
这个就比较好理解了，就是指向最终实现程序的内存地址的指针。
综上，在iOS的runtime中，Method通过selector和IMP两个属性，实现了快速查询方法及实现，相对提高了性能，又保持了灵活性。
三十一：Autorelease的原理 ?

ARC下面,我们使用@autoreleasepool{}来使用一个Autoreleasepool,实际上UIKit 通过RunLoopObserver 在RunLoop二次Sleep间Autoreleasepool进行Pop和Push,将这次Loop产生的autorelease对象释放 对编译器会编译大致如下:

1. void *DragonLiContext = objc_ AutoreleasepoolPush();
2. // {} 的 code 
3. objc_ AutoreleasepoolPop(DragonLiContext);
复制代码

释放时机: 当前RunLoop迭代结束时候释放.

三十二：ARC的工作原理


Automatic Reference Counting，自动引用计数，即ARC,ARC会自动帮你插入retain和release语句,ARC编译器有两部分，分别是前端编译器和优化器


前端编译器:前端编译器会为“拥有的”每一个对象插入相应的release语句。如果对象的所有权修饰符是__strong，那么它就是被拥有的。如果在某个方法内创建了一个对象，前端编译器会在方法末尾自动插入release语句以销毁它。而类拥有的对象（实例变量/属性）会在dealloc方法内被释放。事实上，你并不需要写dealloc方法或调用父类的dealloc方法，ARC会自动帮你完成一切。此外，由编译器生成的代码甚至会比你自己写的release语句的性能还要好，因为编辑器可以作出一些假设。在ARC中，没有类可以覆盖release方法，也没有调用它的必要。ARC会通过直接使用objc_release来优化调用过程。而对于retain也是同样的方法。ARC会调用objc_retain来取代保留消息


ARC优化器: 虽然前端编译器听起来很厉害的样子，但代码中有时仍会出现几个对retain和release的重复调用。ARC优化器负责移除多余的retain和release语句，确保生成的代码运行速度高于手动引用计数的代码


三十三：用户需要上传和下载一个重要的资料文件，应该如何判断用户本次是否上传成功和下载成功了?

用MD5验证文件的完整性！(仅仅通过代码来判断当前次的请求发送结束或者收到数据结束不可以的)
当客户端上传一个文件的时候，在请求body里面添加该文件的MD5值来告诉服务器，服务器接受文件完毕以后通过校验收到的文件的MD5值与请求body里面的MD5值来最终确定本次上传是否成功
当客户端下载一个文件的时候，在响应头里面收到了服务器附带的该文件的MD5值，文件下载结束以后，通过获取下载后文件的MD5值与本次请求服务器返回的响应头中的MD5值做一个比较，来最终判断本次下载是否成功
MD5，是一个将任意长度的数据字符串转化成短的固定长度的值的单向操作。任意两个字符串不应有相同的散列值
MD5校验可以应用在多个领域，比如说机密资料的检验，下载文件的检验，明文密码的加密等。MD5校验原理举例：如客户往我们数据中心同步一个文件，该文件使用MD5校验，那么客户在发送文件的同时会再发一个存有校验码的文件，我们拿到该文件后做MD5运算，得到的计算结果与客户发送的校验码相比较，如果一致则认为客户发送的文件没有出错，否则认为文件出错需要重新发送。

三十四：isa指针的作用


对象的isa指向类，类的isa指向元类（meta class），元类isa指向元类的根类。isa帮助一个对象找到它的方法


是一个Class 类型的指针. 每个实例对象有个isa的指针,他指向对象的类，而Class里也有个isa的指针, 指向meteClass(元类)。元类保存了类方法的列表。当类方法被调用时，先会从本身查找类方法的实现，如果没有，元类会向他父类查找该方法。同时注意的是：元类（meteClass）也是类，它也是对象。元类也有isa指针,它的isa指针最终指向的是一个根元类(root meteClass).根元类的isa指针指向本身，这样形成了一个封闭的内循环。


三十五：与 NSURLConnection 相比，NSURLsession 改进哪些?


可以配置每个 session 的缓存，协议，cookie，以及证书策略（credential policy），甚至跨程序共享这些信息


session task。它负责处理数据的加载以及文件和数据在客户端与服务端之间的上传和下载。NSURLSessionTask 与 NSURLConnection 最大的相似之处在于它也负责数据的加载，最大的不同之处在于所有的 task 共享其创造者 NSURLSession 这一公共委托者（common delegate）


三十六：使用drawRect有什么影响？

drawRect方法依赖Core Graphics框架来进行自定义的绘制



缺点：它处理touch事件时每次按钮被点击后，都会用setNeddsDisplay进行强制重绘；而且不止一次，每次单点事件触发两次执行。这样的话从性能的角度来说，对CPU和内存来说都是欠佳的。特别是如果在我们的界面上有多个这样的UIButton实例，那就会很糟糕了


这个方法的调用机制也是非常特别. 当你调用 setNeedsDisplay 方法时, UIKit 将会把当前图层标记为dirty,但还是会显示原来的内容,直到下一次的视图渲染周期,才会将标记为 dirty 的图层重新建立Core Graphics上下文,然后将内存中的数据恢复出来, 再使用 CGContextRef 进行绘制


三十七：什么时候会报unrecognized selector的异常？如何避免?


当调用该对象上某个方法,而该对象上没有实现这个方法的时候， 可以通过“消息转发”进行解决，如果还是不行就会报unrecognized selector异常


objc是动态语言，每个方法在运行时会被动态转为消息发送，即：objc_msgSend(receiver, selector)，整个过程介绍如下：

objc在向一个对象发送消息时，runtime库会根据对象的isa指针找到该对象实际所属的类然后在该类中的方法列表以及其父类方法列表中寻找方法运行 如果，在最顶层的父类中依然找不到相应的方法时，程序在运行时会挂掉并抛出异常unrecognized selector sent to XXX 。但是在这之前，objc的运行时会给出三次拯救程序崩溃的机会



三次拯救程序崩溃的机会

Method resolution:objc运行时会调用+resolveInstanceMethod:或者 +resolveClassMethod:，让你有机会提供一个函数实现。 如果你添加了函数并返回 YES，那运行时系统就会重新启动一次消息发送的过程 如果 resolve 方法返回 NO ，运行时就会移到下一步，消息转发
Fast forwarding:如果目标对象实现了-forwardingTargetForSelector:，Runtime 这时就会调用这个方法，给你把这个消息转发给其他对象的机会 只要这个方法返回的不是nil和self，整个消息发送的过程就会被重启，当然发送的对象会变成你返回的那个对象。否则，就会继续Normal Fowarding。这里叫Fast，只是为了区别下一步的转发机制。因为这一步不会创建任何新的对象，但Normal forwarding转发会创建一个NSInvocation对象，相对Normal forwarding转发更快点，所以这里叫Fast forwarding
Normal forwarding 这一步是Runtime最后一次给你挽救的机会。 首先它会发送-methodSignatureForSelector:消息获得函数的参数和返回值类型。 如果-methodSignatureForSelector:返回nil，Runtime则会发出-doesNotRecognizeSelector:消息，程序这时也就挂掉了。 如果返回了一个函数签名，Runtime就会创建一个NSInvocation对象并发送-forwardInvocation:消息给目标对象



三十八：iOS中常用的数据存储方式有哪些？


综合

所有的本地持久化数据存储的本质都是写文件，而且只能存到沙盒中。
沙盒机制是苹果的一项安全机制，本质就是系统给每个应用分配了一个文件夹来存储数据，而且每个应用只能访问分配给自己的那个文件夹，其他应用的文件夹是不能访问的。
数据存储的核心都是写文件。主要有四种持久化方式：属性列表，对象序列化，SQLite 数据库, CoreData
属性列表：应用于少量数据存储，比如登陆的用户信息，应用程序配置信息等。只有NSString ，NSArray，NSDictory，NSData，可以WriteToFile；存储的依旧是plist文件，plist文件可以存储的7种数据类型：array，dictory，string，bool，data，date，number。



详细

对象序列化：最终也是存为属性列表文件，如果程序中，需要存储的时候，直接存储对象比较方便，例如有一个设置类，我们可以把设置类的对象直接存储，就没必要再把里面的每一个属性单独存到文件中。对象序列化是将一个实现了NSCoding协议的对象，通过序列化（NSKeydArchiver）的形式，将对象中的属性抽取出来，转化成二进制流，也就是NSData，NSData可以选择write to file 或者存储到NSUserdefault中。 必须实现的两个方法 encodeWithCoder，initWithCoder。对象序列化的本质就是 对象NSData。
SQLite： 适合大量，重复，有规律的数据存储。而且频繁的读取，删除，过滤数据，这种适合使用数据库 (iOS 使用第三方FMDB)
CoreData： Sqlite叫做关系型数据库，CoreData 是一中OR-Mapping的思想 ，O代表对象Object，R代表relationship，Mapping代表映射，直译过来就是对象关系映射，其实就是把对象的属性和表中的字段自动映射，简化程序员的负担，以面向对象的方式操作数据库。ORMapping是一种思想，CoreData实现了这种思想，在Java中，hibernate 也是对ORMapping的一种实现，只是利用java实现的。
CoreData 本质还是数据库，只不过使用起来更加面向对象，不关注二维的表结构，而是只需要关注对象，纯面向对象的数据操作方式。我们直接使用数据库的时候，如果向数据库中插入数据，一般是把一个对象的属性和数据库中某个表的字段一一对应，然后把对象的属性存储到具体的表字段中.取一条数据的时候，把表中的一行数据取出，同样需要再封装到对象的属性中，这样的方式有点繁琐，不面向对象。CoreData解决的问题就是不需要这个中间的转换过程，看起来是直接把对象存储进去，并且取出来，不关心表的存在，实际内部帮你做好了映射关系。



三十九：描述一个ViewController的生命周期

当我们调用UIViewControlller的view时，
系统首先判断当前的 UIViewControlller是否存在* view，如果存在直接返回view，
如果不存在的话，会调用loadview方法，
然后判断loadview方法是否是自定义方法，
如果是自定义方法，就执行自定义方法，
如果不是自定义方法，判断当时视图控制器是否有* xib、stroyboard。
如果有xib、stroyboard 就加载xib、stroyboard。
如果没有创建一个空白的view。
调用viewDidLoad方法。
最后返回view

四十：Block中可以修改全局变量，全局静态变量，局部静态变量吗？


可以.深入研究Block捕获外部变量和__block实现原理


全局变量和静态全局变量的值改变，以及它们被Block捕获进去，因为是全局的，作用域很广


静态变量和自动变量，被Block从外面捕获进来，成为__main_block_impl_0这个结构体的成员变量


自动变量是以值传递方式传递到Block的构造函数里面去的。Block只捕获Block中会用到的变量。由于只捕获了自动变量的值，并非内存地址，所以Block内部不能改变自动变量的值。


Block捕获的外部变量可以改变值的是静态变量，静态全局变量，全局变量


Block就分为以下3种


_NSConcreteStackBlock:只用到外部局部变量、成员属性变量，且没有强指针引用的block都是StackBlock。 StackBlock的生命周期由系统控制的，一旦返回之后，就被系统销毁了,是不持有对象的

_NSConcreteStackBlock所属的变量域一旦结束，那么该Block就会被销毁。在ARC环境下，编译器会自动的判断，把Block自动的从栈copy到堆。比如当Block作为函数返回值的时候，肯定会copy到堆上



_NSConcreteMallocBlock:有强指针引用或copy修饰的成员属性引用的block会被复制一份到堆中成为MallocBlock，没有强指针引用即销毁，生命周期由程序员控制,是持有对象的


_NSConcreteGlobalBlock:没有用到外界变量或只用到全局变量、静态变量的block为_NSConcreteGlobalBlock，生命周期从创建到应用程序结束,也不持有对象






ARC环境下，一旦Block赋值就会触发copy，__block就会copy到堆上，Block也是__NSMallocBlock。ARC环境下也是存在__NSStackBlock的时候，这种情况下，__block就在栈上


ARC下，Block中引用id类型的数据有没有__block都一样都是retain，而对于基础变量而言，没有的话无法修改变量值，有的话就是修改其结构体令其内部的forwarding指针指向拷贝后的地址达到值的修改







算法（Algorithm）是指用来操作数据、解决程序问题的一组方法。对于同一个问题，使用不同的算法，也许最终得到的结果是一样的，但在过程中消耗的资源和时间却会有很大的区别。

那么我们应该如何去衡量不同算法之间的优劣呢？

主要还是从算法所占用的「时间」和「空间」两个维度去考量。

时间维度：是指执行当前算法所消耗的时间，我们通常用「时间复杂度」来描述。
空间维度：是指执行当前算法需要占用多少内存空间，我们通常用「空间复杂度」来描述。
因此，评价一个算法的效率主要是看它的时间复杂度和空间复杂度情况。然而，有的时候时间和空间却又是「鱼和熊掌」，不可兼得的，那么我们就需要从中去取一个平衡点。

下面我来分别介绍一下「时间复杂度」和「空间复杂度」的计算方式。

一、时间复杂度
我们想要知道一个算法的「时间复杂度」，很多人首先想到的的方法就是把这个算法程序运行一遍，那么它所消耗的时间就自然而然知道了。

这种方式可以吗？当然可以，不过它也有很多弊端。
这种方式非常容易受运行环境的影响，在性能高的机器上跑出来的结果与在性能低的机器上跑的结果相差会很大。而且对测试时使用的数据规模也有很大关系。再者，并我们在写算法的时候，还没有办法完整的去运行呢。

因此，另一种更为通用的方法就出来了：「 大O符号表示法 」，即 T(n) = O(f(n))

我们先来看个例子：

for(i=1; i<=n; ++i)
{
   j = i;
   j++;
}
通过「 大O符号表示法 」，这段代码的时间复杂度为：O(n) ，为什么呢?

在 大O符号表示法中，时间复杂度的公式是： T(n) = O( f(n) )，其中f(n) 表示每行代码执行次数之和，而 O 表示正比例关系，这个公式的全称是：算法的渐进时间复杂度。

我们继续看上面的例子，假设每行代码的执行时间都是一样的，我们用 1颗粒时间 来表示，那么这个例子的第一行耗时是1个颗粒时间，第三行的执行时间是 n个颗粒时间，第四行的执行时间也是 n个颗粒时间（第二行和第五行是符号，暂时忽略），那么总时间就是 1颗粒时间 + n颗粒时间 + n颗粒时间 ，即 (1+2n)个颗粒时间，即： T(n) = (1+2n)*颗粒时间，从这个结果可以看出，这个算法的耗时是随着n的变化而变化，因此，我们可以简化的将这个算法的时间复杂度表示为：T(n) = O(n)

为什么可以这么去简化呢，因为大O符号表示法并不是用于来真实代表算法的执行时间的，它是用来表示代码执行时间的增长变化趋势的。

所以上面的例子中，如果n无限大的时候，T(n) = time(1+2n)中的常量1就没有意义了，倍数2也意义不大。因此直接简化为T(n) = O(n) 就可以了。

常见的时间复杂度量级有：

常数阶O(1)
对数阶O(logN)
线性阶O(n)
线性对数阶O(nlogN)
平方阶O(n²)
立方阶O(n³)
K次方阶O(n^k)
指数阶(2^n)
上面从上至下依次的时间复杂度越来越大，执行的效率越来越低。

下面选取一些较为常用的来讲解一下（没有严格按照顺序）：

常数阶O(1)
无论代码执行了多少行，只要是没有循环等复杂结构，那这个代码的时间复杂度就都是O(1)，如：

int i = 1;
int j = 2;
++i;
j++;
int m = i + j;
上述代码在执行的时候，它消耗的时候并不随着某个变量的增长而增长，那么无论这类代码有多长，即使有几万几十万行，都可以用O(1)来表示它的时间复杂度。

线性阶O(n)
这个在最开始的代码示例中就讲解过了，如：

for(i=1; i<=n; ++i)
{
   j = i;
   j++;
}
这段代码，for循环里面的代码会执行n遍，因此它消耗的时间是随着n的变化而变化的，因此这类代码都可以用O(n)来表示它的时间复杂度。

对数阶O(logN)
还是先来看代码：

int i = 1;
while(i<n)
{
    i = i * 2;
}
从上面代码可以看到，在while循环里面，每次都将 i 乘以 2，乘完之后，i 距离 n 就越来越近了。我们试着求解一下，假设循环x次之后，i 就大于 2 了，此时这个循环就退出了，也就是说 2 的 x 次方等于 n，那么 x = log2^n
也就是说当循环 log2^n 次以后，这个代码就结束了。因此这个代码的时间复杂度为：O(logn)

线性对数阶O(nlogN)
线性对数阶O(nlogN) 其实非常容易理解，将时间复杂度为O(logn)的代码循环N遍的话，那么它的时间复杂度就是 n * O(logN)，也就是了O(nlogN)。

就拿上面的代码加一点修改来举例：

for(m=1; m<n; m++)
{
    i = 1;
    while(i<n)
    {
        i = i * 2;
    }
}
平方阶O(n²)
平方阶O(n²) 就更容易理解了，如果把 O(n) 的代码再嵌套循环一遍，它的时间复杂度就是 O(n²) 了。
举例：

for(x=1; i<=n; x++)
{
   for(i=1; i<=n; i++)
    {
       j = i;
       j++;
    }
}
这段代码其实就是嵌套了2层n循环，它的时间复杂度就是 O(n*n)，即 O(n²)
如果将其中一层循环的n改成m，即：

for(x=1; i<=m; x++)
{
   for(i=1; i<=n; i++)
    {
       j = i;
       j++;
    }
}
那它的时间复杂度就变成了 O(m*n)

立方阶O(n³)、K次方阶O(n^k)
参考上面的O(n²) 去理解就好了，O(n³)相当于三层n循环，其它的类似。

除此之外，其实还有 平均时间复杂度、均摊时间复杂度、最坏时间复杂度、最好时间复杂度 的分析方法，有点复杂，这里就不展开了。

二、空间复杂度
既然时间复杂度不是用来计算程序具体耗时的，那么我也应该明白，空间复杂度也不是用来计算程序实际占用的空间的。

空间复杂度是对一个算法在运行过程中临时占用存储空间大小的一个量度，同样反映的是一个趋势，我们用 S(n) 来定义。

空间复杂度比较常用的有：O(1)、O(n)、O(n²)，我们下面来看看：

空间复杂度 O(1)
如果算法执行所需要的临时空间不随着某个变量n的大小而变化，即此算法空间复杂度为一个常量，可表示为 O(1)
举例：

int i = 1;
int j = 2;
++i;
j++;
int m = i + j;
代码中的 i、j、m 所分配的空间都不随着处理数据量变化，因此它的空间复杂度 S(n) = O(1)

空间复杂度 O(n)
我们先看一个代码：

int[] m = new int[n]
for(i=1; i<=n; ++i)
{
   j = i;
   j++;
}
这段代码中，第一行new了一个数组出来，这个数据占用的大小为n，这段代码的2-6行，虽然有循环，但没有再分配新的空间，因此，这段代码的空间复杂度主要看第一行即可，即 S(n) = O(n)

Widget与Element

Widget实际上就是Element的配置数据, Widget的功能是描述一个UI元素的一个配置数据, 而真正的UI渲染是由Element构成
由于Element是通过Widget生成，所以它们之间有对应关系，所以在大多数场景，我们可以宽泛地认为Widget就是指UI控件或UI渲染
一个Widget对象可以对应多个Element对象。这很好理解，根据同一份配置（Widget），可以创建多个实例（Element）

## Flutter的UIKit
Text == UILabel/TextView
```
// 两种构造函数
// 显示普通的文本
 const Text(this.data, {
    Key key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  }) : assert(data != null),
       textSpan = null,
       super(key: key);

  /// 段落式文本,可以给文本中的每个textSpan设置其样式
  const Text.rich(this.textSpan, {
    Key key,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  }): assert(textSpan != null),
      data = null,
      super(key: key);


```

Image == UIImageView
```
  const Image({
    Key key,
    // 一个图片对象ImageProvider, 可设置NetworkImage(), FileImage(), MemoryImage()三种对象
    @required this.image,
    // 图片的描述, String
    this.semanticLabel,
    this.excludeFromSemantics = false,
    // 图片的宽度, double
    this.width,
    // 图片的高度, double
    this.height,
    // 图像的颜色, 用于和图片混合的颜色, 结合colorBlendMode使用
    this.color,
    // 颜色和图片混合的状态, BlendMode
    this.colorBlendMode,
    // 图像在布局中分配的空间, BoxFit
    this.fit,
    // 图像边界内对齐图像, Alignment
    this.alignment = Alignment.center,
    // 未充分填充容器时,是否重复显示图片
    this.repeat = ImageRepeat.noRepeat,
    // 九片图像的中心切点, Rect
    this.centerSlice,
    // 是否在图像的方向上绘制图像 TextDirection
    this.matchTextDirection = false,
    // 当图像提供者发生变化时，是继续显示旧图像（true）还是暂时不显示（false）
    this.gaplessPlayback = false,
    // 设置图片的过滤质量
    this.filterQuality = FilterQuality.low,
  }) 

```
图像在布局中分配的空间, BoxFit枚举值

fill: 填充满容器空间, 图片会被拉伸
contain: 以容器的大小等比例缩放图片
cover: 填充整个容器, 图片会被剪切
fitWidth: 以容器的宽度, 等比例缩放图片
fitHeight: 以容器的高度, 等比例的缩放图片
none: 以图片的实际大小显示
scaleDown: 居中显示, 图片不会拉伸, 以宽高中最小的尺寸为标准

```
Image.network(
  'https://titanjun.oss-cn-hangzhou.aliyuncs.com/flutter/catimage.jpg',
  width: 100,
  height: 100,
  fit: BoxFit.scaleDown,
  alignment: Alignment.center,
)
```

缓存

ImageCache是ImageProvider默认使用的图片缓存。ImageCache使用的是LRU的算法
默认可以存储1000张图片。如果觉得缓存太大，可以通过设置ImageCache的maximumSize属性来控制缓存图片的数量。
也可以通过设置maximumSizeBytes来控制缓存的大小（默认缓存大小10MB）

Image.asset

Flutter应用程序可以包含代码和 assets（有时称为资源）
asset是打包到程序安装包中的，可在运行时访问
常见类型的asset包括静态数据（例如JSON文件），配置文件，图标和图片（JPEG，WebP，GIF，动画WebP / GIF，PNG，BMP和WBMP）
Flutter使用pubspec.yaml文件（位于项目根目录），来识别应用程序所需的asset

图片所在的文件夹images和pubspec.yaml需要在同一目录下, 否则pubspec.yaml文件中, 设置资源路径的时候要对应修改
images图片文件夹中2.0x和3.0x图片要分别创建两个文件夹, 并把2倍和3倍图分别放在不同的文件夹中, 切文件的名字不要在带@2x和@3x字样


按钮 == UIButton

Flutter提供了RaisedButton、FlatButton、OutlineButton和IconButton四种按钮, 除了IconButton之外都是继承自MaterialButton
所有Material库中的按钮都有如下相同点：

按下时都会有“水波动画”。
有一个onPressed属性来设置点击回调，当按钮按下时会执行该回调，如果不提供该回调则按钮会处于禁用状态，禁用状态不响应用户点击


MaterialButton
MaterialButton是除IconButton按钮之外的其他按钮的父类, 下面介绍一下各属性的使用


## Dart语言

在Dart中，一切都是对象，一切对象都是class的实例，哪怕是数字类型、方法甚至null都是对象，所有的对象都是继承自Object
虽然Dart是强类型语言，但变量类型是可选的因为Dart可以自动推断变量类型
Dart支持范型，List<int>表示一个整型的数据列表，List<dynamic>则是一个对象的列表，其中可以装任意对象
Dart支持顶层方法（如main方法），也支持类方法或对象方法，同时你也可以在方法内部创建方法
Dart支持顶层变量，也支持类变量或对象变量
跟Java不同的是，Dart没有public protected private等关键字，如果某个变量以下划线（_）开头，代表这个变量在库中是私有的，具体可以看这里
Dart中变量可以以字母或下划线开头，后面跟着任意组合的字符或数字
变量
变量定义
以下代码是Dart中定义变量的方法：

```
main() {
  var a = 1;
  int b = 10;
  String s = "hello";
  dynamic c = 0.5;
}
```

你可以明确指定某个变量的类型，如int bool String，也可以用var或 dynamic来声明一个变量，Dart会自动推断其数据类型。

变量的默认值
注意：没有赋初值的变量都会有默认值null

final和const
如果你绝不想改变一个变量，使用final或const，不要使用var或其他类型，一个被final修饰的变量只能被赋值一次，一个被const修饰的变量是一个编译时常量（const常量毫无疑问也是final常量）。可以这么理解：final修饰的变量是不可改变的，而const修饰的表示一个常量。

注意：实例变量可以是final的但不能是const的

下面用代码说明：

var count = 10; 
final Num = count;  // final 只能赋值一次
const Num1 = 10; // const赋值必须是编译时常量
final和const的区别：
区别一：final 要求变量只能初始化一次，并不要求赋的值一定是编译时常量，可以是常量也可以不是。而 const 要求在声明时初始化，并且赋值必需为编译时常量。

区别二：final 是惰性初始化，即在运行时第一次使用前才初始化。而 const 是在编译时就确定值了。

内建数据类型
Dart有如下几种内建的数据类型：

numbers
strings
booleans
lists(或者是arrays)
maps
runes（UTF-32字符集的字符）
symbols
下面用一段代码来演示以上各类数据类型：
```
main() {
  // numbers
  var a = 0;
  int b = 1;
  double c = 0.1;

  // strings
  var s1 = 'hello';
  String s2 = "world";

  // booleans
  var real = true;
  bool isReal = false;

  // lists
  var arr = [1, 2, 3, 4, 5];
  List<String> arr2 = ['hello', 'world', "123", "456"];
  List<dynamic> arr3 = [1, true, 'haha', 1.0];

  // maps
  var map = new Map();
  map['name'] = 'zhangsan';
  map['age'] = 10;
  Map m = new Map();
  m['a'] = 'a';

  //runes，Dart 中 使用runes 来获取UTF-32字符集的字符。String的 codeUnitAt and codeUnit属性可以获取UTF-16字符集的字符
  var clapping = '\u{1f44f}';
  print(clapping); // 打印的是拍手emoji的表情

  // symbols
  print(#s == new Symbol("s")); // true
}
```

函数
函数的返回值
Dart是一个面向对象的编程语言，所以即使是函数也是一个对象，也有一种类型Function，这就意味着函数可以赋值给某个变量或者作为参数传给另外的函数。虽然Dart推荐你给函数加上返回值，但是不加返回值的函数同样可以正常工作，另外你还可以用=>代替return语句，比如下面的代码：

```
// 声明返回值
int add(int a, int b) {
  return a + b;
}

// 不声明返回值
add2(int a, int b) {
  return a + b;
}

// =>是return语句的简写
add3(a, b) => a + b; 

main() {
  print(add(1, 2)); // 3
  print(add2(2, 3)); // 5
  print(add3(1, 2)); // 3
}
命名参数、位置参数、参数默认值
命名参数
sayHello({String name}) {
  print("hello, my name is $name");
}

sayHello2({name: String}) {
  print("hello, my name is $name");
}

main() {
  // 打印 hello, my name is zhangsan
  sayHello(name: 'zhangsan');

  // 打印 hello, my name is wangwu
  sayHello2(name: 'wangwu');
}
```

可以看到，定义命名参数时，你可以以 {type paramName} 或者 {paramName: type} 两种方式声明参数，而调用命名参数时，需要以 funcName(paramName: paramValue) 的形式调用。

命名参数的参数并不是必须的，所以上面的代码中，如果调用sayHello()不带任何参数，也是可以的，只不过最后打印出来的结果是：hello, my name is null，在Flutter开发中，你可以使用@required注解来标识一个命名参数，这代表该参数是必须的，你不传则会报错，比如下面的代码：

const Scrollbar({Key key, @required Widget child})
位置参数
使用中括号[]括起来的参数是函数的位置参数，代表该参数可传可不传，位置参数只能放在函数的参数列表的最后面，如下代码所示：

```
sayHello(String name, int age, [String hobby]) { // 位置参数可以有多个，比如[String a, int b]
  StringBuffer sb = new StringBuffer();
  sb.write("hello, this is $name and I am $age years old");
  if (hobby != null) {
    sb.write(", my hobby is $hobby");
  }
  print(sb.toString());
}

main() {
  // hello, this is zhangsan and I am 20 years old
  sayHello("zhangsan", 20);
  // hello, this is zhangsan and I am 20 years old, my hobby is play football
  sayHello("zhangsan", 20, "play football");
}
参数默认值
你可以为命名参数或者位置参数设置默认值，如下代码所示：

// 命名参数的默认值
int add({int a, int b = 3}) { // 不能写成：int add({a: int, b: int = 3})
  return a + b;
}

// 位置参数的默认值
int sum(int a, int b, [int c = 3]) {
  return a + b + c;
}
main()函数
不论在Dart还是Flutter中，必须都需要一个顶层的main()函数，它是整个应用的入口函数，main()函数的返回值是void，还有一个可选的参数，参数类型是List<String>。

函数作为一类对象
你可以将一个函数作为参数传给另一个函数，比如下面的代码：

printNum(int a) {
  print("$a");
}

main() {
  //  依次打印：
  //  1
  //  2
  //  3
  var arr = [1, 2, 3];
  arr.forEach(printNum);
}
你也可以将一个函数赋值给某个变量，比如下面的代码：

printNum(int a) {
  print("$a");
}

main() {
  var f1 = printNum;
  Function f2 = printNum;
  var f3 = (int a) => print("a = $a");
  f1(1);
  f2(2);
  f3(6);
}
匿名函数
大多数函数都是有名称的，比如main() printName()等，但是你也可以写匿名函数，如果你对Java比较熟悉，那下面的Dart代码你肯定也不会陌生：

test(Function callback) {
  callback("hello");
}

main() {
  test((param) {
    // 打印hello
    print(param);
  });
}
```
匿名函数类似于Java中的接口，往往在某个函数的参数为函数时使用到。

函数返回值
所有的函数都有返回值，如果没有指定return语句，那么该函数的返回值为null。

运算符
Dart中的运算符与Java中的类似，比如++a a == b b ? a : b，但是也有一些与Java不太一样的运算符，下面用代码说明：
```
main() {
  // 与Java相同的运算符操作

  int a = 1;
  ++a;
  a++;
  var b = 1;
  print(a == b);  // false
  print(a * b); // 3
  bool real = false;
  real ? print('real') : print('not real'); // not real
  print(real && a == b); // false
  print(real || a == 3); // true
  print(a != 2); // true
  print(a <= b); // false
  var c = 9;
  c += 10;
  print("c = $c"); // c = 19
  print(1<<2); // 4

  // 与Java不太一样的运算符操作

  // is运算符用于判断一个变量是不是某个类型的数据
  // is!则是判断变量不是某个类型的数据
  var s = "hello";
  print(s is String); // true
  var num = 6;
  print(num is! String); // true

  // ~/才是取整运算符，如果使用/则是除法运算，不取整
  int k = 1;
  int j = 2;
  print(k / j); // 0.5
  print(k ~/ j); // 0

  // as运算符类似于Java中的cast操作，将一个对象强制类型转换
  (emp as Person).teach();

  // ??=运算符 如果 ??= 运算符前面的变量为null，则赋值，否则不赋值
  var param1 = "hello", param2 = null;
  param1 ??= "world";
  param2 ??= "world";
  print("param1 = $param1"); // param1 = hello
  print("param2 = $param2"); // param2 = world
  
  // ?.运算符
  var str1 = "hello world";
  var str2 = null;
  print(str1?.length); // 11
  print(str2?.length); // null 
  print(str2.length); // 报错
}
```
..运算符（级联操作）
如果你对Java中的建造者模式比较熟悉的话，Dart中的..运算符也很好理解，先看下面的代码：

class Person {
  eat() {
    print("I am eating...");
  }

  sleep() {
    print("I am sleeping...");
  }

  study() {
    print("I am studying...");
  }
}

main() {
  // 依次打印
  //  I am eating...
  //  I am sleeping...
  //  I am studying...
  new Person()..eat()
      ..sleep()
      ..study();
}
可以看到，使用..调用某个对象的方法（或者成员变量）时，返回值是这个对象本身，所以你可以接着使用..调用这个对象的其他方法，这不就类似于Java中的建造者模式，每次build某个属性时，都返回一个this对象吗。

控制流程
if / else switch for /while try / catch语句跟Java中都类似，try / catch语句可能稍有不同，下面用一段代码说明：

main() {
  // if else语句
  int score = 80;
  if (score < 60) {
    print("so bad!");
  } else if (score >= 60 && score < 80) {
    print("just so so!");
  } else if (score >= 80) {
    print("good job!");
  }

  // switch语句
  String a = "hello";
  // case语句中的数据类型必须是跟switch中的类型一致
  switch (a) {
    case "hello":
      print("haha");
      break;
    case "world":
      print("heihei");
      break;
    default:
      print("WTF");
  }

  // for语句
  List<String> list = ["a", "b", "c"];
  for (int i = 0; i < list.length; i++) {
    print(list[i]);
  }
  for (var i in list) {
    print(i);
  }
  // 这里的箭头函数参数必须用圆括号扩起来
  list.forEach((item) => print(item));

  // while语句
  int start = 1;
  int sum = 0;
  while (start <= 100) {
    sum += start;
    start++;
  }
  print(sum);

  // try catch语句
  try {
    print(1 ~/ 0);
  } catch (e) {
    // IntegerDivisionByZeroException
    print(e);
  }
  try {
    1 ~/ 0;
  } on IntegerDivisionByZeroException { // 捕获指定类型的异常
    print("error"); // 打印出error
  } finally {
    print("over"); // 打印出over
  }
}

类（Class）
类的定义与构造方法
Dart中的类没有访问控制，所以你不需要用private, protected, public等修饰成员变量或成员函数，一个简单的类如下代码所示：

class Person {
  String name;
  int age;
  String gender;
  Person(this.name, this.age, this.gender);
  sayHello() {
    print("hello, this is $name, I am $age years old, I am a $gender");
  }
}
上面的Person类中有3个成员变量，一个构造方法和一个成员方法，看起来比较奇怪的是Person的构造方法，里面传入的3个参数都是this.xxx，而且没有大括号{}包裹的方法体，这种语法是Dart比较独特而简洁的构造方法声明方式，它等同于下面的代码：

Person(String name, int age, String gender) {
    this.name = name;
    this.age = age;
    this.gender = gender;
}
要调用Person类的成员变量或成员方法，可以用下面的代码：

  var p = new Person("zhangsan", 20, "male");
  p.sayHello(); // hello, this is zhangsan, I am 20 years old, I am a male
  p.age = 50;
  p.gender = "female";
  p.sayHello(); // hello, this is zhangsan, I am 50 years old, I am a female
类除了有跟类名相同的构造方法外，还可以添加命名的构造方法，如下代码所示：

class Point {
  num x, y;
  Point(this.x, this.y);
  // 类的命名构造方法
  Point.origin() {
    x = 0;
    y = 0;
  }
}

main() {
  // 调用Point类的命名构造方法origin()
  var p = new Point.origin();
  var p2 = new Point(1, 2);
}
Dart中使用extends关键字做类的继承，如果一个类只有命名的构造方法，在继承时需要注意，如下代码：

class Human {
  String name;
  Human.fromJson(Map data) {
    print("Human's fromJson constructor");
  }
}

class Man extends Human {
  Man.fromJson(Map data) : super.fromJson(data) {
    print("Man's fromJson constructor");
  }
}
由于Human类没有默认构造方法，只有一个命名构造方法fromJson，所以在Man类继承Human类时，需要调用父类的fromJson方法做初始化，而且必须使用Man.fromJson(Map data) : super.fromJson(data)这种写法，而不是像Java那样将super写到花括号中。

有时候你仅仅只是在某个类的构造方法中，调用这个类的另一个构造方法，你可以这么写：

class Point {
  num x, y;
  Point(this.x, this.y);
  // 命名构造方法调用了默认的构造方法
  Point.alongXAxis(num x) : this(x, 0);
}
类的成员方法
一个类的成员方法是一个函数，为这个类提供某些行为。上面的代码中已经有了一些类的成员方法的定义，这些定义方式跟Java很类似，你可以为某个类的成员变量提供getter/setter方法，如下代码：

class Rectangle {
  num left, top, width, height;

  // 构造方法传入left, top, width, height几个参数
  Rectangle(this.left, this.top, this.width, this.height);

  // right, bottom两个成员变量提供getter/setter方法
  num get right => left + width;
  set right(num value) => left = value - width;
  num get bottom => top + height;
  set bottom(num value) => top = value - height;
}
抽象类和抽象方法
使用abstract修饰一个类，则这个类是抽象类，抽象类中可以有抽象方法和非抽象方法，抽象方法没有方法体，需要子类去实现，如下代码：

abstract class Doer {
  // 抽象方法，没有方法体，需要子类去实现
  void doSomething();
  // 普通的方法
  void greet() {
    print("hello world!");
  }
}

class EffectiveDoer extends Doer {
  // 实现了父类的抽象方法
  void doSomething() {
    print("I'm doing something...");
  }
}
运算符重载
Dart中有类似于C++中的运算符重载语法，比如下面的代码定义了一个向量类，重载了向量的+ -运算：

class Vector {
  num x, y;
  Vector(this.x, this.y);
  Vector operator +(Vector v) => new Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => new Vector(x - v.x, y - v.y);
  printVec() {
    print("x: $x, y: $y");
  }
}

main() {
  Vector v1 = new Vector(1, 2);
  Vector v2 = new Vector(3, 4);
  (v1 - v2).printVec(); // -2, -2
  (v1 + v2).printVec(); // 4, 6
}
枚举类
使用enum关键字定义一个枚举类，这个语法跟Java类似，如下代码：

enum Color { red, green, blue }
mixins
mixins是一个重复使用类中代码的方式，比如下面的代码：

class A {
  a() {
    print("A's a()");
  }
}

class B {
  b() {
    print("B's b()");
  }
}

// 使用with关键字，表示类C是由类A和类B混合而构成
class C = A with B;

main() {
  C c = new C();
  c.a(); // A's a()
  c.b(); // B's b()
}
静态成员变量和静态成员方法
// 类的静态成员变量和静态成员方法
class Cons {
  static const name = "zhangsan";
  static sayHello() {
    print("hello, this is ${Cons.name}");
  }
}

main() {
  Cons.sayHello(); // hello, this is zhangsan
  print(Cons.name); // zhangsan
}
泛型（Generics）
Java和C++语言都有泛型，Dart语言也不例外，使用泛型有很多好处，比如：

正确指定泛型类型会产生更好的生成代码。
泛型可以减小代码的复杂度

Dart内置的数据类型List就是一个泛型数据类型，你可以往List中塞任何你想的数据类型比如整型、字符串、布尔值等
关于Dart更多的泛型知识点，可以查看这里。

Dart库（Libraries）
Dart目前已经有很多的库提供给开发者，许多功能不需要开发者自己去实现，只需要导入对应的包即可，使用import语句来导入某个包，比如下面的代码：

import 'dart:html';
如果你想导入自己写的某个代码文件，使用相对路径即可，例如当前有一个demo.dart文件，跟该文件同级目录下有个util.dart文件，文件代码如下：

// util.dart文件内容

int add(int a, int b) {
  return a + b;
}

在demo.dart文件中如果要引用util.dart文件，使用下面的方式导入：

// demo.dart

import './util.dart';

main() {
  print(add(1, 2));
}

你可以使用as关键字为导入的某个包设置一个前缀，或者说别名，比如下面的代码：

import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

// Uses Element from lib1.
Element element1 = Element();

// Uses Element from lib2.
lib2.Element element2 = lib2.Element();
你也可以在导入包时使用show hide关键字来导入某个包中的部分功能，比如下面的代码：

// 只导入foo
import 'package:lib1/lib1.dart' show foo;

// 导入除了foo的所有其他部分
import 'package:lib2/lib2.dart' hide foo;
导入包时使用deferred as可以让这个包懒加载，懒加载的包只会在该包被使用时得到加载，而不是一开始就加载，比如下面的代码：

import 'package:greetings/hello.dart' deferred as hello;

异步
Dart提供了类似ES7中的async await等异步操作，这种异步操作在Flutter开发中会经常遇到，比如网络或其他IO操作，文件选择等都需要用到异步的知识。
async和await往往是成对出现的，如果一个方法中有耗时的操作，你需要将这个方法设置成async，并给其中的耗时操作加上await关键字，如果这个方法有返回值，你需要将返回值塞到Future中并返回，如下代码所示：

Future checkVersion() async {
  var version = await lookUpVersion();
  // Do something with version
}
下面的代码使用Dart从网络获取数据并打印出来：

import 'dart:async';
import 'package:http/http.dart' as http;

Future<String> getNetData() async{
  http.Response res = await http.get("http://www.baidu.com");
  return res.body;
}

main() {
  getNetData().then((str) {
    print(str);
  });
}

## Flutter widget组件简介
一、简介
Flutter Widget采用现代响应式框架构建，核心思想是用widget组件来构建UI，当widget的状态发生变化时，widget也会对应重新构建UI，Flutrer会对比前后变化的不同，以确定底层渲染树从一个状态转换到下一个状态所需的最小更改。

二、入口程序
通过flutter create创建的项目，我们可以看到在lib目录下有一个默认的mian.dart文件，下面来看下这个文件里的内容。

Flutter跟Java程序一样，程序要跑起来就必须要一个入口，Java中用的是main方法当作入口，Flutter也是一样

void main() => runApp(MyApp());

这个main就是flutter的入口，使用runApp函数可以将给定的根组件填满整个屏幕。

三、基础的widget
3.1 无状态和有状态的组件
接着看flutter create创建出来的这个项目代码：

class MyApp extends StatelessWidget {}
class MyHomePage extends StatefulWidget {}

StatelessWidget表示无状态的组件，这个意味着它里面的值都是不可变的

StatefulWidget表示有状态的组件，这个意味着StatefulWidget持有的状态在widget的生命周期中发生改变，创建一个StatefulWidget需要两个类：

class MyHomePage extends StatefulWidget {
  @override 
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override 
  Widget build(BuildContext context){
    return Container();
  }
}

StatefulWidget类本身是不变的，但State类在Widget中的生命周期是始终存在的

3.2 常用的基础Widget
Text：带格式的文本。相当于Android中的TextView
Row、Column：水平和垂直方向的布局组件。符合Vue中的Flexbox布局模型，相当于Android中的LinearLayout的orientation=horizontal和vertical
Stack：允许子widget堆叠，可以用Positioned来定位上下左右的位置。相当于Android中的RelativeLayout
Container：创建一个矩形视觉元素，可以通过BoxDecoration设置background、边框、阴影。相当于C#中的panel
四、Material组件
几乎所有的dart文件中都会引入flutter/material.dart这个包，这个是一个实现了Material Design风格的组件库，如flutter create创建出来的这个项目代码中的MaterialApp、Scaffold、Navigator等组件

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

五、State的生命周期
Flutter程序可以看成是一个巨大的状态机器，用户的操作、网络请求、系统事件都是推动这个状态机运行的触发点，触发点通过setState来推动状态机的改变。

构造函数-->initState-->didChangeDepencies-->build-->deactivate-->dispose

构造函数：调用一次
initState：调用一次，在这里可以做一些初始化的工作，比如变量初始化、调用网络接口。相当于Android中的onCreate
didChangeDependencies：多次调用，在initState之后立刻调用，在InheritedWidget rebuild时也会触发调用
build：调用多次，第一次绘制界面时调用，当setState时也会被触发调用
didUpdateWidget：组件状态改变时调用，可能会调用多次，在widget重新构建时，Flutter framework会调用Widget.canUpdate来检测Widget树中同一位置的新旧节点，然后决定是否需要更新，如果Widget.canUpdate返回true则会调用此回调。正如之前所述，Widget.canUpdate会在新旧widget的key和runtimeType同时相等时会返回true，也就是说在在新旧widget的key和runtimeType同时相等时didUpdateWidget()就会被调用。如rebuild、hot reload
deactivate：调用多次，当移除渲染树时调用，比如跳转新界面、栈顶界面被销毁时都会调用。相当于Android中的onDetatch和onResume
dispose：调用一次，组件即将销毁时调用。相当于Android中的onDestroy

