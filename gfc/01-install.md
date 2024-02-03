# 安装

## 1、下载程序

点击[下载地址](https://github.com/GUI-for-Cores/GUI.for.Clash/releases)，在 Releases 里找到最新的版本，Assets 里提供了 Windows 32 位、64 位以及 arm 架构 64 位处理器的版本，按照自己电脑的架构来下载。

## 2、移动程序

将下载的程序重命名为`GUI.for.Clash.exe`，然后移动到任何你想放置的目录；

例如：`D:\MyPrograms\GUI.for.Cores\GUI.for.Clash`；

此时的程序路径：`D:\MyPrograms\GUI.for.Cores\GUI.for.Clash\GUI.for.Clash.exe`。

注意事项：

- 避免路径中出现`空格`
- 避免路径中出现`中文`

## 3、运行程序

双击运行程序，待程序启动完成，你可以右键任务栏的程序图标，将程序固定到任务栏，方便下次打开。你也可以自行创建桌面快捷方式。

## 4、目录详解

```
GUI.for.Clash
└─ data                 // 程序资源目录
|   ├─ .cache           // 缓存文件夹，临时文件应该放在此目录
|   ├─ mihomo           // 内核程序目录
|   ├─ plugins          // 插件目录，仅存放插件源码，一个插件对应一个plugin-xxx.js文件
|   ├─ rulesets         // 规则集目录，供内核程序引用
|   ├─ subscribes       // 订阅目录，供内核程序引用
|   ├─ third            // 第三方程序目录，插件下载的第三方程序应该放在本目录运行
|   ├─ plugins.yaml     // 插件索引文件
|   ├─ profiles.yaml    // 配置索引文件
|   ├─ rulesets.yaml    // 规则集索引文件
|   ├─ subscribes.yaml  // 订阅索引文件
|   └─ user.yaml        // 程序配置文件
└─ GUI.for.Clash.exe    // 主程序
```

## 疑问与解答

1、为什么和传统的程序安装方式不同？

> GUI.for.Clash 是一款免安装的绿色软件、或者称之为便携版本。这意味着你可以将软件存储在移动设备或便携式存储设备上，方便随时随地使用。

2、为何教程上称之为`安装`？

> 大部分文档都是这样写的。
