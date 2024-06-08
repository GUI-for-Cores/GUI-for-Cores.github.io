# 运行原理

下面从程序的正常使用流程来介绍程序的运行原理。

## 1、快速开始

当你第一次打开程序，可以看见界面上有个`快速开始`按钮，点击后可以填写订阅链接，保存后 GUI 做了以下几件事：

1. 在 profiles.yaml 中新建一份配置(profile)，这里的配置是 GUI 的配置，不是内核配置。

2. 在 subscribes.yaml 中保存订阅信息(subscription)，包括你填写的订阅连接，到期时间，流量信息。

3. 拉取订阅，更新上一步的订阅信息，读取节点，保存到 `subscribes/ID_xxxxxx.yaml`文件，文件以随机 ID 命名。

4. 如果拉取订阅成功，则提示初始化完成，此时可以启动内核程序，如果拉取订阅失败，则需要手动到`订阅`菜单里更新对应的订阅。

## 2、运行配置

选中一个配置，点击`启动内核`按钮，GUI 会根据当前的配置生成一份 `config.yaml` 或 `config.json` 文件，然后调用内核程序运行。如果你创建了多个配置，也可以在`配置`页面，右键某个配置，在更多里选择`使用此配置启动/重启`。排列顺序靠前的会展示在`概览`页，概览页最多展示`4`个配置。

## 3、配置系统代理

默认的设置下，GUI 不会主动的为你设置系统代理，当你点击主页的`系统代理`按钮时，GUI 会从配置中获取 http 代理端口、混合代理端口，并选择一个将其设置为系统代理，混合代理端口总是优先于 http 代理端口。

## 4、TUN 模式

TUN 模式下 GUI 没有对系统做任何的修改，创建虚拟网卡、自动设置路由均是内核完成的。TUN 模式需要管理员权限，请在设置里打开`以管理员身份运行`，然后退出程序，再打开。不要使用程序的重新启动。

Linux 和 macOS 下的 tun 模式授权较复杂，暂未找到合适的解决方案，请手动执行以下命令：

macOS 下：

```bash
# 请将${KernelFilePath}替换为真实的内核路径
osascript -e 'do shell script "chown root:admin ${KernelFilePath}\nchmod +sx ${KernelFilePath}" with administrator privileges'
```

linux 下：

```bash
# 请将${KernelFilePath}替换为真实的内核路径
sudo setcap cap_net_bind_service,cap_net_admin,cap_dac_override=+ep ${KernelFilePath}
```
