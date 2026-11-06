# 在 Linux 桌面环境中免密码运行 TUN 模式

## 准备工作

- 已正常安装与配置 GUI.for.SingBox 且已可正常工作
- 当前用户具备运行 `sudo` 的权限
- 开机自启或手动打开 GUI.for.SingBox 时，会弹出一个或多个窗口要求输入当前用户密码
- Init 为 systemd，OpenRC 等其他 init 请自行使用相应命令检查与重启 polkit 服务

## 快捷方案：停用 systemd-resolved 服务

弹窗的根源是内核在启用 TUN 时会通过 D-Bus 接口调用 `systemd-resolved` 变更 DNS 配置而触发了系统安全提权。若不想配置复杂的 Polkit 规则，可通过直接停用该服务来规避弹窗：

```bash
# 停止并禁用 systemd-resolved 服务
sudo systemctl disable --now systemd-resolved.service

# 若系统存在相关的 socket 单元，建议一并停用
sudo systemctl disable --now systemd-resolved-monitor.socket systemd-resolved-varlink.socket
```

> **注意与风险提示**：
> 此方法虽一劳永逸，但属于全局变更。部分深度依赖 `systemd-resolved` 维护 DNS 的发行版在禁用后可能会出现网络解析异常等副作用，请用户根据自身的系统网络环境自行评估并决定是否采用。若追求最小权限与系统稳定性，建议采用下文的 Polkit 策略方案。

---

## 检查 polkit 服务是否正在运行

```bash
systemctl status polkit.service
```

若返回状态为除 `active (running)` 之外的结果，运行

```bash
sudo systemctl enable --now polkit.service
```

## 创建 polkit 策略

- 策略文件名建议与应用保持关联，例如：

```bash
sudo vim /etc/polkit-1/rules.d/99-gui-for-singbox.rules
```

- 添加以下内容并保存退出

```javascript
polkit.addRule(function (action, subject) {
  if (
    (action.id == 'org.freedesktop.resolve1.set-domains' ||
      action.id == 'org.freedesktop.resolve1.set-default-route' ||
      action.id == 'org.freedesktop.resolve1.set-dns-servers' ||
      action.id == 'org.freedesktop.resolve1.revert' ||
      action.id == 'org.freedesktop.resolve1.flush-caches') &&
    subject.local &&
    subject.active &&
    subject.isInGroup('gui-for-singbox')
  ) {
    return polkit.Result.YES;
  }
});
```

## 创建用户组并将当前用户添加至组中

- 推荐单独创建新用户组 `gui-for-singbox`（而非直接使用系统级提权组）：

```bash
sudo groupadd -r -f gui-for-singbox
sudo usermod -aG gui-for-singbox $USER
```

> **注意**：必须带上 `-a` 参数以追加用户组，避免覆盖用户已有的其他附属组。

## 重新加载 polkit 使更改生效

```bash
sudo systemctl restart polkit.service
```

- 用户组更改通常需要重新登录桌面会话或重新启动系统后生效。

## 说明与引用

- 以上内容在 Fedora 40 (Gnome), Ubuntu 25.10 (Gnome), Arch Linux (KDE) 等 Linux 桌面环境中测试通过

- 参考 [https://cn.linux-console.net/?p=31038](https://cn.linux-console.net/?p=31038)

- 此文与另一群友共同完成

## 附：查找 `action.id` 以将此方法应用于其他软件中

- 以下命令同样可应用于 GUI.for.Clash 与其他类似软件，适用于各常见桌面环境。将运行后返回的 `action.id` 替换至前文的 polkit 策略文件中：

```bash
pkaction | grep domain
```

```bash
pkaction | grep route
```

```bash
pkaction | grep dns
```
