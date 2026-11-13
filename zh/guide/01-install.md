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
- Linux-amd64
- Linux-arm64

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

### 脚本安装（推荐）

在终端执行下面命令，按提示选择要安装的程序（GUI.for.Clash 或 GUI.for.SingBox）及各项设置：

```bash
curl -fsSL https://gui-for-cores.github.io/install.sh | bash
```

脚本会下载最新版并校验 sha256，安装到 `~/.local/opt/<程序名>`，并按需创建桌面图标、命令行软链接（`gui-for-clash` / `gui-for-singbox`）、检查运行依赖、配置免密 TUN。下载时可填写 GitHub 加速源。之后的升级由程序自行完成，再次执行脚本可修复安装或卸载。

### 手动安装

解压文件，移动至合适的目录，以 GUI.for.Clash 为例：`~/.local/opt/GUI.for.Clash`

手动创建桌面图标：在 `~/.local/share/applications` 目录新建 `GUI.for.Clash.desktop` 文件，填入下面内容：

```
[Desktop Entry]
Version=1.0
Name=GUI.for.Clash
Comment=适用于 Clash 的图形客户端
StartupWMClass=GUI.for.Clash
Exec=/path/to/GUI.for.Clash/GUI.for.Clash %u
Icon=/path/to/GUI.for.Clash/appicon.png
Terminal=false
Type=Application
Categories=Network;Utility;
StartupNotify=true
MimeType=x-scheme-handler/clash;
```

## 5、目录详解

### 数据目录位置

程序默认将数据保存在当前用户的数据目录，以 GUI.for.Clash 为例（GUI.for.SingBox 将目录名替换为 `GUI.for.SingBox`）：

- Windows：`%LOCALAPPDATA%\GUI.for.Clash`
- macOS：`~/Library/Application Support/GUI.for.Clash`
- Linux：`$XDG_DATA_HOME/GUI.for.Clash`，未设置 `XDG_DATA_HOME` 时为 `~/.local/share/GUI.for.Clash`

### 便携版

满足以下任一条件时，数据保存在程序旁的 `data` 目录，即便携版：

- 程序旁已存在 `data` 目录（从旧版本升级的用户会自动沿用，无需迁移）
- 使用 `--portable` 参数启动

也可以使用 `--data-dir=<路径>` 参数将数据保存到任意目录，相对路径相对于程序所在目录。

注意事项：

- macOS 下 `data` 目录应放在 `.app` 所在的目录，而不是 `.app` 内部
- 修改启动参数后，如已开启【开机时启动】，请关闭后重新开启一次

### 目录结构

以 GUI.for.Clash 便携版为例，非便携版的数据目录内容与 `data` 目录相同：

```
GUI.for.Clash
└─ data                      // 程序资源目录
|   ├─ .cache                // 缓存文件夹，临时文件应该放在此目录
|   ├─ mihomo                // 内核程序目录
|   ├─ locales               // 多语言文件目录
|   ├─ plugins               // 插件目录，仅存放插件源码，一个插件对应一个plugin-xxx.js文件
|   ├─ rolling-release       // 滚动发行资源存放目录，存放前端编译后的文件
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
