# How it works

Now let's understand how the application works by configuring and starting it normally

## 1. Getting Started

When running the application for the first time, there is a `Quick Start` button. Enter the subscription link, and after saving it, GUI performs the following actions:

1. Creates a config segment(profile) in profiles.yaml. This segment is the configuration for GUI, not for the cores

2. Creates a subscription data segment(subscription) in subscribes.yaml, including the subscription link, expiration date and traffic details

3. Fetches the subscription data, reads the proxies infomation from it, and saves them to `subscribes/ID_xxxxxx.yaml`. The files are named with random IDs

4. If the subscription data is successfully fetched, a successful initialization notification will be displayed, and the core will be ready to start. If the application fails to fetch the subscription data, the user must go to the `Subscriptions` page and manually update the corresponding subscription

## 2. Starting with a Profile

Choose a profile, click the `Click to Start` button, GUI will generate a `config.yaml` or `config.json` file based on the chosen profile and call the core application to run with it. If multiple profiles were created, right-click on one of them in the `profiles` page, in the `More` submenu, click `Start/Restart with This Profile`. The profiles at the top of the `Profiles` page will be displayed on the `Overview` page, with a maximum of `4` configurations shown


## 3. Configuring as System Proxy

By default, GUI does not configure itself as system proxy automatically. When `System Proxy` button on the `Overview` page is clicked, GUI reads HTTP port and Mixed port from the configuration file and chooses one of them as the system proxy. The Mixed port always has higher priority than the HTTP port

## 4. TUN Mode

In TUN mode, GUI does not make any modifications to the operating system. Creating the virtual adapters and configuring the routes are done by the cores. TUN mode requires administrator privileges. Please turn on `Run as Admin` in the Settings page, exit the application, and re-open it. Please refrain from using the application's Restart button from any menu in this step.

Turning on TUN mode is a bit complicated on Linux and macOS, there is no simplified solution so far, so please run the commands manually:

On macOS:

```bash
# Please replace ${KernelFilePath} with the actual path of the core file
osascript -e 'do shell script "chown root:admin ${KernelFilePath}\nchmod +sx ${KernelFilePath}" with administrator privileges'
```

On Linux:

```bash
# Please replace ${KernelFilePath} with the actual path of the core file
sudo setcap cap_net_bind_service,cap_net_admin,cap_dac_override=+ep ${KernelFilePath}
```
