# 安装

## 1、下载程序

> GUI.for.Clash 最新版：[下载地址](https://github.com/GUI-for-Cores/GUI.for.Clash/releases/latest)

> GUI.for.SingBox 最新版：[下载地址](https://github.com/GUI-for-Cores/GUI.for.SingBox/releases/latest)

在项目的 Releases 里找到最新的版本，Assets 里提供了以下平台：

- Windows-amd64
- Windows-arm64
- Windows-386
- macOS-amd64
- macOS-arm64
- Ubuntu-amd64

确认自己设备的平台，然后下载对应的压缩包文件。

## 2、Windows

解压下载的文件，然后移动到任何你想放置的目录；

以 GUI.for.Clash 为例：`D:\MyPrograms\GUI.for.Cores\GUI.for.Clash`；

此时的程序路径：`D:\MyPrograms\GUI.for.Cores\GUI.for.Clash\GUI.for.Clash.exe`。

注意事项：

- 避免路径中出现`空格`
- 避免路径中出现`中文`

## 3、macOS

双击解压文件，将`解压后`的文件`拖到桌面`，按下列步骤进行：

1、双击运行，提示【无法打开...因为无法验证开发者】，点击取消；

2、系统设置 - 隐私与安全性 - 安全性，【已阻止使用...因为来自身份不明的开发者】，点击【仍要打开】，输入密码并二次确认。

注意事项：

- 解压后的程序必须`移动`一次（例如上面，从下载文件夹移动到了桌面），否则运行后没有【写入权限】

## 4、Linux

> 只测试了 Ubuntu 22.04.4，如果你是其他发行版，也可以下载该目标文件，尝试运行。

解压文件，移动至合适的目录，以 GUI.for.Clash 为例：`/opt/GUI.for.Clash`

手动创建桌面图标：新建`GUI.for.Clash.desktop`文件，填入下面内容，然后移动至`/usr/share/applications`目录。

```
[Desktop Entry]
Version=1.0
Name=GUI.for.Clash
Comment=GUI.for.Clash
Exec=/path/to/GUI.for.Clash/GUI.for.Clash
Icon=/path/to/GUI.for.Clash/appicon.png
Terminal=false
Type=Application
Categories=Application;GUI.for.Clash;
StartupNotify=true

```

## 5、目录详解

以 GUI.for.Clash 为例：

```
GUI.for.Clash
└─ data                      // 程序资源目录
|   ├─ .cache                // 缓存文件夹，临时文件应该放在此目录
|   ├─ mihomo                // 内核程序目录
|   ├─ plugins               // 插件目录，仅存放插件源码，一个插件对应一个plugin-xxx.js文件
|   ├─ rulesets              // 规则集目录，供内核程序引用
|   ├─ subscribes            // 订阅目录，供内核程序引用
|   ├─ third                 // 第三方程序目录，插件下载的第三方程序应该放在本目录运行
|   ├─ plugins.yaml          // 插件索引文件
|   ├─ profiles.yaml         // 配置索引文件
|   ├─ rulesets.yaml         // 规则集索引文件
|   ├─ scheduledtasks.yaml   // 计划任务索引文件
|   ├─ subscribes.yaml       // 订阅索引文件
|   └─ user.yaml             // 程序配置文件：APP设置、插件设置
└─ GUI.for.Clash.exe         // 主程序
```
