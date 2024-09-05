# A Guide for GUI.for.SingBox

Welcome to GUI.for.SingBox, this manual aims to introduce the basic usage of the application, making it easier for users. No maintainence of a sophisticated configuration file is required. This project generates a complete configuration file for sing-box cores to run through a convenient GUI configuration. At the same time, it nearly supports all features that sing-box offers as a client

## Settings

- `Settings` - `Language`: Choose the display language. Currently it supports English and Chinese. This wiki is based on the **English** version

- `Kernel Cache`: Created in the `data/sing-box` folder, for storing persistent Fake-IP data and remote ruleset data

- `Exit APP On Window Close`: Exit the app when the close button is clicked. This does not minimize the application to the notification area

- `Close Kernel When APP Exits`: Terminate the sing-box.exe process when the application is closed

- `Auto Start Kernel`: Automatically start the core process when the application is started

- `Run Ad Admin`: Recommended for Windows users who are not in the `Administrators` group. Otherwise, TUN mode may not be able to be started, or when `tun.stack` is set to `system` or `mixed`, the core is unable to modify the Windows Firewall settings

- `Startup on Boot`: The application starts with the OS

- **Kernel** page is for downloading and updating the sing-box core

- **About** page is for checking the applications version and updating it

## Subscriptions Settings (Required)

Only the `outbounds` segment in the core's configuration file is required by **Subscriptions**. For example:

```json
[
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
]
```

The example is based on `Manual` for the Subscription Type, the user may use GUI for managing the proxies

<img src="/zh/resources/gfs/add-subscription.webp" title="" alt="添加订阅.png" data-align="center">

Fill in `Save Path` with the json's path. A relative path is recommended. After entering the name and saving the file, click on `Update` to ensure that the subscription card shows the correct number of the proxies

<img src="/zh/resources/gfs/subscription-list.webp" title="" alt="订阅信息.png" data-align="center">

## Profile Settings (Required)

Create a profile, with a desired name. Right-click on the profile card to launch respective settings, or use the guide to configure it step by step

### General Settigns (Including Advanced Settings - Required)

- **Mode**: There are three modes to select from, `Global`, `Rule` and `Direct`. `Rule` is recommended

- **Allow Lan**: If Yacd or XD WebUI is to be used, or network sharing is expected, turn this option on

- **Interface Name**: Choose one of the network interfaces as outbound, `Auto` is recommended

- **Mixed Port**: When this option is configured, a `Mixed` port will be created for listening on the local inbound traffic

- **HTTP(S) Port**: If `Mixed Port` is configured, this field can be left in blank

- **SOCKS5 Port**: If `Mixed Port` is configured, this field can be left in blank

- **External Controller**: This is for `RESTful WEB API`, corresponding to `clash_api` in the core's configuration file. It is for Yacd or XD WebUI panels, the format is `server:port`

- **RESTful API Secret**: The secret for accessing `RESTful WEB API`

- **External UI URL**: Remote address for downloading Yacd or XD WebUI panel

- **Store Cache**: Store the selected proxies in proxy-groups. By trning on this option, re-selecting the proxies in proxy-groups after restarting the core is not required

- **Store Fake-IP**: Store the results of DNS queries of Fake-IP

- **TCP Fast Open**: Corresponds to the `tcp_fast_open` segment in the core's configuration file, for mixed inbound

- **TCP Multi Path**: Corresponds to the `tcp_multi_path` segment in the core's configuration file, for mixed inbound

- **UDP Fragment**: Corresponds to the `udp_fragment` segment in the core's configuration file, for mixed inbound

- **Sniff**: Corresponds to the `sniff` segment in the core's configuration file, for mixed and tun inbounds

- **Sniff Override Destination**: Corresponds to the `sniff_override_destination` segment in the core's configuration file, for mixed and tun inbounds

### TUN Settings (Not Required)

- **Stack**: There are three stacks to select from, `System`, `gVisor` and `Mixed`. When `Mixed` is selected, the TCP outbound traffic uses the `System` stack, and the UDP outbound traffic uses the `gVisor` stack

- **Auto Route**: Turning it on is recommended

- **Interface Name**: Customizable or leave it blank

- **MTU**: Corresponds to the `mtu` segment in the core's configuration file. The default value is 9000

- **Strict Route**: Turn this on if the DNS settings are configured

- **Endpoint Independent NAT**: Turning it on is recommended. If problems are encounted, turn it off

### Proxy Groups Settings (Required):

<img src="/zh/resources/gfs/proxy-groups.webp" title="" alt="代理组列表.png" data-align="center">

Edit the corresponding proxy group to add the proxies from subscriptions to it

