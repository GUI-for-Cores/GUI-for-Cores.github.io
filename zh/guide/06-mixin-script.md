# 混入与脚本

在引入`混入`与`脚本`之前，类似的操作可以通过插件完成，实现方式是创建一个具有`生成配置时`的触发器，对生成的配置进行个性化修改，但这样做有一些不便：

- 1、作用于所有配置，如果仅修改部分配置则需要使用`if`来判断；

- 2、必须编写`JavaScript`代码来处理，对没有编程经验的人不友好；

`混入`与`脚本`解决了以上两个问题，它们和配置强绑定，仅作用于自身，既不会影响全部配置、也不需要编写`if`与`JavaScript`代码。

## 混入 - Mixin

混入的原理是使用`用户提供的配置`与`GUI生成的配置`进行合并处理，如果两个配置存在冲突，则可以使用`优先级`来指定最终的配置以哪一个为准。

![](/zh/resources/guide/601_mixin.png)

示例：

1、GUI.for.Clash 示例，YAML 格式

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

2、GUI.for.SingBox 示例，JSON 格式

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

注意事项：混入操作不支持`数组合并`，只会取`用户提供的配置`与`GUI生成的配置`其一。如果想对数组进行操作，只能使用`脚本`。

## 脚本 - `Script`

脚本的实现原理和插件的`onGenerate`钩子相同，GUI 会把`GUI生成的配置`通过参数`config`传入`onGenerate`方法，用户对`config`进行修改，然后返回最终的配置。

![](/zh/resources/guide/602_script.png)

示例：

1、GUI.for.Clash 示例

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

2、GUI.for.SingBox 示例

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
