# Import Custom Proxies

Now introducing how to import custom proxies that are not provided by subscription links

## 1. Create A New Config

Click on the `Add` button on the `Subscription` page, choose `Manual` for Subscription Type (if the application does not provide a `Manual` option, choose `local` instead, and fill `Remote Url` and `Save Path` with the same value). Enter the name, and the `Save Path` can be default or a desired one

## 2. Add Proxies

After saving the new subscription, right-click on it and choose `Edit Proxies` or `Edit Proxies(Source)`

### 2.1. GUI.for.Clash

If the `Edit Proxies` page is opened, click on the `Add Proxy` button in the top right corner, enter the `proxies` segment of the mihomo configuration, one proxy at a time. For example:

```yaml
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

If the `Edit Proxies(Source)` page is opend, enter all the `proxies` segment content of the mihomo configuration. For example:

```yaml
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

### 2.2. GUI.for.SingBox

The same as 2.1, but the content should be the `outbounds` segment of sing-box configuration, and in JSON format

If the `Edit Proxies` page is opened, click on the `Add Proxy` button in the top right corner, enter the `outbounds` segment of the sing-box configuration, one proxy at a time. For example:

```json
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

If the `Edit Proxies(Source)` page is opend, enter all the `outbounds` content of the sing-box configuration. For example:

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

# Add Custom Rulesets

Now introducing how to add custom rulesets

## 1. Create A New Ruleset

Click on the `Add` button on the `Rulesets` page, choose `Manual` for Ruleset Type. Enter the name, and the `Save Path` can be default or a desired one

## 2. Add Rules

After saving the new ruleset, right-click on it and choose `Edit Rules` or `Open File`

### 2.1 GUI.for.Clash

If the `Edit Rules` page is opened, add the rules in the format as below and click on the `Add` button

```yaml
DOMAIN-SUFFIX,example.com
```

If multiple rules are added at one time, `DOMAIN-SUFFIX` must not be omitted, and use `|` as seperators. For example:

```yaml
DOMAIN-SUFFIX,example.com|DOMAIN-SUFFIX,example2.com
```

If the `Open File` page is opened, add the rules in the format as below and click on the `save` button

```yaml
payload:
  - DOMAIN-SUFFIX,example.com
  - DOMAIN-SUFFIX,example2.com
  - PROCESS-NAME,test.exe
```

All other rules like `PROCESS-PATH` follow the same rules as above, please refer to the mihomo's user manual for details

### 2.2. GUI.for.SingBox

Click on the `Add` button in the `Rulesets` page, choose `Manual` for Ruleset Type, enter the name, `Save Path` can be default or a desired one

After saving the new ruleset, right-click on it and choose `Edit Rules`, add the rules in the format as below and click on the `save` button

```json
{
  "version": 1,
  "rules": [
    {
      "domain_suffix": ["example.com", "example2.com"]
    },
    {
      "process_name": "test.exe"
    }
  ]
}
```

All other rules like `process_path` follow the same rules as above, please refer to the sing-box's user manual for details

For the matching relationships between key values 'AND' and 'OR', please refer to https://sing-box.sagernet.org/configuration/rule-set/headless-rule/#default-fields
