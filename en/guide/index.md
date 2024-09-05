<script setup>
const GUI_List = [
    'GUI.for.Clash',
    'GUI.for.SingBox'
]
</script>

# GUI.for.Cores Project User Manual

This project currently has {{ GUI_List.length }} GUI applications，They are: {{ GUI_List.join('、') }}

GUI applications does not have any direct connections to the core applications, they cannot be equated, and GUI applications are essentially different from VPNs or proxies. Please bear this in mind

## Original Intentions

The GUI.for Cores project aims to generate configuration files for cores quickly and display parameters as UI options, providing default values for these options at the same time. Based on this, this project has developed a series of auxiliary functions around the cores

- Profiles management
- Subscriptions management
- Proxy groups management
- Plugin System
- Scheduled Task System

These functions significantly improve the ease of use of the cores, especially the Plugin System, which makes the core more fun and extensible

## Not VPN or Proxy Applications

The applications based on this project are neither VPN nor proxy applications. They don't integrate any proxy applications or similar functions

## Note

- Please do not download any of **our** applications aside from the GitHub Releases page. Otherwise, security may be compromised, this is extremely IMPORTANT!

- To all blog and website owners, please do not provide any download links other than GitHub Releases on the grounds of *'convenience'* or *'caring for readers'*

- Please do not launch any applications downloaded from unknown sources, even if they are uploaded by the developers of this project in the group. GitHub Releases is the only trustworthy source!

## Q & A

1. How to submit PRs for the project?

> As of now, we do not recommend submitting PRs for new functions, but the bug-fixing ones are welcome. Here are the reasons: the developers have their own agenda regarding the applications' architectures and functions. New functions that are not planned will interrupt the developement process. But we are sincerely grateful to your enthusiasm and support for this project

2. Aside from submitting the bug-fixing PRs, what can I do to make the project better?

> 1. Base on the GUI.for.Cores project, develope GUI applications for other cores

> 2. Complete the user manual to help others

> 3. Test and identify bugs or vulnerabilities, and provide optimization ideas for UI and functions

1. May I use the source code of this project for further developement?

> Definitely. You may use all the current code from this project for the developement of other GUI applications for cores

## To Do

- [ ] Migrate the framework to wails-v3-alpha

- [ ] Develop a visualized traffic usage plugin

- [ ] More GNU/Linux desktops support

- [ ] TUN mode in macOS and GNU/Linux

- [ ] Better installation and upgrade experience on macOS and GNU/Linux

- [ ] Rewrite some functions for GUI.for.SingBox

- [ ] GUI applications for Android™
