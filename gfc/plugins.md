# 插件系统

插件系统作为 GUI 的灵魂，有着非常的强大的功能，请朋友们不要安装来源不明、加密、复杂的插件，它可能会损坏你的电脑。

## 插件系统能够做什么？

- 修改你的 APP 主题、语言，管理你的配置、订阅、规则组、内核。

- 对生成的配置进行修改、对订阅的结果进行修改。

- 扩展 GUI 的能力。

- GUI 中的一切操作均可通过插件进行。

## 插件运行原理

本 GUI 中的插件是一系列的触发器，所谓的触发器就是在满足某个条件时自动执行，GUI 支持了下面几种触发器：

- `手动触发`：点击运行按钮时会被触发，GUI 会执行源码中的 `onRun` 方法。

- `更新订阅时`：更新订阅时会被触发，GUI 会执行源码中的 `onSubscribe` 方法，并传递一个参数，其值可能是 Base64 编码的字符串，或一个节点列表数组。插件需要将参数处理成节点列表的数组并返回。

- `生成配置时`：生成配置文件时会被触发，GUI 会执行源码中的 `onGenerate` 方法，并传递一个参数，其值是一个对象，里面包含了 core 的配置，插件需要将处理后的参数返回，或原样返回。

- `启动 APP 时`：启动 APP 时会被触发，GUI 会执行源码中的 `onStartup` 方法，没有传递参数，插件无需返回任何值。

- `关闭 APP 时`：关闭 APP 时会被触发，GUI 会执行源码中的 `onShutdown` 方法，没有传递参数，插件无需返回任何值。

特别的，当插件开启了`需要安装`参数时，界面会多出`安装`和`卸载`按钮，点击后 GUI 会执行源码中的`onInstall` 和 `onUninstall` 方法。可用来做插件的初始化工作与善后工作，当`onInstall`方法执行没有出错，GUI 会认为插件执行安装成功，将插件标记为已安装，当`onUninstall`方法执行没有出错，GUI 会认为插件执行卸载成功，将插件标记为已卸载（即未安装）。

## 插件编写示例

1、手动触发插件示例

```javascript
const onInstall = async () => {
  Plugins.message.info("你点击了安装，插件将会被标记为已安装。");
};
const onUninstall = async () => {
  Plugins.message.info("你点击了卸载，插件将会被标记为未安装。");
};
const onRun = async () => {
  try {
    const { body } = await Plugins.HttpGet("http://baidu.com");
    Plugins.message.info("你成功访问了一次百度");
  } catch (err) {
    Plugins.message.info("看来你访问百度出现了问题");
  }
};
```

2、更新订阅时插件代码示例

```javascript
// proxies可能是base64字符串，也可能是一个数组
// 请返回一个数组[]
const onSubscribe = (proxies) => {
  if (Plugins.isValidBase64(proxies)) {
    // 你可以在这里解析节点，或调用第三方程序解析节点
    return [];
  }
  // 示例：把节点名称中的新加坡替换为空
  proxies = proxies.map((v) => {
    return {
      ...v,
      name: v.name.replace("新加坡", ""),
    };
  });
  return proxies;
};
```

3、生成配置时插件代码示例

```javascript
const onGenerate = (config) => {
  // 移除tun配置
  delete config.tun;
  // 关闭DNS服务器
  config.dns.enable = false;
  return config;
};
```

4、启动 APP 时插件代码示例

```javaScript
const onStartup = () => {
    alert('APP启动了')
}
```

5、关闭 APP 时插件代码示例

```javaScript
const onShutdown = () => {
    alert('APP启动了')
}
```

## 插件能力：Plugins

在上面我们演示了 Plugins.message、Plugins.HttpGet、Plugins.isValidBase64，那么插件对象 Plugins 还有哪些能力呢，你可以在软件界面按下 Ctrl+Shift+F12 打开开发者面板，切换到控制台，输入 Plugins 并回车查看，具体的使用示例可以看源码。

## 更多的示例

```javascript
// 消息提示示例
const { id } = Plugins.message.info('GUI.for.Cores', 4_000)
await Plugins.sleep(1_000)
Plugins.message.update(id, 'is')
await Plugins.sleep(1_000)
Plugins.message.update(id, 'powerful')
await Plugins.sleep(1_000)
Plugins.message.destroy(id)

// APP设置示例
const appSettings = Plugins.useAppSettingsStore()
appSettings.app.theme = 'dark' // light
appSettings.app.lang = 'en' // zh

// 系统代理管理示例
const envStore = Plugins.useEnvStore()
envStore.setSystemProxy()
envStore.clearSystemProxy()
envStore.switchSystemProxy()

// 内核管理示例
const kernelApiStore = Plugins.useKernelApiStore()
kernelApiStore.startKernel()
kernelApiStore.stopKernel()
kernelApiStore.restartKernel()

// 配置管理示例
const profilesStore = Plugins.useProfilesStore()
profilesStore.addProfile(p: ProfileType)
profilesStore.editProfile(id: string, p: ProfileType)
profilesStore.deleteProfile(id: string)

// 订阅管理示例
const subscribesStore = Plugins.useSubscribesStore()
subscribesStore.addSubscribe(s: SubscribeType)
subscribesStore.editSubscribe(id: string, s: SubscribeType)
subscribesStore.deleteSubscribe(id: string)
subscribesStore.updateSubscribe(id: string)

// 规则组管理示例
const rulesetsStore = Plugins.useRulesetsStore()
rulesetsStore.addRuleset(r: RuleSetType)
rulesetsStore.editRuleset(id: string, r: RuleSetType)
rulesetsStore.deleteRuleset(id: string)
rulesetsStore.updateRuleset(id: string)

// 插件管理示例
const pluginsStore = Plugins.usePluginsStore()
pluginsStore.addPlugin(p: PluginType)
pluginsStore.editPlugin(id: string, p: PluginType)
pluginsStore.deletePlugin(id: string)
pluginsStore.updatePlugin(id: string)
pluginsStore.reloadPlugin(plugin: PluginType, code = '')
pluginsStore.updatePluginTrigger(plugin: PluginType)
```

最后欢迎各位为 GUI 编写插件，插件中心已经在筹备中了，欢迎关注[Plugin-Hub](https://github.com/GUI-for-Cores/Plugin-Hub)。
