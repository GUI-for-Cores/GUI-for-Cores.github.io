# Run TUN mode in Linux Desktop Environment Without Password

## Preparation

- Installed and configured GUI.for.SingBox for it to run TUN mode without issues
- The current user has sufficient privileges to run `sudo`
- When launch GUI.for.SingBox manually or at system startup, it prompts one or multiple dialog(s) asking for password
- The OS uses systemd as init, please check for polkit service if the OS uses OpenRC and other init systems

## Quick Workaround: Disable systemd-resolved Service

The root cause of the password prompts is that the core calls `systemd-resolved` via the D-Bus interface to update DNS configurations when enabling TUN mode, which triggers system privilege elevation. If you prefer not to configure Polkit rules, you can bypass the prompts by disabling this service directly:

```bash
# Stop and disable systemd-resolved service
sudo systemctl disable --now systemd-resolved.service

# If related socket units exist on your system, it is recommended to disable them as well
sudo systemctl disable --now systemd-resolved-monitor.socket systemd-resolved-varlink.socket
```

> **Caution & Risk Notice**:
> While this is a quick and permanent fix, it applies system-wide. Some distributions that heavily rely on `systemd-resolved` for DNS resolution may experience network issues or other side effects after disabling it. Please evaluate the risks based on your system environment before proceeding. For minimal privileges and maximum system stability, using the Polkit policy method below is recommended.

---

## Check If polkit Service Is Running

```bash
systemctl status polkit.service
```

If the status is not `active (running)`, run the following command:

```bash
sudo systemctl enable --now polkit.service
```

## Create a polkit Policy

- It is recommended to name the policy file after the application, for example:

```bash
sudo vim /etc/polkit-1/rules.d/99-gui-for-singbox.rules
```

- Add the following content, save it, and then quit the editor

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

## Create User Group and Add Current User to It

- It is recommended to create a dedicated group `gui-for-singbox` (rather than directly using system privilege groups):

```bash
sudo groupadd -r -f gui-for-singbox
sudo usermod -aG gui-for-singbox $USER
```

> **Note**: The `-a` flag is required to append the group, preventing the user's existing supplementary groups from being overwritten.

## Restart polkit Service and Apply the Changes

```bash
sudo systemctl restart polkit.service
```

- Group membership changes typically require logging out of the desktop session and logging back in, or restarting the system, to take effect.

## Notes and Citations

- The content above has been tested on Fedora 40 (Gnome), Ubuntu 25.10 (Gnome), Arch Linux (KDE) and other Linux desktop environments

- Reference: [https://cn.linux-console.net/?p=31038](https://cn.linux-console.net/?p=31038)

- This manual was completed with the help of another user from the group

## Appendix: Find Out `action.id` and Use Them for Other Applications

- The following commands apply to GUI.for.Clash and other similar applications, and are applicable to common desktop environments. Replace the `Create a Polkit Policy` content with the actual returned values of `action.id`:

```bash
pkaction | grep domain
```

```bash
pkaction | grep route
```

```bash
pkaction | grep dns
```
