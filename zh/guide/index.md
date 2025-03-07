<script setup>
import CheckBox from '/components/CheckBox'

const GUI_List = [
    'GUI.for.Clash',
    'GUI.for.SingBox'
]
</script>

# GUI-for-Cores 项目使用指南

本项目目前包含 {{ GUI_List.length }} 个 GUI 程序，它们是：{{ GUI_List.join('、') }}。

GUI 程序与 core 没有直接关系，更不能等同，且与 VPN、代理软件性质不同，请朋友们知晓。

## 初衷

GUI.for.Cores 项目旨在快速生成 core 的配置文件，并将其参数以用户界面（UI）的形式展示和修改，同时为这些参数提供合适的默认值。基于此，本项目还围绕 core 的功能开发了一系列辅助功能，包括：

- 配置管理
- 订阅管理
- 规则组管理
- 插件系统
- 计划任务系统

这些功能大大提高了 core 的易用性，特别是插件系统，极大地丰富了 core 的可玩性和扩展性。

## 并非 VPN 或代理软件

本项目组下的程序并非`VPN`或`代理软件`，没有内置代理程序也没有提供代理的功能。

## 注意事项

- 请勿从 GitHub Releases 以外的渠道下载“我们”的应用，那将无法确保安全，这很重要！

- 禁止任何博客、文章以`方便、关怀读者`为由提供 GitHub Releases 以外的下载链接！

- 请朋友们不要使用来源不明的应用程序，即便是我们的开发者在交流群里提供的应用程序，GitHub Releases 是唯一的可信来源！

## 疑问与解答

1、如何提交 PR，为项目做出贡献？

> 目前，我们不建议提交开发新功能的 PR。修复 BUG 的 PR 除外。原因如下：现有的维护者对软件的架构、功能划分有着自己的想法，突如其来的新功能会打乱原有的开发节奏，但我们感谢你想为项目做出贡献的热情与支持。

2、除了提交修复 BUG 的 PR，我还能做哪些贡献？

> 1、基于 GUI.for.Clash 或 GUI.for.SingBox 项目，为其他的 core 开发 GUI 程序 。

> 2、完善我们的使用文档，为更多的使用者提供帮助。

> 3、测试并查找现有 GUI 程序的漏洞，提供界面、功能的优化想法。

3、我能使用你们的项目进行二次开发吗？

> 当然。你可以使用目前项目里的所有代码，并开发出其他 core 的 GUI 应用。

## 开发计划

- <CheckBox /> 迁移框架至 wails-v3-alpha 版本

- <CheckBox /> 开发一个流量可视化插件

- <CheckBox checked /> 支持更多的 GNU/Linux 桌面

- <CheckBox checked /> 支持 macOS、 GNU/Linux 下的 TUN 模式

- <CheckBox /> 优化 macOS、 GNU/Linux 下的安装升级体验

- <CheckBox checked /> 重构 GUI.for.SingBox 的部分功能

- <CheckBox /> 开发安卓端的 GUI 系列
