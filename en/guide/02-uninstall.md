# Uninstallation

## If the application has been run

1. Please run the application again and revert some changes

In the Settings page, turn off `Run As Admin` and `Startup on Boot`

Completely exit the application, including terminating the core process.

1. Delete the folder: `%APPDATA%\[BinaryName.exe]`

BinaryName is the application's name

1. Delete the data directory (you can keep it if you want)

The data directory is created when the application starts and stores binaries, subscriptions, configurations, rulesets, plugins and scheduled tasks files

In portable mode, it is the `data` folder next to the application. Otherwise, see [Directory Dissection](./01-install.md#_5-directory-dissection) for its location

## If the application has not been run

You should give it a try
