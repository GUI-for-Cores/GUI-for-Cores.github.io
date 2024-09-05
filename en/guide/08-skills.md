# Tips

## Right-Click on Title Bar

The following functions are provided when right-clicking on the title bar

- Reset Window: Resets the window to the optimal size. If you prefer things to be perfectly aligned, you might find yourself using this option frequently

- Reload Window: Equivalent to refreshing the interface. GUI performs a series actions after starting, except triggering the `onStartup` action

- Restart App: Equivalent to exiting GUI and then restarting it, the `onStartup` action will be triggered

- Exit App: Completely quits GUI, but whether the core and plugins quit depends on your configuration

## `Cnnections` on the OverView Page Is Clickable

- The Connections page shows all connections information returned by the cores. `Right-click` on each connection to add it to a corresponding ruleset. The modification is persistent and stored in the `rulesets/direct.yaml`, `rulesets/reject.yaml`, and `rulesets/proxy.yaml` files. To make the modification effective, add these three ruleset files to the profiles

## `Controller` on the Buttom of the OverView Page Is Clickable

Clicking on `Controller` opens the groups panel, as does scrolling on the OverView Page

## Each Item on the Profiles Page Is Right-Clickable

- Right-Click on each profile, there are options for changing names, general settings and more. The user does not have to click on the `Edit` button in the top right corner and then go to the respective settings page one step at a time

- `More` option in the right-click menu allows the user to switch to current profile with one click or use current profile as a template to create a new profile

## The User Can Add the Proxy Provider's `Website Link` to the Subscription Card When Adding it

- After saving, a `link` icon will appear on the subscription card. Click on it to quickly open the proxy provider's website

## The `Plugin-Hub` Button on the Plugins Page Is the Plugin-Hub

- If the user opens the application for the first time and there are no plugins, click on the `Plugin-Hub` button to open it

- All plugins do not need to be manually imported from the GitHub repository. Simply open the `Plugin-Hub` to complete the process

## Update the Applications by Clicking on the `Settings` - `About` Button

- Except on macOS

## Press Ctrl + Shift + F12 to Open DevTools

- The Applications do not have a log system, so no log is recorded. Debugging can be done in the DevTools

## Press Ctrl + Shift + P to Open Command Palette

- The Command Palette has some built-in options, such as shortcuts. Use the `Arrow Key` to select, `Enter` to execute, and `Esc` to quit
