# Mixin & Script

Before `Mixin` and `Script` were introduced, similar actions could be performed by the plugins. The way to do it was to add an `onGenerate` trigger, modify the generated config file with customizations, but this caused inconvenience:

- 1. Affects all config files, if only some of them require to be modified, `if` must be used

- 2. The code must be in `JavaScript`, which is not friendly to the users who do not have coding experience

`Mixin` and `Script` fixed the two problems mentioned above. They are bound to the current profile and work only on it. They do not affect all profiles and do not require knowing `if` and `JavaScript`

## Mixin

Mixin combines `the config that provided by user` and `the config that generated by GUI`. If there are conflicts, the user can designate which one has the higher priority

![](/zh/resources/guide/601_mixin.png)

示例：
Examples:

1. GUI.for.Clash, in YAML format

```yaml
mode: global
ipv6: true
mixed-port: 7890
tun:
  enable: true
  stack: gVisor
  dns-hijack:
    - any:53
dns:
  enable: true
  ipv6: true
  default-nameserver:
    - 223.5.5.5
    - 114.114.114.114
```

2. GUI for SingBox, in JSON format

```json
{
  "log": {
    "timestamp": false
  },
  "experimental": {
    "clash_api": {
      "external_controller": "127.0.0.1:20123",
      "default_mode": "global"
    },
    "cache_file": {
      "enabled": true,
      "store_fakeip": true
    }
  }
}
```

Note: Mixin does not support `array.concat`, it can only choose between `the config that provided by user` or `the config that generated by GUI`. If the operation is performed on an array, `Script` is the only option

## `Script`

`Script` performs the same action as the `onGenerate` hook in plugins. GUI passes `the config that generated by GUI` to the `onGenerate` action via the parameter `config`, the user modifies `config`, and the final configuration is returned

![](/zh/resources/guide/602_script.png)

Examples:

1. GUI.for.Clash

```javascript
const onGenerate = async (config) => {
  config.dns["default-nameserver"].unshift("223.5.5.5");
  config.dns["default-nameserver"].unshift("114.114.114.114");
  config.sniffer = {
    enable: false,
    "force-dns-mapping": true,
    "parse-pure-ip": true,
    "override-destination": false,
    sniff: {
      HTTP: {
        ports: [80, "8080-8880"],
        "override-destination": true,
      },
      TLS: {
        ports: [443, 8443],
      },
      QUIC: {
        ports: [443, 8443],
      },
    },
    "force-domain": ["+.v2ex.com"],
    "skip-domain": ["Mijia Cloud"],
  };
  return config;
};
```

2. GUI.for.SingBox

```javascript
const onGenerate = async (config) => {
  config.log.timestamp = false;
  config.experimental.clash_api.default_mode = "global";
  config.dns.servers.unshift({
    tag: "remote-dns-google",
    address: "tls://8.8.4.4",
    address_resolver: "remote-resolver-dns",
    detour: "🚀 Select",
  });
  return config;
};
```