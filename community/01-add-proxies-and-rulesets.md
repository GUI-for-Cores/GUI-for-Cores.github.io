# 导入自建节点

下面介绍如何导入非订阅链接提供的节点。

## 1、创建配置

在`订阅`页面点击`添加`按扭，订阅类型选择`手动管理`，（没有`手动管理`则选择订阅类型为`本地`，`远程链接`和`保存路径`填写一致即可）填入名称，保存路径可保留默认或自定义

## 2、添加节点

保存新建配置后，右键点击此配置并选择`编辑节点`，或选择`编辑节点（源文件）`

### 2.1、GUI.for.Clash

若选择`编辑节点`，则再点击右上角的`添加代理`按扭，填入 mihomo 的 `proxies` 段配置，一次填入一个节点，如

```
name: "vless-reality-vision"
type: vless
server: server
port: 443
uuid: uuid
network: tcp
tls: true
udp: true
flow: xtls-rprx-vision
servername: www.microsoft.com
reality-opts:
  public-key: xxx
  short-id: xxx
client-fingerprint: chrome
```

若选择`编辑节点（源文件）`，可直接填入 mihomo 的 `proxies` 所有节点配置，如

```
proxies:
  - name: "vless-reality-vision"
    type: vless
    server: server
    port: 443
    uuid: uuid
    network: tcp
    tls: true
    udp: true
    flow: xtls-rprx-vision
    servername: www.microsoft.com
    reality-opts:
      public-key: xxx
      short-id: xxx
    client-fingerprint: chrome

  - name: tuic
    server: www.example.com
    port: 10443
    type: tuic
    token: TOKEN
    uuid: 00000000-0000-0000-0000-000000000001
    password: PASSWORD_1
    disable-sni: true
    reduce-rtt: true
    request-timeout: 8000
    udp-relay-mode: native
```

### 2.2、GUI.for.SingBox

其余与 2.1 相同，但填入内容应为 sing-box `outbounds` 段中的节点，且应为 json 格式

若选择`编辑节点`，则再点击右上角的`添加代理`按扭，填入 sing-box 的 `outbounds` 段配置，一次填入一个节点，如

```
{
  "type": "vless",
  "tag": "vless-out",
  "server": "127.0.0.1",
  "server_port": 1080,
  "uuid": "bf000d23-0752-40b4-affe-68f7707a9661",
  "flow": "xtls-rprx-vision",
  "network": "tcp",
  "tls": {},
  "packet_encoding": "",
  "multiplex": {},
  "transport": {},

  ... // Dial Fields
}
```

若选择`编辑节点（源文件）`，可直接填入 sing-box 的 `outbounds` 段所有节点配置，如

```json
[
  {
    "type": "vless",
    "tag": "vless-out",
    "server": "127.0.0.1",
    "server_port": 1080,
    "uuid": "bf000d23-0752-40b4-affe-68f7707a9661",
    "flow": "xtls-rprx-vision",
    "network": "tcp",
    "tls": {},
    "packet_encoding": "",
    "multiplex": {},
    "transport": {},

    ... // Dial Fields
  },
  {
    "type": "tuic",
    "tag": "tuic-out",
    "server": "127.0.0.1",
    "server_port": 1080,
    "uuid": "2DD61D93-75D8-4DA4-AC0E-6AECE7EAC365",
    "password": "hello",
    "congestion_control": "cubic",
    "udp_relay_mode": "native",
    "udp_over_stream": false,
    "zero_rtt_handshake": false,
    "heartbeat": "10s",
    "network": "tcp",
    "tls": {},

    ... // Dial Fields
  }
]
```

# 添加自定义规则集

下面介绍如何创建自定义规则集。

## 1、创建新规则集

在`规则集`页面点击`添加`按扭，订阅类型选择`手动管理`，填入名称，保存路径可保留默认或自定义

## 2、添加规则

保存新建规则集后，右键点击此规则集并选择`编辑规则`，或选择`打开文件`

### 2.1 GUI.for.Clash

若选择`编辑规则`，则按照以下格式先填入规则并点击`添加`按扭

```
DOMAIN-SUFFIX,example.com
```

若需要一次性填入多个规则时， `DOMAIN-SUFFIX` 不可省略，多个规则之间使用 `|` 分隔，如

```
DOMAIN-SUFFIX,example.com|DOMAIN-SUFFIX,example2.com
```

若选择`打开文件`，按照以下格式填入规则并保存

```
payload:
  - DOMAIN-SUFFIX,example.com
  - DOMAIN-SUFFIX,example2.com
  - PROCESS-NAME,test.exe
```

其余规则如 `PROCESS-PATH` 等的配置方式相同，详情请自行参考 mihomo 手册

### 2.2、GUI.for.SingBox

在`规则集`页面点击`添加`按扭，订阅类型选择`手动管理`，填入名称，保存路径可保留默认或自定义

保存新建规则集后，右键点击此规则集并选择`编辑规则集文件`，则按照以下格式先填入规则并点击`保存`按扭

```
{
  "domain_suffix": [
    "example.com",
    "example2.com"
  ],
  "process_name": [
    "test.exe"
  ]
}
```

其余规则如 `process_path` 等的配置方式相同，详情请自行参考 sing-box 手册
