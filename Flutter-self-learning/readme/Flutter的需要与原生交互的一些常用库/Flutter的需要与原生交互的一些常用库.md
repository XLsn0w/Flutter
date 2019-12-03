# Flutter的需要与原生交互的一些常用库

**【说明】由于这些库一直在更新，请自己选择合适的稳定版本下载。**
**另外如果发现有问题或者你有更好的库，欢迎留言告诉我。**

----

## 谷歌官方的针对Dart语言的一些实用性的功能以及扩展的库 -- Quiver

Quiver是一组针对Dart的实用程序库，它使使用许多Dart库变得更容易、更方便，或者增加了额外的功能。

github地址  https://github.com/google/quiver-dart

使用方式：

```yaml
dependencies:
  quiver: '>=2.0.0 <3.0.0'
```

----

## 根据pubspec.yaml中设置的目录模板自动向其中添加文件记录的脚本 `asset_generator`

好多人都说Flutter中的资源引用很头疼，手写很麻烦，最近找到了一个脚本刚好卡呀解决这个问题。

 **这个脚本的作用：利用`asset_generator`脚本生成r.dart 资源文件,方便在代码中引用资源。**

github地址： https://github.com/flutter-dev/asset_generator

使用方式：

```
1.下载 asset_generator.dart 脚本文件。
2.找到自己Flutter的安装目录，将脚本放在Flutter的根目录下。
```

#### :point_right:  另外关于pubspec.yaml文件，它很严格，很多人会写错，多一个或者少一个空格都会报错。刚好我找到了一个在线监测工具https://www.bejson.com/validators/yaml/   把你的yaml文件复制进去 就可以自动帮你找出错误了。

----

常用开源包：


| 文档地址          | 文档内容描述                                                 |
| ----------------- | ------------------------------------------------------------ |
| [原生平台有关的第三方库](https://github.com/AweiLoveAndroid/Flutter-learning/blob/master/readme/Flutter%E7%9A%84%E9%9C%80%E8%A6%81%E4%B8%8E%E5%8E%9F%E7%94%9F%E4%BA%A4%E4%BA%92%E7%9A%84%E4%B8%80%E4%BA%9B%E5%B8%B8%E7%94%A8%E5%BA%93/third_libs.md) | 原生平台有关的第三方库。包括以下内容：<br/>-  **地图（地图显示、定位、经纬度等）**。<br/>- **二维码**。<br/>- **WebView(Flutter和JavaScript交互)**。<br/>- **图表库**。<br/>- **权限库（移动端App需要申请权限，必备）**。<br/>- **统计（统计App的有关数据：比如日活跃量、用户量、下载量、在线时长等）**。<br/>- **分享和登陆（QQ、微信、微博等平台的分享和登陆）**。<br/>- **推送（把服务端的消息推送到移动设备上必备的）**。<br/>- **IM(即时通讯（聊天）等使用场景)**。<br/>- **RTC(音视频会议通话等使用场景)**。<br/>- **视频播放（本地视频、网上视频或者rtmp源格式）**。<br/>- **支付（使用支付宝、微信支付等支付方式）**。<br/>- **SMS（短信验证码）**。<br/>- **网页页面跳转到App具体页面（APP的链接化）**。<br/>- **一个好玩的可库：PWA（基于Dart的PWA的一个库）**。 |
|[数据有关的第三方库](https://github.com/AweiLoveAndroid/Flutter-learning/blob/master/readme/Flutter%E7%9A%84%E9%9C%80%E8%A6%81%E4%B8%8E%E5%8E%9F%E7%94%9F%E4%BA%A4%E4%BA%92%E7%9A%84%E4%B8%80%E4%BA%9B%E5%B8%B8%E7%94%A8%E5%BA%93/data_libs.md)|数据有关的第三方库。包括以下内容：<br/>- **网络请求（加载网络数据，发送数据到服务端）**。<br/>- **类型编解码的库（字符编解码）**。<br/>- **序列化**。<br/>- **Json解析（json解析成Map或对象）**。<br/>- **几个常用Json库的比较**。<br/>- **编解码、加密解密（AES、RSA等）有关的库**。<br/>- **系统平台有关的库（设备信息、蓝牙、wifi、文件等）**。<br/>- **国际化和本地化（多国语言版本）**。<br/>- **图片加载和缓存**。<br/>- **数据存储、缓存有关的库**。<br/>- **路由（导航切换）**。<br/>- **消息传递通信有关**。<br/>- **视频 & 音频处理**。<br/>- **Rx系列（异步任务流的操作、(注：Rx是一种思想，各类常用语言都有这个技术，如：RxJava、RxKotlin、RxJs、RxSwift等)）**。|
|[UI界面展示有关的第三方库](https://github.com/AweiLoveAndroid/Flutter-learning/blob/master/readme/Flutter%E7%9A%84%E9%9C%80%E8%A6%81%E4%B8%8E%E5%8E%9F%E7%94%9F%E4%BA%A4%E4%BA%92%E7%9A%84%E4%B8%80%E4%BA%9B%E5%B8%B8%E7%94%A8%E5%BA%93/UI_libs.md)|动画有关的第三方库。包括以下内容：<br/>- **弹窗和提示窗有关的库**。<br/>- **图标有关的开源库**。<br/>- **富文本**。<br/>- **MarkDown**。<br/>- **动画有关的库**。<br/>- **针对Android和iOS平台适配的库**。<br/>- **日历库（主要用于显示和操作日历）**。<br/>- **日期，时间，日期时间，icon，自定义数据的选择器（很全面）**。<br/>- **图片选择的库**。<br/>- **联系人选择的库**。<br/>- **颜色选择的库**。<br/>- **轮播图有关的库(以及Tab PagerView有关的库)**。<br/>- **导航栏有关的库(库)**。<br/>- **列表有关的库**。|

----

#### 如果你对以上这些有觉得不好用的，或者你发现了有更多更好用的第三方库，欢迎提issues，期待你的积极参与。
