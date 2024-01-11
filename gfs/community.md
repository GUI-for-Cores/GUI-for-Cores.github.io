# GUI.for.SingBox 用户指南

欢迎使用GUI.for.SingBox，该文档将介绍本项目基本使用指南，以降低用户使用Sing-Box的门槛，不再需要维护大量的json配置，本项目通过便捷的GUI操作即可生成的Sing-Box的完整客户端配置并运行；同时，它几乎支持Sing-Box作为客户端的全部特性！

<img src="https://input-s3.mn.input.im/adm-group/1/20240111/659fc5b71a59a.png" title="" alt="主界面.png" data-align="center">



## 软件设置项

- `Settings`-`Language`选择语言，目前支持中英语；该wiki之后的介绍将基于**中文**语言进行说明

- `内核缓存`：生成在`data/sing-box`目录下，用于存储持久化Fake-IP数据以及远程规则集数据

- `关闭窗口时退出程序`：当点击右上角的关闭按钮时将退出主程序，将不会出现托盘图标

- `退出程序时同时关闭内核`：当关闭程序时结束sing-box.exe内核进程，Sing-Box终止

- `自动启动内核程序`：当启动软件时自动启动内核

- `以管理员身份运行`：非Windows的`Administrators`用户组的系统用户建议打开该选项，否则可能出现Tun模式无法启动核心或Tun.stack为`system`或`mixed`时无法修改系统网络防火墙设置

- `开机时启动`：程序跟随系统启动

- **内核**选项卡下可管理下载和更新Sing-Box核心程序

- **关于**选项卡可查看本项目版本信息以及在线更新



## 订阅设置(必须)

GUI.for.SingBox的**订阅**部分只需要包含出站(outbounds)部分，格式如下

```json
{
    {
        "type": "vless",
        "tag": "Proxy1",
        "server": "xxx.xxx.xxx.xxx",
        "server_port": 443,
        "uuid": "..."
        ...
    },
    {
        "type": "shadowsocks",
        "tag": "Proxy2",
        ...
    }
}
```

这里以手动管理方式的订阅为例，之后可以使用GUI进行节点管理

<img src="https://input-s3.mn.input.im/adm-group/1/20240111/659fca9003eb9.png" title="" alt="添加订阅.png" data-align="center">

`保存路径`填写json文件的完整路径，建议使用相对路径，命名之后保存点一下更新，确保订阅正常显示节点数量

<img src="https://input-s3.mn.input.im/adm-group/1/20240111/659fcc523f6c3.png" title="" alt="订阅信息.png" data-align="center">

## 配置设置(必须)

新建一个配置，任意命名即可，在创建的配置上使用右键菜单可以分别设置，也可以使用向导模式一步一步进行设置！

### 通用设置(包含高级设置-必须)：

- **工作模式**：可选全局、规则、直连三种模式，默认建议使用规则模式

- **允许局域网访问**：如果还想使用Yacd或XD面板或其它局域网使用场景，建议打开该项

- **出站接口名称**：建议选择**自动**

- **混合代理端口**：设置该项时会创建一个`mixed`类型的入站用于作为本地监听的代理服务器

- **HTTP(s)代理端口**：设置了混合代理端口之后可以不用单独设置

- **SOCKS5代理端口**：设置了混合代理端口之后可以不用单独设置

- **RESTful WEB API监听地址**：用于`clash_api`方式的监听地址，用途是使用第三方面板，格式为`server:port`

- **RESTful API密钥**：API访问secret

- **自定义外部用户界面下载地址**：自定义下载yacd或xd面板的资源链接

- **持久化缓存**：用于记录选择的节点以及分流规则，下次重启核心无需重新设置

- **持久化Fake-IP**：存储Fake-IP记录

- **TCP快速打开**：Sing-Box的`tcp_fast_open`字段，用于mixed入站

- **多路径TCP**：Sing-Box的`tcp_multi_path`字段，用于mixed入站

- **UDP分段**：Sing-Box的`udp_fragment`字段，用于mixed入站

- **协议探测**：Sing-Box的`sniff`字段，用于mixed和tun入站

- **探测域名覆盖目标地址**：Sing-Box的`sniff_override_destination`字段，用于mixed和tun入站

### TUN设置(非必须)：

- **TUN模式堆栈**：可选`System`、`gVisor`、`Mixed`三种，当使用`Mixed`时，TCP使用`System`栈，UDP使用`gVisor`栈

- **自动设置全局路由**：建议打开

- **TUN网卡名称**：可自定义

- **最大传输单元**：Sing-Box的`mtu`字段，默认9000

- **严格路由**：使用Sing-Box的DNS务必打开

- **独立于端点的NAT**：建议打开

### 代理组设置(必须)：

<img src="https://input-s3.mn.input.im/adm-group/1/20240111/659fd0e106afe.png" title="" alt="代理组列表.png" data-align="center">

