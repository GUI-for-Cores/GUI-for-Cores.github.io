# 在 Gnome 桌面环境中免密码运行 TUN 模式

## 准备工作

- 已正常安装与配置 GUI.for.SingBox 且已可正常工作
- 当前用户具备运行 `sudo` 的权限
- 开机自启或手动打开 GUI.for.SingBox 时，Gnome 弹出一个或多个窗口要求输入当前用户密码
- Init 为 systemd，OpenRC 等其他 init 请自行使用相应命令检查与重启 polkit 服务

## 检查 polkit 服务是否正在运行

```bash
sytemctl status polkit
```

若返回状态为除 `active (running)` 之外的结果，运行

```bash
sudo systemctl enable --now polkit
```

## 创建 polkit 策略

- 文件名可自定义

```bash
sudo vi /etc/polkit-1/rules.d/99-nopassword.rules
```

- 添加以下内容并保存退出

```javascript
polkit.addRule(function (action, subject) {
  if (
    (action.id == "org.freedesktop.resolve1.set-domains" ||
      action.id == "org.freedesktop.resolve1.set-default-route" ||
      action.id == "org.freedesktop.resolve1.set-dns-servers") &&
    subject.local &&
    subject.active &&
    subject.isInGroup("wheel")
  ) {
    return polkit.Result.YES;
  }
});
```

## 将当前用户添加至 wheel 组中

- Debian 与衍生系统需要先创建 `wheel` 组，然后运行

```bash
sudo usermod -G wheel 当前用户
```

## 重新加载 polkit 使更改生效

```bash
sudo systemctl restart polkit
```

- 或可重新启动系统

## 说明与引用

- 以上内容在 Fedora 40，Gnome 46.3.1 中测试通过

- 参考 [https://cn.linux-console.net/?p=31038](https://cn.linux-console.net/?p=31038)

- 此文与另一群友共同完成

## 附：查找 `action.id` 以将此方法应用于其他软件中

- 以下命令同样可应用于 GUI.for.Clash 与其他类似软件，且应可应用于其他 Desktop Environment。将运行后返回的 `action.id` 替换至前文的 polkit 策略文件中

```bash
pkaction | grep domain
```

```bash
pkaction | grep route
```

```bash
pkaction | grep dns
```
