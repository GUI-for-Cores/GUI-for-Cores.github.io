# Run TUN mode in Gnome Desktop Environment Without Password

## Preparation

- Installed and configured GUI.for.SingBox for it to run TUN mode without issues
- The current user has sufficient privileges to run `sudo`
- When launch GUI.for.SingBox manually or at system startup, Gnome prompts one or multiple dialog(s) asking for password
- The OS uses systemd as init, please check for polkit service if the OS uses OpenRC and other init systems

## Check If polkit Service Is Running

```bash
sytemctl status polkit
```

If the status is not `active (running)`, run the following command:

```bash
sudo systemctl enable --now polkit
```

## Create a polkit Policy

- The filename can be customized

```bash
sudo vi /etc/polkit-1/rules.d/99-nopassword.rules
```

- Add the following content, save it, and then quit the editor

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

## Add Current User to Wheel Group

- Debian and its derivatives need to create the `wheel` group first, and then run the following command (remember to replace ${CurrentUser} with the actual current username):

```bash
sudo usermod -G wheel ${CurrentUser}
```

## Restart polkit Service and Apply the Changes

```bash
sudo systemctl restart polkit
```

- Or, restart the system

## Notes and Citations

- The content above has been tested on Fedora 40, Gnome 46.3.1

- Reference: [https://cn.linux-console.net/?p=31038](https://cn.linux-console.net/?p=31038)

- This manual was completed with the help of another user from the group

## Appendix: Find Out `action.id` and Use Them for Other Applications

- The following commands apply to GUI.for.Clash and other similar applications, and should also be working on other Desktop Environments. Replace the `Create a Polkit Policy` content with the actual returned values of `action.id`

```bash
pkaction | grep domain
```

```bash
pkaction | grep route
```

```bash
pkaction | grep dns
```
