# Flutter
Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。

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