<img src="/zh/resources/gfs/edit-proxy-group.webp" title="" alt="代理组添加节点.png" data-align="center">

Add, edit, or delete proxy groups as needed

### Route Rules Settings (Required)

This section mainly introduces the most commonly used route rules: `CLASH-MODE`, `FALLBACK`, `PROTOCOL`, `INLINE`, and `(REMOTE-)RULE-SET`

<img src="/zh/resources/gfs/route-rules.webp" title="" alt="默认路由规则列表.png" data-align="center">

- **CLASH-MODE**: `GLOBAL` and `DIRECT`, respectively corresponding to the `GLOBAL` and `DIRECT` modes

- **FALLBACK**: Corresponds to `route.final` in the core's configuration file. When an outbound connection does not match any rules, this route rule will be used

- **PROTOCOL**: A configuration for `dns-out` is required. Otherwise, the DNS of sing-box will not work properly

- **INLINE**: For multiple conditioned rules or logical rules, fill in the content in json format

- **(REMOTE-)RULE-SET**: Corresponds to `rule_set` in the core's configuration file. It uses only required extracted segments of the geoip or geosite files. In theory, this is more efficient than using the complete geoip or geosite files

### DNS Settings (Required)

- **Local DNS**: For direct DNS query outbound connections. Usually configured as domestic DNS. Supports UDP53, QUIC, DoH, and DoT

- **Remote DNS**: For proxied DNS query outbound connections. Usually configured as foreign DNS. Supports UDP53, QUIC, DoH, and DoT

- **Resolver DNS**: When **Local DNS** is configured as DoH or DoT, this is used for the DNS hostname queries. If **Local DNS** is configured as an IP address, this option can be left blank. Only supports UDP53, or DoH and DoT that configured with an IP address as their hostname

- **Remote Resolver DNS**: When **Remote DNS** is configured as DoH or DoT, this is used for the DNS hostname queries. If **Remote DNS** is configured as an IP address, this option can be left blank. Only supports UDP53, or DoH and DoT that configured with an IP address as their hostname

- **Fallback DNS**: Corresponds to the DNS Rules settings. When an outbound DNS connection does not match any DNS Rules, this DNS server will be used

- **Strategy**: The DNS inquiry strategy, Prefer IPv4, Prefer IPv6, IPv4 Only and IPv6 Only can be chosen

- **Fake-IP**: The switch to turn Fake-IP on or off

- **Fake-IP Filter**: The domains in this list do not use Fake-IP (requires the corresponding DNS rules to be configured)

### DNS Rules Settings (Required)

<img src="/zh/resources/gfs/dns-rules.webp" title="" alt="DNS规则设置.png" data-align="center">

Configuring the DNS Rules settings is as the same as configuring the Route Rules settings. Note that a DNS server has to be selected in the `any` outbound. If the aforementioned `Fake-IP Filter` is configured, the `FAKE-IP` rules must be added

## Rulesets Settings

There are two types of rulesets: local and remote

### Local Rulesets

<img src="/zh/resources/gfs/rulesets.webp" title="" alt="本地规则集.png" data-align="center">

There are several ways to configure local rulesets

- Download srs formatted binary rulesets or json formatted source rulesets through a remote URL

- Use json formatted source rulesets created locally. For format reference: [Source Format - sing-box](https://sing-box.sagernet.org/configuration/rule-set/source-format/) and [Headless Rule - sing-box](https://sing-box.sagernet.org/configuration/rule-set/headless-rule/)

### Remote Rulesets

Usually, remote rulesets are configured in the `Route Rules` settings or `DNS Rules` settings and added by a URL

<img src="/zh/resources/gfs/remote-rulesets.webp" title="" alt="远程规则集.png" data-align="center">

### How to Fetch the Ruleset Files

- GEOIP：

  - [GitHub - MetaCubeX/meta-rules-dat - GEOIP](https://github.com/MetaCubeX/meta-rules-dat/tree/sing/geo/geoip)

  - [GitHub - SagerNet/sing-geoip at rule-set](https://github.com/SagerNet/sing-geoip/tree/rule-set)

- GEOSITE：

  - [GitHub - MetaCubeX/meta-rules-dat - GEOSITE](https://github.com/MetaCubeX/meta-rules-dat/tree/sing/geo/geosite)

  - [GitHub - SagerNet/sing-geosite at rule-set](https://github.com/SagerNet/sing-geosite/tree/rule-set)

## Note

- For Windows users who are not in the `Administrators` group, it is recommended to turn on `Run As Admin` in the `Settings` - `General` page. Otherwise, TUN mode may not be able to start
- If the national flags are added in the proxy tags (tag), please install the `Twemoji.Mozilla` plugin
