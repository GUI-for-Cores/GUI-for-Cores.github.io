# Installation

## 1. Download

> Latest GUI.for.Clash: [Download Link](https://github.com/GUI-for-Cores/GUI.for.Clash/releases/latest)

> Latest GUI.for.SingBox: [Download Link](https://github.com/GUI-for-Cores/GUI.for.SingBox/releases/latest)

We provide the following files for different OS and CPU architectures in the project's Github Releases page

- Windows-amd64
- Windows-arm64
- Windows-386
- macOS-amd64
- macOS-arm64
- Ubuntu-amd64

Check the device's operating system and CPU architecture, download the corresponding file

## 2. Windows

Unzip the downloaded file, and move it to any folder of your choice;

Take GUI.for.Clash as an example: `D:\MyPrograms\GUI.for.Cores\GUI.for.Clash`;

The path of the exe file is: `D:\MyPrograms\GUI.for.Cores\GUI.for.Clash\GUI.for.Clash.exe`.

Notes:

- Avoid using `spaces` in the path
- Avoid using `Chinese characters` in the path


## 3. macOS

Double click the zip file, move the `unzipped` file to `Desktop`, follow these steps:

1. Double click the executable, The error message "**Cannot open... because the developer cannot be verified**", click Cancel button;

2. Go to System Settings - Privacy & Security - Security, "**Cannot be opened because the developer cannot be verified**", click "**Open Anyway**", enter the password to confirm.

Note:

- The unzipped executable must be `moved` at least once (as the example step above, it is moved from Downloads to Desktop), otherwise the executable will not have the `permission to write`

## 4. Linux

> Only tested on Ubuntu 22.04.4, if you are on other distributions, download the same file and try to run it.

Unzipped the file, move the executable to the directory of your choice, take GUI.for.Clash for example: `/opt/GUI.for.Clash`

Create the desktop shortcut manually: create a file named `GUI.for.Clash.desktop`, copy and paste the following content, move the file to `/usr/share/applications` directory

```
[Desktop Entry]
Version=1.0
Name=GUI.for.Clash
Comment=GUI.for.Clash
Exec=/path/to/GUI.for.Clash/GUI.for.Clash
Icon=/path/to/GUI.for.Clash/appicon.png
Terminal=false
Type=Application
Categories=Application;GUI.for.Clash;
StartupNotify=true

```

## 5. Directory Dissection

Using GUI.for.Clash as an example:

```
GUI.for.Clash
└─ data                      // Application resource directory
|   ├─ .cache                // Cache folder, temporary files should be placed in this directory
|   ├─ mihomo                // Core files directory
|   ├─ plugins               // Plugin directory, only stores plugin source code, each plugin corresponds to a plugin-xxx.js file
|   ├─ rolling-release       // Rolling release resource directory, stores compiled frontend files
|   ├─ rulesets              // Ruleset directory, referenced by the core application
|   ├─ subscribes            // Subscription directory, referenced by the core application
|   ├─ third                 // Third-party application directory, third-party applications downloaded by plugins should be placed and run in this directory
|   ├─ plugins.yaml          // Plugin index file
|   ├─ profiles.yaml         // Configuration index file
|   ├─ rulesets.yaml         // Ruleset index file
|   ├─ scheduledtasks.yaml   // Scheduled tasks index file
|   ├─ subscribes.yaml       // Subscriptions index file
|   └─ user.yaml             // Application configuration file: APP settings, plugin settings
└─ GUI.for.Clash.exe         // Main application
```