编辑相应代理组可以将自己添加的订阅节点加入该组

<img src="https://input-s3.mn.input.im/adm-group/1/20240111/659fd14ece276.png" title="" alt="代理组添加节点.png" data-align="center">

可以根据需求添加/编辑/删除代理组

### 路由规则设置(必须)

这里着重介绍以下最常用最实用几种，分别是`Clash模式`、`Fallback`、`协议`、`内联规则`以及`(远程)规则集`

<img src="https://input-s3.mn.input.im/adm-group/1/20240111/659fd4f3ec2f9.png" title="" alt="默认路由规则列表.png" data-align="center">

- **Clash模式**：`global/direct`、应分别设置为使用代理和直连

- **Fallback**：属于Sing-Box的route.final字段，当没有命中任何规则时默认使用的outbound

- **协议**：dns协议使用`dns-out`出站为必须的，否则无法正常使用Sing-Box的DNS功能

- **内联规则**：使用多条件的复杂规则或逻辑规则时使用，可直接填写json内容

- **(远程)规则集**：对应Sing-Box的rule_set功能，用途是将geoip或geosite需要用到的部分单独取出来，理论效率比直接使用geoip/geosite更高且在处理路由规则时更低的核心占用

### DNS设置(必须)

- **本地DNS**：用于本地使用直连出站的DNS服务器，通常使用国内DNS，支持UDP53/QUIC/DoH/DoT

- **远程DNS**：用于使用代理作为出站的目标域名的DNS解析，通常使用国外DNS，支持UDP53/QUIC/DoH/DoT

- **本地解析DNS**：当**本地DNS**使用DoT或DoH时，用于解析的hostname，当其使用IP则可以不配置。仅支持UDP53或hostname为IP的DoT/DoH

- **远程解析DNS**：当**远程DNS**使用DoT或DoH时，用于解析的hostname，当其使用IP则可以不配置。仅支持UDP53或hostname为IP的DoT/DoH

- **回退DNS**：该选项属于DNS规则中的配置项，当没有命中任何DNS规则时使用该outbound作为DNS服务器

- **策略**：DNS解析策略，可选优先IPV4/优先IPV6/只使用IPV4/只使用IPV6

- **Fake-IP**：Fake-IP使用开关

- **Fake-IP 排除**：列表中的域名不会使用Fake-IP (需配合DNS规则)

### DNS规则设置(必须)

<img src="https://input-s3.mn.input.im/adm-group/1/20240111/659fd8ebed128.png" title="" alt="DNS规则设置.png" data-align="center">

DNS规则设置和`路由规则设置`方法一样，需要注意any出站选中一个DNS Server，以及前面提及的DNS设置中如果设置了Fake-IP 排除的话，需要在DNS规则中启用Fake-IP规则。

### 规则集

规则集有两种方式，本地规则集和远程规则集

#### 本地规则集

<img src="https://input-s3.mn.input.im/adm-group/1/20240111/659fd9e78420f.png" title="" alt="本地规则集.png" data-align="center">

本地规则集有如下几种方式设置

- 使用远程链接下载srs格式的binary规则集或json格式的source规则集

- 使用本地创建json格式的source规则集，格式参考[源文件格式 - sing-box](https://sing-box.sagernet.org/zh/configuration/rule-set/source-format/)和[无头规则 - sing-box](https://sing-box.sagernet.org/zh/configuration/rule-set/headless-rule/)

#### 远程规则集

远程规则集通常是在设置`路由规则设置`或`DNS规则设置`中使用，即直接使用链接形式添加规则集

<img src="https://input-s3.mn.input.im/adm-group/1/20240111/659fdb3a95acd.png" title="" alt="远程规则集.png" data-align="center">

#### 规则集获取方式

- GEOIP：
  
  - [GitHub - MetaCubeX/meta-rules-dat - GEOIP](https://github.com/MetaCubeX/meta-rules-dat/tree/sing/geo/geoip)
  
  - [GitHub - SagerNet/sing-geoip at rule-set](https://github.com/SagerNet/sing-geoip/tree/rule-set)

- GEOSITE：
  
  - [GitHub - MetaCubeX/meta-rules-dat - GEOSITE](https://github.com/MetaCubeX/meta-rules-dat/tree/sing/geo/geosite)
  
  - [GitHub - SagerNet/sing-geosite at rule-set](https://github.com/SagerNet/sing-geosite/tree/rule-set)



## 注意事项

- `内核缓存`：如果在对应`配置`的`通用设置`-`高级设置`中启用了`持久化缓存`或`持久化Fake-IP`选项，将会在`data/sing-box`目录下存储`cache.db`文件，如果更改了代理、DNS以及规则集相关设置，建议停止核心并点击`清除持久化缓存`，否则可能导致部分站点SSL报错

- 非Administrators用户组的用户建议打开`设置`-`通用`中的`以管理员身份运行`，否则可能导致无法使用TUN启动内核或无法实现开机自启

